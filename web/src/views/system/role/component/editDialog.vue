<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="750px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" size="default" label-width="90px">
			<el-row :gutter="35">
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="角色名称" prop="roleName">
						<el-input v-model="state.dataForm.roleName" placeholder="请输入角色名称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="角色代码" prop="roleCode">
						<el-input v-model="state.dataForm.roleCode" placeholder="请输入角色代码" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="排序" prop="sort">
						<el-input-number v-model="state.dataForm.sort" :min="0" :max="999" controls-position="right"
							placeholder="请输入排序" class="w100" />
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="角色状态" prop="status">
						<el-switch v-model="state.dataForm.status" :active-value="0" :inactive-value="1" inline-prompt
							active-text="启用" inactive-text="禁用"></el-switch>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
					<el-form-item label="角色描述" prop="remark">
						<el-input v-model="state.dataForm.remark" type="textarea" placeholder="请输入角色描述"
							maxlength="150"></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
					<el-form-item label="菜单权限">
						<el-tree ref="roleMenuRef" :data="state.menuData" :props="state.menuProps" class="menu-data-tree"
							node-key="id" show-checkbox />
					</el-form-item>
				</el-col>
			</el-row>
		</el-form>
		<template #footer>
			<span class="dialog-footer">
				<el-button @click="closeDialog" size="default">取 消</el-button>
				<el-button type="primary" @click="onSubmit" size="default">确 定</el-button>
			</span>
		</template>
	</el-dialog>
</template>

<script setup lang="ts">
import { reactive, ref, nextTick } from 'vue';
import { ElMessage, ElTree } from 'element-plus';
import roleApi from '/@/api/system/role';
import menuApi from '/@/api/system/menu';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dataFormRef = ref();
const roleMenuRef = ref<InstanceType<typeof ElTree>>();
const state = reactive({
	dataForm: {
		roleName: '', // 角色名称
		roleCode: '', // 角色代码
		sort: 0, // 排序
		status: 0, // 角色状态
		remark: '', // 角色描述
		menuIds: [], // 角色菜单
	},
	rules: {
		roleName: [{ required: true, message: '角色名称不能为空', trigger: 'blur' }],
		roleCode: [{ required: true, message: '角色代码不能为空', trigger: 'blur' }],
	},
	menuData: [] as any,
	menuProps: {
		children: 'children',
		label: 'label',
	},
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
});

// 打开弹窗
const openDialog = (row: any) => {
	// 获取菜单结构数据
	getMenuData();
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '编辑角色';
		nextTick(() => {
			getRoleDetail(row.id);
		});
	} else {
		state.dialog.isEdit = false;
		state.dialog.title = '添加角色';
	}

	state.dialog.isShowDialog = true;
};

// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
	// 重置表单
	dataFormRef.value.resetFields();
	// 重置选项
	roleMenuRef.value!.setCheckedKeys([], false);
};

// 提交
const onSubmit = () => {
	dataFormRef.value.validate(async (valid: boolean) => {
		if (!valid) {
			return;
		}
		// 选中节点
		var checkedKeys = roleMenuRef.value!.getCheckedKeys() as any;
		// 半选中节点
		var halfCheckedKeys = roleMenuRef.value!.getHalfCheckedKeys() as any;

		// 需要将半选keys放到前面，否则回显的半选会变成选中
		state.dataForm.menuIds = halfCheckedKeys.concat(checkedKeys);
		if (state.dialog.isEdit) {
			//更新
			roleApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			roleApi.add(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('添加成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		}
	});
};

// 获取菜单结构数据
const getMenuData = () => {
	menuApi.list().then((res) => {
		if (res.success) {
			state.menuData = buildMenuTree(res.data, 0);
		}
	});
};

// 构建菜单树状（递归）
const buildMenuTree = (menuData: any, parentId: number): any => {
	var menuTree = [];
	for (let index = 0; index < menuData.length; index++) {
		const menu = menuData[index];
		if (menu.parentId == parentId) {
			menuTree.push({
				id: menu.id,
				label: menu.menuName,
				children: buildMenuTree(menuData, menu.id),
			});
		}
	}
	return menuTree;
};

// 获取角色详情
const getRoleDetail = (roleId: number) => {
	roleApi.detail({ id: roleId }).then((res) => {
		if (res.success) {
			Object.assign(state.dataForm, res.data);
			// 设置选中
			const checkedKeys = res.data.menuIds;
			if (checkedKeys) {
				checkedKeys.forEach((v: any) => {
					roleMenuRef.value?.setChecked(v, true, false);
				});
			}
		}
	});
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>

<style scoped lang="scss">
.menu-data-tree {
	width: 100%;
	border: 1px solid var(--el-border-color);
	border-radius: var(--el-input-border-radius, var(--el-border-radius-base));
	padding: 5px;
}
</style>


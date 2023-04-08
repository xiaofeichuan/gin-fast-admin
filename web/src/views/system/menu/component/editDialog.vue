<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" size="default" label-width="80px">
			<el-row :gutter="35">
				<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
					<el-form-item label="上级菜单" prop="parentId">
						<el-cascader
							:options="state.menuOptions"
							v-model="state.dataForm.parentId"
							:props="{ checkStrictly: true, emitPath: false }"
							class="w100"
							clearable
						/>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
					<el-form-item label="菜单类型" prop="menuType">
						<el-radio-group v-model="state.dataForm.menuType">
							<!-- <el-radio :label="0">目录</el-radio>
							<el-radio :label="1">菜单</el-radio>
							<el-radio :label="2">按钮</el-radio> -->
							<el-radio v-for="item in state.menuTypeOption" :key="item.dictItemValue" :label="item.dictItemValue">{{ item.dictItemName }}</el-radio>
						</el-radio-group>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
					<el-form-item label="菜单状态" prop="status">
						<el-switch
							v-model="state.dataForm.status"
							:active-value="0"
							:inactive-value="1"
							inline-prompt
							active-text="启用"
							inactive-text="禁用"
						></el-switch>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
					<el-form-item label="菜单名称" prop="menuName">
						<el-input v-model="state.dataForm.menuName" placeholder="请输入菜单名称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
					<el-form-item label="菜单排序" prop="sort">
						<el-input-number v-model="state.dataForm.sort" controls-position="right" placeholder="请输入排序" class="w100" />
					</el-form-item>
				</el-col>
				<template v-if="state.dataForm.menuType === 0 || state.dataForm.menuType === 1">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="菜单图标">
							<IconSelector placeholder="请选择菜单图标" v-model="state.dataForm.icon" />
						</el-form-item>
					</el-col>
					<template v-if="state.dataForm.menuType === 1">
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="路由地址" prop="path">
								<el-input v-model="state.dataForm.path" placeholder="请输入路由地址" clearable></el-input>
							</el-form-item>
						</el-col>

						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="链接地址" prop="isLink">
								<el-input
									v-model="state.dataForm.link"
									placeholder="请输入链接地址（如：http:baidu.com）"
									clearable
									:disabled="!state.dataForm.isLink"
								>
								</el-input>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="组件路径" prop="component">
								<el-input v-model="state.dataForm.component" placeholder="请输入组件路径" clearable></el-input>
							</el-form-item>
						</el-col>

						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否外链" prop="isLink">
								<el-radio-group v-model="state.dataForm.isLink" :disabled="state.dataForm.isIframe">
									<el-radio :label="true">是</el-radio>
									<el-radio :label="false">否</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否内嵌" prop="isIframe">
								<el-radio-group v-model="state.dataForm.isIframe" @change="onSelectIframeChange">
									<el-radio :label="true">是</el-radio>
									<el-radio :label="false">否</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="页面缓存" prop="isCache">
								<el-radio-group v-model="state.dataForm.isCache">
									<el-radio :label="true">缓存</el-radio>
									<el-radio :label="false">不缓存</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否固定" prop="isAffix">
								<el-radio-group v-model="state.dataForm.isAffix">
									<el-radio :label="true">固定</el-radio>
									<el-radio :label="false">不固定</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
					</template>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="是否隐藏" prop="isHide">
							<el-radio-group v-model="state.dataForm.isHide">
								<el-radio :label="true">隐藏</el-radio>
								<el-radio :label="false">不隐藏</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
				</template>
				<template v-if="state.dataForm.menuType === 2">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="权限标识" prop="permission">
							<el-input v-model="state.dataForm.permission" placeholder="请输入权限标识" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="请求方式" prop="requestMethod">
							<el-select v-model="state.dataForm.requestMethod" placeholder="请选择请求方式" clearable class="w100">
								<el-option label="POST" value="POST"></el-option>
								<el-option label="GET" value="GET"></el-option>
								<el-option label="PUT" value="PUT"></el-option>
								<el-option label="DELETE" value="DELETE"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
				</template>
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
import { defineAsyncComponent, reactive, ref, nextTick } from 'vue';
import { ElMessage } from 'element-plus';
import { useDictData } from '/@/stores/dictData';
import menuApi from '/@/api/system/menu';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 引入组件
const IconSelector = defineAsyncComponent(() => import('/@/components/iconSelector/index.vue'));

// 定义变量内容
const dataFormRef = ref();

const state = reactive({
	dataForm: {
		parentId: 0, // 上级菜单
		menuName: '', // 菜单名称
		menuType: 0, // 菜单类型（0菜单，1按钮）
		path: '', // 路由地址
		link: '', // 外部地址
		isLink: false, // 是否外链，
		isIframe: false, // 是否内嵌
		isHide: false, // 是否隐藏
		isCache: true, // 是否缓存
		isAffix: true, // 是否固定
		component: '', // 组件路径
		icon: '', // 菜单图标
		permission: '', // 按钮权限
		requestMethod: '', // 请求方法
		status: 0, // 菜单状态（0启用 1停用）
		sort: 0, // 排序
		remark: '', // 备注
	},
	rules: {
		menuName: [{ required: true, message: '菜单名称不能为空', trigger: 'blur' }],
		permission: [{ required: true, message: '权限标识不能为空', trigger: 'blur' }],
		path: [{ required: true, message: '路由地址不能为空', trigger: 'blur' }],
		requestMethod: [{ required: true, message: '请求方式为必选项', trigger: 'blur' }],
	},
	//isLink:false,
	menuOptions: [] as any, // 上级菜单数据
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
	menuTypeOption:[]
});

// 获取路由
const getMenuData = () => {
	menuApi.list().then((res) => {
		if (res.success) {
			state.menuOptions = [
				{
					value: 0,
					label: '顶级',
					children: buildMenuOptions(res.data, 0),
				},
			];
		}
	});
};

//
const buildMenuOptions = (list: any, parentId: number): any => {
	var data = [];
	var children = list.filter((item: any) => item.parentId == parentId);

	if (children == undefined || children.length == 0) {
		return [];
	}
	for (let index = 0; index < children.length; index++) {
		data.push({
			value: children[index].id,
			label: children[index].menuName,
			children: buildMenuOptions(list, children[index].id),
		});
	}
	return data;
};

// 打开弹窗
const openDialog = (row: any) => {
	getMenuData();
	state.menuTypeOption = useDictData().getDictItem('menu_type');
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '编辑角色';
		nextTick(() => {
			Object.assign(state.dataForm, row);
			if (state.dataForm.link) {
				state.dataForm.isLink = true;
			}
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
};

// 是否内嵌下拉改变
const onSelectIframeChange = () => {
	if (state.dataForm.isIframe) state.dataForm.isLink = true;
	else state.dataForm.isLink = false;
};

// 提交
const onSubmit = () => {
	dataFormRef.value.validate(async (valid: boolean) => {
		if (!valid) {
			return;
		}

		if (state.dialog.isEdit) {
			//更新
			menuApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			menuApi.add(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('添加成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		}
	});
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>

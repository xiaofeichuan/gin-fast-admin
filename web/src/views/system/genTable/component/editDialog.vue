<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="750px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" size="default" label-width="90px">
			<el-row :gutter="35">
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="表名称" prop="tableName">
						<el-select v-model="state.dataForm.tableName" placeholder="请选择表名称" @change="changeTableName"
							clearable class="w100">
							<el-option v-for="item in state.tableList" :key="item.tableName" :label="item.tableName"
								:value="item.tableName">
							</el-option>
						</el-select>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="表描述" prop="tableDescription">
						<el-input v-model="state.dataForm.tableDescription" placeholder="请输入表注释" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="业务名称" prop="businessName">
						<el-input v-model="state.dataForm.businessName" placeholder="请输入业务名称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="模块名称" prop="moduleName">
						<el-input v-model="state.dataForm.moduleName" placeholder="请输入模块名称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="实体名称" prop="modelName">
						<el-input v-model="state.dataForm.modelName" placeholder="请输入实体名称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">					
					<el-form-item label="上级菜单" prop="menuParentId">						
						<el-tree-select v-model="state.dataForm.menuParentId" :data="state.menuOptions"  class="w100" :check-strictly="true"/>
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
import { ElMessage } from 'element-plus';
import genTableApi from '/@/api/system/genTable';
import menuApi from '/@/api/system/menu';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dataFormRef = ref();
const state = reactive({
	dataForm: {
		tableName: '', // 表名称
		tableDescription: '', // 表描述
		modelName: '', // 实体名称
		businessName: '', // 业务名称
		moduleName: '', // 模块名称
		functionName: '', // 功能名称
		paramName: '', // 参数名称
		menuParentId:0, // 上级菜单
	},
	rules: {
		tableName: [{ required: true, message: '表名称不能为空', trigger: 'blur' }],
	},
	tableList: [] as any,
	menuOptions: [] as any, // 上级菜单数据
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
});

// 打开弹窗
const openDialog = (row: any) => {
	getTableList()
	getMenuData();
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '更新代码生成';
		nextTick(() => {
			Object.assign(state.dataForm, row);
		});
	} else {
		state.dialog.isEdit = false;
		state.dialog.title = '添加代码生成';
	}

	state.dialog.isShowDialog = true;
};
// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
	// 重置表单
	dataFormRef.value.resetFields();
};

// 提交
const onSubmit = () => {
	dataFormRef.value.validate(async (valid: boolean) => {
		if (!valid) {
			return;
		}

		if (state.dialog.isEdit) {
			//更新
			genTableApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			genTableApi.add(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('添加成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		}
	});
};

// 获取表列表
const getTableList = () => {
	genTableApi.tableList().then((res) => {
		if (res.success) {
			state.tableList = res.data;
		}
	});
};

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

// 构建菜单选项
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

// 选中表
const changeTableName = (val: string) => {
	var table = state.tableList.filter((_: any) => _.tableName == val)[0]
	state.dataForm.tableDescription = table.tableDescription
	state.dataForm.modelName = table.modelName
	state.dataForm.businessName = table.businessName
	state.dataForm.moduleName = table.moduleName
	state.dataForm.functionName = table.functionName
	state.dataForm.paramName = table.paramName
}

// 暴露变量
defineExpose({
	openDialog,
});
</script>



<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="1100px" @close="closeDialog">
		<el-card shadow="hover">
			<div>
				<el-button type="primary" @click="openEditDialog()" v-permission="['system_dictItem_add']" plain>
					<el-icon>
						<ele-Plus />
					</el-icon>
					新增
				</el-button>
			</div>
			<el-table :data="state.tableData.data" v-loading="state.tableData.loading" max-height="500">
				<el-table-column prop="id" label="编号" width="60" />
				<el-table-column prop="dictItemName" label="选项名称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="dictItemValue" label="选项值" show-overflow-tooltip></el-table-column>
				<el-table-column prop="status" label="字典状态" show-overflow-tooltip>
					<template #default="scope">
						<el-tag v-if="scope.row.status == 0">启用</el-tag>
						<el-tag type="info" v-else>禁用</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="remark" label="字典描述" show-overflow-tooltip></el-table-column>
				<el-table-column prop="createdAt" label="创建时间" show-overflow-tooltip></el-table-column>
				<el-table-column label="操作" width="150">
					<template #default="scope">
						<el-button text type="primary" @click="openEditDialog(scope.row)" v-permission="['system_dictItem_update']">修改</el-button>
						<el-button text type="primary" @click="handleDel(scope.row)" v-permission="['system_dictItem_delete']">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-card>
	</el-dialog>
	<EditDialog ref="editFormRef" @refresh="handleQuery()" />
</template>

<script setup lang="ts">
import { defineAsyncComponent, reactive, ref, nextTick } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import dictItemApi from '/@/api/system/dictItem';

// 引入组件
const EditDialog = defineAsyncComponent(() => import('./itemEditDialog.vue'));

// 定义变量内容
const editFormRef = ref();
const state = reactive({
	dictData: {} as any,
	tableData: {
		data: [],
		loading: true,
	},
	dialog: {
		isShowDialog: false,
		title: '',
	},
});

// 打开弹窗
const openDialog = (row?: any) => {
	state.dictData = row;
	state.dialog.title = '字典选项';
	handleQuery();
	state.dialog.isShowDialog = true;
};
// 初始化表格数据
const handleQuery = () => {
	state.tableData.loading = true;
	dictItemApi.list({ dictId: state.dictData.id }).then((res) => {
		if (res.success) {
			state.tableData.data = res.data;
			state.tableData.loading = false;
		}
	});
};

// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
};

// 打开编辑弹窗
const openEditDialog = (row?: any) => {
	editFormRef.value.openDialog(state.dictData, row);
};

// 删除
const handleDel = (row: any) => {
	ElMessageBox.confirm(`此操作将永久删除选项名称：“${row.dictItemName}”?`, '提示', {
		confirmButtonText: '确认',
		cancelButtonText: '取消',
		type: 'warning',
	})
		.then(() => {
			dictItemApi.delete({ id: row.id }).then((res) => {
				if (res.success) {
					handleQuery();
					ElMessage.success('删除成功');
				}
			});
		})
		.catch(() => {});
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>


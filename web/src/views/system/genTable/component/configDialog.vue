<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="1300px" @close="closeDialog">
		<el-card shadow="hover">
			<el-table :data="state.tableData.data" v-loading="state.tableData.loading" max-height="500">
				<el-table-column prop="id" label="编号" width="60" />
				<el-table-column prop="columnName" label="字段名" show-overflow-tooltip></el-table-column>
				<el-table-column prop="columnDescription" label="字段描述" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.columnDescription" placeholder="请输入模块名称" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="columnType" label="字段类型" show-overflow-tooltip></el-table-column>
				
				<el-table-column prop="goType" label="go类型" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.goType" placeholder="请输入模块名称" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="goField" label="go字段名" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.goField" placeholder="请输入模块名称" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="jsonField" label="参数名称" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.jsonField" placeholder="请输入模块名称" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="isPk" label="是否主键" show-overflow-tooltip>
					<template #default="scope">
						<el-switch
							v-model="scope.row.isPk"
							inline-prompt
							:active-value="true"
							:inactive-value="false"
							active-text="启用"
							inactive-text="禁用"
						></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="isEdit" label="是否编辑" show-overflow-tooltip>
					<template #default="scope">
						<el-switch
							v-model="scope.row.isEdit"
							inline-prompt
							:active-value="true"
							:inactive-value="false"
							active-text="启用"
							inactive-text="禁用"
						></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="isList" label="是否列表" show-overflow-tooltip>
					<template #default="scope">
						<el-switch
							v-model="scope.row.isList"
							inline-prompt
							:active-value="true"
							:inactive-value="false"
							active-text="启用"
							inactive-text="禁用"
						></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="isQuery" label="是否查询" show-overflow-tooltip>
					<template #default="scope">
						<el-switch
							v-model="scope.row.isQuery"
							inline-prompt
							:active-value="true"
							:inactive-value="false"
							active-text="启用"
							inactive-text="禁用"
						></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="queryMethod" label="查询方式" show-overflow-tooltip></el-table-column>
			</el-table>
		</el-card>
	</el-dialog>
</template>

<script setup lang="ts">
import { reactive, ref, nextTick } from 'vue';
import { ElMessage } from 'element-plus';
import genTableColumnApi from '/@/api/system/genTableColumn';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

const state = reactive({
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
const openDialog = (row: any) => {
	state.dialog.title = '字段列表';
	handleQuery(row.id);
	state.dialog.isShowDialog = true;
};

// 初始化表格数据
const handleQuery = (tableId:number) => {
	state.tableData.loading = true;
	genTableColumnApi.list({ tableId: tableId}).then((res) => {
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

// 暴露变量
defineExpose({
	openDialog,
});
</script>



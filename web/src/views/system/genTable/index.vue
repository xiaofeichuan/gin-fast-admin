<template>
	<div class="layout-padding">
		<el-card shadow="hover" :body-style="{ paddingBottom: 0 }">
			<el-form :model="state.tableData.param" ref="queryFormRef" :inline="true" label-width="70px">
				<el-form-item label="表名称" prop="tableName">
					<el-input v-model="state.tableData.param.tableName" placeholder="请输入表名称" style="width: 200px"
						@keyup.enter="handleQuery" clearable />
				</el-form-item>
				<el-form-item>
					<el-button @click="resetQueryForm()">
						<el-icon>
							<ele-Refresh />
						</el-icon>
						重置
					</el-button>
					<el-button type="primary" @click="handleQuery">
						<el-icon>
							<ele-Search />
						</el-icon>
						查询
					</el-button>
				</el-form-item>
			</el-form>
		</el-card>
		<el-card shadow="hover" style="margin-top: 10px">
			<div>
				<el-button type="primary" @click="openEditDialog()" v-permission="['system_genTable_add']" plain>
					<el-icon>
						<ele-Plus />
					</el-icon>
					新增
				</el-button>
			</div>
			<el-table :data="state.tableData.data" v-loading="state.tableData.loading">
				<el-table-column prop="id" label="编号" width="60" />
				<el-table-column prop="tableName" label="表名称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="tableDescription" label="表描述" show-overflow-tooltip></el-table-column>
				<el-table-column prop="modelName" label="实体名称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="businessName" label="业务名称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="moduleName" label="模块名称" show-overflow-tooltip></el-table-column>		
				<el-table-column prop="createdAt" label="创建时间" show-overflow-tooltip></el-table-column>
				<el-table-column label="操作" width="200">
					<template #default="scope">
						<el-button text type="primary" @click="openPreviewDialog(scope.row)"
							v-permission="['system_genTable_update']">预览</el-button>
						<el-button text type="primary" @click="openColumnDialog(scope.row)"
							v-permission="['system_genTable_update']">字段</el-button>
						<el-button text type="primary" @click="openEditDialog(scope.row)"
							v-permission="['system_genTable_update']">修改</el-button>
						<el-button text type="primary" @click="handleDel(scope.row)"
							v-permission="['system_genTable_delete']">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :pager-count="5"
				:page-sizes="[10, 20, 30]" v-model:current-page="state.tableData.param.pageNum" background
				v-model:page-size="state.tableData.param.pageSize" layout="total, sizes, prev, pager, next, jumper"
				:total="state.tableData.total">
			</el-pagination>
		</el-card>
		<EditDialog ref="editFormRef" @refresh="handleQuery()" />
		<PreviewDialog ref="previewRef" />
	</div>
</template>

<script setup lang="ts">
import { defineAsyncComponent, reactive, onMounted, ref } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import genTableApi from '/@/api/system/genTable';
import { useRoute, useRouter } from 'vue-router';

// 引入组件
const EditDialog = defineAsyncComponent(() => import('./component/editDialog.vue'));
const PreviewDialog = defineAsyncComponent(() => import('./component/previewDialog.vue'));

// 定义变量内容
const queryFormRef = ref();
const editFormRef = ref();
const previewRef = ref();
const router = useRouter();

const state = reactive({
	tableData: {
		data: [],
		total: 0,
		loading: false,
		param: {
			pageNum: 1,
			pageSize: 10,
			tableName: undefined,
		},
	},
});

// 页面加载时
onMounted(() => {
	handleQuery();
});

// 重置
const resetQueryForm = () => {
	queryFormRef.value?.resetFields();
	handleQuery();
};

// 初始化表格数据
const handleQuery = () => {
	state.tableData.loading = true;
	genTableApi.query(state.tableData.param).then((res) => {
		if (res.success) {
			state.tableData.data = res.data.list;
			state.tableData.total = res.data.totalCount;
			state.tableData.loading = false;
		}
	});
};
// 打开编辑弹窗
const openEditDialog = (row?: any) => {
	editFormRef.value.openDialog(row);
};

// 打开预览代码弹窗
const openPreviewDialog = (row?: any) => {
	previewRef.value.openDialog(row);
}

// 打开字段弹窗
const openColumnDialog = (row?: any) => {
	// configFormRef.value.openDialog(row);
	router.push({
		path: '/system/genTable/column',
		query: { tableId: row.id },
	});
}
// 删除
const handleDel = (row: any) => {
	ElMessageBox.confirm(`是否删除此记录`, '提示', {
		confirmButtonText: '确认',
		cancelButtonText: '取消',
		type: 'warning',
	})
		.then(() => {
			genTableApi.delete({ id: row.id }).then((res) => {
				if (res.success) {
					handleQuery();
					ElMessage.success('删除成功');
				}
			});
		})
		.catch(() => { });
};

// 分页改变
const handleSizeChange = (val: number) => {
	state.tableData.param.pageSize = val;
	handleQuery();
};

// 分页改变
const handleCurrentChange = (val: number) => {
	state.tableData.param.pageNum = val;
	handleQuery();
};
</script>


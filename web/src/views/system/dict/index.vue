<template>
	<div class="layout-padding">
		<el-card shadow="hover" :body-style="{ paddingBottom: 0 }">
			<el-form :model="state.tableData.param" ref="queryFormRef" :inline="true" label-width="70px">
				<el-form-item label="字典名称" prop="roleName">
					<el-input v-model="state.tableData.param.dictName" placeholder="请输入字典名称" style="width: 200px" @keyup.enter="handleQuery"  clearable />
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
				<el-button type="primary" @click="openEditDialog()" v-permission="['system_dict_add']"  plain>
					<el-icon>
						<ele-Plus />
					</el-icon>
					新增
				</el-button>
			</div>
			<el-table :data="state.tableData.data" v-loading="state.tableData.loading">
				<el-table-column prop="id" label="编号" width="60" />
				<el-table-column prop="dictName" label="字典名称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="dictCode" label="字典代码" show-overflow-tooltip></el-table-column>
				<el-table-column prop="dictType" label="字典类型" show-overflow-tooltip>
					<template #default="scope">
						<el-tag v-if="scope.row.dictType == 0">整数</el-tag>
						<el-tag v-else>字符</el-tag>
					</template>
				</el-table-column>
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
						<el-button text type="primary" @click="openEditDialog(scope.row)" v-permission="['system_dict_update']">修改</el-button>
						<el-button text type="primary" @click="openItemDialog(scope.row)" v-permission="['system_dictItem_list']">选项</el-button>
						<el-button text type="primary" @click="handleDel(scope.row)" v-permission="['system_dict_delete']">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				@size-change="handleSizeChange"
				@current-change="handleCurrentChange"
				:pager-count="5"
				:page-sizes="[10, 20, 30]"
				v-model:current-page="state.tableData.param.pageNum"
				background
				v-model:page-size="state.tableData.param.pageSize"
				layout="total, sizes, prev, pager, next, jumper"
				:total="state.tableData.total"
			>
			</el-pagination>
		</el-card>
		<EditDialog ref="editFormRef" @refresh="handleQuery()" />
		<ItemDialog ref="itemFormRef" />
	</div>
</template>

<script setup lang="ts" name="systemRole">
import { defineAsyncComponent, reactive, onMounted, ref } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import dictApi from '/@/api/system/dict';

// 引入组件
const EditDialog = defineAsyncComponent(() => import('./component/editDialog.vue'));
const ItemDialog = defineAsyncComponent(() => import('./component/itemDialog.vue'));

// 定义变量内容
const queryFormRef = ref();
const editFormRef = ref();
const itemFormRef = ref();
const state = reactive({
	tableData: {
		data: [],
		total: 0,
		loading: false,
		param: {
			pageNum: 1,
			pageSize: 10,
			dictName: undefined,
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
	dictApi.query(state.tableData.param).then((res) => {
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

// 打开选项弹窗
const openItemDialog = (row: any) => {
	itemFormRef.value.openDialog(row);
};

// 删除
const handleDel = (row: any) => {
	ElMessageBox.confirm(`此操作将永久删除字典名称：“${row.dictName}”?`, '提示', {
		confirmButtonText: '确认',
		cancelButtonText: '取消',
		type: 'warning',
	})
		.then(() => {
			dictApi.delete({ id: row.id }).then((res) => {
				if (res.success) {
					handleQuery();
					ElMessage.success('删除成功');
				}
			});			
		})
		.catch(() => {});
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


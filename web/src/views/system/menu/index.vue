<template>
	<div class="layout-pd">
		<el-card shadow="hover" style="margin-top: 10px">
			<div>
				<el-button type="primary" @click="openEditDialog()" v-permission="['system_menu_add']" plain>
					<el-icon>
						<ele-Plus />
					</el-icon>
					新增
				</el-button>
			</div>
			<el-table
				:data="state.tableData.data"
				v-loading="state.tableData.loading"
				row-key="id"
				:tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
			>
				<el-table-column label="菜单名称"  show-overflow-tooltip>
					<template #default="scope">
						<SvgIcon :name="scope.row.icon" />
						<span class="ml10">{{ scope.row.menuName }}</span>
					</template>
				</el-table-column>
				<el-table-column prop="path" label="路由路径" show-overflow-tooltip></el-table-column>
				<el-table-column prop="component" label="组件路径" show-overflow-tooltip></el-table-column>
				<el-table-column prop="permission" label="权限标识" show-overflow-tooltip></el-table-column>
				<el-table-column prop="sort" label="排序" show-overflow-tooltip></el-table-column>
				<el-table-column prop="status" label="菜单状态" show-overflow-tooltip>
					<template #default="scope">
						<el-tag v-if="scope.row.status == 0">启用</el-tag>
						<el-tag type="info" v-else>禁用</el-tag>
					</template>
				</el-table-column>
				<el-table-column label="操作" show-overflow-tooltip width="140">
					<template #default="scope">
						<el-button text type="primary" @click="openEditDialog(scope.row)" v-permission="['system_menu_update']">修改</el-button>
						<el-button text type="primary" @click="handleDel(scope.row)" v-permission="['system_menu_delete']">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-card>
		<EditDialog ref="editFormRef" @refresh="handleQuery()" />
	</div>
</template>

<script setup lang="ts" name="systemMenu">
import { defineAsyncComponent, ref, onMounted, reactive } from 'vue';
import { RouteRecordRaw } from 'vue-router';
import { ElMessageBox, ElMessage } from 'element-plus';
import { storeToRefs } from 'pinia';
import { useRoutesList } from '/@/stores/routesList';
import menuApi from '/@/api/system/menu';

// 引入组件
const EditDialog = defineAsyncComponent(() => import('./component/editDialog.vue'));

// 定义变量内容
const stores = useRoutesList();
const { routesList } = storeToRefs(stores);
const queryFormRef = ref();
const editFormRef = ref();
const state = reactive({
	tableData: {
		data: [],
		loading: true,
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

// 获取路由数据，真实请从接口获取
const handleQuery = () => {
	state.tableData.loading = true;
	menuApi.tree().then((res) => {
		if (res.success) {
			state.tableData.data = res.data;
			state.tableData.loading = false;
		}
	});
};
// 打开新增菜单弹窗
const openEditDialog = (row: any) => {
	editFormRef.value.openDialog(row);
};

// 打开编辑菜单弹窗
const onOpenEditMenu = (type: string, row: RouteRecordRaw) => {
	editFormRef.value.openDialog(type, row);
};

// 删除
const handleDel = (row: any) => {
	ElMessageBox.confirm(`此操作将永久删除菜单：${row.menuName}`, '提示', {
		confirmButtonText: '确认',
		cancelButtonText: '取消',
		type: 'warning',
	})
		.then(() => {
			menuApi.delete({ id: row.id }).then((res) => {
				if (res.success) {
					handleQuery();
					ElMessage.success('删除成功');
				}
			});
		})
		.catch(() => {});
};
</script>

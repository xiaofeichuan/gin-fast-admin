<template>
	<div class="layout-padding">
		<el-card shadow="hover" :body-style="{ paddingBottom: 0 }">
			<el-form :model="state.tableData.param" ref="queryFormRef" :inline="true" label-width="70px">
				<el-form-item label="用户账号" prop="userName">
					<el-input
						v-model="state.tableData.param.userName"
						placeholder="请输入用户账号/手机/昵称"
						style="width: 200px"
						@keyup.enter="handleQuery"
						clearable
					/>
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
				<el-button type="primary" @click="openEditDialog()" v-permission="['system_user_add']" plain>
					<el-icon>
						<ele-Plus />
					</el-icon>
					新增
				</el-button>
			</div>
			<el-table :data="state.tableData.data" v-loading="state.tableData.loading">
				<el-table-column prop="id" label="编号" width="80" fixed></el-table-column>
				<el-table-column prop="userName" label="账户账号" fixed show-overflow-tooltip></el-table-column>
				<el-table-column prop="nickName" label="用户昵称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="phone" label="手机号" show-overflow-tooltip></el-table-column>
				<el-table-column prop="email" label="邮箱" show-overflow-tooltip></el-table-column>
				<el-table-column prop="status" label="用户状态" show-overflow-tooltip>
					<template #default="scope">
						<el-switch
							v-model="scope.row.status"
							inline-prompt
							:active-value="0"
							:inactive-value="1"
							active-text="启用"
							inactive-text="禁用"
							@change="handleSetStatus(scope.row)"
							:disabled="!useUserInfo().hasPermission('system_user_setStatus')"
						></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="createdAt" label="创建时间" show-overflow-tooltip></el-table-column>
				<el-table-column prop="remark" label="用户描述" show-overflow-tooltip></el-table-column>
				<el-table-column label="操作" width="150" fixed="right">
					<template #default="scope">
						<el-button text type="primary" @click="openEditDialog(scope.row)" v-permission="['system_user_update']">修改</el-button>
						<el-button text type="primary" @click="handleDel(scope.row)" v-permission="['system_user_delete']">删除</el-button>
						<el-dropdown @command="(command:any) => handleCommand(command, scope.row)" v-permission="['system_user_resetPwd']">
							<el-button text icon="ele-MoreFilled" size="small" type="primary" class="ml10 mt4" />
							<template #dropdown>
								<el-dropdown-menu>
									<el-dropdown-item command="handleResetPwd">重置密码</el-dropdown-item>
									<!-- <el-dropdown-item>分配角色</el-dropdown-item> -->
								</el-dropdown-menu>
							</template>
						</el-dropdown>
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
	</div>
</template>

<script setup lang="ts">
import { defineAsyncComponent, reactive, onMounted, ref } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import userApi from '/@/api/system/user';
import { useUserInfo } from '/@/stores/userInfo';
// 引入组件
const EditDialog = defineAsyncComponent(() => import('./component/editDialog.vue'));

// 定义变量内容
const queryFormRef = ref();
const editFormRef = ref();
const state = reactive({
	tableData: {
		data: [],
		total: 0,
		loading: false,
		param: {
			pageNum: 1,
			pageSize: 10,
			userName: undefined,
		},
	},
});

// 页面加载时
onMounted(() => {
	handleQuery();
});

// 重置表单
const resetQueryForm = () => {
	queryFormRef.value?.resetFields();
	handleQuery();
};

// 查询数据
const handleQuery = () => {
	state.tableData.loading = true;
	userApi.query(state.tableData.param).then((res) => {
		if (res.success) {
			state.tableData.data = res.data.list;
			state.tableData.total = res.data.totalCount;
			state.tableData.loading = false;
		}
	});
};

// 设置用户状态
const handleSetStatus = (row: any) => {
	let text = row.status === 0 ? '启用' : '禁用';
	ElMessageBox.confirm(`是否确定${text}账号为：${row.userName}?`, '提示', {
		confirmButtonText: '确认',
		cancelButtonText: '取消',
		type: 'warning',
	})
		.then(() => {
			userApi.setStatus({ userId: row.id, status: row.status }).then((res) => {
				if (res.success) {
					handleQuery();
					ElMessage.success('设置成功');
				}
			});
		})
		.catch(() => {
			if (row.status == 0) {
				row.status = 1;
			} else {
				row.status = 0;
			}
		});
};

// 打开编辑弹窗
const openEditDialog = (row?: any) => {
	editFormRef.value.openDialog(row);
};

// 删除
const handleDel = (row: any) => {
	if (row.userType === 1) {
		ElMessage.error('超级管理员不允许删除');
		return;
	}
	ElMessageBox.confirm(`此操作将永久删除账号：${row.userName}`, '提示', {
		confirmButtonText: '确认',
		cancelButtonText: '取消',
		type: 'warning',
	})
		.then(() => {
			userApi.delete({ id: row.id }).then((res) => {
				if (res.success) {
					handleQuery();
					ElMessage.success('删除成功');
				}
			});
		})
		.catch(() => {});
};

//更多操作触发
const handleCommand = (command: string, row: any) => {
	console.log('handleCommand：' + command);
	switch (command) {
		case 'handleResetPwd':
			handleResetPwd(row);
			break;

		default:
			break;
	}
};

//重置密码
const handleResetPwd = (row: any) => {
	ElMessageBox.prompt(`请输入账号【${row.userName}】的新密码 `, '提示', {
		confirmButtonText: '确定',
		cancelButtonText: '取消',
		inputPattern: /^.{6,20}$/,
		inputErrorMessage: '请输入6-20位密码',
	})
		.then(({ value }) => {
			userApi.resetPwd({ userId: row.id, password: value }).then((res) => {
				if (res.success) {
					ElMessage.success('重置成功');
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


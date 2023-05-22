<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="750px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" label-width="90px">
			<el-row :gutter="30">
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="账号名称" prop="userName">
						<el-input v-model="state.dataForm.userName" placeholder="请输入账号名称" :disabled="state.dialog.isEdit"
							clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="用户昵称" prop="nickName">
						<el-input v-model="state.dataForm.nickName" placeholder="请输入用户昵称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="手机号码" prop="phone">
						<el-input v-model="state.dataForm.phone" placeholder="请输入手机号" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="邮箱" prop="email">
						<el-input v-model="state.dataForm.email" placeholder="请输入邮箱" clearable></el-input>
					</el-form-item>
				</el-col>

				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="性别" prop="gender">
						<el-select v-model="state.dataForm.gender" placeholder="请选择性别" clearable class="w100">
							<!-- <el-option label="未知" :value="0"></el-option>
							<el-option label="男" :value="1"></el-option>
							<el-option label="女" :value="2"></el-option> -->
							<el-option v-for="item in useDictData().getDictItem('user_gender')" :key="item.dictItemValue"
								:label="item.dictItemName" :value="item.dictItemValue">
							</el-option>
						</el-select>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="用户状态" prop="status">
						<el-switch v-model="state.dataForm.status" :active-value="0" :inactive-value="1" inline-prompt
							active-text="启用" inactive-text="禁用"></el-switch>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" v-if="!state.dialog.isEdit">
					<el-form-item label="账户密码" prop="password">
						<el-input v-model="state.dataForm.password" placeholder="请输入账户密码" type="password"
							show-password></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="用户角色" prop="roleIds">
						<el-select v-model="state.dataForm.roleIds" multiple collapse-tags collapse-tags-tooltip
							:max-collapse-tags="2" placeholder="请选择角色" style="width: 100%">
							<el-option v-for="item in state.roleOption" :key="item.id" :label="item.roleName"
								:value="item.id" />
						</el-select>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
					<el-form-item label="用户备注" prop="remark">
						<el-input v-model="state.dataForm.remark" type="textarea" placeholder="请输入用户描述"
							maxlength="150"></el-input>
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
import { useDictData } from '/@/stores/dictData';
import userApi from '/@/api/system/user';
import roleApi from '/@/api/system/role';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dataFormRef = ref();
const state = reactive({
	dataForm: {
		id: 0, //用户id
		userName: '', // 账号名称
		nickName: '', // 用户昵称
		phone: '', // 手机号
		email: '', // 邮箱
		gender: 0, // 性别
		password: '123456', // 账户密码
		status: 0, // 用户状态
		remark: '', // 备注
		roleIds: [],
	},
	rules: {
		userName: [{ required: true, message: '账号名称不能为空', trigger: 'blur' }],
		nickName: [{ required: true, message: '用户昵称不能为空', trigger: 'blur' }],
		email: [{ type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }],
		phone: [{ pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/, message: '请输入正确的手机号码', trigger: 'blur' }],
		password: [{ pattern: /^(?=.*[0-9])(.{6,18})$/, message: '请输入6-18位密码', trigger: 'blur' }],
	},

	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
	roleOption: [] as any,
});

// 打开弹窗
const openDialog = (row: any) => {
	getRoleOption();
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '编辑用户';
		nextTick(() => {
			getUserDetail(row.id);
		});
	} else {
		state.dialog.isEdit = false;
		state.dialog.title = '添加用户';
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
			userApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			userApi.add(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('添加成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		}
	});
};
const getRoleOption = () => {
	roleApi.list().then((res) => {
		if (res.success) {
			state.roleOption = res.data;
		}
	});
};

// 获取用户详细
const getUserDetail = (userId: number) => {
	userApi.detail({ id: userId }).then((res) => {
		if (res.success) {
			Object.assign(state.dataForm, res.data);
		}
	});
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>

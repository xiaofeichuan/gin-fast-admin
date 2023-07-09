<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="750px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" size="default" label-width="90px">
			<el-row :gutter="35">
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="用户id" prop="userId">
						<el-input v-model="state.dataForm.userId" placeholder="请输入用户id" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="登录时间" prop="loginTime">
						<el-date-picker v-model="state.dataForm.loginTime" type="datetime" style="width: 100%;"/>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="IP地址" prop="ipAddress">
						<el-input v-model="state.dataForm.ipAddress" placeholder="请输入IP地址" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="登录位置" prop="location">
						<el-input v-model="state.dataForm.location" placeholder="请输入登录位置" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="浏览器" prop="browser">
						<el-input v-model="state.dataForm.browser" placeholder="请输入浏览器" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="操作系统" prop="operatingSystem">
						<el-input v-model="state.dataForm.operatingSystem" placeholder="请输入操作系统" clearable></el-input>
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
import { reactive, ref ,nextTick} from 'vue';
import { ElMessage } from 'element-plus';
import loginLogApi from '/@/api/system/loginLog';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dataFormRef = ref();
const state = reactive({
	dataForm: {
		userId: undefined,// 用户id
		loginTime: undefined,// 登录时间
		ipAddress: undefined,// IP地址
		location: undefined,// 登录位置
		browser: undefined,// 浏览器
		operatingSystem: undefined,// 操作系统
	},
	rules: {},
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
});

// 打开弹窗
const openDialog = (row: any) => {
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '编辑配置';
		nextTick(() => {
			Object.assign(state.dataForm, row);
		});
	} else {
		state.dialog.isEdit = false;
		state.dialog.title = '添加配置';
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
			loginLogApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			loginLogApi.add(state.dataForm).then((res) => {
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


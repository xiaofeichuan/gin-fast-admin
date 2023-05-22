<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="750px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" size="default" label-width="90px">
			<el-row :gutter="35">
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="字典名称" prop="dictName">
						<el-input v-model="state.dataForm.dictName" placeholder="请输入字典名称" clearable></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="字典类型" prop="dictType">
						<el-select v-model="state.dataForm.dictType" placeholder="请选择字典类型" clearable class="w100">
							<!-- <el-option label="整数" :value="0"></el-option>
								<el-option label="字符" :value="1"></el-option> -->
							<el-option v-for="item in state.dictTypeOption" :key="item.dictItemValue" :label="item.dictItemName" :value="item.dictItemValue">
							</el-option>
						</el-select>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="字典代码" prop="dictCode">
						<el-input v-model="state.dataForm.dictCode" placeholder="请输入字典代码" clearable></el-input>
					</el-form-item>
				</el-col>

				<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					<el-form-item label="字典状态" prop="status">
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
				<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
					<el-form-item label="字典描述" prop="remark">
						<el-input v-model="state.dataForm.remark" type="textarea" placeholder="请输入字典描述" maxlength="150"></el-input>
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
import dictApi from '/@/api/system/dict';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dataFormRef = ref();
const state = reactive({
	dataForm: {
		dictName: '', // 字典名称
		dictType: 0, // 字典类型
		dictCode: '', // 字典代码
		status: 0, // 角色状态
		remark: '', // 角色描述
	},
	rules: {
		dictName: [{ required: true, message: '字典名称不能为空', trigger: 'blur' }],
		dictCode: [{ required: true, message: '字典代码不能为空', trigger: 'blur' }],
	},
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
	dictTypeOption:[] as any,
});

// 打开弹窗
const openDialog = (row: any) => {
	state.dictTypeOption = useDictData().getDictItem('dict_type');
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '编辑角色';
		nextTick(() => {
			Object.assign(state.dataForm, row);
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

// 提交
const onSubmit = () => {
	dataFormRef.value.validate(async (valid: boolean) => {
		if (!valid) {
			return;
		}

		if (state.dialog.isEdit) {
			//更新
			dictApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			dictApi.add(state.dataForm).then((res) => {
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


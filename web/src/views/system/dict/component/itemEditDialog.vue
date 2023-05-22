<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="450px" @close="closeDialog">
		<el-form ref="dataFormRef" :model="state.dataForm" :rules="state.rules" size="default" label-width="90px">
			<el-row>
				<el-form-item label="选项名称" prop="dictItemName" class="w100">
					<el-input v-model="state.dataForm.dictItemName" placeholder="请输入选项名称" clearable></el-input>
				</el-form-item>
				<el-form-item label="选项值" prop="dictItemValue" class="w100">
					<el-input v-model="state.dataForm.dictItemValue" placeholder="请输入选项值" clearable></el-input>
				</el-form-item>
				<el-form-item label="选项状态" prop="status">
					<el-switch
						v-model="state.dataForm.status"
						:active-value="0"
						:inactive-value="1"
						inline-prompt
						active-text="启用"
						inactive-text="禁用"
					></el-switch>
				</el-form-item>
				<el-form-item label="字典描述" prop="remark" class="w100">
					<el-input v-model="state.dataForm.remark" type="textarea" placeholder="请输入字典描述" maxlength="150"></el-input>
				</el-form-item>
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
import { ElMessage, FormInstance } from 'element-plus';
import dictItemApi from '/@/api/system/dictItem';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dataFormRef = ref<FormInstance>();
const state = reactive({
	dictType: 0, //字典类型（0int，1string）
	dataForm: {
		dictId: 0, //字典id
		dictItemName: '', // 选项名称
		dictItemValue: '', // 选项值
		status: 0, // 角色状态
		remark: '', // 角色描述
	},
	rules: {
		dictItemName: [{ required: true, message: '选项名称不能为空', trigger: 'blur' }],
		dictItemValue: [
			{ required: true, message: '选项值不能为空', trigger: 'blur' },
			{
				validator(rule: any, value: any, callback: any) {
					
					let exp = /^-?[1-9]\d*|0$/;

					if (state.dictType == 0 && !exp.test(value)) {
						callback(new Error('选项值为整数类型'));
					}
					callback()
				},
			},
		],
	},
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
});

// 打开弹窗
const openDialog = (dictData: any, row: any) => {
	state.dataForm.dictId = dictData.id;
	state.dictType = dictData.dictType;
	
	if (row) {
		state.dialog.isEdit = true;
		state.dialog.title = '编辑选项';
		nextTick(() => {
			Object.assign(state.dataForm, row);
		});
	} else {
		state.dialog.isEdit = false;
		state.dialog.title = '添加选项';
	}
	state.dialog.isShowDialog = true;
};

// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
	// 重置表单
	dataFormRef.value?.resetFields();
};

// 提交
const onSubmit = () => {
	debugger
	dataFormRef.value?.validate(async (valid: boolean) => {
		if (!valid) {
			return;
		}

		if (state.dialog.isEdit) {
			//更新
			dictItemApi.update(state.dataForm).then((res) => {
				if (res.success) {
					ElMessage.success('更新成功');
					emit('refresh'); //刷新页面
					closeDialog();
				}
			});
		} else {
			//添加
			dictItemApi.add(state.dataForm).then((res) => {
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


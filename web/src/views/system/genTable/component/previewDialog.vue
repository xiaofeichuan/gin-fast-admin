<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="750px" @close="closeDialog">
		<el-tabs type="border-card">
			<el-tab-pane v-for="item in state.previewCodeList" :label="item.fileName">{{ item.fileContent }}</el-tab-pane>
		</el-tabs>
	</el-dialog>
</template>

<script setup lang="ts">
import { reactive, ref, nextTick } from 'vue';
import { ElMessage } from 'element-plus';
import genTableApi from '/@/api/system/genTable';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

const state = reactive({
	previewCodeList: [] as any,
	dialog: {
		isShowDialog: false,
		isEdit: false,
		title: '',
	},
});

// 打开弹窗
const openDialog = (row: any) => {
	state.dialog.isEdit = true;
	state.dialog.title = '代码预览';
	getPreviewCodeList()
	
	state.dialog.isShowDialog = true;
};
// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
};

// 获取表列表
const getPreviewCodeList = () => {
	genTableApi.previewCode().then((res) => {
		if (res.success) {
			state.previewCodeList = res.data;
		}
	});
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>



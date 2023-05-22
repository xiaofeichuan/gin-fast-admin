<template>
	<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="1200px" @close="closeDialog">
		<el-tabs>
			<el-tab-pane v-for="item in state.previewCodeList" :label="item.fileName">
				<el-button @click="copyCode(item.fileContent)" circle style="position: absolute;right: 10px;top: 9px;">
					<el-icon>
						<ele-DocumentCopy />
					</el-icon>
				</el-button>
				<highlightjs :code="item.fileContent" />
			</el-tab-pane>
		</el-tabs>
	</el-dialog>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue';
import genTableApi from '/@/api/system/genTable';
import commonFunction from '/@/utils/commonFunction';

const { copyText } = commonFunction();
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
	getPreviewCodeList(row.id)

	state.dialog.isShowDialog = true;
};

// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
	state.previewCodeList = [];
};

// 获取表列表
const getPreviewCodeList = (tableId: number) => {
	genTableApi.previewCode({ tableId: tableId }).then((res) => {
		if (res.success) {
			state.previewCodeList = res.data;
		}
	});
};

// 复制代码
const copyCode = (text:string) => {
	copyText(text)
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>



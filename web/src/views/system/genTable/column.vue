<template>
	<div class="layout-padding">
		<el-card shadow="hover">
			<el-table :data="state.tableData.data" v-loading="state.tableData.loading" >
				<!-- <el-table-column prop="id" label="编号" width="60" /> -->
				<el-table-column prop="columnDescription" label="描述" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.columnDescription" placeholder="字段描述" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="columnName" label="字段" show-overflow-tooltip></el-table-column>

				<el-table-column prop="codeField" label="代码字段" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.codeField" placeholder="代码字段" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="paramName" label="参数字段" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.paramName" placeholder="参数名称" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="columnType" label="字段类型" show-overflow-tooltip></el-table-column>
				<el-table-column prop="codeType" label="代码类型" show-overflow-tooltip>
					<template #default="scope">
						<el-input v-model="scope.row.codeType" placeholder="代码类型" clearable></el-input>
					</template>
				</el-table-column>
				<el-table-column prop="componentType" label="组件类型" show-overflow-tooltip>
					<template #default="scope">
						<el-select v-model="scope.row.componentType" placeholder="请选择" clearable>
							<el-option v-for="item in useDictData().getDictItem('component_type')" :key="item.dictItemValue"
								:label="item.dictItemName" :value="item.dictItemValue">
							</el-option>
						</el-select>
					</template>
				</el-table-column>
				<el-table-column prop="dictCode" label="字典类型" show-overflow-tooltip>
					<template #default="scope">
						<el-select v-model="scope.row.dictCode" placeholder="请选择"
							:disabled="scope.row.componentType != 'Select'" clearable>
							<el-option v-for="item in useDictData().getDictList()" :key="item.dictCode"
								:label="item.dictName + '(' + item.dictCode + ')'" :value="item.dictCode">
							</el-option>
						</el-select>
					</template>
				</el-table-column>
				<!-- <el-table-column prop="isPk" label="是否主键" show-overflow-tooltip>
					<template #default="scope">
						<el-switch v-model="scope.row.isPk" inline-prompt :active-value="true" :inactive-value="false"
							active-text="启用" inactive-text="禁用"></el-switch>
					</template>
				</el-table-column> -->
				<el-table-column prop="isEdit" label="是否编辑" width="80" show-overflow-tooltip>
					<template #default="scope">
						<el-switch v-model="scope.row.isEdit" inline-prompt :active-value="true" :inactive-value="false"
							active-text="启用" inactive-text="禁用"></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="isList" label="是否列表" width="80" show-overflow-tooltip>
					<template #default="scope">
						<el-switch v-model="scope.row.isList" inline-prompt :active-value="true" :inactive-value="false"
							active-text="启用" inactive-text="禁用"></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="isQuery" label="是否查询" width="80" show-overflow-tooltip>
					<template #default="scope">
						<el-switch v-model="scope.row.isQuery" inline-prompt :active-value="true" :inactive-value="false"
							active-text="启用" inactive-text="禁用"></el-switch>
					</template>
				</el-table-column>
				<el-table-column prop="queryMethod" label="查询方式" width="115" show-overflow-tooltip>
					<template #default="scope">
						<el-select v-model="scope.row.queryMethod" placeholder="请选择" :disabled="!scope.row.isQuery"
							clearable>
							<el-option v-for="item in useDictData().getDictItem('query_method')" :key="item.dictItemValue"
								:label="item.dictItemName" :value="item.dictItemValue">
							</el-option>
						</el-select>
					</template>
				</el-table-column>
			</el-table>
			<div style="text-align: right;margin-top: 20px;">
				<el-button type="primary" @click="save()" v-permission="['system_genTable_add']">
					保存
				</el-button>
			</div>
		</el-card>
	</div>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import genTableColumnApi from '/@/api/system/genTableColumn';
import { useRoute, useRouter } from 'vue-router';
import { useDictData } from '/@/stores/dictData';

const route = useRoute();
const state = reactive({
	tableData: {
		data: [],
		loading: true,
	},
});

// 页面加载时
onMounted(() => {
	var tableId = route.query.tableId
	handleQuery(tableId);
});

// 初始化表格数据
const handleQuery = (tableId: any) => {
	state.tableData.loading = true;
	genTableColumnApi.list({ tableId: tableId }).then((res) => {
		if (res.success) {
			state.tableData.data = res.data;
			state.tableData.loading = false;
		}
	});
};

// 保存
const save = () => {
	genTableColumnApi.update(state.tableData.data).then((res) => {
		if (res.success) {
			ElMessage.success('保存成功');
		}
	});
};
</script>



<template>
    <div class="layout-padding">
        <el-row :gutter="10">
            <el-col :xs="24" :sm="8" :md="8" :lg="8" :xl="8">
                <el-card shadow="hover">
                    <template #header>
                        <span>缓存列表</span>
                    </template>
                    <el-table :data="state.tableData.data" v-loading="state.tableData.loading" max-height="600" @row-click="getCacheValue">
                        <el-table-column type="index" label="序号" width="100" />
                        <el-table-column prop="key" label="缓存键名" show-overflow-tooltip></el-table-column>
                        <el-table-column label="操作" width="100">
                            <template #default="scope">
                                <el-button text type="primary" @click="handleDel(scope.row)"
                                    v-permission="['system_monitor_deleteCache']">删除</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </el-card>
            </el-col>
            <el-col :xs="24" :sm="16" :md="16" :lg="16" :xl="16">
                <el-card shadow="hover">
                    <template #header>
                        <span>缓存数据</span>
                    </template>
                    <vue-json-pretty :data="state.cacheValue" showLength showIcon showLineNumber showSelectController style="height:600px;overflow-y: auto;">
                    </vue-json-pretty>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script setup lang="ts">
import { reactive, onMounted } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import monitorApi from '/@/api/system/monitor';
import VueJsonPretty from 'vue-json-pretty';
import 'vue-json-pretty/lib/styles.css';

const state = reactive({
    tableData: {
        data: [] as any,
        loading: false,
    },
    cacheValue: ''
});

// 页面加载时
onMounted(() => {
    handleQuery();
});

// 初始化表格数据
const handleQuery = () => {
    state.tableData.loading = true;
    monitorApi.cacheKeys().then((res) => {
        if (res.success) {
            var data = []
            for (let index = 0; index < res.data.length; index++) {
                data.push({ key: res.data[index] })
            }
            state.tableData.data = data;
            state.tableData.loading = false;
        }
    });
};

// 获取缓存数据
const getCacheValue = (row: any, column: any, event: any) => {
    monitorApi.cacheValue({ key: row.key }).then((res) => {
        state.cacheValue = res.data;
    });
    console.log(row)
    console.log(column)
    console.log(event)
}

// 删除
const handleDel = (row: any) => {
    ElMessageBox.confirm(`是否删除此记录`, '提示', {
        confirmButtonText: '确认',
        cancelButtonText: '取消',
        type: 'warning',
    })
        .then(() => {
            monitorApi.deleteCache({ key: row.key }).then((res) => {
                if (res.success) {
                    handleQuery();
                    ElMessage.success('删除成功');
                }
            });
        })
        .catch(() => { });
};

</script>
        
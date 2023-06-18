<template>
    <div class="layout-padding">
        <el-row :gutter="10">
            <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" style="margin-bottom: 10px;">
                <el-card shadow="hover">
                    <template #header>
                        <span>系统信息</span>
                    </template>
                    <el-row style="height: 260px;">
                        <table class="server_table">
                        <tr>
                            <td class="server_table_title">主机名称</td>
                            <td> {{ state.data.host.hostname }}</td>
                        </tr>
                        <tr>
                            <td class="server_table_title">操作系统</td>
                            <td>{{ state.data.host.platform }}</td>
                        </tr>
                        <tr>
                            <td class="server_table_title">系统架构</td>
                            <td>{{ state.data.host.kernelArch }}</td>
                        </tr>
                        <tr>
                            <td class="server_table_title">CPU核数</td>
                            <td>{{ state.data.cpu[0]?.modelName }}</td>
                        </tr>
                        <tr>
                            <td class="server_table_title">CPU核数</td>
                            <td>{{ state.data.cpu[0]?.cores }} 核</td>
                        </tr>
                        <tr>
                            <td class="server_table_title">公网IP</td>
                            <td>{{ state.data.remoteIp.replace("当前 IP：", "").replace("来自于：", "") }}</td>
                        </tr>
                    </table>
                    </el-row>
                    
                </el-card>
            </el-col>
            <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" style="margin-bottom: 10px;">
                <el-card shadow="hover">
                    <template #header>
                        <span>使用信息</span>
                    </template>
                    <el-row style="height: 260px;" >
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" :xl="12" class="server_useInfo">
                            <el-progress type="dashboard" :percentage="state.data.memory.usedPercent"
                                :color="'var(--el-color-primary)'">
                                <template #default>
                                    <span>{{ state.data.memory.usedPercent }}%<br /></span>
                                    <span style="font-size: 10px">
                                        已用:{{ getSize(state.data.memory.used) }}<br />
                                        剩余:{{ getSize(state.data.memory.free) }}<br />
                                        内存使用率
                                    </span>
                                </template>
                            </el-progress>
                        </el-col>
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" :xl="12" class="server_useInfo">
                            <el-progress type="dashboard" :percentage="state.data.cpuPercent"
                                :color="'var(--el-color-primary)'">
                                <template #default>
                                    <span>{{ state.data.cpuPercent?.toFixed(2) }}%<br /></span>
                                    <span style="font-size: 10px">
                                        CPU使用率
                                    </span>
                                </template>
                            </el-progress>
                        </el-col>
                    </el-row>

                </el-card>
            </el-col>
        </el-row>
        <el-row >
            <el-col>
                <el-card shadow="hover">
                    <template #header>
                        <span>磁盘</span>
                    </template>
                    <el-table :data="state.data.disk">
                        <el-table-column label="盘符路径" prop="path" />
                        <el-table-column label="总大小" prop="total">
                            <template #default="scope">
                                {{ getSize(scope.row.total) }}
                            </template>
                        </el-table-column>
                        <el-table-column label="可用空间" prop="free">
                            <template #default="scope">
                                {{ getSize(scope.row.free) }}
                            </template>
                        </el-table-column>
                        <el-table-column label="已用空间" prop="used">
                            <template #default="scope">
                                {{ getSize(scope.row.used) }}
                            </template>
                        </el-table-column>
                        <el-table-column label="使用率" prop="usedPercent">
                            <template #default="scope">
                                {{ scope.row.usedPercent.toFixed(2) }}%
                            </template>
                        </el-table-column>
                    </el-table>
                </el-card>
            </el-col>
        </el-row>

    </div>
</template>

<script setup lang="ts" >
import { reactive, onMounted } from 'vue';
import monitorApi from '/@/api/system/monitor';
import { number } from 'echarts';

const state = reactive({
    data: {
        disk: [] as any,
        host: {} as any,
        cpu: [] as any,
        memory: {} as any,
        remoteIp: '',
    } as any,
});

// 页面加载时
onMounted(() => {
    handleQuery();
});

// 初始数据
const handleQuery = () => {
    monitorApi.serverInfo().then((res) => {
        if (res.success) {
            state.data = res.data;
        }
    });
};

const getSize = (size: number) => {
    if (!size)
        return "";

    var num = 1024.00; //byte

    if (size < num)
        return size + "B";
    if (size < Math.pow(num, 2))
        return (size / num).toFixed(2) + "K"; //kb
    if (size < Math.pow(num, 3))
        return (size / Math.pow(num, 2)).toFixed(2) + "M"; //M
    if (size < Math.pow(num, 4))
        return (size / Math.pow(num, 3)).toFixed(2) + "G"; //G
    return (size / Math.pow(num, 4)).toFixed(2) + "T"; //T
};
</script>

<style lang="scss" scoped>
.server_table {
    width: 100%;
    min-height: 40px;
    line-height: 40px;
    text-align: center;
}

.server_table td {
    border-bottom: 1px solid #e8e8e8;
}

.server_table_title {
    width: 120px;
}
.server_useInfo{
    display: flex;
    justify-content: center;
    align-items: Center;
}
</style>
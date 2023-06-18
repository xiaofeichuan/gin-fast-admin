import request from '/@/utils/request';

/**
 * 监控接口
 */
class MonitorApi {
	/**
	 * 获取缓存key
	 * @returns 
	 */
	cacheKeys() {
		return request({
			url: '/system/monitor/cacheKeys',
			method: 'get',
		});
	}
	/**
	 * 获取缓存value
	 * @returns 
	 */
	cacheValue(parameter: any) {
		return request({
			url: '/system/monitor/cacheValue',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 删除缓存
	 * @returns 
	 */
	deleteCache(parameter: any) {
		return request({
			url: '/system/monitor/deleteCache',
			method: 'post',
			params: parameter
		});
	}
	/**
	 * 获取服务器信息
	 * @returns 
	 */
	serverInfo() {
		return request({
			url: '/system/monitor/serverInfo',
			method: 'get',
		});
	}
}
export default new MonitorApi()
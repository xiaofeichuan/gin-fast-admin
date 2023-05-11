import request from '/@/utils/request';

/**
 * 配置接口
 */
 class ConfigApi {
	/**
	 * 配置查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter:any) {
		return request({
			url: '/system/config/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 新增配置
	 * @param parameter 
	 * @returns 
	 */
	 add(parameter:any) {
		return request({
			url: '/system/config/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 更新配置
	 * @param parameter 
	 * @returns 
	 */
	 update(parameter:any) {
		return request({
			url: '/system/config/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 配置删除
	 * @param parameter 
	 * @returns 
	 */
	 delete(parameter:any) {
		return request({
			url: '/system/config/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 配置详情
	 * @param parameter 
	 * @returns 
	 */
	 detail(parameter:any) {
		return request({
			url: '/system/config/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 配置列表
	 * @returns 
	 */
	 list() {
		return request({
			url: '/system/config/list',
			method: 'get',
		});
	}
}

export default new ConfigApi()
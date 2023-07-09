import request from '/@/utils/request';

/**
 * 登录日志
 */
 class LoginLogApi {
	/**
	 * 登录日志查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter:any) {
		return request({
			url: '/system/loginLog/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 新增登录日志
	 * @param parameter 
	 * @returns 
	 */
	 add(parameter:any) {
		return request({
			url: '/system/loginLog/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 更新登录日志
	 * @param parameter 
	 * @returns 
	 */
	 update(parameter:any) {
		return request({
			url: '/system/loginLog/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 删除登录日志
	 * @param parameter 
	 * @returns 
	 */
	 delete(parameter:any) {
		return request({
			url: '/system/loginLog/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 登录日志详情
	 * @param parameter 
	 * @returns 
	 */
	 detail(parameter:any) {
		return request({
			url: '/system/loginLog/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 登录日志列表
	 * @returns 
	 */
	 list() {
		return request({
			url: '/system/loginLog/list',
			method: 'get',
		});
	}
}

export default new LoginLogApi()
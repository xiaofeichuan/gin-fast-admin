import request from '/@/utils/request';

/**
 * 用户接口
 */
class UserApi {
	/**
	 * 用户查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter: any) {
		return request({
			url: '/system/user/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 新增用户
	 * @param parameter 
	 * @returns 
	 */
	add(parameter: any) {
		return request({
			url: '/system/user/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 更新用户
	 * @param parameter 
	 * @returns 
	 */
	update(parameter: any) {
		return request({
			url: '/system/user/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 删除用户
	 * @param parameter 
	 * @returns 
	 */
	delete(parameter: any) {
		return request({
			url: '/system/user/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 用户详情
	 * @param parameter 
	 * @returns 
	 */
	detail(parameter: any) {
		return request({
			url: '/system/user/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 用户列表
	 * @returns 
	 */
	list() {
		return request({
			url: '/system/user/list',
			method: 'get',
		});
	}
	/**
	 * 设置用户状态
	 * @param parameter 
	 * @returns 
	 */
	setStatus(parameter: any) {
		return request({
			url: '/system/user/setStatus',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 重置密码
	 * @param parameter 
	 * @returns 
	 */
	resetPwd(parameter: any) {
		return request({
			url: '/system/user/resetPwd',
			method: 'post',
			data: parameter
		});
	}
}

export default new UserApi()
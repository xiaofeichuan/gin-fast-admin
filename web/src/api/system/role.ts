import request from '/@/utils/request';

/**
 * 角色接口
 */
 class RoleApi {
	/**
	 * 角色查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter:any) {
		return request({
			url: '/system/role/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 新增角色
	 * @param parameter 
	 * @returns 
	 */
	 add(parameter:any) {
		return request({
			url: '/system/role/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 更新角色
	 * @param parameter 
	 * @returns 
	 */
	 update(parameter:any) {
		return request({
			url: '/system/role/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 删除角色
	 * @param parameter 
	 * @returns 
	 */
	 delete(parameter:any) {
		return request({
			url: '/system/role/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 角色详情
	 * @param parameter 
	 * @returns 
	 */
	 detail(parameter:any) {
		return request({
			url: '/system/role/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 角色列表
	 * @returns 
	 */
	 list() {
		return request({
			url: '/system/role/list',
			method: 'get',
		});
	}
	/**
	 * 角色菜单权限
	 * @returns 
	 */
	authMenu(parameter:any) {
		return request({
			url: '/system/role/authMenu',
			method: 'get',
			params: parameter
		});
	}
}

export default new RoleApi()
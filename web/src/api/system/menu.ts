import request from '/@/utils/request';

/**
 * 菜单接口
 */
 class MenuApi {
	/**
	 * 菜单查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter:any) {
		return request({
			url: '/system/menu/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 菜单新增
	 * @param parameter 
	 * @returns 
	 */
	 add(parameter:any) {
		return request({
			url: '/system/menu/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 菜单新增
	 * @param parameter 
	 * @returns 
	 */
	 update(parameter:any) {
		return request({
			url: '/system/menu/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 菜单删除
	 * @param parameter 
	 * @returns 
	 */
	 delete(parameter:any) {
		return request({
			url: '/system/menu/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 菜单删除
	 * @param parameter 
	 * @returns 
	 */
	 detail(parameter:any) {
		return request({
			url: '/system/menu/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 菜单列表
	 * @returns 
	 */
	 list() {
		return request({
			url: '/system/menu/list',
			method: 'get',
		});
	}
	/**
	 * 菜单树状
	 * @returns 
	 */
	tree() {
		return request({
			url: '/system/menu/tree',
			method: 'get',
		});
	}
}

export default new MenuApi()
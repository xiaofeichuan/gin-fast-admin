import request from '/@/utils/request';

/**
 * 字典选项接口
 */
class DictItemApi {
	/**
	 * 字典选项查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter: any) {
		return request({
			url: '/system/dictItem/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 新增字典选项
	 * @param parameter 
	 * @returns 
	 */
	add(parameter: any) {
		return request({
			url: '/system/dictItem/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 更新字典选项
	 * @param parameter 
	 * @returns 
	 */
	update(parameter: any) {
		return request({
			url: '/system/dictItem/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 删除字典选项
	 * @param parameter 
	 * @returns 
	 */
	delete(parameter: any) {
		return request({
			url: '/system/dictItem/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 字典选项详情
	 * @param parameter 
	 * @returns 
	 */
	detail(parameter: any) {
		return request({
			url: '/system/dictItem/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 字典选项列表
	 * @returns 
	 */
	list(parameter: any) {
		return request({
			url: '/system/dictItem/list',
			method: 'get',
			params: parameter
		});
	}
}

export default new DictItemApi()
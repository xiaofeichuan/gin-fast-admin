import request from '/@/utils/request';

/**
 * 代码生成（表）接口
 */
 class GenTableApi {
	/**
	 * 代码生成查询
	 * @param parameter 
	 * @returns 
	 */
	query(parameter:any) {
		return request({
			url: '/system/genTable/query',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 新增代码生成
	 * @param parameter 
	 * @returns 
	 */
	 add(parameter:any) {
		return request({
			url: '/system/genTable/add',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 更新代码生成
	 * @param parameter 
	 * @returns 
	 */
	 update(parameter:any) {
		return request({
			url: '/system/genTable/update',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 删除代码生成
	 * @param parameter 
	 * @returns 
	 */
	 delete(parameter:any) {
		return request({
			url: '/system/genTable/delete',
			method: 'post',
			data: parameter
		});
	}
	/**
	 * 代码生成详情
	 * @param parameter 
	 * @returns 
	 */
	 detail(parameter:any) {
		return request({
			url: '/system/genTable/detail',
			method: 'get',
			params: parameter
		});
	}
	/**
	 * 代码生成列表
	 * @returns 
	 */
	 list() {
		return request({
			url: '/system/genTable/list',
			method: 'get',
		});
	}
	/**
	 * 获取表列表
	 * @returns 
	 */
	tableList() {
		return request({
			url: '/system/genTable/tableList',
			method: 'get',
		});
	}
	/**
	 * 获取表列表
	 * @returns 
	 */
	previewCode() {
		return request({
			url: '/system/genTable/previewCode',
			method: 'get',
		});
	}
}

export default new GenTableApi()
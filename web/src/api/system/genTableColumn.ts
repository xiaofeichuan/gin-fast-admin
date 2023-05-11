import request from '/@/utils/request';

/**
 * 代码生成（表字段）接口
 */
class GenTableColumnApi {
    /**
     * 更新代码生成（表字段）
     * @param parameter 
     * @returns 
     */
    update(parameter: any) {
        return request({
            url: '/system/genTableColumn/update',
            method: 'post',
            data: parameter
        });
    }
	/**
	 * 代码生成（表字段）列表
	 * @returns 
	 */
    list(parameter: any) {
		return request({
			url: '/system/genTableColumn/list',
			method: 'get',
            params: parameter
		});
	}
}


export default new GenTableColumnApi()
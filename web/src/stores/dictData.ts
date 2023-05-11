import { defineStore } from 'pinia';
import dictApi from '/@/api/system/dict';

/**
 * 用户信息
 */
export const useDictData = defineStore('dictData', {
	state: (): any => ({
		dictData: [],
	}),
	actions: {
		/**
		 * 获取字典
		 */
		async setDictData() {
			const res: any = await dictApi.list()
			if (res.success) {
				this.dictData = res.data;
			}
		},
		/**
		 * 获取字典列表
		 */
		getDictList() {			
			return this.dictData
		},
		/**
		 * 获取字典选项
		 */
		getDictItem(dictCode: string) {
			var dictData = this.dictData.filter((_: any) => _.dictCode == dictCode)
			if (dictData.length > 0) {
				return dictData[0].items
			}
			return []
		},
	},
});

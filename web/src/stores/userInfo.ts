import { defineStore } from 'pinia';
import authApi from '/@/api/system/auth';
import cache from '/@/utils/cache';

/**
 * 用户信息
 */
export const useUserInfo = defineStore('userInfo', {
	state: (): any => ({
		userInfos: {
			id: 0,
			userName: '',
			nickName: '',
			userType: '',
			email: '',
			phone: '',
			avatar: '',
			status: '',
			remark: '',
			permission: []
		},
	}),
	actions: {
		/**
		 * 登录
		 */
		async loginAction(loginInfo: any) {
			const res: any = await authApi.login(loginInfo)
			if (res.success) {
				cache.setToken(res.data)
			}
			return res
		},
		/**
		 * 用户信息
		 */
		async setUserInfos() {		
			//获取用户信息
			const res: any = await authApi.getUserInfo()
			if (res.success) {
				this.userInfos = res.data;
			}

		},		
		// 权限验证
		hasPermission(permissions: string[]) {
			let hasPermissions = false;
			if (permissions.length > 0) {

				this.userInfos.permission.map((permission: string) => {
					if (permission == "*_*_*" || permissions.includes(permission)) {
						hasPermissions = true;
						return
					}
				})
			}
			return hasPermissions;
		}
	},
});

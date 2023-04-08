import request from '/@/utils/request';

/**
 * 登录接口
 */
 class AuthApi {
	/**
	 * 获取验证码
	 * @returns 
	 */
	getCaptcha() {
		return request({
			url: '/system/auth/captcha',
			method: 'get',
		});
	}
	/**
	 * 用户登录
	 * @param params 
	 * @returns 
	 */
	login(params: object) {
		return request({
			url: '/system/auth/login',
			method: 'post',
			data: params,
		});
	}
	/**
	 * 获取用户信息
	 * @param params 
	 * @returns 
	 */
	 getUserInfo() {
		return request({
			url: '/system/auth/userInfo',
			method: 'get',
		});
	}
	/**
	 * 获取菜单信息
	 * @param params 
	 * @returns 
	 */
	 getMenu() {
		return request({
			url: '/system/auth/menu',
			method: 'get',
		});
	}
}

export default new AuthApi()
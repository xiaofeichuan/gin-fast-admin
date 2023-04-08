import Cookies from 'js-cookie';
import { Local, Session } from '/@/utils/storage';

/**
 * 缓存（主要存储关于用户、权限、路由等与后端关联的信息）
 */
class Cache {
	/**
	 * 设置token
	 * @param value 
	 */
	setToken = (value: string) => {
		Cookies.set(CacheKey.TokenKey, value)
	}
	/**
	 * 获取token
	 * @returns 
	 */
	getToken = (): string => {
		return Cookies.get(CacheKey.TokenKey)
	}


	/**
	 * 清除所有缓存信息
	 */
	clearAll = () => {
		Cookies.remove(CacheKey.TokenKey)
		Local.clear()
		Session.clear()
	}


}

export default new Cache()

/**
 * 缓存key
 */
class CacheKey {
	//Token
	public static readonly TokenKey: string = "token";
}

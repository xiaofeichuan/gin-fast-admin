import type { App } from 'vue';
import { useUserInfo } from '/@/stores/userInfo';
import { judementSameArr } from '/@/utils/arrayOperation';

/**
 * 用户权限指令
 * @directive 单个权限验证（v-auth="xxx"）
 * @directive 多个权限验证，满足一个则显示（v-auths="[xxx,xxx]"）
 * @directive 多个权限验证，全部满足则显示（v-auth-all="[xxx,xxx]"）
 */
export function authDirective(app: App) {	
	// 多个权限验证，满足一个则显示（v-permission="[xxx,xxx]"）
	app.directive('permission', {
		mounted(el, binding) {
			const hasPermissions = useUserInfo().hasPermission(binding.value);
			if (!hasPermissions) el.parentNode.removeChild(el);
		},
	});	
}

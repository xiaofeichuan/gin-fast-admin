package consts

import "time"

const (
	CacheTime        = time.Minute * 30 //缓存时间（可应用大部分业务缓存）
	CacheKeyUserMenu = "user_menu_"     //菜单
	// CacheKeySysRoleMenu = "sys_role_menu"  //角色菜单关联
	CacheKeyUserPermission = "user_permission_" //用户权限标识
)

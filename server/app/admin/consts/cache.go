package consts

import "time"

const (
	CacheTime                 = time.Minute * 30       //缓存时间（可应用大部分业务缓存）
	CacheKeySysUserMenu       = "sys_user_menu_"       //菜单
	CacheKeySysUserPermission = "sys_user_permission_" //用户权限标识
)

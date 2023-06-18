package api

import adminService "go-fast-admin/server/app/admin/service"

var (
	authService           = &adminService.SysAuthService{}
	configService         = &adminService.SysConfigService{}
	dictService           = &adminService.SysDictService{}
	dictItemService       = &adminService.SysDictItemService{}
	userService           = &adminService.SysUserService{}
	roleService           = &adminService.SysRoleService{}
	menuService           = &adminService.SysMenuService{}
	genTableService       = &adminService.SysGenTableService{}
	genTableColumnService = &adminService.SysGenTableColumnService{}
	monitorService        = &adminService.MonitorService{}
)

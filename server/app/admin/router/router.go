package router

import (
	"github.com/gin-gonic/gin"
	"go-fast-admin/server/app/admin/api"
)

// SystemRouter 系统路由
// 建议：
// 当接口数量超出一定范围，可适当分类或将复杂模块独立文件整理
// 路由规范：业务/模块/操作，比如：mall/user/add
type SystemRouter struct{}

var (
	sysConfigApi   = &api.SysConfigApi{}
	sysDictApi     = &api.SysDictApi{}
	sysDictItemApi = &api.SysDictItemApi{}
	sysAuthApi     = &api.SysAuthApi{}
	sysMenuApi     = &api.SysMenuApi{}
	sysUserApi     = &api.SysUserApi{}
	sysRoleApi     = &api.SysRoleApi{}
	sysTableApi    = &api.SysTableApi{}
)

// InitPublicRouter 初始化公开路由
func (s *SystemRouter) InitPublicRouter(routerGroup *gin.RouterGroup) {

	//权限
	authRouter := routerGroup.Group("/system/auth")
	{
		authRouter.GET("captcha", sysAuthApi.GenerateCaptcha) // 生成验证码
		authRouter.POST("login", sysAuthApi.Login)            // 用户登录
	}
}

// InitPrivateRouter 初始化私有路由
func (s *SystemRouter) InitPrivateRouter(routerGroup *gin.RouterGroup) {

	//权限
	authRouter := routerGroup.Group("/system/auth")
	{
		authRouter.GET("userInfo", sysAuthApi.GetUserInfo) // 获取用户信息
		authRouter.GET("menu", sysAuthApi.GetAuthMenu)     // 获取用户菜单（树状）
		authRouter.POST("updatePwd", sysAuthApi.UpdatePwd) // 更新密码
	}

	//用户
	userRouter := routerGroup.Group("/system/user")
	{
		userRouter.GET("query", sysUserApi.Query)              // 用户分页查询
		userRouter.POST("add", sysUserApi.Add)                 // 添加用户
		userRouter.POST("update", sysUserApi.Update)           // 更新用户
		userRouter.POST("delete", sysUserApi.Delete)           // 删除用户
		userRouter.GET("detail", sysUserApi.Detail)            // 用户详情
		userRouter.GET("list", sysUserApi.List)                // 用户列表
		userRouter.POST("resetPwd", sysUserApi.ResetPwd)       // 重置密码
		userRouter.POST("setStatus", sysUserApi.SetUserStatus) // 设置状态
	}

	//菜单
	menuRouter := routerGroup.Group("/system/menu")
	{
		menuRouter.GET("query", sysMenuApi.Query)      // 菜单分页查询
		menuRouter.POST("add", sysMenuApi.Add)         // 添加菜单
		menuRouter.POST("update", sysMenuApi.Update)   // 更新菜单
		menuRouter.POST("delete", sysMenuApi.Delete)   // 删除菜单
		menuRouter.GET("detail", sysMenuApi.Detail)    // 菜单详情
		menuRouter.GET("list", sysMenuApi.List)        // 菜单列表
		menuRouter.GET("tree", sysMenuApi.GetMenuTree) // 菜单树状
	}

	//角色
	roleRouter := routerGroup.Group("/system/role")
	{
		roleRouter.GET("query", sysRoleApi.Query)    // 角色查询
		roleRouter.POST("add", sysRoleApi.Add)       // 添加角色
		roleRouter.POST("update", sysRoleApi.Update) // 更新角色
		roleRouter.POST("delete", sysRoleApi.Delete) // 删除角色
		roleRouter.GET("detail", sysRoleApi.Detail)  // 角色详情
		roleRouter.GET("list", sysRoleApi.List)      // 角色列表
	}

	//配置
	configRouter := routerGroup.Group("/system/config")
	{
		configRouter.GET("query", sysConfigApi.Query)    // 配置查询
		configRouter.POST("add", sysConfigApi.Add)       // 添加配置
		configRouter.POST("update", sysConfigApi.Update) // 更新配置
		configRouter.POST("delete", sysConfigApi.Delete) // 删除配置
		configRouter.GET("detail", sysConfigApi.Detail)  // 配置详情
		configRouter.GET("list", sysConfigApi.List)      // 配置列表
	}

	//字典
	dictRouter := routerGroup.Group("/system/dict")
	{
		dictRouter.GET("query", sysDictApi.Query)    // 字典查询
		dictRouter.POST("add", sysDictApi.Add)       // 添加字典
		dictRouter.POST("update", sysDictApi.Update) // 更新字典
		dictRouter.POST("delete", sysDictApi.Delete) // 删除字典
		dictRouter.GET("detail", sysDictApi.Detail)  // 字典详情
		dictRouter.GET("list", sysDictApi.List)      // 字典列表
	}

	//字典选项
	dictItemRouter := routerGroup.Group("/system/dictItem")
	{
		dictItemRouter.GET("query", sysDictItemApi.Query)    // 字典选项查询
		dictItemRouter.POST("add", sysDictItemApi.Add)       // 添加字典选项
		dictItemRouter.POST("update", sysDictItemApi.Update) // 更新字典选项
		dictItemRouter.POST("delete", sysDictItemApi.Delete) // 删除字典选项
		dictItemRouter.GET("detail", sysDictItemApi.Detail)  // 字典选项详情
		dictItemRouter.GET("list", sysDictItemApi.List)      // 字典选项列表
	}

	//代码生成（表）
	tableRouter := routerGroup.Group("/system/sysTable")
	{
		tableRouter.GET("getDBTableInfos", sysTableApi.GetDBTableInfos) // 获取当前数据库所有表信息
		tableRouter.POST("importTables", sysTableApi.ImportTables)      // 导入表
		tableRouter.GET("previewCode", sysTableApi.PreviewCode)         // 导入表
	}
}

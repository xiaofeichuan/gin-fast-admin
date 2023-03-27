package router

import (
	"github.com/gin-gonic/gin"
	adminRouter "go-fast-admin/server/app/admin/router"
	exampleRouter "go-fast-admin/server/app/example/router"
	"go-fast-admin/server/middleware"
)

// InitRouters 初始化路由
func InitRouters() *gin.Engine {
	Router := gin.Default()
	//允许修复当前请求路径，如/FOO和/..//Foo会被修复为/foo，并进行重定向，默认为 false。
	Router.RedirectFixedPath = true

	//跨域
	Router.Use(middleware.Cors())

	//实例化路由
	systemRouter := adminRouter.SystemRouter{}
	exampleRouter := exampleRouter.TestRouter{}

	//授权路由
	privateGroup := Router.Group("/")
	privateGroup.Use(middleware.JwtAuth()).Use(middleware.Casbin())
	{
		systemRouter.InitPrivateRouter(privateGroup) //系统路由
	}

	//公开路由
	publicGroup := Router.Group("")
	{
		systemRouter.InitPublicRouter(publicGroup) //系统路由
		exampleRouter.InitPublicRouter(publicGroup)
	}

	return Router
}

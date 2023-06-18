package api

import (
	"github.com/gin-gonic/gin"
	"go-fast-admin/server/common/dto/response"
)

// List
// @Tags 监控
// @Summary 获取缓存key
// @Security ApiKeyAuth
// @Success 200 {object} response.JsonResult{data=[]dto.SysConfigVo}
// @Router /system/monitor/cacheKeys [get]
func (sysUserApi *SysConfigApi) GetCacheKeys(c *gin.Context) {
	objs, err := configService.List()
	response.Complete(objs, err, c)
}

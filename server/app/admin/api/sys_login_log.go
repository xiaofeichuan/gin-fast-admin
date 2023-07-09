package api

import (
	"github.com/gin-gonic/gin"
	"go-fast-admin/server/app/admin/dto"
	"go-fast-admin/server/common/dto/request"
	"go-fast-admin/server/common/dto/response"
)

type SysLoginLogApi struct{}

// Query
// @Tags 登录日志
// @Summary 登录日志查询
// @Security ApiKeyAuth
// @Param data query dto.SysLoginLogQuery true "请求参数"
// @Success 200 {object} response.JsonResult{data=response.PageResult{list=[]dto.SysLoginLogVo}}
// @Router /system/loginLog/query [get]
func (sysUserApi *SysLoginLogApi) Query(c *gin.Context) {
	var query dto.SysLoginLogQuery
	c.ShouldBindQuery(&query)
	list, total, err := loginLogService.Query(query)
	response.Complete(response.PageResult{List: list, TotalCount: total}, err, c)
}

// Add
// @Tags 登录日志
// @Summary 添加登录日志
// @Security ApiKeyAuth
// @Param data body dto.SysLoginLogAddDto true "请求参数"
// @Success 200 {object} response.JsonResult
// @Router /system/loginLog/add [post]
func (sysUserApi *SysLoginLogApi) Add(c *gin.Context) {
	var addDto dto.SysLoginLogAddDto
	c.ShouldBindJSON(&addDto)
	err := loginLogService.Add(addDto)
	response.CompleteWithMessage(err, c)
}

// Update
// @Tags 登录日志
// @Summary 更新登录日志
// @Security ApiKeyAuth
// @Param data body dto.SysLoginLogUpdateDto true "请求参数"
// @Success 200 {object} response.JsonResult
// @Router /system/loginLog/update [post]
func (sysUserApi *SysLoginLogApi) Update(c *gin.Context) {
	var updateDto dto.SysLoginLogUpdateDto
	c.ShouldBindJSON(&updateDto)
	err := loginLogService.Update(updateDto)
	response.CompleteWithMessage(err, c)
}

// Delete
// @Tags 登录日志
// @Summary 删除登录日志
// @Security ApiKeyAuth
// @Param data body request.IdInfoDto true "请求参数"
// @Success 200 {object} response.JsonResult
// @Router /system/loginLog/delete [post]
func (sysUserApi *SysLoginLogApi) Delete(c *gin.Context) {
	var idInfoDto request.IdInfoDto
	c.ShouldBindJSON(&idInfoDto)
	err := loginLogService.Delete(idInfoDto.Id)
	response.CompleteWithMessage(err, c)
}

// Detail
// @Tags 登录日志
// @Summary 获取登录日志详情
// @Security ApiKeyAuth
// @Param data query request.IdInfoDto true "登录日志id"
// @Success 200 {object} response.JsonResult{data=dto.SysLoginLogVo}
// @Router /system/loginLog/detail [get]
func (sysUserApi *SysLoginLogApi) Detail(c *gin.Context) {
	var idInfoDto request.IdInfoDto
	c.ShouldBindQuery(&idInfoDto)
	obj, err := loginLogService.Detail(idInfoDto.Id)
	response.Complete(obj, err, c)
}

// List
// @Tags 登录日志
// @Summary 登录日志列表
// @Security ApiKeyAuth
// @Success 200 {object} response.JsonResult{data=[]dto.SysLoginLogVo}
// @Router /system/loginLog/list [get]
func (sysUserApi *SysLoginLogApi) List(c *gin.Context) {
	objs, err := loginLogService.List()
	response.Complete(objs, err, c)
}

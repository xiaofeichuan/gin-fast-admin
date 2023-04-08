package api

import (
	"github.com/gin-gonic/gin"
	"go-fast-admin/server/app/admin/dto"
	"go-fast-admin/server/common/dto/response"
)

type SysAuthApi struct{}

// GenerateCaptcha
// @Tags 授权
// @Summary 生成验证码
// @Security ApiKeyAuth
// @Success 200 {object} response.JsonResult{data=dto.CaptchaVo}
// @Router /system/auth/captcha [get]
func (*SysAuthApi) GenerateCaptcha(c *gin.Context) {
	id, b64s, err := authService.GenerateCaptcha()
	response.Complete(dto.CaptchaVo{CaptchaId: id, CaptchaBase64: b64s}, err, c)
}

// Login
// @Tags 授权
// @Summary 用户登录
// @Security ApiKeyAuth
// @Param data body dto.LoginDto true "请求参数"
// @Success 200 {object} response.JsonResult
// @Router /system/auth/login [post]
func (*SysAuthApi) Login(c *gin.Context) {
	var loginDto dto.LoginDto
	c.ShouldBindJSON(&loginDto)
	token, err := authService.Login(loginDto)
	response.Complete(token, err, c)
}

// GetUserInfo
// @Tags 授权
// @Summary 获取用户信息
// @Security ApiKeyAuth
// @Success 200 {object} response.JsonResult{data=dto.UserInfoVo}
// @Router /system/auth/userInfo [get]
func (*SysAuthApi) GetUserInfo(c *gin.Context) {
	userInfo, err := authService.GetUserInfo(c)
	response.Complete(userInfo, err, c)

}

// GetAuthMenu
// @Tags 授权
// @Summary 获取用户菜单（树状）
// @Security ApiKeyAuth
// @Success 200 {object} response.JsonResult{data=[]dto.AuthMenuVo}
// @Router /system/auth/menu [get]
func (*SysAuthApi) GetAuthMenu(c *gin.Context) {
	authMenu, err := authService.GetAuthMenu(c)
	response.Complete(authMenu, err, c)
}

// UpdatePwd
// @Tags 授权
// @Summary 更新密码
// @Security ApiKeyAuth
// @Param data body dto.UpdatePwdDto true "请求参数"
// @Success 200 {object} response.JsonResult
// @Router /system/auth/updatePwd [post]
func (*SysAuthApi) UpdatePwd(c *gin.Context) {
	var updatePwdDto dto.UpdatePwdDto
	c.ShouldBindJSON(&updatePwdDto)
	err := authService.UpdatePwd(c, updatePwdDto)
	response.Complete(nil, err, c)
}

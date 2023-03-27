package service

import (
	"github.com/gin-gonic/gin"
	"github.com/mojocn/base64Captcha"
	"go-fast-admin/server/app/admin/consts"
	"go-fast-admin/server/app/admin/dto"
	"go-fast-admin/server/app/admin/model"
	"go-fast-admin/server/common/tools"
	utils2 "go-fast-admin/server/common/utils"
	"go-fast-admin/server/global"
	"gopkg.in/errgo.v2/fmt/errors"
	"strconv"
	"time"
)

var store = base64Captcha.DefaultMemStore

type SysAuthService struct{}

// GenerateCaptcha 生成验证码
func (s *SysAuthService) GenerateCaptcha() (id string, b64s string, err error) {
	driver := base64Captcha.NewDriverDigit(80, 240, 4, 0.7, 80)
	captcha := base64Captcha.NewCaptcha(driver, store)
	return captcha.Generate()
}

// Login 用户登录
func (s *SysAuthService) Login(loginDto dto.LoginDto) (token string, err error) {

	if loginDto.CaptchaId == "" || loginDto.CaptchaCode == "" {
		return "", errors.New("验证码错误")
	}

	if !store.Verify(loginDto.CaptchaId, loginDto.CaptchaCode, true) {
		return "", errors.New("验证码错误")
	}

	var user model.SysUser

	err = global.DB.Where("user_name = ?", loginDto.UserName).First(&user).Error
	if err != nil {
		return "", errors.New("账号不存在")
	}

	if user.Status == consts.UserStatusDisable {
		return "", errors.New("账号已被禁用")
	}

	pwd := utils2.Md5(loginDto.Password + user.Salt)
	if pwd != user.Password {
		return "", errors.New("密码错误")
	}

	//生成token
	var claims = utils2.UserAuthClaims{
		UserId:   user.Id,
		UserName: user.UserName,
		NickName: user.NickName,
		UserType: user.UserType,
	}
	token, err = utils2.GenerateToken(claims, time.Now().AddDate(0, 0, 1))
	return token, err
}

// GetUserInfo 获取用户信息
func (s *SysAuthService) GetUserInfo(c *gin.Context) (userInfo dto.UserInfoVo, err error) {
	currentUserId := utils2.GetUserId(c)

	//查询用户信息
	err = global.DB.Model(&model.SysUser{}).Where("id = ?", currentUserId).Scan(&userInfo).Error
	if err != nil {
		return userInfo, err
	}

	return userInfo, err
}

// GetAuthMenu 获取用户菜单路由
func (s *SysAuthService) GetAuthMenu(c *gin.Context) (authMenu []dto.AuthMenuVo, err error) {

	var currentUserId = utils2.GetUserId(c)

	var cacheKey = consts.CacheKeyUserMenu + strconv.FormatInt(currentUserId, 10)

	tools.Redis.Get(cacheKey, authMenu)

	if authMenu == nil || len(authMenu) == 0 {
		var menuList []model.SysMenu
		//是否超级管理员
		if utils2.IsSuperAdmin(c) {
			//超级管理员，拥有最高权限
			global.DB.Model(&model.SysMenu{}).Where("menu_type = ? AND status = ? ",
				consts.MenuTypeMenu,
				consts.MenuStatusEnable).Scan(&menuList)
		} else {
			var menuIds []int64
			var userId = utils2.GetUserId(c)
			var sql = `
			SELECT
				roleMenu.menu_id 
			FROM
				sys_user_role userRole
				LEFT JOIN sys_role_menu roleMenu ON userRole.role_id = roleMenu.role_id 
			WHERE
				userRole.user_id = ? 
			GROUP BY
				roleMenu.menu_id`
			//用户拥有菜单id
			global.DB.Raw(sql, userId).Scan(&menuIds)

			global.DB.Model(&model.SysMenu{}).Where("id IN ? AND menu_type = ? AND status = ? ",
				menuIds,
				consts.MenuTypeMenu,
				consts.MenuStatusEnable).Scan(&menuList)
		}
		authMenu = BuildAuthMenuTree(menuList, 0)

		//设置缓存
		tools.Redis.Set(cacheKey, authMenu, consts.CacheTime)
	}

	return authMenu, err
}

// GetAuthPermission 获取用户权限
func (s *SysAuthService) GetAuthPermission(c *gin.Context) (permissions []string, err error) {
	//是否超级管理员
	if utils2.IsSuperAdmin(c) {
		//所有权限
		return []string{"*:*:*"}, nil
	} else {

		userPermissions := GetPermissionList(c)
		for i := 0; i < len(userPermissions); i++ {
			permissions = append(permissions, userPermissions[i].Permission)
		}
		return permissions, err
	}
}

func GetPermissionList(c *gin.Context) (permissions []dto.UserPermissionVo) {

	var currentUserId = utils2.GetUserId(c)
	var cacheKey = consts.CacheKeyUserPermission + strconv.FormatInt(currentUserId, 10)

	tools.Redis.Get(cacheKey, permissions)
	if permissions == nil || len(permissions) == 0 {

		var menuIds []int64
		var sql = `
		SELECT
			roleMenu.menu_id 
		FROM
			sys_user_role userRole
			LEFT JOIN sys_role_menu roleMenu ON userRole.role_id = roleMenu.role_id 
		WHERE
			userRole.user_id = ? 
		GROUP BY
			roleMenu.menu_id`
		//用户拥有菜单id
		global.DB.Raw(sql, currentUserId).Scan(&menuIds)

		global.DB.Model(&model.SysMenu{}).
			Select("permission", "request_method").
			Where("id IN ? AND menu_type = ? AND status = ? ", menuIds, consts.MenuTypeBtn, consts.MenuStatusEnable).
			Scan(&permissions)

		//设置缓存
		tools.Redis.Set(cacheKey, permissions, consts.CacheTime)
	}
	return permissions
}

// BuildAuthMenuTree 构建菜单树状
func BuildAuthMenuTree(menuList []model.SysMenu, parentId int64) (menus []dto.AuthMenuVo) {

	var childMenuList []model.SysMenu
	for i := 0; i < len(menuList); i++ {
		var menu = menuList[i]
		if menu.ParentId == parentId {
			childMenuList = append(childMenuList, menu)
		}
	}

	var menuRouters []dto.AuthMenuVo
	for i := 0; i < len(childMenuList); i++ {
		var menuRouter dto.AuthMenuVo
		menuRouter.Path = "/" + childMenuList[i].Path
		menuRouter.Name = childMenuList[i].Path
		menuRouter.Component = childMenuList[i].Component
		menuRouter.Meta = dto.MenuRouterMetaVo{
			Title:       childMenuList[i].MenuName,
			Icon:        childMenuList[i].Icon,
			IsLink:      childMenuList[i].Link,
			IsIframe:    childMenuList[i].IsIframe,
			IsHide:      childMenuList[i].IsHide,
			IsKeepAlive: childMenuList[i].IsCache,
			IsAffix:     false,
		}
		menuRouter.Children = BuildAuthMenuTree(menuList, childMenuList[i].Id)
		menuRouters = append(menuRouters, menuRouter)
	}
	return menuRouters
}

// UpdatePwd 修改密码
func (s *SysAuthService) UpdatePwd(c *gin.Context, updatePwdDto dto.UpdatePwdDto) error {
	var user model.SysUser
	currentUserId := utils2.GetUserId(c)
	err := global.DB.Model(&model.SysUser{}).Where("id = ?", currentUserId).Scan(&user).Error
	if err != nil {
		return err
	}
	encryptPassword := utils2.Md5(updatePwdDto.Password + user.Salt)
	if encryptPassword != user.Password {
		return errors.New("密码错误")
	}

	//密码盐
	salt := utils2.GetRoundNumber(15)

	//加密 => MD5（密码+密码盐）
	pwd := utils2.Md5(updatePwdDto.Password + salt)

	//更新密码
	err = global.DB.Model(&model.SysUser{}).Where("id = ?", user.Id).Update("password", pwd).Error
	return err
}

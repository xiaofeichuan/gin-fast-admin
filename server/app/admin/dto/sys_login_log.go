package dto

import (
	"go-fast-admin/server/common/dto/request"
	"time"
)

// SysLoginLogQuery 查询
type SysLoginLogQuery struct {
	request.PageQuery
	StartLoginTime string `form:"startLoginTime"` //开始登录时间
	EndLoginTime   string `form:"endLoginTime"`   //结束登录时间
}

// SysLoginLogAddDto 创建
type SysLoginLogAddDto struct {
	UserId          int64     `json:"userId"`          //用户id
	LoginTime       time.Time `json:"loginTime"`       //登录时间
	IpAddress       string    `json:"ipAddress"`       //IP地址
	Location        string    `json:"location"`        //登录位置
	Browser         string    `json:"browser"`         //浏览器
	OperatingSystem string    `json:"operatingSystem"` //操作系统
}

// SysLoginLogUpdateDto 更新
type SysLoginLogUpdateDto struct {
	Id int64 `json:"id"` //编号
	SysLoginLogAddDto
}

// SysLoginLogVo 输出对象
type SysLoginLogVo struct {
	Id              int64     `json:"id"`              //字典id
	UserId          int64     `json:"userId"`          //用户id
	LoginTime       time.Time `json:"loginTime"`       //登录时间
	IpAddress       string    `json:"ipAddress"`       //IP地址
	Location        string    `json:"location"`        //登录位置
	Browser         string    `json:"browser"`         //浏览器
	OperatingSystem string    `json:"operatingSystem"` //操作系统
}

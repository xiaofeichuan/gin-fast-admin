package model

import (
	"time"
)

type SysLoginLog struct {
	Id              int64     `json:"id" gorm:"primaryKey;comment:字典id"`
	UserId          int64     `json:"userId" gorm:"comment:用户id"`
	LoginTime       time.Time `json:"loginTime" gorm:"comment:登录时间"`
	IpAddress       string    `json:"ipAddress" gorm:"comment:IP地址"`
	Location        string    `json:"location" gorm:"comment:登录位置"`
	Browser         string    `json:"browser" gorm:"comment:浏览器"`
	OperatingSystem string    `json:"operatingSystem" gorm:"comment:操作系统"`
}

func (SysLoginLog) TableName() string {
	return "sys_login_log"
}

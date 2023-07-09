package service

import (
	"go-fast-admin/server/app/admin/dto"
	"go-fast-admin/server/app/admin/model"
	"go-fast-admin/server/global"
)

type SysLoginLogService struct{}

// Query 登录日志查询
func (s *SysLoginLogService) Query(query dto.SysLoginLogQuery) (list []dto.SysLoginLogVo, total int64, err error) {
	db := global.DB.Model(&model.SysLoginLog{})

	//查询条件
	if query.StartLoginTime != "" && query.EndLoginTime != "" {
		db = db.Where("`login_time` BETWEEN ? and ?", query.StartLoginTime, query.EndLoginTime)
	}

	//总条数
	db.Count(&total)

	//查询数据
	offset := (query.PageNum - 1) * query.PageSize
	err = db.Order("id DESC").Offset(offset).Limit(query.PageSize).Find(&list).Error
	if err != nil {
		return nil, 0, err
	}

	return list, total, err
}

// Add 添加登录日志
func (s *SysLoginLogService) Add(addDto dto.SysLoginLogAddDto) error {
	var model = &model.SysLoginLog{
		UserId:          addDto.UserId,
		LoginTime:       addDto.LoginTime,
		IpAddress:       addDto.IpAddress,
		Location:        addDto.Location,
		Browser:         addDto.Browser,
		OperatingSystem: addDto.OperatingSystem,
	}
	err := global.DB.Create(model).Error
	return err
}

// Update 更新登录日志
func (s *SysLoginLogService) Update(updateDto dto.SysLoginLogUpdateDto) error {
	err := global.DB.Model(&model.SysLoginLog{}).Where("id = ?", updateDto.Id).Updates(map[string]interface{}{
		"UserId":          updateDto.UserId,
		"LoginTime":       updateDto.LoginTime,
		"IpAddress":       updateDto.IpAddress,
		"Location":        updateDto.Location,
		"Browser":         updateDto.Browser,
		"OperatingSystem": updateDto.OperatingSystem,
	}).Error
	return err
}

// Delete 删除登录日志
func (s *SysLoginLogService) Delete(id int64) error {
	err := global.DB.Delete(&model.SysLoginLog{}, "id = ?", id).Error
	return err
}

// Detail 获取登录日志详情
func (s *SysLoginLogService) Detail(id int64) (obj dto.SysLoginLogVo, err error) {
	err = global.DB.Model(&model.SysLoginLog{}).Where("id = ?", id).Scan(&obj).Error
	return obj, err
}

// List 登录日志列表
func (s *SysLoginLogService) List() (objs []dto.SysLoginLogVo, err error) {
	err = global.DB.Model(&model.SysLoginLog{}).Scan(&objs).Error
	return objs, err
}

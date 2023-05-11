package service

import (
	"bytes"
	"fmt"
	"go-fast-admin/server/app/admin/consts"
	"go-fast-admin/server/app/admin/dto"
	"go-fast-admin/server/app/admin/model"
	"go-fast-admin/server/common/utils"
	"go-fast-admin/server/global"
	"strings"
	"text/template"
)

type SysGenTableService struct{}

// Query 业务表查询
func (s *SysGenTableService) Query(query dto.SysGenTableQuery) (list []dto.SysGenTableVo, total int64, err error) {
	db := global.DB.Model(&model.SysGenTable{})
	//查询条件
	if query.TableName != "" {
		db = db.Where("`table_name` LIKE ?", "%"+query.TableName+"%")
	}
	//总条数
	db.Count(&total)

	offset := (query.PageNum - 1) * query.PageSize
	//查询数据
	err = db.Order("id DESC").Offset(offset).Limit(query.PageSize).Find(&list).Error
	if err != nil {
		return nil, 0, err
	}

	return list, total, err
}

// Add 添加业务表
func (s *SysGenTableService) Add(addDto dto.SysGenTableAddDto) error {
	var genTable = &model.SysGenTable{
		TableName:    addDto.TableName,
		TableComment: addDto.TableComment,
		ModelName:    addDto.ModelName,
		BusinessName: addDto.BusinessName,
		ModuleName:   addDto.ModuleName,
		FunctionName: addDto.FunctionName,
		ParamName:    addDto.ParamName,
		MenuParentId: addDto.MenuParentId,
	}
	err := global.DB.Create(genTable).Error

	//添加表字段
	AddColumn(addDto.TableName, genTable.Id)

	return err
}

// Update 更新业务表
func (s *SysGenTableService) Update(updateDto dto.SysGenTableUpdateDto) error {
	err := global.DB.Model(&model.SysGenTable{}).Where("id = ?", updateDto.Id).Updates(map[string]interface{}{
		"TableName":    updateDto.TableName,
		"TableComment": updateDto.TableComment,
		"ModelName":    updateDto.ModelName,
		"BusinessName": updateDto.BusinessName,
		"ModuleName":   updateDto.ModuleName,
		"FunctionName": updateDto.FunctionName,
		"ParamName":    updateDto.ParamName,
		"MenuParentId": updateDto.MenuParentId,
	}).Error
	return err
}

// Delete 删除业务表
func (s *SysGenTableService) Delete(id int64) error {
	err := global.DB.Delete(&model.SysGenTable{}, "id = ?", id).Error
	return err
}

// Detail 获取业务表详情
func (s *SysGenTableService) Detail(id int64) (obj dto.SysGenTableVo, err error) {
	err = global.DB.Model(&model.SysGenTable{}).Where("id = ?", id).Find(&obj).Error
	return obj, err
}

// GetTableList 获取表列表
func (s *SysGenTableService) GetTableList() (data []dto.TableInfoVo, err error) {
	var tables []dto.TableInfoVo
	sql := `
		SELECT 
			table_name AS TableName,
			table_comment AS TableComment
		FROM 
			information_schema.TABLES 
		WHERE 
			table_schema = (SELECT DATABASE()) AND table_name NOT IN (select table_name from sys_gen_table)`
	err = global.DB.Raw(sql).Find(&tables).Error

	for i := 0; i < len(tables); i++ {
		tables[i].ModelName = utils.SnakeToUpperCamelCase(tables[i].TableName)
		tables[i].BusinessName = strings.Split(tables[i].TableName, "_")[0]
		tables[i].ModuleName = GetModuleName(tables[i].TableName)
		tables[i].FunctionName = GetFunctionName(tables[i].TableComment)
		tables[i].ParamName = utils.SnakeToLowerCamelCase(tables[i].TableName)
	}
	return tables, err
}

// GetFunctionName 获取功能名称 例如：用户信息表=>用户信息
func GetFunctionName(tableComment string) string {
	if strings.Contains(tableComment, "表") {
		tableComment = strings.Replace(tableComment, "表", "", -1)
	}
	return tableComment
}

// GetModuleName 获取业务名称 例如：sys_user=>user
func GetModuleName(tableName string) string {
	var nameArr []string
	nameList := strings.Split(tableName, "_")

	//这边可以进行简化
	//nameList := strings.Split(tableName, "_")[1..]

	for i := 1; i < len(nameList); i++ {
		nameArr = append(nameArr, nameList[i])
	}
	snakeCase := strings.Join(nameArr, "_")
	return utils.SnakeToLowerCamelCase(snakeCase)
}

// AddColumn 导入表字段
func AddColumn(tableName string, tableId int64) error {

	var columnInfos []dto.DbTableColumnInfoVo
	columnSql := `		
	SELECT
		table_name AS TableName,
		column_name AS ColumnName,
		column_comment AS ColumnComment,
		data_type AS ColumnType,
		( CASE WHEN column_key = 'PRI' THEN '1' ELSE '0' END ) AS IsPk 
	FROM
		information_schema.COLUMNS 
	WHERE
		table_schema = (SELECT DATABASE()) AND table_name = ? ORDER BY TABLE_NAME,ORDINAL_POSITION`
	err := global.DB.Raw(columnSql, tableName).Scan(&columnInfos).Error
	if err != nil {
		return err
	}
	//导入表数据
	var columns []model.SysGenTableColumn
	for _, column := range columnInfos {

		//是否编辑
		isEdit := true
		if column.ColumnName == "id" || column.ColumnName == "created_at" || column.ColumnName == "updated_at" || column.ColumnName == "deleted_at" {
			isEdit = false
		}

		//代码类型
		codeType := utils.GetGoType(column.ColumnType)

		//组件类型
		var componentType = consts.ComponentTypeInput
		if column.ColumnType == "int" {
			componentType = consts.ComponentTypeInputNumber
		} else if strings.Contains(column.ColumnName, "is_") {
			codeType = "bool"
			componentType = consts.ComponentTypeSwitch
		} else if column.ColumnType == "datetime" || column.ColumnType == "timestamp" {
			componentType = consts.ComponentTypeDateTimePicker
		}

		columns = append(columns, model.SysGenTableColumn{
			TableId:       tableId,
			ColumnName:    column.ColumnName,
			ColumnComment: column.ColumnComment,
			ColumnType:    column.ColumnType,
			ParamName:     utils.SnakeToLowerCamelCase(column.ColumnName),
			CodeField:     utils.SnakeToUpperCamelCase(column.ColumnName),
			CodeType:      codeType,
			IsPk:          column.IsPk,
			IsEdit:        isEdit,
			IsList:        true,
			IsQuery:       false,
			QueryMethod:   "==",
			ComponentType: componentType,
		})
	}
	err = global.DB.Create(&columns).Error
	return err
}

// PreviewCode 预览代码
func (s *SysGenTableService) PreviewCode(tableId int64) (vos []dto.PreviewCodeVo, err error) {

	table := GetTableDetail(tableId)

	//api文件
	apiTemp, err := template.ParseFiles("resource/template/api.go.template")
	if err != nil {
		return nil, err
	}
	var apiContent bytes.Buffer
	err = apiTemp.Execute(&apiContent, table)
	vos = append(vos, dto.PreviewCodeVo{FileName: "api.go", FileContent: apiContent.String()})

	//dto文件
	dtoTemp, err := template.ParseFiles("resource/template/dto.go.template")
	if err != nil {
		return nil, err
	}
	var dtoContent bytes.Buffer
	err = dtoTemp.Execute(&dtoContent, table)
	vos = append(vos, dto.PreviewCodeVo{FileName: "dto.go", FileContent: dtoContent.String()})

	//model文件
	modelTemp, err := template.ParseFiles("resource/template/model.go.template")
	if err != nil {
		return nil, err
	}
	var modelContent bytes.Buffer
	err = modelTemp.Execute(&modelContent, table)
	fmt.Println(modelContent.String())
	vos = append(vos, dto.PreviewCodeVo{FileName: "model.go", FileContent: modelContent.String()})

	//router文件
	routerTemp, err := template.ParseFiles("resource/template/router.go.template")
	if err != nil {
		return nil, err
	}
	var routerContent bytes.Buffer
	err = routerTemp.Execute(&routerContent, table)
	vos = append(vos, dto.PreviewCodeVo{FileName: "router.go", FileContent: routerContent.String()})

	//service文件
	serviceTemp, err := template.ParseFiles("resource/template/service.go.template")
	if err != nil {
		return nil, err
	}
	var serviceContent bytes.Buffer
	err = serviceTemp.Execute(&serviceContent, table)
	vos = append(vos, dto.PreviewCodeVo{FileName: "service.go", FileContent: serviceContent.String()})

	return vos, err
}

// GetTableDetail 表数据详情
func GetTableDetail(tableId int64) (table dto.TableInfoVo) {
	global.DB.Model(model.SysGenTable{Id: tableId}).Scan(&table)

	var columnList *[]model.SysGenTableColumn
	global.DB.Model(model.SysGenTableColumn{TableId: tableId}).Scan(&columnList)
	table.ParamName = utils.SnakeToLowerCamelCase(table.TableName)
	//table.ColumnList = columnList
	fmt.Println(table)
	return table

}

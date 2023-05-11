package utils

import (
	"math/rand"
	"strings"
	"time"
)

// SnakeToUpperCamelCase
// 蛇形命名法=>大驼峰式命名法
// 例如：user_name->UserName
func SnakeToUpperCamelCase(snakeCase string) string {
	var result string
	nameList := strings.Split(snakeCase, "_")
	for i := 0; i < len(nameList); i++ {
		name := nameList[i]
		// 第一个字母
		firstChar := string([]byte(name)[:1])
		// 剩余字母
		otherChar := string([]byte(name)[1:])
		result += strings.ToUpper(firstChar) + otherChar
	}
	return result
}

// SnakeToLowerCamelCase
// 蛇形命名法=>小驼峰式命名法
// 例如：user_name->userName
func SnakeToLowerCamelCase(snakeCase string) string {
	var result string
	nameList := strings.Split(snakeCase, "_")
	for i := 0; i < len(nameList); i++ {
		name := nameList[i]
		if i == 0 {
			// 第一个单词
			result += strings.ToLower(name)
		} else {
			// 第一个字母
			firstChar := string([]byte(name)[:1])
			// 剩余字母
			otherChar := string([]byte(name)[1:])
			result += strings.ToUpper(firstChar) + otherChar
		}
	}
	return result
}

// GetGoType 获取go的数据类型
// mysql/pgsql数据类型=>go数据类型
func GetGoType(columnType string) string {
	switch columnType {
	case "text":
	case "varchar":
	case "char":
	case "longtext":
		return "string"

	case "tinyint":
	case "int":
	case "int2":
	case "int4":
		return "int"

	case "bigint":
	case "int8":
		return "int"

	case "bool":
		return "bool"

	case "date":
	case "datetime":
	case "smalldatetime":
	case "timestamp":
		return "time.Time"

	case "money":
	case "numeric":
	case "decimal":
		return "decimal.Decimal"
	}
	return columnType
}

// GetRoundNumber 获取随机数
func GetRoundNumber(size int) string {
	str := "0123456789abcdefghijklmnopqrstuvwxyz"
	bytes := []byte(str)
	var result []byte
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	for i := 0; i < size; i++ {
		result = append(result, bytes[r.Intn(len(bytes))])
	}
	return string(result)
}

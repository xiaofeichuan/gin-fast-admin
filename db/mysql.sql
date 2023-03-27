/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : go_fast_admin

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 31/01/2023 17:12:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数标识',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键名',
  `config_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键值',
  `status` tinyint NOT NULL COMMENT '参数状态（0正常 1停用）',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint NOT NULL COMMENT '字典id',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `dict_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典代码',
  `dict_type` tinyint NULL DEFAULT NULL COMMENT '字典类型（0int，1string）',
  `status` tinyint NOT NULL COMMENT '状态（0启用 1停用）',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` bigint NOT NULL COMMENT '字典项id',
  `dict_id` bigint NOT NULL COMMENT '字典id',
  `dict_item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典项名称',
  `dict_item_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典项值',
  `status` tinyint NOT NULL COMMENT '状态（0启用 1停用）',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------

-- ----------------------------
-- Table structure for sys_gen_table
-- ----------------------------
DROP TABLE IF EXISTS `sys_gen_table`;
CREATE TABLE `sys_gen_table`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表名称',
  `table_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表注释',
  `model_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '实体名称',
  `business_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务名称',
  `function_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能名称',
  `param_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数名称',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成器-业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_gen_table
-- ----------------------------
INSERT INTO `sys_gen_table` VALUES (1, 'sys_user', '用户信息表', 'SysUser', 'user', '用户信息', 'sysUser', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table` VALUES (2, 'sys_menu', '', 'SysMenu', 'menu', '', 'sysMenu', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);

-- ----------------------------
-- Table structure for sys_gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `sys_gen_table_column`;
CREATE TABLE `sys_gen_table_column`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `column_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段注释',
  `column_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `param_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数名称',
  `go_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'go字段名',
  `go_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'go类型',
  `is_pk` tinyint(1) NULL DEFAULT NULL COMMENT '是否主键（0否 1是）',
  `is_edit` tinyint NULL DEFAULT NULL COMMENT '是否编辑字段（0否 1是）',
  `is_list` tinyint NULL DEFAULT NULL COMMENT '是否列表字段（0否 1是）',
  `is_query` tinyint NULL DEFAULT NULL COMMENT '是否查询字段（0否 1是）',
  `query_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '查询方式',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成器-业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_gen_table_column
-- ----------------------------
INSERT INTO `sys_gen_table_column` VALUES (1, 1, 'id', '用户ID', 'bigint', 'id', 'Id', 'uint64', 1, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (2, 1, 'account', '用户账号', 'varchar(30)', 'account', 'Account', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (3, 1, 'nick_name', '用户昵称', 'varchar(30)', 'nickName', 'NickName', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (4, 1, 'user_type', '用户类型（0普通账号，1超级管理员）', 'tinyint', 'userType', 'UserType', 'int', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (5, 1, 'email', '用户邮箱', 'varchar(50)', 'email', 'Email', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (6, 1, 'phone', '手机号码', 'varchar(20)', 'phone', 'Phone', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (7, 1, 'password', '密码', 'varchar(100)', 'password', 'Password', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (8, 1, 'sex', '用户性别（0未知，1男，2女）', 'tinyint', 'sex', 'Sex', 'bool', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (9, 1, 'avatar', '头像地址', 'varchar(255)', 'avatar', 'Avatar', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (10, 1, 'status', '帐号状态（0正常 1停用）', 'tinyint', 'status', 'Status', 'int', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (11, 1, 'created_at', '创建时间', 'datetime', 'createdAt', 'CreatedAt', 'time.Time', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (12, 1, 'updated_at', '更新时间', 'datetime', 'updatedAt', 'UpdatedAt', 'time.Time', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (13, 1, 'deleted_at', '删除时间', 'datetime', 'deletedAt', 'DeletedAt', 'time.Time', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (14, 1, 'remark', '备注', 'varchar(500)', 'remark', 'Remark', 'string', 0, 0, 1, 0, '', '2022-10-29 14:30:21', '2022-10-29 14:30:21', NULL);
INSERT INTO `sys_gen_table_column` VALUES (15, 2, 'id', '菜单ID', 'bigint', 'id', 'Id', 'uint64', 1, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (16, 2, 'parent_id', '父菜单ID', 'bigint', 'parentId', 'ParentId', 'int', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (17, 2, 'menu_name', '菜单名称', 'varchar(50)', 'menuName', 'MenuName', 'string', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (18, 2, 'path', '路由地址', 'varchar(200)', 'path', 'Path', 'string', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (19, 2, 'is_iframe', '是否外链', 'tinyint', 'isIframe', 'IsIframe', 'int', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (20, 2, 'is_hide', '是否隐藏', 'tinyint', 'isHide', 'IsHide', 'int', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (21, 2, 'is_cache', '是否缓存', 'tinyint', 'isCache', 'IsCache', 'int', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (22, 2, 'component', '组件路径', 'varchar(255)', 'component', 'Component', 'string', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (23, 2, 'icon', '菜单图标', 'varchar(100)', 'icon', 'Icon', 'string', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (24, 2, 'permission', '权限', 'varchar(255)', 'permission', 'Permission', 'string', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (25, 2, 'status', '菜单状态（0正常 1停用）', 'tinyint', 'status', 'Status', 'int', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (26, 2, 'created_at', '创建时间', 'datetime', 'createdAt', 'CreatedAt', 'time.Time', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (27, 2, 'updated_at', '更新时间', 'datetime', 'updatedAt', 'UpdatedAt', 'time.Time', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (28, 2, 'deleted_at', '删除时间', 'datetime', 'deletedAt', 'DeletedAt', 'time.Time', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);
INSERT INTO `sys_gen_table_column` VALUES (29, 2, 'remark', '备注', 'varchar(500)', 'remark', 'Remark', 'string', 0, 0, 1, 0, '', '2022-12-04 23:01:15', '2022-12-04 23:01:15', NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `menu_type` tinyint NOT NULL COMMENT '菜单类型（0目录，1菜单，2按钮）',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部地址',
  `is_iframe` tinyint NULL DEFAULT NULL COMMENT '是否内嵌',
  `is_hide` tinyint NULL DEFAULT NULL COMMENT '是否隐藏',
  `is_cache` tinyint NULL DEFAULT NULL COMMENT '是否缓存',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '按钮权限',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `status` tinyint NOT NULL COMMENT '菜单状态（0启用 1停用）',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1206 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '主页', 0, 'home', NULL, 0, 0, 1, 'home/index', 'iconfont icon-shouye', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (10, 0, '系统管理', 0, 'system', NULL, 0, 0, 1, NULL, 'iconfont icon-xitongshezhi', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (20, 0, '外链', 0, 'link1', 'https://www.json.cn/', 0, 0, 1, NULL, 'iconfont icon-neiqianshujuchucun', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (21, 0, '内链', 0, 'link2', 'https://www.json.cn/', 1, 0, 1, NULL, 'iconfont icon-neiqianshujuchucun', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (100, 10, '用户管理', 1, 'system/user', NULL, 0, 0, 1, 'system/user/index', 'iconfont icon-icon-', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (110, 10, '菜单管理', 1, 'system/menu', NULL, 0, 0, 1, 'system/menu/index', 'iconfont icon-caidan', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (120, 10, '角色管理', 1, 'system/role', NULL, 0, 0, 1, 'system/role/index', 'fa fa-street-view', NULL, NULL, NULL, 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1000, 100, '用户查询', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_user_query', '/system/user/query', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1001, 100, '用户新增', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_user_add', '/system/user/add', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1002, 100, '用户更新', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_user_update', '/system/user/update', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1003, 100, '用户删除', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_user_delete', '/system/user/delete', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1004, 100, '用户详情', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_user_detail', '/system/user/detail', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1005, 100, '用户列表', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_user_list', '/system/user/list', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1100, 110, '菜单查询', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_menu_query', '/system/menu/query', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1101, 110, '菜单新增', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_menu_add', '/system/menu/add', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1102, 110, '菜单更新', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_menu_update', '/system/menu/update', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1103, 110, '菜单删除', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_menu_delete', '/system/menu/delete', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1104, 110, '菜单详情', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_menu_detail', '/system/menu/detail', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1105, 110, '菜单列表', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_menu_list', '/system/menu/list', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1200, 120, '角色查询', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_role_query', '/system/role/query', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1201, 120, '角色新增', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_role_add', '/system/role/add', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1202, 120, '角色更新', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_role_update', '/system/role/update', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1203, 120, '角色删除', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_role_delete', '/system/role/delete', 'POST', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1204, 120, '角色详情', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_role_detail', '/system/role/detail', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);
INSERT INTO `sys_menu` VALUES (1205, 120, '角色列表', 2, NULL, NULL, 0, 0, 0, NULL, NULL, 'system_role_list', '/system/role/list', 'GET', 0, NULL, '2022-12-05 21:21:34', '2022-12-05 21:21:34', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色代码',
  `status` tinyint NOT NULL COMMENT '角色状态（0启用 1停用）',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', 1, 0, '2022-12-15 21:50:10', '2023-01-31 17:10:52', NULL, '555');
INSERT INTO `sys_role` VALUES (2, '财务', 'finance', 0, NULL, '2022-12-15 21:50:10', '2023-01-29 10:56:51', NULL, '555');
INSERT INTO `sys_role` VALUES (3, '', '', 0, 0, '2023-01-29 10:57:00', '2023-01-29 10:57:00', '2023-01-29 11:01:26', '');
INSERT INTO `sys_role` VALUES (4, '', '', 0, 0, '2023-01-29 11:00:26', '2023-01-29 11:00:26', '2023-01-29 11:01:16', '');
INSERT INTO `sys_role` VALUES (5, '2223', '2223', 0, 1, '2023-01-29 11:01:29', '2023-01-29 13:39:35', '2023-01-29 13:39:37', 'www');
INSERT INTO `sys_role` VALUES (6, '11', '11', 0, 0, '2023-01-29 13:48:51', '2023-01-29 13:48:51', '2023-01-29 13:48:53', '11');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色和菜单关联id',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` bigint NULL DEFAULT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_role_menu`(`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` tinyint NOT NULL COMMENT '用户类型（0普通账号，1超级管理员）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码盐',
  `sex` tinyint NULL DEFAULT NULL COMMENT '用户性别（0未知，1男，2女）',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `status` tinyint NOT NULL COMMENT '帐号状态（0启用 1停用）',
  `created_at` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'superAdmin', '超级管理员', 1, '514634736@qq.com', '19999999999', 'ec71d37f4340c223896afd45aaf3cf06', '41b278387b85404', 1, 'https://img1.baidu.com/it/u=948325104,3657174403&fm=253&fmt=auto&app=138&f=JPEG?w=388&h=514', 0, '2022-11-08 14:27:47', '2022-11-08 14:27:51', NULL, '超级管理');
INSERT INTO `sys_user` VALUES (2, 'admin', '管理员', 0, '514634736@qq.com', '19999999999', 'ec71d37f4340c223896afd45aaf3cf06', '41b278387b85404', 1, NULL, 0, '2022-11-08 14:27:47', '2022-11-08 14:27:51', NULL, NULL);
INSERT INTO `sys_user` VALUES (38, 'test111', 'test111', 0, 'test111@11.com', '15392187210', '7c4ec2c3c5dea54dad60062346cf283c', '', 0, '', 0, '2023-01-16 11:26:03', '2023-01-16 14:27:49', NULL, 'test111');
INSERT INTO `sys_user` VALUES (40, 'test222', 'test111', 0, '112!#@11.cn', '15392187211', '17f00a6868aaa02f38b77e0558eb1456', '', 1, '', 0, '2023-01-16 12:25:35', '2023-01-16 12:25:40', NULL, '');
INSERT INTO `sys_user` VALUES (41, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (55, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (56, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (57, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (58, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (59, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (60, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (61, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (62, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (63, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (64, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (65, 'test222', 'test222', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, NULL, 0, '2023-01-16 13:36:01', '2023-01-16 13:36:01', NULL, 'test222');
INSERT INTO `sys_user` VALUES (66, 'test222', '阿秀', 0, 'test222@qq.com', '15392187210', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, '', 0, '2023-01-16 13:36:01', '2023-01-16 16:16:36', NULL, 'test222');
INSERT INTO `sys_user` VALUES (67, 'test222', '阿古', 0, 'test222@qq.com', '15392187211', '582d95cc4c99f8dcee5267ef4afa43a3', '', 1, '', 0, '2023-01-16 13:36:01', '2023-01-28 18:02:51', NULL, '阿古8888');
INSERT INTO `sys_user` VALUES (68, 'test2221', 'test222', 0, '514634736@qq.com', '15392187210', '74d57c945e3dd23837f0c7ab8712182a', '', 0, '', 1, '2023-01-28 18:03:23', '2023-01-31 17:11:00', NULL, '');
INSERT INTO `sys_user` VALUES (69, 'test222555', 'test222111', 0, '5@qq.com', '15392187210', 'a8ed38de2ec65cd6b6054259c445bcdc', '', 0, '', 0, '2023-01-28 18:03:42', '2023-01-29 11:39:10', NULL, '111');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户和角色关联id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `role_id` bigint NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_role`(`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (4, 2, 1);
INSERT INTO `sys_user_role` VALUES (5, 2, 2);

SET FOREIGN_KEY_CHECKS = 1;

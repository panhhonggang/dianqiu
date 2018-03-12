/*
 Navicat Premium Data Transfer

 Source Server         : 120.27.12.1
 Source Server Type    : MySQL
 Source Server Version : 50636
 Source Host           : localhost:3306
 Source Schema         : pubdata

 Target Server Type    : MySQL
 Target Server Version : 50636
 File Encoding         : 65001

 Date: 12/03/2018 09:26:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pub_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `pub_admin_menu`;
CREATE TABLE `pub_admin_menu`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单表',
  `pid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '所属菜单',
  `name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单名称',
  `mca` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块、控制器、方法',
  `ico` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'font-awesome图标',
  `order_number` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_admin_menu
-- ----------------------------
INSERT INTO `pub_admin_menu` VALUES (43, 0, '设备管理', 'Admin/Devices', '', 2);
INSERT INTO `pub_admin_menu` VALUES (44, 43, '设备列表', 'Admin/Devices/devicesList', '', 2);
INSERT INTO `pub_admin_menu` VALUES (46, 0, '建议及报修', 'Admin/Feeds', '', 3);
INSERT INTO `pub_admin_menu` VALUES (47, 46, '建议列表', 'Admin/Feeds/feedslist', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (48, 46, '报修列表', 'Admin/Feeds/repairlist', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (49, 0, '后台管理', 'Admin/Vendors', '', 2);
INSERT INTO `pub_admin_menu` VALUES (50, 49, '经销商添加', 'Admin/Vendors/add', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (54, 49, '经销商列表', 'Admin/Vendors/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (52, 49, '设备归属', 'Admin/Vendors/devices_add', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (53, 49, '设备归属列表', 'Admin/Vendors/bindinglist', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (55, 0, '产品管理', 'Admin/Product', '', 4);
INSERT INTO `pub_admin_menu` VALUES (56, 55, '滤芯设置', 'Admin/Product/filter_add', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (57, 55, '滤芯列表', 'Admin/Product/filterlist', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (58, 55, '产品类型设置', 'Admin/Product/add', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (59, 55, '产品类型列表', 'Admin/Product/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (60, 43, '设备添加', 'Admin/Devices/show_add_device', '', 1);
INSERT INTO `pub_admin_menu` VALUES (61, 0, '订单管理', 'Admin/Orders', '', 5);
INSERT INTO `pub_admin_menu` VALUES (62, 61, '订单列表', 'Admin/Orders/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (63, 0, '工单管理', 'Admin/Work', '', 6);
INSERT INTO `pub_admin_menu` VALUES (64, 63, '工单添加', 'Admin/Work/add', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (65, 63, '工单列表', 'Admin/Work/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (66, 0, '用户管理', 'Admin/Users', '', 7);
INSERT INTO `pub_admin_menu` VALUES (67, 66, '用户列表', 'Admin/Users/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (68, 66, '充值记录', 'Admin/Users/flow', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (70, 0, '权限管理', 'Admin/Rule', '', 8);
INSERT INTO `pub_admin_menu` VALUES (71, 70, '权限组', 'Admin/Rule/group', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (72, 70, '权限列表', 'Admin/Rule/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (74, 0, '首页', 'Admin/Test/welcome', '', 1);
INSERT INTO `pub_admin_menu` VALUES (75, 0, '菜单管理', 'Admin/Menu', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (76, 75, '菜单编辑', 'Admin/Menu/index', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (77, 0, '套餐管理', 'Admin/Setmeal', '9', NULL);
INSERT INTO `pub_admin_menu` VALUES (78, 77, '套餐设置', 'Admin/Setmeal/add', '', NULL);
INSERT INTO `pub_admin_menu` VALUES (79, 77, '套餐列表', 'Admin/Setmeal/index', '', NULL);

-- ----------------------------
-- Table structure for pub_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `pub_auth_group`;
CREATE TABLE `pub_auth_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_auth_group
-- ----------------------------
INSERT INTO `pub_auth_group` VALUES (1, ' 超级管理员', 1, '1,2,38,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37');
INSERT INTO `pub_auth_group` VALUES (2, '一级代理商', 1, '1,2,3,7,13,15,16,18,19,20,21,22,23,24,25,26,35,36,37');
INSERT INTO `pub_auth_group` VALUES (5, '游客', 1, NULL);
INSERT INTO `pub_auth_group` VALUES (4, '管理员', 1, '1,2,38,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37');

-- ----------------------------
-- Table structure for pub_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `pub_auth_group_access`;
CREATE TABLE `pub_auth_group_access`  (
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `group_id` int(11) UNSIGNED NOT NULL COMMENT '用户组id',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组明细表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of pub_auth_group_access
-- ----------------------------
INSERT INTO `pub_auth_group_access` VALUES (1, 1);
INSERT INTO `pub_auth_group_access` VALUES (9, 2);
INSERT INTO `pub_auth_group_access` VALUES (12, 2);
INSERT INTO `pub_auth_group_access` VALUES (16, 2);
INSERT INTO `pub_auth_group_access` VALUES (19, 2);
INSERT INTO `pub_auth_group_access` VALUES (43, 2);
INSERT INTO `pub_auth_group_access` VALUES (50, 2);
INSERT INTO `pub_auth_group_access` VALUES (51, 4);
INSERT INTO `pub_auth_group_access` VALUES (54, 2);

-- ----------------------------
-- Table structure for pub_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `pub_auth_rule`;
CREATE TABLE `pub_auth_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级id',
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：为1正常，为0禁用',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规则表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of pub_auth_rule
-- ----------------------------
INSERT INTO `pub_auth_rule` VALUES (1, 0, 'Admin/Index', '后台首页', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (2, 1, 'Admin/Index/index', '欢迎页面', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (3, 0, 'Admin/Vendors', '后台管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (4, 3, 'Admin/Vendors/add', '添加经销商', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (5, 3, 'Admin/Vendors/index', '经销商列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (6, 3, 'Admin/Vendors/devices_add', '设备归属', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (7, 3, 'Admin/Vendors/bindinglist', '设备归属列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (8, 0, 'Admin/Product', '产品管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (9, 8, 'Admin/Product/filter_add', '滤芯设置', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (10, 8, 'Admin/Product/filterlist', '滤芯列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (11, 8, 'Admin/Product/add', '产品类型设置', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (12, 8, 'Admin/Product/index', '产品类型列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (13, 0, 'Admin/Devices', '设备管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (18, 0, 'Admin/Orders', '订单管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (15, 13, 'Admin/Devices/devicesList', '设备列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (16, 13, 'Admin/Devices/show_add_device', '设备添加', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (19, 18, 'Admin/Orders/index', '订单列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (20, 0, 'Admin/Work', '工单管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (21, 20, 'Admin/Work/add', '工单添加', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (22, 20, 'Admin/Work/index', '工单列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (23, 0, 'Admin/Users', '用户管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (24, 23, 'Admin/Users/index', '用户列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (25, 23, 'Admin/Users/flow', '充值记录', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (26, 23, 'Admin/Users/consume', '消费记录', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (27, 0, 'Admin/Rule', '权限管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (28, 27, 'Admin/Rule/group', '权限组', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (29, 27, 'Admin/Rule/index', '权限列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (30, 0, 'Admin/Menu', '菜单管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (31, 30, 'Admin/Menu/index', '菜单编辑', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (32, 0, 'Admin/Setmeal', '套餐管理', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (33, 32, 'Admin/Setmeal/add', '套餐设置', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (34, 32, 'Admin/Setmeal/index', '套餐列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (35, 0, 'Admin/Feeds', '建议及报修', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (36, 35, 'Admin/Feeds/feedslist', '建议列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (37, 35, 'Admin/Feeds/repairlist', '报修列表', 1, 1, '');
INSERT INTO `pub_auth_rule` VALUES (38, 1, 'Admin/Vendors/password', '修改密码', 1, 1, '');

-- ----------------------------
-- Table structure for pub_binding
-- ----------------------------
DROP TABLE IF EXISTS `pub_binding`;
CREATE TABLE `pub_binding`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` int(11) NOT NULL COMMENT '经销商ID',
  `did` int(11) NOT NULL COMMENT '设备ID',
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人是谁',
  `addtime` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_binding
-- ----------------------------
INSERT INTO `pub_binding` VALUES (1, 47, 1, '炒鸡管理员', 1516355779);
INSERT INTO `pub_binding` VALUES (2, 47, 2, '炒鸡管理员', 1516356183);
INSERT INTO `pub_binding` VALUES (3, 47, 3, '炒鸡管理员', 1516356190);
INSERT INTO `pub_binding` VALUES (4, 47, 4, '炒鸡管理员', 1516356196);
INSERT INTO `pub_binding` VALUES (5, 47, 5, '炒鸡管理员', 1516360599);
INSERT INTO `pub_binding` VALUES (6, 1, 6, '炒鸡管理员', 1516374497);
INSERT INTO `pub_binding` VALUES (7, 47, 7, '炒鸡管理员', 1516411171);
INSERT INTO `pub_binding` VALUES (47, 52, 8, '炒鸡管理员', 1517455156);
INSERT INTO `pub_binding` VALUES (12, 48, 10, '炒鸡管理员', 1516418523);
INSERT INTO `pub_binding` VALUES (13, 48, 11, '炒鸡管理员', 1516418896);
INSERT INTO `pub_binding` VALUES (14, 48, 12, '炒鸡管理员', 1516426126);
INSERT INTO `pub_binding` VALUES (16, 48, 13, '炒鸡管理员', 1516600684);
INSERT INTO `pub_binding` VALUES (18, 47, 14, '炒鸡管理员', 1516607209);
INSERT INTO `pub_binding` VALUES (19, 48, 15, '炒鸡管理员', 1516672575);
INSERT INTO `pub_binding` VALUES (23, 1, 16, '炒鸡管理员', 1516763881);
INSERT INTO `pub_binding` VALUES (39, 51, 17, '炒鸡管理员', 1517318889);
INSERT INTO `pub_binding` VALUES (25, 1, 18, '炒鸡管理员', 1516846439);
INSERT INTO `pub_binding` VALUES (27, 50, 19, '炒鸡管理员', 1516851965);
INSERT INTO `pub_binding` VALUES (28, 50, 20, '炒鸡管理员', 1516865698);
INSERT INTO `pub_binding` VALUES (29, 47, 21, '炒鸡管理员', 1516930289);
INSERT INTO `pub_binding` VALUES (30, 47, 22, '炒鸡管理员', 1516930294);
INSERT INTO `pub_binding` VALUES (31, 47, 23, '炒鸡管理员', 1516930307);
INSERT INTO `pub_binding` VALUES (32, 47, 24, '炒鸡管理员', 1516931717);
INSERT INTO `pub_binding` VALUES (33, 47, 25, '炒鸡管理员', 1516931725);
INSERT INTO `pub_binding` VALUES (35, 47, 26, '炒鸡管理员', 1517193105);
INSERT INTO `pub_binding` VALUES (37, 48, 9, '炒鸡管理员', 1517212367);
INSERT INTO `pub_binding` VALUES (40, 52, 27, '炒鸡管理员', 1517367741);
INSERT INTO `pub_binding` VALUES (41, 1, 28, '炒鸡管理员', 1517367747);
INSERT INTO `pub_binding` VALUES (42, 50, 29, '炒鸡管理员', 1517367754);
INSERT INTO `pub_binding` VALUES (43, 52, 30, '炒鸡管理员', 1517370249);
INSERT INTO `pub_binding` VALUES (44, 52, 31, '炒鸡管理员', 1517370303);
INSERT INTO `pub_binding` VALUES (46, 53, 32, '炒鸡管理员', 1517455129);
INSERT INTO `pub_binding` VALUES (48, 53, 33, '炒鸡管理员', 1517542048);
INSERT INTO `pub_binding` VALUES (49, 1, 34, '炒鸡管理员', 1517542056);
INSERT INTO `pub_binding` VALUES (50, 53, 35, '炒鸡管理员', 1517550722);
INSERT INTO `pub_binding` VALUES (51, 53, 36, '炒鸡管理员', 1517550727);
INSERT INTO `pub_binding` VALUES (52, 53, 37, '炒鸡管理员', 1517550734);
INSERT INTO `pub_binding` VALUES (53, 53, 38, '炒鸡管理员', 1517550740);
INSERT INTO `pub_binding` VALUES (54, 53, 39, '炒鸡管理员', 1517550747);
INSERT INTO `pub_binding` VALUES (55, 53, 40, '炒鸡管理员', 1517550755);
INSERT INTO `pub_binding` VALUES (56, 53, 41, '炒鸡管理员', 1517550763);
INSERT INTO `pub_binding` VALUES (57, 1, 42, '超级管理员', 1520318390);
INSERT INTO `pub_binding` VALUES (59, 1, 45, '超级管理员', 1520319200);
INSERT INTO `pub_binding` VALUES (60, 1, 46, '超级管理员', 1520330414);

-- ----------------------------
-- Table structure for pub_cart_filters
-- ----------------------------
DROP TABLE IF EXISTS `pub_cart_filters`;
CREATE TABLE `pub_cart_filters`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
  `fid` int(11) UNSIGNED NOT NULL COMMENT '滤芯ID',
  `num` int(11) UNSIGNED NOT NULL COMMENT '购物数量',
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 230 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of pub_cart_filters
-- ----------------------------
INSERT INTO `pub_cart_filters` VALUES (85, 9, 4, 1, 1516701181, NULL);
INSERT INTO `pub_cart_filters` VALUES (84, 9, 2, 3, 1516701167, 1516701181);
INSERT INTO `pub_cart_filters` VALUES (83, 9, 3, 3, 1516701167, 1516701181);
INSERT INTO `pub_cart_filters` VALUES (106, 10, 4, 1, 1516720038, NULL);
INSERT INTO `pub_cart_filters` VALUES (226, 2, 15, 3, 1520504246, 1520504246);
INSERT INTO `pub_cart_filters` VALUES (225, 3, 2, 1, 1520496858, NULL);
INSERT INTO `pub_cart_filters` VALUES (207, 4, 2, 2, 1518513604, NULL);
INSERT INTO `pub_cart_filters` VALUES (224, 3, 1, 1, 1520496858, NULL);
INSERT INTO `pub_cart_filters` VALUES (227, 29, 11, 1, 1520652349, NULL);
INSERT INTO `pub_cart_filters` VALUES (228, 29, 2, 1, 1520652349, NULL);
INSERT INTO `pub_cart_filters` VALUES (229, 29, 9, 1, 1520652349, NULL);

-- ----------------------------
-- Table structure for pub_cart_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_cart_setmeal`;
CREATE TABLE `pub_cart_setmeal`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
  `sid` int(11) UNSIGNED NOT NULL COMMENT '套餐ID',
  `num` int(11) UNSIGNED NOT NULL COMMENT '购物数量',
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 267 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of pub_cart_setmeal
-- ----------------------------
INSERT INTO `pub_cart_setmeal` VALUES (135, 6, 9, 1, 1517035406, NULL);
INSERT INTO `pub_cart_setmeal` VALUES (133, 6, 6, 19, 1517035094, 1517126866);
INSERT INTO `pub_cart_setmeal` VALUES (132, 6, 5, 19, 1517034956, 1517035523);
INSERT INTO `pub_cart_setmeal` VALUES (122, 2, 1, 1, 1516935981, NULL);
INSERT INTO `pub_cart_setmeal` VALUES (113, 11, 3, 1, 1516930012, NULL);
INSERT INTO `pub_cart_setmeal` VALUES (90, 10, 2, 1, 1516720044, NULL);
INSERT INTO `pub_cart_setmeal` VALUES (148, 6, 4, 16, 1517038059, 1517131328);
INSERT INTO `pub_cart_setmeal` VALUES (252, 4, 22, 1, 1518513604, NULL);
INSERT INTO `pub_cart_setmeal` VALUES (265, 29, 22, 1, 1520652353, NULL);
INSERT INTO `pub_cart_setmeal` VALUES (266, 29, 21, 3, 1520652359, 1520652359);

-- ----------------------------
-- Table structure for pub_charg
-- ----------------------------
DROP TABLE IF EXISTS `pub_charg`;
CREATE TABLE `pub_charg`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `vendors_id` int(11) UNSIGNED NOT NULL COMMENT '关联的供销商ID号',
  `lease_way` tinyint(1) UNSIGNED NOT NULL COMMENT '计费方式',
  `price` decimal(15, 2) UNSIGNED NOT NULL COMMENT '价格',
  `begin_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `vendors_id`(`vendors_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pub_consume
-- ----------------------------
DROP TABLE IF EXISTS `pub_consume`;
CREATE TABLE `pub_consume`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL COMMENT '设备ID',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `icid` int(11) NULL DEFAULT NULL COMMENT 'IC卡ID',
  `flow` int(10) NOT NULL COMMENT '消费流量',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消费地点',
  `time` int(11) NOT NULL COMMENT '消费时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pub_current_devices
-- ----------------------------
DROP TABLE IF EXISTS `pub_current_devices`;
CREATE TABLE `pub_current_devices`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户',
  `did` int(11) UNSIGNED NOT NULL COMMENT '当前设备',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 48 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of pub_current_devices
-- ----------------------------
INSERT INTO `pub_current_devices` VALUES (37, 4, 6);
INSERT INTO `pub_current_devices` VALUES (36, 1, 21);
INSERT INTO `pub_current_devices` VALUES (43, 3, 45);
INSERT INTO `pub_current_devices` VALUES (12, 6, 20);
INSERT INTO `pub_current_devices` VALUES (40, 14, 11);
INSERT INTO `pub_current_devices` VALUES (33, 12, 46);
INSERT INTO `pub_current_devices` VALUES (44, 8, 1);
INSERT INTO `pub_current_devices` VALUES (45, 7, 4);
INSERT INTO `pub_current_devices` VALUES (46, 2, 3);
INSERT INTO `pub_current_devices` VALUES (47, 29, 8);

-- ----------------------------
-- Table structure for pub_device_config
-- ----------------------------
DROP TABLE IF EXISTS `pub_device_config`;
CREATE TABLE `pub_device_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL COMMENT '设备ID',
  `dtid` int(11) NOT NULL COMMENT '设备类型ID',
  `vid` int(11) NOT NULL COMMENT '经销商ID',
  `leasingmode` tinyint(1) NULL DEFAULT NULL COMMENT '租赁模式(0：时间 1：流量)',
  `addtime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for pub_device_type
-- ----------------------------
DROP TABLE IF EXISTS `pub_device_type`;
CREATE TABLE `pub_device_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型名称',
  `filter1` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级滤芯',
  `filter2` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filter3` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filter4` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filter5` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filter6` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filter7` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filter8` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_device_type
-- ----------------------------
INSERT INTO `pub_device_type` VALUES (1, '滤芯', 'PP膜-PP棉A型', 'RO膜-R膜', 'PDF-PDFA型', 'RO膜-RO膜A型', '滤芯E-滤芯E型', 'PP膜-PP棉A型', '滤芯H-滤芯H型', '', 1516355722);
INSERT INTO `pub_device_type` VALUES (2, '产品', '滤芯V-滤芯V型', '滤芯B-滤芯B型', '滤芯C-滤芯C型', '滤芯E-滤芯E型', '滤芯D-滤芯D型', '', '', '', 1516418238);
INSERT INTO `pub_device_type` VALUES (3, 'LV', '滤芯F-滤芯F型', '滤芯H-滤芯H型', 'RO1膜', 'PP1膜', '滤芯C', '滤芯D', '', '', 1516765317);
INSERT INTO `pub_device_type` VALUES (4, '01', 'RO膜-R膜', 'RO膜-R膜', 'RO膜-R膜', '', '', '', '', '', 1516846382);
INSERT INTO `pub_device_type` VALUES (5, '滤芯V', '滤芯F-滤芯F型', 'RO膜', 'PP膜', '', '', '', '', '', 1516851739);
INSERT INTO `pub_device_type` VALUES (6, 'LX', 'PP膜-PP棉A型', '滤芯B-滤芯B型', '滤芯C-滤芯C型', '滤芯D-滤芯D型', '滤芯E-滤芯E型', '滤芯F-滤芯F型', 'PDF-PDFA型', 'PP膜-PP棉A型', 1518054606);
INSERT INTO `pub_device_type` VALUES (7, 'GB', 'PP棉-W型', '滤芯V-滤芯V型', '', '', '', '', '', '', 1520318650);
INSERT INTO `pub_device_type` VALUES (8, '继科A', 'PP棉-PP棉100', 'PP棉-PP棉100', 'PP棉-PP棉100', 'PO膜-PO膜400', 'T33-后置滤芯', '', '', '', 1520330378);

-- ----------------------------
-- Table structure for pub_devices
-- ----------------------------
DROP TABLE IF EXISTS `pub_devices`;
CREATE TABLE `pub_devices`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `device_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编码',
  `device_statu` tinyint(1) UNSIGNED NOT NULL COMMENT '设备状态：1已入库，2待激活，3已激活',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `binding_statu` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否绑定经销商 0：未绑定 1：已绑定',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `type_id` int(11) NOT NULL COMMENT '产品类型ID',
  `name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聯係人名字',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安裝地址',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聯係人手機號',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`, `device_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_devices
-- ----------------------------
INSERT INTO `pub_devices` VALUES (1, '166753845596778', 1, 1516355769, 1, 8, 1, '天天', '广州番禺市桥', '13525489368');
INSERT INTO `pub_devices` VALUES (2, '112733445596778', 1, 1516356174, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (3, '162753445596778', 1, 1516356174, 1, 2, 1, '地狱使者', '哦说明民工公民', '18002229021');
INSERT INTO `pub_devices` VALUES (4, '155753845596778', 1, 1516356174, 1, 7, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (5, '112533645596778', 1, 1516360588, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (6, '865473039777571', 1, 1516374484, 1, 4, 1, '张华斌', '广州市番禺区钟村镇', '13556190315');
INSERT INTO `pub_devices` VALUES (7, '162753445555778', 1, 1516411161, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (8, '000000000000000', 1, 1516415486, 1, 29, 1, '智慧', '广州市白云区永泰新村的', '15800859980');
INSERT INTO `pub_devices` VALUES (9, '112733445596668', 1, 1516417899, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (10, '112799945596778', 1, 1516418263, 1, NULL, 2, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (11, '111133445596778', 1, 1516418884, 1, 14, 2, 'yi', '广州市番禺区钟村', '13060815601');
INSERT INTO `pub_devices` VALUES (12, '112798845596778', 1, 1516426113, 1, NULL, 2, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (13, '992833445596778', 1, 1516600675, 1, 3, 2, '韩毅', '广州市番禺区钟村街道办事处', '15900890896');
INSERT INTO `pub_devices` VALUES (14, '112233445566778', 1, 1516607201, 1, 12, 1, '张显荣', '深圳市宝安区福永', '18202099099');
INSERT INTO `pub_devices` VALUES (15, '552933445596668', 1, 1516672567, 1, NULL, 2, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (16, '123456789123456', 1, 1516688841, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (17, '999999999999999', 1, 1516765336, 1, NULL, 3, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (18, '112233665544778', 1, 1516846407, 1, NULL, 4, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (19, '252633445596788', 1, 1516851913, 1, NULL, 5, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (20, '228733445596778', 1, 1516865689, 1, 6, 2, '瓦斯', '广东省南雄市', '18475039192');
INSERT INTO `pub_devices` VALUES (21, '888733445596578', 1, 1516930219, 1, 1, 1, '潘宏钢', '不能说的时候我是', '15920569139');
INSERT INTO `pub_devices` VALUES (22, '328833445596978', 1, 1516930226, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (23, '626733445596776', 1, 1516930241, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (24, '826733485596976', 1, 1516931697, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (25, '656533485596976', 1, 1516931707, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (26, '756533485586976', 1, 1516931814, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (27, '888888888888888', 1, 1517283748, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (28, '999999998888888', 1, 1517317345, 1, NULL, 5, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (29, '121212121212121', 1, 1517317799, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (30, '111115698743598', 1, 1517363080, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (31, '565623652365236', 1, 1517367479, 1, NULL, 4, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (32, '111111111111111', 1, 1517376778, 1, NULL, 3, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (33, '111212222222222', 1, 1517450808, 1, NULL, 5, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (34, '333335698743598', 1, 1517450992, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (35, '000012121212121', 1, 1517451466, 1, NULL, 5, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (36, '223232222222222', 1, 1517536430, 1, NULL, 4, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (37, '666888868686868', 1, 1517541855, 1, NULL, 5, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (38, '000232323232301', 1, 1517541899, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (39, '898989898989898', 1, 1517542115, 1, NULL, 3, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (40, '230230542152154', 1, 1517542260, 1, NULL, 2, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (41, '584521542152365', 1, 1517542306, 1, NULL, 2, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (42, '111111111122222', 1, 1519528469, 1, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (43, '222222211111111', 1, 1519528469, 0, NULL, 2, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (44, '111115698743596', 1, 1519529356, 0, NULL, 1, NULL, NULL, NULL);
INSERT INTO `pub_devices` VALUES (45, '252222222222222', 1, 1520318242, 1, 3, 1, '笑笑', '广州市番禺区钟村街道办事处', '15899086658');
INSERT INTO `pub_devices` VALUES (46, '868575025674179', 1, 1520330401, 1, 12, 8, '张显荣', '深圳市龙岗区', '18202099099');

-- ----------------------------
-- Table structure for pub_devices_statu
-- ----------------------------
DROP TABLE IF EXISTS `pub_devices_statu`;
CREATE TABLE `pub_devices_statu`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `DeviceID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备码',
  `DeviceStause` tinyint(2) NULL DEFAULT 11 COMMENT '设备状态 0:制水 1:冲洗 2:水满 3:缺水 4漏水 5:检修 6:欠费停机 7:关机 8:开机(仅命令)',
  `ReFlow` int(10) NULL DEFAULT NULL COMMENT '剩余流量 租赁用',
  `Reday` int(10) NULL DEFAULT NULL COMMENT '剩余天数 租赁用',
  `RawTDS` int(10) NULL DEFAULT NULL COMMENT '纯水',
  `PureTDS` int(10) NULL DEFAULT NULL COMMENT '原水',
  `Temperature` int(10) NULL DEFAULT NULL COMMENT '温度',
  `ReFlowFilter1` int(10) NULL DEFAULT NULL COMMENT '滤芯1剩余流量',
  `ReDayFilter1` int(10) NULL DEFAULT NULL COMMENT '滤芯1剩余天数',
  `ReFlowFilter2` int(10) NULL DEFAULT NULL COMMENT '滤芯2剩余流量',
  `ReDayFilter2` int(10) NULL DEFAULT NULL COMMENT '滤芯2剩余天数',
  `ReFlowFilter3` int(10) NULL DEFAULT NULL COMMENT '滤芯3剩余流量',
  `ReDayFilter3` int(10) NULL DEFAULT NULL COMMENT '滤芯3剩余天数',
  `ReFlowFilter4` int(10) NULL DEFAULT NULL COMMENT '滤芯4剩余流量',
  `ReDayFilter4` int(10) NULL DEFAULT NULL COMMENT '滤芯4剩余天数',
  `ReFlowFilter5` int(10) NULL DEFAULT NULL COMMENT '滤芯5剩余流量',
  `ReDayFilter5` int(10) NULL DEFAULT NULL COMMENT '滤芯5剩余天数',
  `ReFlowFilter6` int(10) NULL DEFAULT NULL COMMENT '滤芯6剩余流量',
  `ReDayFilter6` int(10) NULL DEFAULT NULL COMMENT '滤芯6剩余天数',
  `ReFlowFilter7` int(10) NULL DEFAULT NULL COMMENT '滤芯7剩余流量',
  `ReDayFilter7` int(10) NULL DEFAULT NULL COMMENT '滤芯7剩余天数',
  `ReFlowFilter8` int(10) NULL DEFAULT NULL COMMENT '滤芯8剩余流量',
  `ReDayFilter8` int(10) NULL DEFAULT NULL COMMENT '滤芯8剩余天数',
  `LeasingMode` tinyint(1) NULL DEFAULT NULL COMMENT '租赁模式  0:零售型 1:按流量计费 2:按时间计费 3:时长和流量套餐',
  `AliveStause` tinyint(1) NULL DEFAULT NULL,
  `SumFlow` int(10) NULL DEFAULT NULL COMMENT '累计流量',
  `SumDay` int(10) NULL DEFAULT NULL COMMENT '累计天数',
  `FilterMode` tinyint(1) NULL DEFAULT NULL COMMENT '滤芯模式',
  `Device` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ICCID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CSQ` int(3) NULL DEFAULT NULL,
  `Loaction` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updatetime` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`, `DeviceID`, `DeviceStause`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_devices_statu
-- ----------------------------
INSERT INTO `pub_devices_statu` VALUES (1, '155753845596778', 1, 2200, 200, 46, 65, 30, 100, NULL, 200, NULL, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 500, NULL, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', '1516355769', '1516428190');
INSERT INTO `pub_devices_statu` VALUES (2, '166753845596778', 0, 1100, 200, 46, 65, 30, 67, NULL, 165, NULL, 200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 476, NULL, 1, NULL, NULL, 90, NULL, '1516355769', '1516355769');
INSERT INTO `pub_devices_statu` VALUES (3, '112733445596778', 1, 200, 300, 60, 78, 20, 58, 111, 34, 111, 147, 111, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, 396, 111, 1, NULL, NULL, 80, NULL, '1516355769', '1516355769');
INSERT INTO `pub_devices_statu` VALUES (4, '162753445596778', 2, 604, -1, 0, 0, -1, 100, 11, 200, 22, 300, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 1, 'GPRS', '898602b8191750155013', 20, '25CB,708D\0', '1516355769', '1516787067');
INSERT INTO `pub_devices_statu` VALUES (5, '112233445566778', 0, -1, 100, 100, 100, -1, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, 0, 0, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', '1516371894', '1520320421');
INSERT INTO `pub_devices_statu` VALUES (6, '865473039777571', 0, 9, -1, 0, 0, -1, 100, 99, 100, 99, 300, 299, 200, 199, 330, 329, 34954, 17556, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 1, 'GPRS', '898602b8191750155013', 14, '25CB,DE70\0', '1516371894', '1516957058');
INSERT INTO `pub_devices_statu` VALUES (7, '162753445555778', 1, 5400, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (8, '112733445596668', 0, 269, 100, 100, 100, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, -1, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, 0, 0, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1516607104');
INSERT INTO `pub_devices_statu` VALUES (9, '111133445596778', 11, 1210, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1516434647');
INSERT INTO `pub_devices_statu` VALUES (10, '112798845596778\r\n\r\n\r', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (11, '112799945596778\r\n\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (12, '992833445596778', 11, 25600, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1516781989');
INSERT INTO `pub_devices_statu` VALUES (13, '552933445596668', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (14, '112533645596778\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (15, '992833445596778\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (16, '123456789123456', 0, -1, 40, 0, 0, -1, -1, 99, -1, 0, -1, 99, -1, 0, -1, 0, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, 0, 200, 1, 'GPRS', '898602b8191750155013', 23, '25CB,708D\0', NULL, '1517038099');
INSERT INTO `pub_devices_statu` VALUES (17, '111133445596778\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (18, '155753845596778\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (19, '112733445596668\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (20, '000000000000000', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (21, '999999999999999', 11, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (22, '112533645596778', 11, 911, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (23, '112799945596778', 11, 38900, NULL, NULL, NULL, NULL, 111, 11, 12, 123, 111, 111, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 22111, 111, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (24, '112233665544778\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (25, '252633445596788', 2, 2900, 385, 90, 50, 32, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 3, 1, 0, 0, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1517023452');
INSERT INTO `pub_devices_statu` VALUES (26, '228733445596778', 4, -1, -1, 0, 0, -1, -1, 11, -1, 22, -1, 11, -1, 11, -1, 11, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 1, 'GPRS', '898607B6191730009321', 28, '25CB,708D\0', NULL, '1520515602');
INSERT INTO `pub_devices_statu` VALUES (27, '112798845596778', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (28, '888733445596578', 2, 21000, 85, 90, 50, 32, -1, 100, 55, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 3, 1, 2301, 0, 1, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1516931035');
INSERT INTO `pub_devices_statu` VALUES (29, '656533485596976\r\n', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (30, '826733485596976', 2, 11100, 11300, 90, 50, 32, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 3, 1, 0, 0, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1517105977');
INSERT INTO `pub_devices_statu` VALUES (31, '111111111111111', 0, -1, 100, 100, 100, -1, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, 0, 0, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', '1516953362', '1517213595');
INSERT INTO `pub_devices_statu` VALUES (32, '756533485586976', 0, 2000, 85, 90, 50, 32, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 3, 1, 0, 0, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1517205330');
INSERT INTO `pub_devices_statu` VALUES (33, '626733445596776', 11, 285, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pub_devices_statu` VALUES (34, '369852369852369', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', '1517914176', NULL);
INSERT INTO `pub_devices_statu` VALUES (35, '252222222222222', 2, 2000, 85, 90, 50, 32, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', NULL, '1520321353');
INSERT INTO `pub_devices_statu` VALUES (36, '868575025674179', 1, -1, 80, 0, 0, -1, -1, 100, -1, 100, -1, 100, -1, 400, -1, 200, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, 0, 0, NULL, 'GPRS', '898607B6191792615189', 26, '25CB,708D\0', '1520329436', '1520577785');
INSERT INTO `pub_devices_statu` VALUES (37, '666666662222222', 0, 2000, 85, 90, 50, 32, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', '1520495981', '1520496028');
INSERT INTO `pub_devices_statu` VALUES (38, '333333322222211', 2, 2000, 85, 90, 50, 32, -1, 100, -1, 100, -1, 100, -1, 100, -1, 100, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, NULL, 'GPRS', '11223344556677889900', 90, '10020\0\0\0\0\0', '1520575375', '1520575825');
INSERT INTO `pub_devices_statu` VALUES (39, '352425025336838', 6, -1, 0, 0, 0, -1, 100, 100, 100, 100, 100, 100, 400, 400, 200, 200, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, 0, 0, NULL, 'GPRS', '898602b1031600061425', 20, '25cb,708d\0', '1520670569', '1520670962');
INSERT INTO `pub_devices_statu` VALUES (40, '352425025338354', 0, -1, -1, 0, 0, -1, 35127, 49710, 35127, 49710, 35127, 49710, 400, 400, 200, 200, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, 'GPRS', '898602b1031600061425', 17, '25cb,708d\0', '1520671508', '1520676025');
INSERT INTO `pub_devices_statu` VALUES (41, '868575025672611', 5, -1, -1, 0, 0, -1, 100, 100, 100, 100, 100, 100, 400, 400, 200, 200, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, 'GPRS', '898607B6191730009335', 28, '25CB,708D\0', '1520674814', '1520696962');
INSERT INTO `pub_devices_statu` VALUES (42, '868575025659352', 5, -1, -1, 0, 0, -1, 100, 100, 100, 100, 100, 100, 400, 400, 200, 200, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, 'GPRS', '898607B6191730009336', 30, '25CB,708D\0', '1520674921', '1520697184');

-- ----------------------------
-- Table structure for pub_express_information
-- ----------------------------
DROP TABLE IF EXISTS `pub_express_information`;
CREATE TABLE `pub_express_information`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的用户ID号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `addres` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件地址',
  `created_at` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_express_information
-- ----------------------------
INSERT INTO `pub_express_information` VALUES (1, 4, '张华斌', '13556190315', '广州市番禺区钟村', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (2, 3, '小琴', '14085236985', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (3, 3, '小琴', '14208523698', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (4, 4, '张华斌', '13556190315', '广州市番禺区钟村镇', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (5, 3, '小琴', '14698563248', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (6, 3, '小琴', '17580962536', '黄樱桃习明泽破功', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (7, 8, '小心', '15896582563', '广州市番禺区市桥汽车站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (8, 3, '心心', '13589652563', '广州市天河区天河天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (9, 3, '小琴', '13580962563', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (10, 7, '巴黎街', '18888888888', '广州市天河区天天天', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (11, 7, '陈昌平', '15698522252', '怕广迈腾飞不得你', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (12, 3, '小琴', '14963259875', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (13, 3, '小美', '18698563652', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (14, 3, '下雨', '18096583659', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (15, 3, '慧慧', '17800858085', '广州市天河区天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (16, 3, '小琴', '13580962457', '广州市天河区天河棠下', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (17, 3, '小琴', '13580089632', '广州市天河区天河', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (18, 3, '咯个涂脸', '13536363636', '体重肉比较三节课', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (19, 3, '进去了', '13434343434', '新裙子伺候您进去之后', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (20, 3, '小小', '13980523698', '广州市天河区天河棠下', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (21, 3, '小小', '14708523698', '广州市天河区天河天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (22, 3, '小小', '15800896589', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (23, 3, '小小', '13800859658', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (24, 3, '小琴', '13680803306', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (25, 3, '小小', '13880803306', '广州市天河区体检这', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (26, 3, '小小', '13800803360', '广州市天河区天河', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (27, 3, '下子玩', '13580803306', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (28, 3, '小琴', '13580803306', '广州市天河区天河棠下', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (29, 7, '您好', '13580083698', '广州市政府召开全市', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (30, 3, '希希', '13580803306', '湖滨我姑行我哦哦拍张照片', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (31, 3, '小小', '13580803306', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (32, 3, '想小', '13580083306', '咯哦红心送您哦婆婆红', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (33, 3, '小琴', '13580803306', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (34, 3, '赵荣', '13580803306', '广州市天河区天河路', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (35, 14, 'XXX', '13060815601', '广州市番禺区钟村街', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (36, 14, 'XXX', '13060815601', '广州市番禺区钟村XXX', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (37, 3, '希希', '13580803306', '广州市天河区天河', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (38, 1, '潘宏钢', '15920569139', '广东省深圳市宝安区', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (39, 1, '哈哈哈哈', '15920569139', '广东省东莞市虎门大桥', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (40, 8, '一盏', '13580803303', '形容哦名您是泼墨婆婆', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (41, 3, '公明', '13580803306', '公公婆婆送公公轰轰轰', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (42, 4, '张华', '13556190315', '广州市番禺区钟村镇', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (43, 3, '西西', '13558093568', '广州市天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (44, 14, 'yi', '13060815601', '广州市番禺区XXX', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (45, 3, '勤奋', '13580803306', '广州市天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (46, 3, '下周', '13580803306', '广州市天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (47, 3, '小时', '13908693256', '广州市天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (48, 14, 'yi', '13060815601', '广州市番禺区钟村', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (49, 3, '小琴', '13580803306', '广州市天河客运站', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (50, 3, '心里', '13580803306', '广州市番禺区天河', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (51, 14, 'yi', '13068815601', '广州市番禺区钟村', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (52, 3, '小小', '15963258008', '广州市番禺区天河', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (53, 3, '美美', '13580805869', '广州市番禺区天河', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (54, 3, '小小', '15896583256', '广州市番禺区钟村', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (55, 14, 'yi', '13060515601', '广州市番禺区钟村', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (56, 3, '小琴', '13580809086', '广州市番禺区钟村街道办事处', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (57, 3, '西西', '17808523698', '广州市番禺区钟村街道办事处', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (58, 14, 'yi', '13060815601', '广州市白云区开心', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (59, 3, '小小', '18099086652', '广州市番禺区钟村街道办事处', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (60, 3, '笑笑', '15800985589', '广州市番禺区钟村街道办事处', NULL, NULL, 0);
INSERT INTO `pub_express_information` VALUES (61, 3, '笑笑', '15800986658', '广州市番禺区钟村街道', NULL, NULL, 0);

-- ----------------------------
-- Table structure for pub_feeds
-- ----------------------------
DROP TABLE IF EXISTS `pub_feeds`;
CREATE TABLE `pub_feeds`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '反馈内容',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `addtime` int(11) NOT NULL COMMENT '反馈时间',
  `did` int(11) NOT NULL COMMENT '设备ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_feeds
-- ----------------------------
INSERT INTO `pub_feeds` VALUES (50, '哦肉麻彤彤', 2, 1520332068, 46);
INSERT INTO `pub_feeds` VALUES (48, '1265463', 14, 1517831924, 11);
INSERT INTO `pub_feeds` VALUES (49, '葫芦', 3, 1520318183, 13);

-- ----------------------------
-- Table structure for pub_filters
-- ----------------------------
DROP TABLE IF EXISTS `pub_filters`;
CREATE TABLE `pub_filters`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `filtername` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '滤芯名称',
  `alias` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '暂无别名' COMMENT '滤芯别名',
  `picpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '滤芯图片',
  `timelife` int(11) UNSIGNED NOT NULL COMMENT '时间寿命（小时）',
  `flowlife` int(11) UNSIGNED NOT NULL COMMENT '流量寿命（升）',
  `balancatime` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '时间寿命使能',
  `balancaflow` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '流量寿命使能',
  `introduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '暂无简介' COMMENT '滤芯简介',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '滤芯购买网址',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `price` decimal(15, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `device_id`(`filtername`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_filters
-- ----------------------------
INSERT INTO `pub_filters` VALUES (1, 'RO膜', 'R膜', '/upload/2018-01-19/5a61bf94c1d62.jpg', 500, 500, NULL, NULL, '500元500小时500升', '', 1519527806, 50000.00);
INSERT INTO `pub_filters` VALUES (2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 1519527111, 10000.00);
INSERT INTO `pub_filters` VALUES (3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 1516355602, 20000.00);
INSERT INTO `pub_filters` VALUES (4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 1516762237, 30000.00);
INSERT INTO `pub_filters` VALUES (5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 1516848526, 2000.00);
INSERT INTO `pub_filters` VALUES (6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 1516843167, 3000.00);
INSERT INTO `pub_filters` VALUES (7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 1516843183, 4000.00);
INSERT INTO `pub_filters` VALUES (8, '滤芯D', '滤芯D型', '/upload/2018-01-23/5a6751bc6a4e5.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 1519529149, 5000.00);
INSERT INTO `pub_filters` VALUES (9, '滤芯E', '滤芯E型', '/upload/2018-01-23/5a67330a6d7ad.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 1516712714, 6000.00);
INSERT INTO `pub_filters` VALUES (10, '滤芯F', '滤芯F型', '/upload/2018-01-24/5a681baa561ec.jpg', 23, 23, NULL, NULL, 'DFSDFDSFD ', '', 1520231223, 2300.00);
INSERT INTO `pub_filters` VALUES (11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, 'FDSJLSDFJSLFJSAJVCJOXJVCXLVJ', '', 1520231405, 33000.00);
INSERT INTO `pub_filters` VALUES (12, '滤芯bbbb', '', '/upload/2018-01-31/5a71325914f84.jpg', 1000, 1000, NULL, NULL, '赶紧上班', '', 1517367897, 100000.00);
INSERT INTO `pub_filters` VALUES (13, '滤芯V', '滤芯V型', '/upload/2018-03-06/5a9e385419ec9.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 1520318962, 2000.00);
INSERT INTO `pub_filters` VALUES (14, 'PP棉', 'W型', '/upload/2018-03-06/5a9e3816c94e5.jpg', 130, 500, NULL, NULL, 'PPmian', '', 1520505633, 60000.00);
INSERT INTO `pub_filters` VALUES (15, 'PP棉', 'PP棉100', '/upload/2018-03-06/5a9e63ce8f70e.jpg', 100, 100, NULL, NULL, '', '', 1520329678, 10000.00);
INSERT INTO `pub_filters` VALUES (16, 'PO膜', 'PO膜400', '/upload/2018-03-06/5a9e63fd042bc.jpg', 400, 400, NULL, NULL, '', '', 1520329725, 20000.00);
INSERT INTO `pub_filters` VALUES (17, 'T33', '后置滤芯', '/upload/2018-03-06/5a9e66683d8f0.jpg', 200, 200, NULL, NULL, '', '', 1520330344, 3000.00);

-- ----------------------------
-- Table structure for pub_flow
-- ----------------------------
DROP TABLE IF EXISTS `pub_flow`;
CREATE TABLE `pub_flow`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '充值流水ID',
  `did` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `money` decimal(25, 0) UNSIGNED NULL DEFAULT NULL COMMENT '充值金额',
  `mode` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '充值方式(0：系统赠送 1：微信 2：支付宝)',
  `flow` int(11) UNSIGNED NOT NULL COMMENT '流量',
  `num` int(11) UNSIGNED NOT NULL COMMENT '套餐数量',
  `describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '套餐描述',
  `currentflow` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '当前流量',
  `addtime` int(11) NOT NULL COMMENT '充值时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0禁 用1启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 189 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_flow
-- ----------------------------
INSERT INTO `pub_flow` VALUES (1, 1, '7721958114830821', 20000, 1, 500, 1, '200元500流量', 600, 1516357884, 0);
INSERT INTO `pub_flow` VALUES (2, 4, '5785534497296014', 10000, 1, 100, 3, '100元100流量', 400, 1516410988, 0);
INSERT INTO `pub_flow` VALUES (3, 4, '5039795438737244', 10000, 1, 100, 3, '100元100流量', 700, 1516414133, 0);
INSERT INTO `pub_flow` VALUES (4, 4, '2052114291507074', 10000, 1, 100, 1, '100元100流量', 800, 1516414749, 0);
INSERT INTO `pub_flow` VALUES (5, 11, '32842426129469711', 10000, 1, 100, 3, '100元100流量', 300, 1516419317, 0);
INSERT INTO `pub_flow` VALUES (6, 7, '3854699010485387', 60000, 1, 1800, 3, '600元1800流量', 5400, 1516420375, 0);
INSERT INTO `pub_flow` VALUES (7, 11, '90803629288238311', 10000, 1, 100, 4, '100元100流量', 400, 1516428606, 0);
INSERT INTO `pub_flow` VALUES (8, 6, '4800128800609856', 50000, 1, 1500, 1, '500元1500流量', 1499, 1516434076, 0);
INSERT INTO `pub_flow` VALUES (9, 1, '5500799409802691', 20000, 1, 500, 1, '200元500流量', 1100, 1516447561, 0);
INSERT INTO `pub_flow` VALUES (10, 11, '15044885833456511', 10000, 1, 100, 4, '100元100流量', 800, 1516583822, 0);
INSERT INTO `pub_flow` VALUES (11, 11, '19105981537192611', 10000, 1, 100, 4, '100元100流量', 1200, 1516590325, 0);
INSERT INTO `pub_flow` VALUES (12, 13, '83712485265568113', 60000, 1, 1800, 1, '600元1800流量', 1800, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (13, 13, '83712485265568113', 50000, 1, 1500, 1, '500元1500流量', 3300, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (14, 13, '83712485265568113', 40000, 1, 1000, 2, '400元1000流量', 5300, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (15, 13, '83712485265568113', 10000, 1, 100, 1, '100元100时长', 5400, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (16, 13, '83712485265568113', 20000, 1, 200, 1, '200元200时长', 5600, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (17, 13, '83712485265568113', 30000, 1, 300, 1, '300元300时长', 5900, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (18, 13, '83712485265568113', 40000, 1, 400, 1, '400元400时长', 6300, 1516675387, 0);
INSERT INTO `pub_flow` VALUES (19, 13, '12301728623964613', 60000, 1, 1800, 1, '600元1800流量', 8100, 1516675451, 0);
INSERT INTO `pub_flow` VALUES (20, 13, '12301728623964613', 50000, 1, 1500, 1, '500元1500流量', 9600, 1516675451, 0);
INSERT INTO `pub_flow` VALUES (21, 13, '12301728623964613', 40000, 1, 1000, 1, '400元1000流量', 10600, 1516675451, 0);
INSERT INTO `pub_flow` VALUES (22, 13, '79949107063978713', 10000, 1, 100, 1, '100元100时长', 10700, 1516675619, 0);
INSERT INTO `pub_flow` VALUES (23, 13, '79949107063978713', 60000, 1, 1800, 1, '600元1800流量', 12500, 1516675619, 0);
INSERT INTO `pub_flow` VALUES (24, 13, '79949107063978713', 50000, 1, 1500, 1, '500元1500流量', 14000, 1516675619, 0);
INSERT INTO `pub_flow` VALUES (25, 13, '79949107063978713', 40000, 1, 1000, 1, '400元1000流量', 15000, 1516675619, 0);
INSERT INTO `pub_flow` VALUES (26, 13, '52097518163316313', 40000, 1, 400, 1, '400元400时长', 15400, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (27, 13, '52097518163316313', 30000, 1, 300, 1, '300元300时长', 15700, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (28, 13, '52097518163316313', 20000, 1, 200, 1, '200元200时长', 15900, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (29, 13, '52097518163316313', 10000, 1, 100, 1, '100元100时长', 16000, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (30, 13, '52097518163316313', 50000, 1, 1500, 1, '500元1500流量', 17500, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (31, 13, '52097518163316313', 60000, 1, 1800, 1, '600元1800流量', 19300, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (32, 13, '52097518163316313', 40000, 1, 1000, 1, '400元1000流量', 20300, 1516712005, 0);
INSERT INTO `pub_flow` VALUES (33, 13, '96071098499537613', 40000, 1, 400, 1, '400元400时长', 20700, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (34, 13, '96071098499537613', 30000, 1, 300, 1, '300元300时长', 21000, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (35, 13, '96071098499537613', 20000, 1, 200, 1, '200元200时长', 21200, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (36, 13, '96071098499537613', 10000, 1, 100, 1, '100元100时长', 21300, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (37, 13, '96071098499537613', 60000, 1, 1800, 1, '600元1800流量', 23100, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (38, 13, '96071098499537613', 50000, 1, 1500, 1, '500元1500流量', 24600, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (39, 13, '96071098499537613', 40000, 1, 1000, 1, '400元1000流量', 25600, 1516715881, 0);
INSERT INTO `pub_flow` VALUES (40, 4, '6003016779622624', 30000, 1, 800, 1, '300元800流量', 1600, 1516717862, 0);
INSERT INTO `pub_flow` VALUES (41, 4, '6003016779622624', 20000, 1, 500, 1, '200元500流量', 2100, 1516717862, 0);
INSERT INTO `pub_flow` VALUES (42, 4, '6003016779622624', 10000, 1, 100, 1, '100元100流量', 2200, 1516717862, 0);
INSERT INTO `pub_flow` VALUES (43, 6, '4751610201425666', 10000, 1, 100, 2, '100元100流量', 199, 1516761932, 0);
INSERT INTO `pub_flow` VALUES (44, 6, '4751610201425666', 30000, 1, 800, 2, '300元800流量', 1799, 1516761932, 0);
INSERT INTO `pub_flow` VALUES (45, 6, '4751610201425666', 20000, 1, 500, 1, '200元500流量', 2299, 1516761932, 0);
INSERT INTO `pub_flow` VALUES (46, 17, '26500557989931317', 10000, 1, 100, 1, '100元100流量', 100, 1516765615, 0);
INSERT INTO `pub_flow` VALUES (47, 17, '26500557989931317', 20000, 1, 200, 1, '200元200流量', 300, 1516765615, 0);
INSERT INTO `pub_flow` VALUES (48, 10, '67164063539198010', 10000, 1, 100, 1, '100元100时长', 30100, 1516788687, 0);
INSERT INTO `pub_flow` VALUES (49, 10, '67164063539198010', 60000, 1, 1800, 1, '600元1800流量', 31900, 1516788687, 0);
INSERT INTO `pub_flow` VALUES (50, 10, '67164063539198010', 30000, 1, 300, 1, '300元300时长', 32200, 1516788687, 0);
INSERT INTO `pub_flow` VALUES (51, 10, '67164063539198010', 20000, 1, 200, 1, '200元200时长', 32400, 1516788687, 0);
INSERT INTO `pub_flow` VALUES (52, 10, '67164063539198010', 50000, 1, 1500, 1, '500元1500流量', 33900, 1516788687, 0);
INSERT INTO `pub_flow` VALUES (53, 10, '67164063539198010', 40000, 1, 1000, 1, '400元1000流量', 34900, 1516788687, 0);
INSERT INTO `pub_flow` VALUES (54, 10, '33463306977389710', 50000, 1, 1500, 1, '500元1500流量', 36400, 1516788752, 0);
INSERT INTO `pub_flow` VALUES (55, 10, '33463306977389710', 40000, 1, 1000, 1, '400元1000流量', 37400, 1516788752, 0);
INSERT INTO `pub_flow` VALUES (56, 6, '3922086643247226', 10000, 1, 100, 1, '100元100流量', 99, 1516799935, 0);
INSERT INTO `pub_flow` VALUES (57, 10, '38561441548764810', 50000, 1, 1500, 1, '500元1500流量', 38900, 1516843086, 0);
INSERT INTO `pub_flow` VALUES (58, 5, '3491586748960265', 30000, 1, 800, 1, '300元800流量', 800, 1516851565, 0);
INSERT INTO `pub_flow` VALUES (59, 19, '76244489229539619', 10000, 1, 100, 1, '100元100天', 2100, 1516867278, 0);
INSERT INTO `pub_flow` VALUES (60, 19, '76244489229539619', 10000, 1, 100, 1, '100元100天', 2200, 1516867278, 0);
INSERT INTO `pub_flow` VALUES (61, 5, '7986637225630125', 66666600, 1, 111, 1, '666666元111天', 911, 1516868678, 0);
INSERT INTO `pub_flow` VALUES (62, 19, '40675688652214519', 10000, 1, 100, 1, '100元100天', 2100, 1516928893, 0);
INSERT INTO `pub_flow` VALUES (63, 21, '31922547313911121', 10000, 1, 100, 1, '100元100流量', 2100, 1516930989, 1);
INSERT INTO `pub_flow` VALUES (64, 21, '31070754808641721', 10000, 1, 100, 1, '100元100流量', 2100, 1516931114, 1);
INSERT INTO `pub_flow` VALUES (65, 6, '1668844794307971', 20000, 1, 500, 1, '200元500流量', 499, 1516936960, 1);
INSERT INTO `pub_flow` VALUES (66, 6, '3262260725735166', 10000, 1, 100, 1, '100元100流量', 99, 1516937058, 1);
INSERT INTO `pub_flow` VALUES (67, 19, '11837143329906219', 10000, 1, 100, 1, '100元100天', 2100, 1516945407, 0);
INSERT INTO `pub_flow` VALUES (68, 19, '11837143329906219', 10000, 1, 100, 1, '100元100天', 2200, 1516945407, 0);
INSERT INTO `pub_flow` VALUES (69, 19, '11837143329906219', 10000, 1, 100, 1, '100元100流量', 2300, 1516945407, 0);
INSERT INTO `pub_flow` VALUES (70, 19, '14416669014972719', 10000, 1, 100, 1, '100元100天', 2100, 1516947142, 0);
INSERT INTO `pub_flow` VALUES (71, 19, '18395139484434919', 10000, 1, 100, 1, '100元100天', 2100, 1516959964, 0);
INSERT INTO `pub_flow` VALUES (72, 19, '41068069763721919', 10000, 1, 100, 1, '100元100天', 2200, 1517015434, 0);
INSERT INTO `pub_flow` VALUES (73, 19, '41068069763721919', 10000, 1, 100, 1, '100元100天', 2300, 1517015434, 0);
INSERT INTO `pub_flow` VALUES (74, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517037543, 0);
INSERT INTO `pub_flow` VALUES (75, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517037543, 0);
INSERT INTO `pub_flow` VALUES (76, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517037556, 0);
INSERT INTO `pub_flow` VALUES (77, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517037556, 0);
INSERT INTO `pub_flow` VALUES (78, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517037572, 0);
INSERT INTO `pub_flow` VALUES (79, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517037572, 0);
INSERT INTO `pub_flow` VALUES (80, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517037606, 0);
INSERT INTO `pub_flow` VALUES (81, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517037606, 0);
INSERT INTO `pub_flow` VALUES (82, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517037789, 0);
INSERT INTO `pub_flow` VALUES (83, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517037789, 0);
INSERT INTO `pub_flow` VALUES (84, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517039590, 0);
INSERT INTO `pub_flow` VALUES (85, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517039590, 0);
INSERT INTO `pub_flow` VALUES (86, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517041393, 0);
INSERT INTO `pub_flow` VALUES (87, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517041393, 0);
INSERT INTO `pub_flow` VALUES (88, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517043194, 0);
INSERT INTO `pub_flow` VALUES (89, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517043194, 0);
INSERT INTO `pub_flow` VALUES (90, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517044996, 0);
INSERT INTO `pub_flow` VALUES (91, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517044996, 0);
INSERT INTO `pub_flow` VALUES (92, 24, '13920657797231924', 20000, 1, 500, 12, '200元500流量', 6000, 1517048600, 0);
INSERT INTO `pub_flow` VALUES (93, 24, '13920657797231924', 30000, 1, 800, 4, '300元800流量', 3200, 1517048600, 0);
INSERT INTO `pub_flow` VALUES (94, 19, '80214631224826419', 10000, 1, 100, 1, '100元100天', 2100, 1517105017, 0);
INSERT INTO `pub_flow` VALUES (95, 19, '80214631224826419', 10000, 1, 100, 1, '100元100流量', 2200, 1517105017, 0);
INSERT INTO `pub_flow` VALUES (96, 19, '80214631224826419', 10000, 1, 100, 1, '100元100天', 2300, 1517105017, 0);
INSERT INTO `pub_flow` VALUES (97, 24, '19390927504116024', 10000, 1, 100, 1, '100元100流量', 2100, 1517107669, 0);
INSERT INTO `pub_flow` VALUES (98, 24, '22820401685490924', 40000, 1, 200, 1, '400元200天', 2300, 1517107900, 0);
INSERT INTO `pub_flow` VALUES (99, 24, '20171666803384024', 40000, 1, 200, 6, '400元200天', 3500, 1517112386, 0);
INSERT INTO `pub_flow` VALUES (100, 24, '97209391163630224', 10000, 1, 100, 1, '100元100流量', 3600, 1517112478, 0);
INSERT INTO `pub_flow` VALUES (101, 24, '19276417629448424', 40000, 1, 200, 1, '400元200天', 3800, 1517125391, 0);
INSERT INTO `pub_flow` VALUES (102, 19, '47898888426073719', 10000, 1, 100, 1, '100元100天', 2400, 1517126674, 0);
INSERT INTO `pub_flow` VALUES (103, 19, '47898888426073719', 10000, 1, 100, 1, '100元100天', 2500, 1517126674, 0);
INSERT INTO `pub_flow` VALUES (104, 19, '47898888426073719', 10000, 1, 100, 1, '100元100流量', 2600, 1517126674, 0);
INSERT INTO `pub_flow` VALUES (105, 24, '59860902116277824', 40000, 1, 200, 1, '400元200天', 4000, 1517127724, 0);
INSERT INTO `pub_flow` VALUES (106, 24, '52513040432865924', 40000, 1, 200, 1, '400元200天', 4200, 1517127765, 0);
INSERT INTO `pub_flow` VALUES (107, 24, '19814401329493624', 40000, 1, 200, 1, '400元200天', 4400, 1517128879, 0);
INSERT INTO `pub_flow` VALUES (108, 24, '78670905945578424', 40000, 1, 200, 6, '400元200天', NULL, 1517129903, 0);
INSERT INTO `pub_flow` VALUES (109, 24, '78670905945578424', 40000, 1, 200, 6, '400元200天', NULL, 1517129918, 0);
INSERT INTO `pub_flow` VALUES (110, 24, '78670905945578424', 40000, 1, 200, 6, '400元200天', NULL, 1517129935, 0);
INSERT INTO `pub_flow` VALUES (111, 24, '78670905945578424', 40000, 1, 200, 6, '400元200天', NULL, 1517129968, 0);
INSERT INTO `pub_flow` VALUES (112, 24, '41878675992435424', 30000, 1, 800, 1, '300元800流量', 5200, 1517129975, 0);
INSERT INTO `pub_flow` VALUES (113, 24, '78670905945578424', 40000, 1, 200, 6, '400元200天', NULL, 1517130150, 0);
INSERT INTO `pub_flow` VALUES (114, 24, '60669606557271824', 40000, 1, 200, 1, '400元200天', 5400, 1517131781, 0);
INSERT INTO `pub_flow` VALUES (115, 24, '78670905945578424', 40000, 1, 200, 6, '400元200天', 6600, 1517131872, 0);
INSERT INTO `pub_flow` VALUES (116, 24, '37022871811251424', 10000, 1, 100, 1, '100元100流量', NULL, 1517131929, 0);
INSERT INTO `pub_flow` VALUES (117, 24, '37022871811251424', 10000, 1, 100, 1, '100元100流量', NULL, 1517131941, 0);
INSERT INTO `pub_flow` VALUES (118, 24, '37022871811251424', 10000, 1, 100, 1, '100元100流量', NULL, 1517131958, 0);
INSERT INTO `pub_flow` VALUES (119, 24, '47005720103170824', 40000, 1, 200, 1, '400元200天', 6800, 1517131960, 0);
INSERT INTO `pub_flow` VALUES (120, 24, '37022871811251424', 10000, 1, 100, 1, '100元100流量', NULL, 1517131991, 0);
INSERT INTO `pub_flow` VALUES (121, 24, '83288550742056324', 30000, 1, 800, 1, '300元800流量', NULL, 1517131993, 0);
INSERT INTO `pub_flow` VALUES (122, 24, '83288550742056324', 40000, 1, 200, 1, '400元200天', 7000, 1517131993, 0);
INSERT INTO `pub_flow` VALUES (123, 24, '83288550742056324', 30000, 1, 800, 1, '300元800流量', NULL, 1517132006, 0);
INSERT INTO `pub_flow` VALUES (124, 24, '83288550742056324', 40000, 1, 200, 1, '400元200天', 7000, 1517132006, 0);
INSERT INTO `pub_flow` VALUES (125, 24, '83288550742056324', 30000, 1, 800, 1, '300元800流量', NULL, 1517132022, 0);
INSERT INTO `pub_flow` VALUES (126, 24, '83288550742056324', 40000, 1, 200, 1, '400元200天', 7000, 1517132022, 0);
INSERT INTO `pub_flow` VALUES (127, 24, '83288550742056324', 30000, 1, 800, 1, '300元800流量', NULL, 1517132056, 0);
INSERT INTO `pub_flow` VALUES (128, 24, '83288550742056324', 40000, 1, 200, 1, '400元200天', 7000, 1517132056, 0);
INSERT INTO `pub_flow` VALUES (129, 24, '37022871811251424', 10000, 1, 100, 1, '100元100流量', NULL, 1517132172, 0);
INSERT INTO `pub_flow` VALUES (130, 24, '83288550742056324', 30000, 1, 800, 1, '300元800流量', NULL, 1517132237, 0);
INSERT INTO `pub_flow` VALUES (131, 24, '83288550742056324', 40000, 1, 200, 1, '400元200天', 7000, 1517132237, 0);
INSERT INTO `pub_flow` VALUES (132, 24, '59220889491222724', 40000, 1, 200, 1, '400元200天', 7000, 1517132763, 0);
INSERT INTO `pub_flow` VALUES (133, 24, '24267619063161424', 30000, 1, 800, 1, '300元800流量', NULL, 1517132832, 0);
INSERT INTO `pub_flow` VALUES (134, 24, '43377643033889224', 40000, 1, 200, 1, '400元200天', 7200, 1517132878, 0);
INSERT INTO `pub_flow` VALUES (135, 24, '56615633184161524', 40000, 1, 200, 4, '400元200天', NULL, 1517132980, 0);
INSERT INTO `pub_flow` VALUES (136, 24, '81365075219351024', 40000, 1, 200, 1, '400元200天', NULL, 1517133024, 0);
INSERT INTO `pub_flow` VALUES (137, 24, '97077949885939924', 40000, 1, 200, 1, '400元200天', NULL, 1517133057, 0);
INSERT INTO `pub_flow` VALUES (138, 24, '97077949885939924', 40000, 1, 200, 1, '400元200天', NULL, 1517133069, 0);
INSERT INTO `pub_flow` VALUES (139, 24, '97077949885939924', 40000, 1, 200, 1, '400元200天', NULL, 1517133085, 0);
INSERT INTO `pub_flow` VALUES (140, 24, '97077949885939924', 40000, 1, 200, 1, '400元200天', NULL, 1517133116, 0);
INSERT INTO `pub_flow` VALUES (141, 24, '97077949885939924', 40000, 1, 200, 1, '400元200天', NULL, 1517133297, 0);
INSERT INTO `pub_flow` VALUES (142, 24, '37022871811251424', 10000, 1, 100, 1, '100元100流量', 7300, 1517133975, 0);
INSERT INTO `pub_flow` VALUES (143, 24, '83288550742056324', 30000, 1, 800, 1, '300元800流量', 8100, 1517134039, 0);
INSERT INTO `pub_flow` VALUES (144, 24, '83288550742056324', 40000, 1, 200, 1, '400元200天', 8100, 1517134039, 0);
INSERT INTO `pub_flow` VALUES (145, 24, '91496834981435424', 40000, 1, 200, 1, '400元200天', NULL, 1517135012, 0);
INSERT INTO `pub_flow` VALUES (146, 24, '45399382543875624', 40000, 1, 200, 3, '400元200天', NULL, 1517135044, 0);
INSERT INTO `pub_flow` VALUES (147, 24, '31873939513103624', 40000, 1, 200, 1, '400元200天', NULL, 1517135079, 0);
INSERT INTO `pub_flow` VALUES (148, 24, '31873939513103624', 20000, 1, 500, 2, '200元500流量', 9100, 1517135079, 0);
INSERT INTO `pub_flow` VALUES (149, 24, '97077949885939924', 40000, 1, 200, 1, '400元200天', NULL, 1517135100, 0);
INSERT INTO `pub_flow` VALUES (150, 24, '56887492995336524', 40000, 1, 200, 2, '400元200天', NULL, 1517135127, 0);
INSERT INTO `pub_flow` VALUES (151, 24, '56887492995336524', 30000, 1, 800, 1, '300元800流量', 9900, 1517135128, 0);
INSERT INTO `pub_flow` VALUES (152, 24, '99230895102894324', 40000, 1, 200, 2, '400元200天', NULL, 1517135175, 0);
INSERT INTO `pub_flow` VALUES (153, 24, '28254729266198524', 30000, 1, 800, 1, '300元800流量', 10700, 1517135217, 0);
INSERT INTO `pub_flow` VALUES (154, 24, '28254729266198524', 10000, 1, 100, 2, '100元100流量', 10900, 1517135217, 0);
INSERT INTO `pub_flow` VALUES (155, 24, '28254729266198524', 40000, 1, 200, 5, '400元200天', 10900, 1517135217, 0);
INSERT INTO `pub_flow` VALUES (156, 19, '91490418964416419', 10000, 1, 100, 2, '100元100天', NULL, 1517188863, 0);
INSERT INTO `pub_flow` VALUES (157, 19, '46757216173492019', 10000, 1, 100, 1, '100元100天', NULL, 1517188937, 0);
INSERT INTO `pub_flow` VALUES (158, 19, '46757216173492019', 10000, 1, 100, 1, '100元100流量', 2700, 1517188937, 0);
INSERT INTO `pub_flow` VALUES (159, 19, '87136705178230719', 10000, 1, 100, 1, '100元100流量', 2800, 1517215370, 0);
INSERT INTO `pub_flow` VALUES (160, 19, '87136705178230719', 10000, 1, 100, 1, '100元100天', 2900, 1517215370, 0);
INSERT INTO `pub_flow` VALUES (161, 24, '69028445087467624', 40000, 1, 200, 1, '400元200天', 11100, 1517216902, 0);
INSERT INTO `pub_flow` VALUES (162, 11, '91501018908607911', 10000, 1, 10, 1, '100元10天', 1210, 1517366727, 1);
INSERT INTO `pub_flow` VALUES (163, 9, '3806529769772209', 40000, 1, 200, 1, '400元200天', 199, 1517377769, 0);
INSERT INTO `pub_flow` VALUES (164, 9, '3806529769772209', 10000, 1, 10, 1, '100元10天', 209, 1517377769, 0);
INSERT INTO `pub_flow` VALUES (165, 9, '3806529769772209', 10000, 1, 10, 1, '100元10天', 219, 1517377769, 0);
INSERT INTO `pub_flow` VALUES (166, 9, '3806529769772209', 50000, 1, 50, 1, '500元50天', 269, 1517377769, 0);
INSERT INTO `pub_flow` VALUES (167, 23, '34456334012786023', 40000, 1, 200, 1, '400元200天', 200, 1517378692, 0);
INSERT INTO `pub_flow` VALUES (168, 23, '34456334012786023', 10000, 1, 10, 1, '100元10天', 210, 1517378692, 0);
INSERT INTO `pub_flow` VALUES (169, 23, '34456334012786023', 10000, 1, 10, 1, '100元10天', 220, 1517378692, 0);
INSERT INTO `pub_flow` VALUES (170, 23, '34456334012786023', 15000, 1, 15, 1, '150元15天', 235, 1517378692, 0);
INSERT INTO `pub_flow` VALUES (171, 23, '34456334012786023', 50000, 1, 50, 1, '500元50天', 285, 1517378692, 0);
INSERT INTO `pub_flow` VALUES (172, 3, '7282342372730583', 10000, 1, 10, 1, '100元10天', 9, 1517452832, 0);
INSERT INTO `pub_flow` VALUES (173, 3, '7282342372730583', 10000, 1, 10, 1, '100元10天', 19, 1517452832, 0);
INSERT INTO `pub_flow` VALUES (174, 3, '7282342372730583', 15000, 1, 15, 1, '150元15天', 34, 1517452832, 0);
INSERT INTO `pub_flow` VALUES (175, 6, '2057042415282246', 10000, 1, 10, 1, '100元10天', 9, 1517471555, 1);
INSERT INTO `pub_flow` VALUES (176, 3, '2058987054456373', 50000, 1, 50, 1, '500元50天', 84, 1517550922, 0);
INSERT INTO `pub_flow` VALUES (177, 3, '2058987054456373', 40000, 1, 200, 1, '400元200天', 284, 1517550922, 0);
INSERT INTO `pub_flow` VALUES (178, 3, '2058987054456373', 10000, 1, 10, 1, '100元10天', 294, 1517550922, 0);
INSERT INTO `pub_flow` VALUES (179, 3, '2058987054456373', 10000, 1, 10, 1, '100元10天', 304, 1517550922, 0);
INSERT INTO `pub_flow` VALUES (180, 3, '2058987054456373', 15000, 1, 15, 1, '150元15天', 319, 1517550922, 0);
INSERT INTO `pub_flow` VALUES (181, 3, '8070335309807653', 40000, 1, 200, 1, '400元200天', 519, 1520316881, 0);
INSERT INTO `pub_flow` VALUES (182, 3, '8070335309807653', 50000, 1, 50, 1, '500元50天', 569, 1520316881, 0);
INSERT INTO `pub_flow` VALUES (183, 3, '8070335309807653', 10000, 1, 10, 2, '100元10天', 589, 1520316881, 0);
INSERT INTO `pub_flow` VALUES (184, 3, '8070335309807653', 15000, 1, 15, 1, '150元15天', 604, 1520316881, 0);
INSERT INTO `pub_flow` VALUES (185, 45, '28577983622513745', 15000, 1, 15, 1, '150元15天', 2015, 1520321053, 1);
INSERT INTO `pub_flow` VALUES (186, 46, '95837900918196446', 1, 1, 100, 1, '100元100天', 99, 1520331709, 0);
INSERT INTO `pub_flow` VALUES (187, 46, '64006737244896346', 1, 1, 100, 1, '100元100天', 99, 1520502790, 0);
INSERT INTO `pub_flow` VALUES (188, 46, '58849300074543146', 1, 1, 100, 1, '100元100天', 99, 1520504195, 0);

-- ----------------------------
-- Table structure for pub_hire
-- ----------------------------
DROP TABLE IF EXISTS `pub_hire`;
CREATE TABLE `pub_hire`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `hire_id` int(11) UNSIGNED NOT NULL COMMENT '租赁编号',
  `vendors_id` int(11) UNSIGNED NOT NULL COMMENT '关联的供销商ID号',
  `device_id` int(11) UNSIGNED NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的用户ID号',
  `charg_id` int(11) UNSIGNED NOT NULL DEFAULT 1 COMMENT '关联的计费ID号',
  `begin_time` int(11) NOT NULL COMMENT '租赁开始时间',
  `end_time` int(11) NOT NULL COMMENT '租赁结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hire_id`(`hire_id`, `device_id`, `user_id`, `vendors_id`, `charg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pub_leaevl
-- ----------------------------
DROP TABLE IF EXISTS `pub_leaevl`;
CREATE TABLE `pub_leaevl`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `vendors_id` int(11) UNSIGNED NOT NULL COMMENT '关联的供销商ID号',
  `parent_vid` int(11) UNSIGNED NOT NULL COMMENT '供销商的父级ID',
  `path` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供销商的层级关系',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pub_loglist
-- ----------------------------
DROP TABLE IF EXISTS `pub_loglist`;
CREATE TABLE `pub_loglist`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的登陆ID号',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作内容',
  `time` int(11) NOT NULL COMMENT '操作时间',
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作IP',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pub_order_filter
-- ----------------------------
DROP TABLE IF EXISTS `pub_order_filter`;
CREATE TABLE `pub_order_filter`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `filter_id` int(11) UNSIGNED NOT NULL,
  `filtername` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '滤芯名称',
  `alias` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '暂无别名' COMMENT '滤芯别名',
  `picpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '滤芯图片',
  `timelife` int(11) UNSIGNED NOT NULL COMMENT '时间寿命（小时）',
  `flowlife` int(11) UNSIGNED NOT NULL COMMENT '流量寿命（升）',
  `balancatime` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '时间寿命使能',
  `balancaflow` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '流量寿命使能',
  `introduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '暂无简介' COMMENT '滤芯简介',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '滤芯购买网址',
  `price` decimal(15, 2) NOT NULL,
  `goods_num` int(11) UNSIGNED NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15, 2) UNSIGNED NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) NOT NULL COMMENT '订单创建时间',
  `updated_at` int(11) NULL DEFAULT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 175 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------
INSERT INTO `pub_order_filter` VALUES (1, '6225562025606521', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516358192, NULL);
INSERT INTO `pub_order_filter` VALUES (2, '6225562025606521', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516358192, NULL);
INSERT INTO `pub_order_filter` VALUES (3, '6225562025606521', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516358192, NULL);
INSERT INTO `pub_order_filter` VALUES (4, '7366574936397834', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516361061, NULL);
INSERT INTO `pub_order_filter` VALUES (5, '7366574936397834', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516361061, NULL);
INSERT INTO `pub_order_filter` VALUES (6, '7366574936397834', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516361061, NULL);
INSERT INTO `pub_order_filter` VALUES (7, '5785534497296014', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516410981, NULL);
INSERT INTO `pub_order_filter` VALUES (8, '5785534497296014', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516410981, NULL);
INSERT INTO `pub_order_filter` VALUES (9, '5785534497296014', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 2, 60000.00, 1516410981, NULL);
INSERT INTO `pub_order_filter` VALUES (10, '9364319663900581', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516418831, NULL);
INSERT INTO `pub_order_filter` VALUES (11, '9364319663900581', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516418831, NULL);
INSERT INTO `pub_order_filter` VALUES (12, '16199850951714511', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516419258, NULL);
INSERT INTO `pub_order_filter` VALUES (13, '16199850951714511', 8, '滤芯D', '滤芯D型', '/upload/2018-01-20/5a62b456e49f1.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 2, 10000.00, 1516419258, NULL);
INSERT INTO `pub_order_filter` VALUES (14, '16199850951714511', 9, '滤芯E', '滤芯E型', '/upload/2018-01-20/5a62b484d8bd5.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516419258, NULL);
INSERT INTO `pub_order_filter` VALUES (15, '16199850951714511', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516419258, NULL);
INSERT INTO `pub_order_filter` VALUES (16, '16199850951714511', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516419258, NULL);
INSERT INTO `pub_order_filter` VALUES (17, '32842426129469711', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516419305, NULL);
INSERT INTO `pub_order_filter` VALUES (18, '32842426129469711', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516419305, NULL);
INSERT INTO `pub_order_filter` VALUES (19, '32842426129469711', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516419305, NULL);
INSERT INTO `pub_order_filter` VALUES (20, '32842426129469711', 8, '滤芯D', '滤芯D型', '/upload/2018-01-20/5a62b456e49f1.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516419305, NULL);
INSERT INTO `pub_order_filter` VALUES (21, '32842426129469711', 9, '滤芯E', '滤芯E型', '/upload/2018-01-20/5a62b484d8bd5.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516419305, NULL);
INSERT INTO `pub_order_filter` VALUES (22, '3854699010485387', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516420362, NULL);
INSERT INTO `pub_order_filter` VALUES (23, '3854699010485387', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516420362, NULL);
INSERT INTO `pub_order_filter` VALUES (24, '3854699010485387', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516420362, NULL);
INSERT INTO `pub_order_filter` VALUES (25, '8661851704292464', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 2, 20000.00, 1516427302, NULL);
INSERT INTO `pub_order_filter` VALUES (26, '8661851704292464', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 3, 60000.00, 1516427302, NULL);
INSERT INTO `pub_order_filter` VALUES (27, '8661851704292464', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 2, 60000.00, 1516427302, NULL);
INSERT INTO `pub_order_filter` VALUES (28, '90803629288238311', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 3, 6000.00, 1516428600, NULL);
INSERT INTO `pub_order_filter` VALUES (29, '90803629288238311', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 3, 9000.00, 1516428600, NULL);
INSERT INTO `pub_order_filter` VALUES (30, '90803629288238311', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 2, 8000.00, 1516428600, NULL);
INSERT INTO `pub_order_filter` VALUES (31, '9733271524754546', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516435580, NULL);
INSERT INTO `pub_order_filter` VALUES (32, '6754715405311196', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516436449, NULL);
INSERT INTO `pub_order_filter` VALUES (33, '6754715405311196', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516436449, NULL);
INSERT INTO `pub_order_filter` VALUES (34, '15044885833456511', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516583815, NULL);
INSERT INTO `pub_order_filter` VALUES (35, '15044885833456511', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516583815, NULL);
INSERT INTO `pub_order_filter` VALUES (36, '15044885833456511', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516583815, NULL);
INSERT INTO `pub_order_filter` VALUES (37, '15044885833456511', 8, '滤芯D', '滤芯D型', '/upload/2018-01-20/5a62b456e49f1.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516583815, NULL);
INSERT INTO `pub_order_filter` VALUES (38, '15044885833456511', 9, '滤芯E', '滤芯E型', '/upload/2018-01-20/5a62b484d8bd5.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516583815, NULL);
INSERT INTO `pub_order_filter` VALUES (39, '73547745493449411', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516600107, NULL);
INSERT INTO `pub_order_filter` VALUES (40, '73547745493449411', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516600107, NULL);
INSERT INTO `pub_order_filter` VALUES (41, '73547745493449411', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516600107, NULL);
INSERT INTO `pub_order_filter` VALUES (42, '45861679027378213', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 2, 4000.00, 1516602066, NULL);
INSERT INTO `pub_order_filter` VALUES (43, '83712485265568113', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 2, 4000.00, 1516675274, NULL);
INSERT INTO `pub_order_filter` VALUES (44, '83712485265568113', 9, '滤芯E', '滤芯E型', '/upload/2018-01-22/5a659167ecceb.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516675274, NULL);
INSERT INTO `pub_order_filter` VALUES (45, '83712485265568113', 8, '滤芯D', '滤芯D型', '/upload/2018-01-22/5a65a4ac83ec9.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516675274, NULL);
INSERT INTO `pub_order_filter` VALUES (46, '83712485265568113', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516675274, NULL);
INSERT INTO `pub_order_filter` VALUES (47, '83712485265568113', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516675274, NULL);
INSERT INTO `pub_order_filter` VALUES (48, '12301728623964613', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516675445, NULL);
INSERT INTO `pub_order_filter` VALUES (49, '12301728623964613', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516675445, NULL);
INSERT INTO `pub_order_filter` VALUES (50, '12301728623964613', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516675445, NULL);
INSERT INTO `pub_order_filter` VALUES (51, '12301728623964613', 8, '滤芯D', '滤芯D型', '/upload/2018-01-22/5a65a4ac83ec9.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516675445, NULL);
INSERT INTO `pub_order_filter` VALUES (52, '12301728623964613', 9, '滤芯E', '滤芯E型', '/upload/2018-01-22/5a659167ecceb.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516675445, NULL);
INSERT INTO `pub_order_filter` VALUES (53, '79949107063978713', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516675609, NULL);
INSERT INTO `pub_order_filter` VALUES (54, '79949107063978713', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516675609, NULL);
INSERT INTO `pub_order_filter` VALUES (55, '79949107063978713', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516675609, NULL);
INSERT INTO `pub_order_filter` VALUES (56, '79949107063978713', 8, '滤芯D', '滤芯D型', '/upload/2018-01-22/5a65a4ac83ec9.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516675609, NULL);
INSERT INTO `pub_order_filter` VALUES (57, '79949107063978713', 9, '滤芯E', '滤芯E型', '/upload/2018-01-22/5a659167ecceb.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516675609, NULL);
INSERT INTO `pub_order_filter` VALUES (58, '60639209713878713', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516675805, NULL);
INSERT INTO `pub_order_filter` VALUES (59, '60639209713878713', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516675805, NULL);
INSERT INTO `pub_order_filter` VALUES (60, '21048900071722313', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516676210, NULL);
INSERT INTO `pub_order_filter` VALUES (61, '21048900071722313', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516676210, NULL);
INSERT INTO `pub_order_filter` VALUES (62, '21048900071722313', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516676210, NULL);
INSERT INTO `pub_order_filter` VALUES (63, '32742759754985613', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 2, 6000.00, 1516676876, NULL);
INSERT INTO `pub_order_filter` VALUES (64, '32742759754985613', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516676876, NULL);
INSERT INTO `pub_order_filter` VALUES (65, '93235939321739013', 5, '滤芯A', '滤芯A型', '/upload/2018-01-20/5a62b3cb4c25e.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 4, 8000.00, 1516677021, NULL);
INSERT INTO `pub_order_filter` VALUES (66, '58344646335821913', 5, '滤芯A', '滤芯A型', '/upload/2018-01-23/5a66d9a537f7c.jpg', 20, 20, NULL, NULL, '200元20小时20升', '', 2000.00, 1, 2000.00, 1516690149, NULL);
INSERT INTO `pub_order_filter` VALUES (67, '58344646335821913', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 4, 12000.00, 1516690149, NULL);
INSERT INTO `pub_order_filter` VALUES (68, '58344646335821913', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516690149, NULL);
INSERT INTO `pub_order_filter` VALUES (69, '58344646335821913', 8, '滤芯D', '滤芯D型', '/upload/2018-01-22/5a65a4ac83ec9.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516690149, NULL);
INSERT INTO `pub_order_filter` VALUES (70, '21265457366309013', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 2, 6000.00, 1516705568, NULL);
INSERT INTO `pub_order_filter` VALUES (71, '21265457366309013', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 2, 8000.00, 1516705568, NULL);
INSERT INTO `pub_order_filter` VALUES (72, '21265457366309013', 5, '滤芯A', '滤芯A型', '/upload/2018-01-23/5a66f61162679.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 2, 4000.00, 1516705568, NULL);
INSERT INTO `pub_order_filter` VALUES (73, '21265457366309013', 8, '滤芯D', '滤芯D型', '/upload/2018-01-22/5a65a4ac83ec9.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516705568, NULL);
INSERT INTO `pub_order_filter` VALUES (74, '52097518163316313', 7, '滤芯C', '滤芯C型', '/upload/2018-01-20/5a62b42898f38.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516711997, NULL);
INSERT INTO `pub_order_filter` VALUES (75, '52097518163316313', 8, '滤芯D', '滤芯D型', '/upload/2018-01-22/5a65a4ac83ec9.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516711997, NULL);
INSERT INTO `pub_order_filter` VALUES (76, '52097518163316313', 9, '滤芯E', '滤芯E型', '/upload/2018-01-22/5a659167ecceb.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516711997, NULL);
INSERT INTO `pub_order_filter` VALUES (77, '52097518163316313', 5, '滤芯A', '滤芯A型', '/upload/2018-01-23/5a66f61162679.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516711997, NULL);
INSERT INTO `pub_order_filter` VALUES (78, '52097518163316313', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516711997, NULL);
INSERT INTO `pub_order_filter` VALUES (79, '36186252285132113', 5, '滤芯A', '滤芯A型', '/upload/2018-01-23/5a66f61162679.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516712860, NULL);
INSERT INTO `pub_order_filter` VALUES (80, '36186252285132113', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516712860, NULL);
INSERT INTO `pub_order_filter` VALUES (81, '36186252285132113', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516712860, NULL);
INSERT INTO `pub_order_filter` VALUES (82, '96071098499537613', 5, '滤芯A', '滤芯A型', '/upload/2018-01-23/5a66f61162679.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516715849, NULL);
INSERT INTO `pub_order_filter` VALUES (83, '96071098499537613', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516715849, NULL);
INSERT INTO `pub_order_filter` VALUES (84, '96071098499537613', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516715849, NULL);
INSERT INTO `pub_order_filter` VALUES (85, '96071098499537613', 8, '滤芯D', '滤芯D型', '/upload/2018-01-23/5a673d34b4cf1.jpg', 50, 50, NULL, NULL, '50元50小时50升', '', 5000.00, 1, 5000.00, 1516715849, NULL);
INSERT INTO `pub_order_filter` VALUES (86, '96071098499537613', 9, '滤芯E', '滤芯E型', '/upload/2018-01-23/5a67330a6d7ad.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1516715849, NULL);
INSERT INTO `pub_order_filter` VALUES (87, '6003016779622624', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516717856, NULL);
INSERT INTO `pub_order_filter` VALUES (88, '6003016779622624', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516717856, NULL);
INSERT INTO `pub_order_filter` VALUES (89, '6003016779622624', 4, 'PDF', 'PDFA型', '/upload/2018-01-19/5a61c07ab6631.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516717856, NULL);
INSERT INTO `pub_order_filter` VALUES (90, '82906478768879215', 5, '滤芯A', '滤芯A型', '/upload/2018-01-23/5a66f61162679.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516756754, NULL);
INSERT INTO `pub_order_filter` VALUES (91, '82906478768879215', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516756754, NULL);
INSERT INTO `pub_order_filter` VALUES (92, '82906478768879215', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516756754, NULL);
INSERT INTO `pub_order_filter` VALUES (93, '4751610201425666', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-19/5a61bfe274e17.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516761924, NULL);
INSERT INTO `pub_order_filter` VALUES (94, '4751610201425666', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516761924, NULL);
INSERT INTO `pub_order_filter` VALUES (95, '26500557989931317', 10, '滤芯F', '滤芯F型', '/upload/2018-01-24/5a67fa6a49fed.jpg', 23, 23, NULL, NULL, '', '', 2300.00, 1, 2300.00, 1516765529, NULL);
INSERT INTO `pub_order_filter` VALUES (96, '26500557989931317', 11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, '', '', 33000.00, 1, 33000.00, 1516765529, NULL);
INSERT INTO `pub_order_filter` VALUES (97, '71335108864336117', 10, '滤芯F', '滤芯F型', '/upload/2018-01-24/5a68018c8c224.jpg', 23, 23, NULL, NULL, '', '', 2300.00, 1, 2300.00, 1516772219, NULL);
INSERT INTO `pub_order_filter` VALUES (98, '71335108864336117', 11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, '', '', 33000.00, 1, 33000.00, 1516772219, NULL);
INSERT INTO `pub_order_filter` VALUES (99, '67164063539198010', 5, '滤芯A', '滤芯A型', '/upload/2018-01-24/5a67ff9c3b5c7.jpg', 20000, 20000, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516788679, NULL);
INSERT INTO `pub_order_filter` VALUES (100, '67164063539198010', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30000, 30000, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516788679, NULL);
INSERT INTO `pub_order_filter` VALUES (101, '67164063539198010', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40000, 40000, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516788679, NULL);
INSERT INTO `pub_order_filter` VALUES (102, '38561441548764810', 5, '滤芯A', '滤芯A型', '/upload/2018-01-24/5a67ff9c3b5c7.jpg', 20000, 20000, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516843080, NULL);
INSERT INTO `pub_order_filter` VALUES (103, '38561441548764810', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30000, 30000, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516843080, NULL);
INSERT INTO `pub_order_filter` VALUES (104, '38561441548764810', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40000, 40000, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516843080, NULL);
INSERT INTO `pub_order_filter` VALUES (105, '83432484001432810', 5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516849852, NULL);
INSERT INTO `pub_order_filter` VALUES (106, '83432484001432810', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1516849852, NULL);
INSERT INTO `pub_order_filter` VALUES (107, '83432484001432810', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1516849852, NULL);
INSERT INTO `pub_order_filter` VALUES (108, '8767345448578235', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 2, 40000.00, 1516851478, NULL);
INSERT INTO `pub_order_filter` VALUES (109, '8767345448578235', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 4, 120000.00, 1516851478, NULL);
INSERT INTO `pub_order_filter` VALUES (110, '8767345448578235', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516851478, NULL);
INSERT INTO `pub_order_filter` VALUES (111, '2239436101495765', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516852164, NULL);
INSERT INTO `pub_order_filter` VALUES (112, '2239436101495765', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 2, 40000.00, 1516852164, NULL);
INSERT INTO `pub_order_filter` VALUES (113, '2068561083459187', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516852889, NULL);
INSERT INTO `pub_order_filter` VALUES (114, '2068561083459187', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516852889, NULL);
INSERT INTO `pub_order_filter` VALUES (115, '2068561083459187', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516852889, NULL);
INSERT INTO `pub_order_filter` VALUES (116, '14959684428583621', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1516931052, NULL);
INSERT INTO `pub_order_filter` VALUES (117, '43747788661593521', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516931214, NULL);
INSERT INTO `pub_order_filter` VALUES (118, '8201665356475814', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1516934670, NULL);
INSERT INTO `pub_order_filter` VALUES (119, '8201665356475814', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 2, 20000.00, 1516934670, NULL);
INSERT INTO `pub_order_filter` VALUES (120, '17113082528772319', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516934692, NULL);
INSERT INTO `pub_order_filter` VALUES (121, '7627543438146556', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1516937113, NULL);
INSERT INTO `pub_order_filter` VALUES (122, '11837143329906219', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1516945402, NULL);
INSERT INTO `pub_order_filter` VALUES (123, '37758674381290624', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 2, 20000.00, 1516960891, NULL);
INSERT INTO `pub_order_filter` VALUES (124, '37758674381290624', 11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, '', '', 33000.00, 1, 33000.00, 1516960891, NULL);
INSERT INTO `pub_order_filter` VALUES (125, '41068069763721919', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1517015426, NULL);
INSERT INTO `pub_order_filter` VALUES (126, '52750416054237319', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1517015750, NULL);
INSERT INTO `pub_order_filter` VALUES (127, '80214631224826419', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 4, 8000.00, 1517105011, NULL);
INSERT INTO `pub_order_filter` VALUES (128, '20171666803384024', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 4, 40000.00, 1517112379, NULL);
INSERT INTO `pub_order_filter` VALUES (129, '97209391163630224', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 2, 20000.00, 1517112473, NULL);
INSERT INTO `pub_order_filter` VALUES (130, '63852760567674319', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1517126542, NULL);
INSERT INTO `pub_order_filter` VALUES (131, '47898888426073719', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1517126670, NULL);
INSERT INTO `pub_order_filter` VALUES (132, '91490418964416419', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 2, 4000.00, 1517188853, NULL);
INSERT INTO `pub_order_filter` VALUES (133, '90862280954716919', 13, '滤芯V', '滤芯V型', '/upload/2018-01-25/5a6951ed4f1da.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1517193456, NULL);
INSERT INTO `pub_order_filter` VALUES (134, '31473295304744224', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 3, 60000.00, 1517195465, NULL);
INSERT INTO `pub_order_filter` VALUES (135, '31473295304744224', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 10, 300000.00, 1517195465, NULL);
INSERT INTO `pub_order_filter` VALUES (136, '91501018908607911', 5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 3, 6000.00, 1517366721, NULL);
INSERT INTO `pub_order_filter` VALUES (137, '91501018908607911', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1517366721, NULL);
INSERT INTO `pub_order_filter` VALUES (138, '77786285224122111', 5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 3, 6000.00, 1517366932, NULL);
INSERT INTO `pub_order_filter` VALUES (139, '77786285224122111', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1517366932, NULL);
INSERT INTO `pub_order_filter` VALUES (140, '3806529769772209', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 2, 20000.00, 1517377763, NULL);
INSERT INTO `pub_order_filter` VALUES (141, '3806529769772209', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1517377763, NULL);
INSERT INTO `pub_order_filter` VALUES (142, '3806529769772209', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1517377763, NULL);
INSERT INTO `pub_order_filter` VALUES (143, '34456334012786023', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 2, 20000.00, 1517378687, NULL);
INSERT INTO `pub_order_filter` VALUES (144, '34456334012786023', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1517378687, NULL);
INSERT INTO `pub_order_filter` VALUES (145, '34456334012786023', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1517378687, NULL);
INSERT INTO `pub_order_filter` VALUES (146, '34456334012786023', 11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, '', '', 33000.00, 1, 33000.00, 1517378687, NULL);
INSERT INTO `pub_order_filter` VALUES (147, '7282342372730583', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 4, 40000.00, 1517452827, NULL);
INSERT INTO `pub_order_filter` VALUES (148, '7282342372730583', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 2, 60000.00, 1517452827, NULL);
INSERT INTO `pub_order_filter` VALUES (149, '7282342372730583', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 2, 40000.00, 1517452827, NULL);
INSERT INTO `pub_order_filter` VALUES (150, '7282342372730583', 11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, '', '', 33000.00, 1, 33000.00, 1517452827, NULL);
INSERT INTO `pub_order_filter` VALUES (151, '54992473537941611', 5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 2, 4000.00, 1517453141, NULL);
INSERT INTO `pub_order_filter` VALUES (152, '86410127669052711', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1517453206, NULL);
INSERT INTO `pub_order_filter` VALUES (153, '86410127669052711', 5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1517453206, NULL);
INSERT INTO `pub_order_filter` VALUES (154, '86410127669052711', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1517453206, NULL);
INSERT INTO `pub_order_filter` VALUES (155, '81088060922640611', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 6, 24000.00, 1517465789, NULL);
INSERT INTO `pub_order_filter` VALUES (156, '2058987054456373', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 4, 40000.00, 1517550902, NULL);
INSERT INTO `pub_order_filter` VALUES (157, '2058987054456373', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1517550902, NULL);
INSERT INTO `pub_order_filter` VALUES (158, '2058987054456373', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1517550902, NULL);
INSERT INTO `pub_order_filter` VALUES (159, '2058987054456373', 11, '滤芯H', '滤芯H型', '/upload/2018-01-24/5a680066e209b.jpg', 330, 330, NULL, NULL, '', '', 33000.00, 1, 33000.00, 1517550902, NULL);
INSERT INTO `pub_order_filter` VALUES (160, '1300447860790493', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1517550963, NULL);
INSERT INTO `pub_order_filter` VALUES (161, '1300447860790493', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1517550963, NULL);
INSERT INTO `pub_order_filter` VALUES (162, '38044801143637411', 7, '滤芯C', '滤芯C型', '/upload/2018-01-23/5a6731fe03c1f.jpg', 40, 40, NULL, NULL, '40元40小时40升', '', 4000.00, 1, 4000.00, 1518053901, NULL);
INSERT INTO `pub_order_filter` VALUES (163, '38044801143637411', 9, '滤芯E', '滤芯E型', '/upload/2018-01-23/5a67330a6d7ad.jpg', 60, 60, NULL, NULL, '60元60小时60升', '', 6000.00, 1, 6000.00, 1518053901, NULL);
INSERT INTO `pub_order_filter` VALUES (164, '38044801143637411', 6, '滤芯B', '滤芯B型', '/upload/2018-01-20/5a62b3fe30442.jpg', 30, 30, NULL, NULL, '30元30小时', '', 3000.00, 1, 3000.00, 1518053901, NULL);
INSERT INTO `pub_order_filter` VALUES (165, '38044801143637411', 5, '滤芯A', '滤芯A型', '/upload/2018-01-25/5a69458e3c523.jpg', 20, 20, NULL, NULL, '20元20小时20升', '', 2000.00, 1, 2000.00, 1518053901, NULL);
INSERT INTO `pub_order_filter` VALUES (166, '3132826905990653', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 3, 30000.00, 1519709485, NULL);
INSERT INTO `pub_order_filter` VALUES (167, '3132826905990653', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 2, 60000.00, 1519709485, NULL);
INSERT INTO `pub_order_filter` VALUES (168, '3132826905990653', 1, 'RO膜', 'R膜', '/upload/2018-01-19/5a61bf94c1d62.jpg', 500, 500, NULL, NULL, '500元500小时500升', '', 50000.00, 1, 50000.00, 1519709485, NULL);
INSERT INTO `pub_order_filter` VALUES (169, '9860983937820223', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1520316565, NULL);
INSERT INTO `pub_order_filter` VALUES (170, '9860983937820223', 1, 'RO膜', 'R膜', '/upload/2018-01-19/5a61bf94c1d62.jpg', 500, 500, NULL, NULL, '500元500小时500升', '', 50000.00, 1, 50000.00, 1520316565, NULL);
INSERT INTO `pub_order_filter` VALUES (171, '8070335309807653', 2, 'PP膜', 'PP棉A型', '/upload/2018-01-24/5a67ff06e4ff3.jpg', 100, 100, NULL, NULL, '100元100小时100升', '', 10000.00, 1, 10000.00, 1520316877, NULL);
INSERT INTO `pub_order_filter` VALUES (172, '8070335309807653', 1, 'RO膜', 'R膜', '/upload/2018-01-19/5a61bf94c1d62.jpg', 500, 500, NULL, NULL, '500元500小时500升', '', 50000.00, 1, 50000.00, 1520316877, NULL);
INSERT INTO `pub_order_filter` VALUES (173, '8070335309807653', 4, 'PDF', 'PDFA型', '/upload/2018-01-24/5a67f47daee9d.jpg', 300, 300, NULL, NULL, '300元300小时300升', '', 30000.00, 1, 30000.00, 1520316877, NULL);
INSERT INTO `pub_order_filter` VALUES (174, '8070335309807653', 3, 'RO膜', 'RO膜A型', '/upload/2018-01-19/5a61c0123d39a.jpg', 200, 200, NULL, NULL, '200元200小时200升', '', 20000.00, 1, 20000.00, 1520316877, NULL);

-- ----------------------------
-- Table structure for pub_order_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_order_setmeal`;
CREATE TABLE `pub_order_setmeal`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `setmeal_id` int(11) UNSIGNED NOT NULL,
  `type_id` int(11) NOT NULL COMMENT '产品类型ID',
  `remodel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '充值模式(0：流量1：时长)',
  `money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '套餐金额',
  `flow` int(11) NOT NULL COMMENT '套餐流量/时长',
  `describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '套餐描述',
  `goods_num` int(11) UNSIGNED NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15, 2) UNSIGNED NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`(11)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 201 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES (1, '8872329721698232', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1516356406, NULL);
INSERT INTO `pub_order_setmeal` VALUES (2, '7721958114830821', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516357875, NULL);
INSERT INTO `pub_order_setmeal` VALUES (3, '7366574936397834', 1, 1, 0, 10000.00, 100, '100元100流量', 3, 30000.00, 1516361061, NULL);
INSERT INTO `pub_order_setmeal` VALUES (4, '5785534497296014', 1, 1, 0, 10000.00, 100, '100元100流量', 3, 30000.00, 1516410981, NULL);
INSERT INTO `pub_order_setmeal` VALUES (5, '5066364933568976', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1516411031, NULL);
INSERT INTO `pub_order_setmeal` VALUES (6, '5039795438737244', 1, 1, 0, 10000.00, 100, '100元100流量', 3, 30000.00, 1516414127, NULL);
INSERT INTO `pub_order_setmeal` VALUES (7, '2052114291507074', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516414737, NULL);
INSERT INTO `pub_order_setmeal` VALUES (8, '13958457198822011', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516419199, NULL);
INSERT INTO `pub_order_setmeal` VALUES (9, '16199850951714511', 1, 1, 0, 10000.00, 100, '100元100流量', 3, 30000.00, 1516419258, NULL);
INSERT INTO `pub_order_setmeal` VALUES (10, '32842426129469711', 1, 1, 0, 10000.00, 100, '100元100流量', 3, 30000.00, 1516419305, NULL);
INSERT INTO `pub_order_setmeal` VALUES (11, '3854699010485387', 6, 2, 0, 60000.00, 1800, '600元1800流量', 3, 180000.00, 1516420362, NULL);
INSERT INTO `pub_order_setmeal` VALUES (12, '90803629288238311', 1, 1, 0, 10000.00, 100, '100元100流量', 4, 40000.00, 1516428600, NULL);
INSERT INTO `pub_order_setmeal` VALUES (13, '4800128800609856', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516434067, NULL);
INSERT INTO `pub_order_setmeal` VALUES (14, '5500799409802691', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516447554, NULL);
INSERT INTO `pub_order_setmeal` VALUES (15, '15044885833456511', 1, 1, 0, 10000.00, 100, '100元100流量', 4, 40000.00, 1516583815, NULL);
INSERT INTO `pub_order_setmeal` VALUES (16, '8906258961391061', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516588438, NULL);
INSERT INTO `pub_order_setmeal` VALUES (17, '1668844794307971', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516588462, NULL);
INSERT INTO `pub_order_setmeal` VALUES (18, '19105981537192611', 1, 1, 0, 10000.00, 100, '100元100流量', 4, 40000.00, 1516590319, NULL);
INSERT INTO `pub_order_setmeal` VALUES (19, '83712485265568113', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (20, '83712485265568113', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (21, '83712485265568113', 4, 2, 0, 40000.00, 1000, '400元1000流量', 2, 80000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (22, '83712485265568113', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (23, '83712485265568113', 9, 2, 1, 20000.00, 200, '200元200时长', 1, 20000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (24, '83712485265568113', 10, 2, 1, 30000.00, 300, '300元300时长', 1, 30000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (25, '83712485265568113', 11, 2, 1, 40000.00, 400, '400元400时长', 1, 40000.00, 1516675274, NULL);
INSERT INTO `pub_order_setmeal` VALUES (26, '12301728623964613', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516675445, NULL);
INSERT INTO `pub_order_setmeal` VALUES (27, '12301728623964613', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516675445, NULL);
INSERT INTO `pub_order_setmeal` VALUES (28, '12301728623964613', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516675445, NULL);
INSERT INTO `pub_order_setmeal` VALUES (29, '79949107063978713', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516675609, NULL);
INSERT INTO `pub_order_setmeal` VALUES (30, '79949107063978713', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516675609, NULL);
INSERT INTO `pub_order_setmeal` VALUES (31, '79949107063978713', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516675609, NULL);
INSERT INTO `pub_order_setmeal` VALUES (32, '79949107063978713', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516675609, NULL);
INSERT INTO `pub_order_setmeal` VALUES (33, '60639209713878713', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516675805, NULL);
INSERT INTO `pub_order_setmeal` VALUES (34, '60639209713878713', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516675805, NULL);
INSERT INTO `pub_order_setmeal` VALUES (35, '60639209713878713', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516675805, NULL);
INSERT INTO `pub_order_setmeal` VALUES (36, '89959262645127313', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516676144, NULL);
INSERT INTO `pub_order_setmeal` VALUES (37, '89959262645127313', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516676144, NULL);
INSERT INTO `pub_order_setmeal` VALUES (38, '32742759754985613', 9, 2, 1, 20000.00, 200, '200元200时长', 1, 20000.00, 1516676876, NULL);
INSERT INTO `pub_order_setmeal` VALUES (39, '32742759754985613', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516676876, NULL);
INSERT INTO `pub_order_setmeal` VALUES (40, '32742759754985613', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516676876, NULL);
INSERT INTO `pub_order_setmeal` VALUES (41, '32742759754985613', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516676876, NULL);
INSERT INTO `pub_order_setmeal` VALUES (42, '32742759754985613', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516676876, NULL);
INSERT INTO `pub_order_setmeal` VALUES (43, '43695958373121013', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516677065, NULL);
INSERT INTO `pub_order_setmeal` VALUES (44, '43695958373121013', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516677065, NULL);
INSERT INTO `pub_order_setmeal` VALUES (45, '43695958373121013', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516677065, NULL);
INSERT INTO `pub_order_setmeal` VALUES (46, '52097518163316313', 11, 2, 1, 40000.00, 400, '400元400时长', 1, 40000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (47, '52097518163316313', 10, 2, 1, 30000.00, 300, '300元300时长', 1, 30000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (48, '52097518163316313', 9, 2, 1, 20000.00, 200, '200元200时长', 1, 20000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (49, '52097518163316313', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (50, '52097518163316313', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (51, '52097518163316313', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (52, '52097518163316313', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516711997, NULL);
INSERT INTO `pub_order_setmeal` VALUES (53, '96071098499537613', 11, 2, 1, 40000.00, 400, '400元400时长', 1, 40000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (54, '96071098499537613', 10, 2, 1, 30000.00, 300, '300元300时长', 1, 30000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (55, '96071098499537613', 9, 2, 1, 20000.00, 200, '200元200时长', 1, 20000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (56, '96071098499537613', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (57, '96071098499537613', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (58, '96071098499537613', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (59, '96071098499537613', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516715849, NULL);
INSERT INTO `pub_order_setmeal` VALUES (60, '6003016779622624', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1516717856, NULL);
INSERT INTO `pub_order_setmeal` VALUES (61, '6003016779622624', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516717856, NULL);
INSERT INTO `pub_order_setmeal` VALUES (62, '6003016779622624', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516717856, NULL);
INSERT INTO `pub_order_setmeal` VALUES (63, '4751610201425666', 1, 1, 0, 10000.00, 100, '100元100流量', 2, 20000.00, 1516761924, NULL);
INSERT INTO `pub_order_setmeal` VALUES (64, '4751610201425666', 3, 1, 0, 30000.00, 800, '300元800流量', 2, 60000.00, 1516761924, NULL);
INSERT INTO `pub_order_setmeal` VALUES (65, '4751610201425666', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516761924, NULL);
INSERT INTO `pub_order_setmeal` VALUES (66, '26500557989931317', 13, 3, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516765529, NULL);
INSERT INTO `pub_order_setmeal` VALUES (67, '26500557989931317', 14, 3, 0, 20000.00, 200, '200元200流量', 1, 20000.00, 1516765529, NULL);
INSERT INTO `pub_order_setmeal` VALUES (68, '54474585703718814', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1516781943, NULL);
INSERT INTO `pub_order_setmeal` VALUES (69, '67164063539198010', 8, 2, 1, 10000.00, 100, '100元100时长', 1, 10000.00, 1516788679, NULL);
INSERT INTO `pub_order_setmeal` VALUES (70, '67164063539198010', 6, 2, 0, 60000.00, 1800, '600元1800流量', 1, 60000.00, 1516788679, NULL);
INSERT INTO `pub_order_setmeal` VALUES (71, '67164063539198010', 10, 2, 1, 30000.00, 300, '300元300时长', 1, 30000.00, 1516788679, NULL);
INSERT INTO `pub_order_setmeal` VALUES (72, '67164063539198010', 9, 2, 1, 20000.00, 200, '200元200时长', 1, 20000.00, 1516788679, NULL);
INSERT INTO `pub_order_setmeal` VALUES (73, '67164063539198010', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516788679, NULL);
INSERT INTO `pub_order_setmeal` VALUES (74, '67164063539198010', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516788679, NULL);
INSERT INTO `pub_order_setmeal` VALUES (75, '33463306977389710', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516788745, NULL);
INSERT INTO `pub_order_setmeal` VALUES (76, '33463306977389710', 4, 2, 0, 40000.00, 1000, '400元1000流量', 1, 40000.00, 1516788745, NULL);
INSERT INTO `pub_order_setmeal` VALUES (77, '3922086643247226', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516799925, NULL);
INSERT INTO `pub_order_setmeal` VALUES (78, '38561441548764810', 5, 2, 0, 50000.00, 1500, '500元1500流量', 1, 50000.00, 1516843080, NULL);
INSERT INTO `pub_order_setmeal` VALUES (79, '1870649270516855', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516847662, NULL);
INSERT INTO `pub_order_setmeal` VALUES (80, '3491586748960265', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1516851559, NULL);
INSERT INTO `pub_order_setmeal` VALUES (81, '9570638926528385', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516851916, NULL);
INSERT INTO `pub_order_setmeal` VALUES (82, '76244489229539619', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516867271, NULL);
INSERT INTO `pub_order_setmeal` VALUES (83, '76244489229539619', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516867271, NULL);
INSERT INTO `pub_order_setmeal` VALUES (84, '7986637225630125', 19, 1, 1, 66666600.00, 111, '666666元111天', 1, 66666600.00, 1516868671, NULL);
INSERT INTO `pub_order_setmeal` VALUES (85, '40675688652214519', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516928888, NULL);
INSERT INTO `pub_order_setmeal` VALUES (86, '31922547313911121', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516930984, NULL);
INSERT INTO `pub_order_setmeal` VALUES (87, '31070754808641721', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516931110, NULL);
INSERT INTO `pub_order_setmeal` VALUES (88, '8201665356475814', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1516934670, NULL);
INSERT INTO `pub_order_setmeal` VALUES (89, '8201665356475814', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516934670, NULL);
INSERT INTO `pub_order_setmeal` VALUES (90, '8201665356475814', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1516934670, NULL);
INSERT INTO `pub_order_setmeal` VALUES (91, '17113082528772319', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516934692, NULL);
INSERT INTO `pub_order_setmeal` VALUES (92, '17113082528772319', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516934692, NULL);
INSERT INTO `pub_order_setmeal` VALUES (93, '17113082528772319', 16, 5, 0, 10000.00, 100, '100元100流量', 2, 20000.00, 1516934692, NULL);
INSERT INTO `pub_order_setmeal` VALUES (94, '3262260725735166', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516937052, NULL);
INSERT INTO `pub_order_setmeal` VALUES (95, '11837143329906219', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516945402, NULL);
INSERT INTO `pub_order_setmeal` VALUES (96, '11837143329906219', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516945402, NULL);
INSERT INTO `pub_order_setmeal` VALUES (97, '11837143329906219', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1516945402, NULL);
INSERT INTO `pub_order_setmeal` VALUES (98, '14416669014972719', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516947135, NULL);
INSERT INTO `pub_order_setmeal` VALUES (99, '18395139484434919', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1516959959, NULL);
INSERT INTO `pub_order_setmeal` VALUES (100, '41068069763721919', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517015426, NULL);
INSERT INTO `pub_order_setmeal` VALUES (101, '41068069763721919', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517015426, NULL);
INSERT INTO `pub_order_setmeal` VALUES (102, '93179771465096024', 3, 1, 0, 30000.00, 800, '300元800流量', 5, 150000.00, 1517035765, NULL);
INSERT INTO `pub_order_setmeal` VALUES (103, '93179771465096024', 2, 1, 0, 20000.00, 500, '200元500流量', 1, 20000.00, 1517035765, NULL);
INSERT INTO `pub_order_setmeal` VALUES (104, '91608000047233924', 3, 1, 0, 30000.00, 800, '300元800流量', 2, 60000.00, 1517037442, NULL);
INSERT INTO `pub_order_setmeal` VALUES (105, '91608000047233924', 2, 1, 0, 20000.00, 500, '200元500流量', 2, 40000.00, 1517037442, NULL);
INSERT INTO `pub_order_setmeal` VALUES (106, '13920657797231924', 2, 1, 0, 20000.00, 500, '200元500流量', 12, 240000.00, 1517037537, NULL);
INSERT INTO `pub_order_setmeal` VALUES (107, '13920657797231924', 3, 1, 0, 30000.00, 800, '300元800流量', 4, 120000.00, 1517037537, NULL);
INSERT INTO `pub_order_setmeal` VALUES (108, '39100634804082324', 3, 1, 0, 30000.00, 800, '300元800流量', 15, 450000.00, 1517040219, NULL);
INSERT INTO `pub_order_setmeal` VALUES (109, '36082095117082424', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517040282, NULL);
INSERT INTO `pub_order_setmeal` VALUES (110, '16945562966977019', 17, 5, 1, 10000.00, 100, '100元100天', 11, 110000.00, 1517103942, NULL);
INSERT INTO `pub_order_setmeal` VALUES (111, '16945562966977019', 18, 5, 1, 10000.00, 100, '100元100天', 48, 480000.00, 1517103942, NULL);
INSERT INTO `pub_order_setmeal` VALUES (112, '31727377496412219', 18, 5, 1, 10000.00, 100, '100元100天', 2, 20000.00, 1517103987, NULL);
INSERT INTO `pub_order_setmeal` VALUES (113, '80214631224826419', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517105011, NULL);
INSERT INTO `pub_order_setmeal` VALUES (114, '80214631224826419', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517105011, NULL);
INSERT INTO `pub_order_setmeal` VALUES (115, '80214631224826419', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517105011, NULL);
INSERT INTO `pub_order_setmeal` VALUES (116, '19390927504116024', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517107662, NULL);
INSERT INTO `pub_order_setmeal` VALUES (117, '22820401685490924', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517107895, NULL);
INSERT INTO `pub_order_setmeal` VALUES (118, '20171666803384024', 20, 1, 1, 40000.00, 200, '400元200天', 6, 240000.00, 1517112379, NULL);
INSERT INTO `pub_order_setmeal` VALUES (119, '97209391163630224', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517112473, NULL);
INSERT INTO `pub_order_setmeal` VALUES (120, '90939506683868324', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517125359, NULL);
INSERT INTO `pub_order_setmeal` VALUES (121, '19276417629448424', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517125378, NULL);
INSERT INTO `pub_order_setmeal` VALUES (122, '63852760567674319', 16, 5, 0, 10000.00, 100, '100元100流量', 4, 40000.00, 1517126542, NULL);
INSERT INTO `pub_order_setmeal` VALUES (123, '66552934915439619', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517126622, NULL);
INSERT INTO `pub_order_setmeal` VALUES (124, '47898888426073719', 18, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517126670, NULL);
INSERT INTO `pub_order_setmeal` VALUES (125, '47898888426073719', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517126670, NULL);
INSERT INTO `pub_order_setmeal` VALUES (126, '47898888426073719', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517126670, NULL);
INSERT INTO `pub_order_setmeal` VALUES (127, '13961300376125619', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517126934, NULL);
INSERT INTO `pub_order_setmeal` VALUES (128, '87602948561477919', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517126948, NULL);
INSERT INTO `pub_order_setmeal` VALUES (129, '59860902116277824', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517127711, NULL);
INSERT INTO `pub_order_setmeal` VALUES (130, '52513040432865924', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517127757, NULL);
INSERT INTO `pub_order_setmeal` VALUES (131, '19814401329493624', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517128873, NULL);
INSERT INTO `pub_order_setmeal` VALUES (132, '27122264683075224', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517129570, NULL);
INSERT INTO `pub_order_setmeal` VALUES (133, '29266949414328624', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517129674, NULL);
INSERT INTO `pub_order_setmeal` VALUES (134, '78670905945578424', 20, 1, 1, 40000.00, 200, '400元200天', 6, 240000.00, 1517129892, NULL);
INSERT INTO `pub_order_setmeal` VALUES (135, '41878675992435424', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517129969, NULL);
INSERT INTO `pub_order_setmeal` VALUES (136, '60669606557271824', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517131775, NULL);
INSERT INTO `pub_order_setmeal` VALUES (137, '37022871811251424', 1, 1, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517131911, NULL);
INSERT INTO `pub_order_setmeal` VALUES (138, '47005720103170824', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517131954, NULL);
INSERT INTO `pub_order_setmeal` VALUES (139, '83288550742056324', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517131986, NULL);
INSERT INTO `pub_order_setmeal` VALUES (140, '83288550742056324', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517131986, NULL);
INSERT INTO `pub_order_setmeal` VALUES (141, '16793947993738624', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517132725, NULL);
INSERT INTO `pub_order_setmeal` VALUES (142, '59220889491222724', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517132757, NULL);
INSERT INTO `pub_order_setmeal` VALUES (143, '24267619063161424', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517132827, NULL);
INSERT INTO `pub_order_setmeal` VALUES (144, '43377643033889224', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517132872, NULL);
INSERT INTO `pub_order_setmeal` VALUES (145, '56615633184161524', 20, 1, 1, 40000.00, 200, '400元200天', 4, 160000.00, 1517132974, NULL);
INSERT INTO `pub_order_setmeal` VALUES (146, '81365075219351024', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517133018, NULL);
INSERT INTO `pub_order_setmeal` VALUES (147, '97077949885939924', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517133051, NULL);
INSERT INTO `pub_order_setmeal` VALUES (148, '91496834981435424', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517135007, NULL);
INSERT INTO `pub_order_setmeal` VALUES (149, '45399382543875624', 20, 1, 1, 40000.00, 200, '400元200天', 3, 120000.00, 1517135038, NULL);
INSERT INTO `pub_order_setmeal` VALUES (150, '31873939513103624', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517135067, NULL);
INSERT INTO `pub_order_setmeal` VALUES (151, '31873939513103624', 2, 1, 0, 20000.00, 500, '200元500流量', 2, 40000.00, 1517135067, NULL);
INSERT INTO `pub_order_setmeal` VALUES (152, '56887492995336524', 20, 1, 1, 40000.00, 200, '400元200天', 2, 80000.00, 1517135121, NULL);
INSERT INTO `pub_order_setmeal` VALUES (153, '56887492995336524', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517135121, NULL);
INSERT INTO `pub_order_setmeal` VALUES (154, '99230895102894324', 20, 1, 1, 40000.00, 200, '400元200天', 2, 80000.00, 1517135170, NULL);
INSERT INTO `pub_order_setmeal` VALUES (155, '28254729266198524', 3, 1, 0, 30000.00, 800, '300元800流量', 1, 30000.00, 1517135211, NULL);
INSERT INTO `pub_order_setmeal` VALUES (156, '28254729266198524', 1, 1, 0, 10000.00, 100, '100元100流量', 2, 20000.00, 1517135211, NULL);
INSERT INTO `pub_order_setmeal` VALUES (157, '28254729266198524', 20, 1, 1, 40000.00, 200, '400元200天', 5, 200000.00, 1517135211, NULL);
INSERT INTO `pub_order_setmeal` VALUES (158, '91490418964416419', 17, 5, 1, 10000.00, 100, '100元100天', 2, 20000.00, 1517188853, NULL);
INSERT INTO `pub_order_setmeal` VALUES (159, '46757216173492019', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517188928, NULL);
INSERT INTO `pub_order_setmeal` VALUES (160, '46757216173492019', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517188928, NULL);
INSERT INTO `pub_order_setmeal` VALUES (161, '63690424467582619', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517192979, NULL);
INSERT INTO `pub_order_setmeal` VALUES (162, '63690424467582619', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517192979, NULL);
INSERT INTO `pub_order_setmeal` VALUES (163, '87136705178230719', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517215365, NULL);
INSERT INTO `pub_order_setmeal` VALUES (164, '87136705178230719', 17, 5, 1, 10000.00, 100, '100元100天', 1, 10000.00, 1517215365, NULL);
INSERT INTO `pub_order_setmeal` VALUES (165, '15000308173545419', 16, 5, 0, 10000.00, 100, '100元100流量', 1, 10000.00, 1517215928, NULL);
INSERT INTO `pub_order_setmeal` VALUES (166, '69028445087467624', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517216895, NULL);
INSERT INTO `pub_order_setmeal` VALUES (167, '52190504017005024', 21, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517282176, NULL);
INSERT INTO `pub_order_setmeal` VALUES (168, '52190504017005024', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1517282176, NULL);
INSERT INTO `pub_order_setmeal` VALUES (169, '52190504017005024', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517282176, NULL);
INSERT INTO `pub_order_setmeal` VALUES (170, '46035668872112624', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1517287359, NULL);
INSERT INTO `pub_order_setmeal` VALUES (171, '91501018908607911', 25, 2, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517366721, NULL);
INSERT INTO `pub_order_setmeal` VALUES (172, '3806529769772209', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517377763, NULL);
INSERT INTO `pub_order_setmeal` VALUES (173, '3806529769772209', 29, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517377763, NULL);
INSERT INTO `pub_order_setmeal` VALUES (174, '3806529769772209', 21, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517377763, NULL);
INSERT INTO `pub_order_setmeal` VALUES (175, '3806529769772209', 24, 1, 0, 50000.00, 50, '500元50天', 1, 50000.00, 1517377763, NULL);
INSERT INTO `pub_order_setmeal` VALUES (176, '34456334012786023', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517378687, NULL);
INSERT INTO `pub_order_setmeal` VALUES (177, '34456334012786023', 29, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517378687, NULL);
INSERT INTO `pub_order_setmeal` VALUES (178, '34456334012786023', 21, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517378687, NULL);
INSERT INTO `pub_order_setmeal` VALUES (179, '34456334012786023', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1517378687, NULL);
INSERT INTO `pub_order_setmeal` VALUES (180, '34456334012786023', 24, 1, 0, 50000.00, 50, '500元50天', 1, 50000.00, 1517378687, NULL);
INSERT INTO `pub_order_setmeal` VALUES (181, '7282342372730583', 29, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517452827, NULL);
INSERT INTO `pub_order_setmeal` VALUES (182, '7282342372730583', 21, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517452827, NULL);
INSERT INTO `pub_order_setmeal` VALUES (183, '7282342372730583', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1517452827, NULL);
INSERT INTO `pub_order_setmeal` VALUES (184, '2057042415282246', 21, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517471540, NULL);
INSERT INTO `pub_order_setmeal` VALUES (185, '2058987054456373', 24, 1, 0, 50000.00, 50, '500元50天', 1, 50000.00, 1517550902, NULL);
INSERT INTO `pub_order_setmeal` VALUES (186, '2058987054456373', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1517550902, NULL);
INSERT INTO `pub_order_setmeal` VALUES (187, '2058987054456373', 29, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517550902, NULL);
INSERT INTO `pub_order_setmeal` VALUES (188, '2058987054456373', 21, 1, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1517550902, NULL);
INSERT INTO `pub_order_setmeal` VALUES (189, '2058987054456373', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1517550902, NULL);
INSERT INTO `pub_order_setmeal` VALUES (190, '8070335309807653', 20, 1, 1, 40000.00, 200, '400元200天', 1, 40000.00, 1520316877, NULL);
INSERT INTO `pub_order_setmeal` VALUES (191, '8070335309807653', 24, 1, 0, 50000.00, 50, '500元50天', 1, 50000.00, 1520316877, NULL);
INSERT INTO `pub_order_setmeal` VALUES (192, '8070335309807653', 21, 1, 0, 10000.00, 10, '100元10天', 2, 20000.00, 1520316877, NULL);
INSERT INTO `pub_order_setmeal` VALUES (193, '8070335309807653', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1520316877, NULL);
INSERT INTO `pub_order_setmeal` VALUES (194, '28577983622513745', 22, 1, 0, 15000.00, 15, '150元15天', 1, 15000.00, 1520321048, NULL);
INSERT INTO `pub_order_setmeal` VALUES (195, '95837900918196446', 31, 8, 0, 1.00, 100, '100元100天', 1, 1.00, 1520331691, NULL);
INSERT INTO `pub_order_setmeal` VALUES (196, '16905261364743820', 10, 2, 1, 30000.00, 300, '300元300时长', 1, 30000.00, 1520385389, NULL);
INSERT INTO `pub_order_setmeal` VALUES (197, '16905261364743820', 8, 2, 1, 10000.00, 100, '100元100时长', 5, 50000.00, 1520385389, NULL);
INSERT INTO `pub_order_setmeal` VALUES (198, '16905261364743820', 25, 2, 0, 10000.00, 10, '100元10天', 1, 10000.00, 1520385389, NULL);
INSERT INTO `pub_order_setmeal` VALUES (199, '64006737244896346', 31, 8, 0, 1.00, 100, '100元100天', 1, 1.00, 1520502784, NULL);
INSERT INTO `pub_order_setmeal` VALUES (200, '58849300074543146', 31, 8, 0, 1.00, 100, '100元100天', 1, 1.00, 1520504182, NULL);

-- ----------------------------
-- Table structure for pub_orders
-- ----------------------------
DROP TABLE IF EXISTS `pub_orders`;
CREATE TABLE `pub_orders`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `device_id` int(11) UNSIGNED NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的用户ID号',
  `express_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '关联快递信息ID号',
  `total_num` int(11) UNSIGNED NOT NULL COMMENT '商品的购买总数量',
  `total_price` decimal(15, 2) UNSIGNED NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) NULL DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) NULL DEFAULT NULL COMMENT '订单修改时间',
  `is_pay` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '付款状态(0：未付款1：已付款 2：已取消)',
  `is_receipt` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '发货状态(0：未发货1：已发货)',
  `is_ship` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '收货状态(0：未收货1：已收货)',
  `is_recharge` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '充值状态(0：未充值1：已充值)',
  `express` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '快递名称',
  `mca` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '快递订单号',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0禁用1启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`, `device_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES (1, '8872329721698232', 2, 2, NULL, 1, 30000.00, 1516356406, NULL, 0, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (2, '7721958114830821', 1, 4, NULL, 1, 20000.00, 1516357875, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (3, '6225562025606521', 1, 4, 1, 3, 60000.00, 1516358192, 1516937184, 1, 1, 1, 0, '圆通', '9863125478901', 1);
INSERT INTO `pub_orders` VALUES (4, '7366574936397834', 4, 3, 2, 6, 90000.00, 1516361061, 1516715365, 2, 1, 1, 0, '顺丰', '562301254201200', 0);
INSERT INTO `pub_orders` VALUES (5, '5785534497296014', 4, 3, 3, 7, 120000.00, 1516410981, 1516411701, 1, 1, 1, 1, '中通', '986532147851', 0);
INSERT INTO `pub_orders` VALUES (6, '4310646019720094', 4, 3, 3, 0, 0.00, 1516410982, 1516715366, 2, 1, 1, 0, '天天', '5698200125452145', 0);
INSERT INTO `pub_orders` VALUES (7, '5066364933568976', 2, 2, NULL, 1, 30000.00, 1516411031, NULL, 0, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (8, '5039795438737244', 4, 3, NULL, 3, 30000.00, 1516414127, NULL, 1, 0, 0, 1, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (9, '2052114291507074', 4, 3, NULL, 1, 10000.00, 1516414737, NULL, 1, 0, 0, 1, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (10, '9364319663900581', 1, 4, 4, 2, 30000.00, 1516418831, 1516937271, 1, 1, 1, 0, '圆通', '986578542150125', 1);
INSERT INTO `pub_orders` VALUES (11, '13958457198822011', 4, 3, NULL, 1, 10000.00, 1516419199, 1516419214, 2, 0, 0, 0, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (12, '16199850951714511', 4, 3, 5, 9, 55000.00, 1516419258, 1516715363, 2, 1, 1, 0, '申通', '5326524221521252', 0);
INSERT INTO `pub_orders` VALUES (13, '32842426129469711', 4, 3, 6, 8, 50000.00, 1516419305, 1516713041, 2, 1, 1, 0, '韵达', '5623211542511356', 0);
INSERT INTO `pub_orders` VALUES (14, '3854699010485387', 7, 8, 7, 6, 240000.00, 1516420362, 1516420467, 1, 1, 1, 1, '圆通', '986523021252122', 0);
INSERT INTO `pub_orders` VALUES (15, '8661851704292464', 4, 3, 8, 7, 140000.00, 1516427302, 1516427395, 1, 1, 1, 0, '韵达', '1896523021545', 0);
INSERT INTO `pub_orders` VALUES (16, '6804945746821974', 4, 3, 8, 0, 0.00, 1516427303, 1516713022, 2, 1, 1, 0, '快递', '59352215521551', 0);
INSERT INTO `pub_orders` VALUES (17, '90803629288238311', 4, 3, 9, 12, 63000.00, 1516428600, 1516434312, 1, 1, 1, 1, '中通', '9623562021210', 0);
INSERT INTO `pub_orders` VALUES (18, '4800128800609856', 6, 7, NULL, 1, 50000.00, 1516434067, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (19, '9733271524754546', 6, 7, 10, 1, 10000.00, 1516435580, 1516435690, 1, 1, 1, 0, '中通', '9623502123', 1);
INSERT INTO `pub_orders` VALUES (20, '6754715405311196', 6, 7, 11, 2, 50000.00, 1516436449, 1516437193, 1, 1, 1, 0, '小快递', '123456789', 1);
INSERT INTO `pub_orders` VALUES (21, '5500799409802691', 1, 4, NULL, 1, 20000.00, 1516447554, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (22, '15044885833456511', 4, 3, 12, 9, 60000.00, 1516583815, 1516584124, 1, 1, 1, 1, '中通', '56231025421621', 0);
INSERT INTO `pub_orders` VALUES (23, '8906258961391061', 1, 4, NULL, 1, 20000.00, 1516588438, NULL, 0, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (24, '1668844794307971', 1, 4, NULL, 1, 20000.00, 1516588462, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (25, '19105981537192611', 4, 3, NULL, 4, 40000.00, 1516590319, NULL, 1, 0, 0, 1, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (26, '73547745493449411', 4, 3, 13, 3, 9000.00, 1516600107, 1516600256, 1, 1, 1, 0, '韵达', '89236589652310', 0);
INSERT INTO `pub_orders` VALUES (27, '45861679027378213', 4, 3, 14, 2, 4000.00, 1516602066, 1516712758, 2, 1, 1, 0, '中通', '562465956532654213', 0);
INSERT INTO `pub_orders` VALUES (28, '83712485265568113', 4, 3, 15, 14, 312000.00, 1516675274, NULL, 1, 1, 0, 1, '中通', '98653202154750', 0);
INSERT INTO `pub_orders` VALUES (29, '58132646603580913', 4, 3, 15, 0, 0.00, 1516675276, 1516676005, 1, 1, 1, 0, '中通', '9562312002125112', 0);
INSERT INTO `pub_orders` VALUES (30, '12301728623964613', 4, 3, 16, 8, 170000.00, 1516675445, NULL, 1, 1, 0, 1, '韵达', '562314782125211511', 0);
INSERT INTO `pub_orders` VALUES (31, '79949107063978713', 4, 3, 17, 9, 180000.00, 1516675609, 1516685382, 1, 1, 1, 1, '圆通', '85421548754', 0);
INSERT INTO `pub_orders` VALUES (32, '60639209713878713', 4, 3, 18, 5, 125000.00, 1516675805, 1516675905, 2, 1, 1, 0, '中通', '0215487212512', 0);
INSERT INTO `pub_orders` VALUES (33, '89959262645127313', 4, 3, NULL, 2, 100000.00, 1516676144, 1516676168, 2, 0, 0, 0, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (34, '21048900071722313', 4, 3, 19, 3, 9000.00, 1516676210, 1516676812, 2, 1, 1, 0, '中文', '12345612345', 0);
INSERT INTO `pub_orders` VALUES (35, '32742759754985613', 4, 3, 20, 8, 188000.00, 1516676876, 1516689895, 2, 0, 0, 0, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (36, '93235939321739013', 4, 3, 21, 4, 8000.00, 1516677021, 1516689892, 2, 0, 0, 0, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (37, '43695958373121013', 4, 3, NULL, 3, 150000.00, 1516677065, 1516689897, 2, 0, 0, 0, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (38, '58344646335821913', 4, 3, 22, 7, 23000.00, 1516690149, 1516756345, 2, 1, 1, 0, '小王', '123456789', 0);
INSERT INTO `pub_orders` VALUES (39, '21265457366309013', 13, 3, 23, 7, 23000.00, 1516705568, 1516756343, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (40, '52097518163316313', 4, 3, 24, 12, 270000.00, 1516711997, 1516712124, 1, 1, 1, 1, '圆通', '265285654843558515', 0);
INSERT INTO `pub_orders` VALUES (41, '36186252285132113', 4, 3, 25, 3, 9000.00, 1516712860, 1516756340, 2, 0, 0, 0, NULL, NULL, 0);
INSERT INTO `pub_orders` VALUES (42, '96071098499537613', 4, 3, 26, 12, 270000.00, 1516715849, 1516716155, 1, 1, 1, 1, '申通', '8953266226652326653', 0);
INSERT INTO `pub_orders` VALUES (43, '6003016779622624', 4, 3, 27, 6, 120000.00, 1516717856, 1516756857, 1, 1, 1, 1, '申通', '562032154215215', 0);
INSERT INTO `pub_orders` VALUES (44, '82906478768879215', 4, 3, 28, 3, 9000.00, 1516756754, 1516765129, 1, 1, 1, 0, '韵达', '562312542551252', 0);
INSERT INTO `pub_orders` VALUES (45, '4751610201425666', 6, 7, 29, 7, 130000.00, 1516761924, 1516762087, 1, 1, 1, 1, '圆通', '256155121251', 1);
INSERT INTO `pub_orders` VALUES (46, '26500557989931317', 4, 3, 30, 4, 65300.00, 1516765529, 1516765665, 1, 1, 1, 1, '囧撒', '9865236595', 0);
INSERT INTO `pub_orders` VALUES (47, '71335108864336117', 13, 3, 31, 2, 35300.00, 1516772219, 1516772477, 1, 1, 1, 0, '申通', '259865236541', 1);
INSERT INTO `pub_orders` VALUES (48, '54474585703718814', 14, 12, NULL, 1, 30000.00, 1516781943, NULL, 0, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (49, '67164063539198010', 10, 3, 32, 9, 219000.00, 1516788679, 1516843470, 1, 1, 1, 1, '申通', '2598652311255215', 1);
INSERT INTO `pub_orders` VALUES (50, '33463306977389710', 10, 3, NULL, 2, 90000.00, 1516788745, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (51, '3922086643247226', 2, 2, NULL, 1, 10000.00, 1516799925, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (52, '38561441548764810', 10, 3, 33, 4, 59000.00, 1516843080, 1516843472, 1, 1, 1, 1, '申通', '259862356210', 1);
INSERT INTO `pub_orders` VALUES (53, '1870649270516855', 5, 14, NULL, 1, 10000.00, 1516847662, 1517282353, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (54, '83432484001432810', 7, 3, 34, 3, 9000.00, 1516849852, 1516849920, 1, 1, 1, 0, '府邸', '8956223523352620', 1);
INSERT INTO `pub_orders` VALUES (55, '8767345448578235', 5, 14, 35, 7, 170000.00, 1516851478, 1517282355, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (56, '3491586748960265', 5, 14, NULL, 1, 30000.00, 1516851559, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (57, '9570638926528385', 5, 14, NULL, 1, 20000.00, 1516851916, 1517282356, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (58, '2239436101495765', 5, 14, 36, 3, 50000.00, 1516852164, 1516960755, 1, 1, 1, 0, '德邦物流', 'xxxx123456', 1);
INSERT INTO `pub_orders` VALUES (59, '2068561083459187', 7, 3, 37, 3, 60000.00, 1516852889, 1516852938, 1, 1, 1, 0, '几个', '14554564545445', 1);
INSERT INTO `pub_orders` VALUES (60, '2967367586589247', 7, 3, 37, 0, 0.00, 1516852890, 1516862345, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (61, '76244489229539619', 7, 3, NULL, 2, 20000.00, 1516867271, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (62, '7986637225630125', 5, 14, NULL, 1, 66666600.00, 1516868671, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (63, '40675688652214519', 7, 3, NULL, 1, 10000.00, 1516928888, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (64, '31922547313911121', 12, 1, NULL, 1, 10000.00, 1516930984, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (65, '14959684428583621', 12, 1, 38, 1, 10000.00, 1516931052, NULL, 1, 1, 0, 0, '德邦物流', 'byuibiukbn', 1);
INSERT INTO `pub_orders` VALUES (66, '31070754808641721', 12, 1, NULL, 1, 10000.00, 1516931110, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (67, '43747788661593521', 12, 1, 39, 1, 20000.00, 1516931214, NULL, 1, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (68, '8201665356475814', 4, 8, 40, 6, 100000.00, 1516934670, 1516934753, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (69, '17113082528772319', 7, 3, 41, 5, 42000.00, 1516934692, 1516934759, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (70, '3262260725735166', 6, 4, NULL, 1, 10000.00, 1516937052, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (71, '7627543438146556', 6, 4, 42, 1, 30000.00, 1516937113, NULL, 1, 1, 0, 0, '顺丰 ', '98651400025458', 1);
INSERT INTO `pub_orders` VALUES (72, '11837143329906219', 7, 3, 43, 4, 32000.00, 1516945402, 1516945505, 1, 1, 1, 1, '圆通', '965221542254555521', 1);
INSERT INTO `pub_orders` VALUES (73, '14416669014972719', 7, 3, NULL, 1, 10000.00, 1516947135, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (74, '18395139484434919', 1, 3, NULL, 1, 10000.00, 1516959959, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (75, '37758674381290624', 24, 14, 44, 3, 53000.00, 1516960891, 1516960997, 1, 1, 1, 0, '马哥物流', 'xxx000000', 1);
INSERT INTO `pub_orders` VALUES (76, '41068069763721919', 19, 3, 45, 3, 22000.00, 1517015426, 1517015675, 1, 1, 1, 1, '顺丰', '59865214523102', 1);
INSERT INTO `pub_orders` VALUES (77, '52750416054237319', 19, 3, 46, 1, 2000.00, 1517015750, 1517015837, 1, 1, 1, 0, '中通', '8956213542157', 1);
INSERT INTO `pub_orders` VALUES (78, '93179771465096024', 24, 14, NULL, 6, 170000.00, 1517035765, 1517282358, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (79, '91608000047233924', 24, 14, NULL, 4, 100000.00, 1517037442, 1517282359, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (80, '13920657797231924', 24, 14, NULL, 16, 360000.00, 1517037537, 1517282360, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (81, '39100634804082324', 24, 14, NULL, 15, 450000.00, 1517040219, 1517282362, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (82, '36082095117082424', 24, 14, NULL, 1, 30000.00, 1517040282, 1517282363, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (83, '16945562966977019', 19, 3, NULL, 59, 590000.00, 1517103942, 1517107291, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (84, '31727377496412219', 19, 3, NULL, 2, 20000.00, 1517103987, 1517107290, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (85, '80214631224826419', 19, 3, 47, 7, 38000.00, 1517105011, 1517105216, 1, 1, 1, 1, '中通', '98653240212012', 1);
INSERT INTO `pub_orders` VALUES (86, '19390927504116024', 24, 14, NULL, 1, 10000.00, 1517107662, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (87, '22820401685490924', 24, 14, NULL, 1, 40000.00, 1517107895, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (88, '20171666803384024', 24, 14, 48, 10, 280000.00, 1517112379, 1517112587, 1, 1, 1, 1, '圆通', '2302689512012045', 1);
INSERT INTO `pub_orders` VALUES (89, '97209391163630224', 24, 14, 48, 3, 30000.00, 1517112473, 1517112575, 1, 1, 1, 1, '顺丰', '59862548752156', 1);
INSERT INTO `pub_orders` VALUES (90, '90939506683868324', 8, 14, NULL, 1, 40000.00, 1517125359, 1517282364, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (91, '19276417629448424', 8, 14, NULL, 1, 40000.00, 1517125378, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (92, '63852760567674319', 19, 3, 49, 5, 42000.00, 1517126542, 1517126606, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (93, '66552934915439619', 19, 3, NULL, 1, 10000.00, 1517126622, 1517552121, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (94, '47898888426073719', 19, 3, 49, 4, 32000.00, 1517126670, 1517126715, 1, 1, 1, 1, ' 中通', '8956214520012', 1);
INSERT INTO `pub_orders` VALUES (95, '13961300376125619', 19, 3, NULL, 1, 10000.00, 1517126934, 1520317311, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (96, '87602948561477919', 19, 3, NULL, 1, 10000.00, 1517126948, 1520317309, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (97, '59860902116277824', 8, 14, NULL, 1, 40000.00, 1517127711, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (98, '52513040432865924', 8, 14, NULL, 1, 40000.00, 1517127757, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (99, '19814401329493624', 8, 14, NULL, 1, 40000.00, 1517128873, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (100, '27122264683075224', 8, 14, NULL, 1, 40000.00, 1517129570, 1517282901, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (101, '29266949414328624', 8, 14, NULL, 1, 40000.00, 1517129674, 1517282900, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (102, '78670905945578424', 8, 14, NULL, 6, 240000.00, 1517129892, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (103, '41878675992435424', 8, 14, NULL, 1, 30000.00, 1517129969, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (104, '60669606557271824', 8, 14, NULL, 1, 40000.00, 1517131775, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (105, '37022871811251424', 8, 14, NULL, 1, 10000.00, 1517131911, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (106, '47005720103170824', 8, 14, NULL, 1, 40000.00, 1517131954, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (107, '83288550742056324', 8, 14, NULL, 2, 70000.00, 1517131986, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (108, '16793947993738624', 8, 14, NULL, 1, 30000.00, 1517132725, 1517282249, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (109, '59220889491222724', 8, 14, NULL, 1, 40000.00, 1517132757, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (110, '24267619063161424', 8, 14, NULL, 1, 30000.00, 1517132827, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (111, '43377643033889224', 8, 14, NULL, 1, 40000.00, 1517132872, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (112, '56615633184161524', 8, 14, NULL, 4, 160000.00, 1517132974, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (113, '81365075219351024', 8, 14, NULL, 1, 40000.00, 1517133018, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (114, '97077949885939924', 8, 14, NULL, 1, 40000.00, 1517133051, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (115, '91496834981435424', 8, 14, NULL, 1, 40000.00, 1517135007, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (116, '45399382543875624', 8, 14, NULL, 3, 120000.00, 1517135038, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (117, '31873939513103624', 8, 14, NULL, 3, 80000.00, 1517135067, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (118, '56887492995336524', 8, 14, NULL, 3, 110000.00, 1517135121, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (119, '99230895102894324', 8, 14, NULL, 2, 80000.00, 1517135170, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (120, '28254729266198524', 8, 14, NULL, 8, 250000.00, 1517135211, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (121, '91490418964416419', 19, 3, 45, 4, 24000.00, 1517188853, 1517190116, 1, 1, 1, 1, '中通', '23658742102551212', 1);
INSERT INTO `pub_orders` VALUES (122, '46757216173492019', 19, 3, NULL, 2, 20000.00, 1517188928, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (123, '63690424467582619', 19, 3, NULL, 2, 20000.00, 1517192979, 1520317307, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (124, '90862280954716919', 19, 3, 50, 1, 2000.00, 1517193456, 1517193505, 1, 1, 1, 0, '韵达', '259862236566952662', 1);
INSERT INTO `pub_orders` VALUES (125, '31473295304744224', 8, 14, 48, 13, 360000.00, 1517195465, 1517287402, 1, 1, 1, 0, '德邦物流', '12fdsf4555555555500', 1);
INSERT INTO `pub_orders` VALUES (126, '87136705178230719', 19, 3, NULL, 2, 20000.00, 1517215365, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (127, '15000308173545419', 19, 3, NULL, 1, 10000.00, 1517215928, 1520317310, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (128, '69028445087467624', 8, 14, NULL, 1, 40000.00, 1517216895, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (129, '52190504017005024', 8, 14, NULL, 3, 65000.00, 1517282176, 1517282246, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (130, '46035668872112624', 8, 14, NULL, 1, 15000.00, 1517287359, NULL, 0, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (131, '91501018908607911', 11, 14, 48, 5, 26000.00, 1517366721, 1517366850, 1, 1, 1, 1, '德邦物流', '12fdsf455555555', 1);
INSERT INTO `pub_orders` VALUES (132, '77786285224122111', 11, 14, 51, 4, 9000.00, 1517366932, 1517367013, 1, 1, 1, 0, '德邦物流', '20180131104954', 1);
INSERT INTO `pub_orders` VALUES (133, '3806529769772209', 23, 3, 52, 8, 180000.00, 1517377763, 1517452969, 1, 1, 1, 1, '申通', '98652326502565656', 1);
INSERT INTO `pub_orders` VALUES (134, '34456334012786023', 23, 3, 53, 10, 228000.00, 1517378687, 1517452956, 1, 1, 1, 1, '中通', '9865230145781554', 1);
INSERT INTO `pub_orders` VALUES (135, '7282342372730583', 3, 3, 54, 12, 208000.00, 1517452827, 1517452942, 1, 1, 1, 1, '韵达', '895620125489822', 1);
INSERT INTO `pub_orders` VALUES (136, '54992473537941611', 11, 14, 55, 2, 4000.00, 1517453141, 1517453536, 1, 1, 1, 0, '德邦物流', '12fdsf455555555b', 1);
INSERT INTO `pub_orders` VALUES (137, '86410127669052711', 11, 14, 48, 3, 9000.00, 1517453206, 1517453332, 1, 1, 1, 0, '德邦物流', '12fdsf455555555mm', 1);
INSERT INTO `pub_orders` VALUES (138, '81088060922640611', 11, 14, 48, 6, 24000.00, 1517465789, 1517465894, 1, 1, 1, 0, '德邦物流', '145dsf4555555555', 1);
INSERT INTO `pub_orders` VALUES (139, '2057042415282246', 6, 4, NULL, 1, 10000.00, 1517471540, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (140, '2058987054456373', 3, 3, 56, 12, 248000.00, 1517550902, 1520316673, 1, 1, 1, 1, '圆通', '98989898989 989898', 1);
INSERT INTO `pub_orders` VALUES (141, '1300447860790493', 3, 3, 57, 2, 40000.00, 1517550963, 1517551174, 1, 1, 1, 0, '中通', '12356565656565665', 1);
INSERT INTO `pub_orders` VALUES (142, '38044801143637411', 11, 14, 58, 4, 15000.00, 1518053901, 1518053967, 1, 1, 1, 0, '德邦物流', 'xxx0000004566', 1);
INSERT INTO `pub_orders` VALUES (143, '3132826905990653', 3, 3, 59, 6, 140000.00, 1519709485, 1520317306, 2, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (144, '9860983937820223', 3, 3, 60, 2, 60000.00, 1520316565, 1520316677, 1, 1, 1, 0, '中通', '259852314521', 1);
INSERT INTO `pub_orders` VALUES (145, '8070335309807653', 3, 3, 61, 9, 235000.00, 1520316877, 1520317096, 1, 1, 1, 1, '鱼鱼物流', '89523652125621', 1);
INSERT INTO `pub_orders` VALUES (146, '28577983622513745', 13, 3, NULL, 1, 15000.00, 1520321048, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (147, '95837900918196446', 2, 2, NULL, 1, 1.00, 1520331691, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (148, '16905261364743820', 20, 6, NULL, 7, 90000.00, 1520385389, NULL, 0, 0, 0, 0, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (149, '64006737244896346', 2, 2, NULL, 1, 1.00, 1520502784, NULL, 1, 0, 0, 1, NULL, NULL, 1);
INSERT INTO `pub_orders` VALUES (150, '58849300074543146', 2, 2, NULL, 1, 1.00, 1520504182, NULL, 1, 0, 0, 1, NULL, NULL, 1);

-- ----------------------------
-- Table structure for pub_personnel
-- ----------------------------
DROP TABLE IF EXISTS `pub_personnel`;
CREATE TABLE `pub_personnel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '安装人员姓名',
  `v_id` int(11) NULL DEFAULT NULL COMMENT '属于哪个经销商',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安装人员登录密码',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `phone` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安装人员手机号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '安装人员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_personnel
-- ----------------------------
INSERT INTO `pub_personnel` VALUES (8, '12344', 1, 'e10adc3949ba59abbe56e057f20f883e', '2018-03-10 14:43:28', '13576653699');

-- ----------------------------
-- Table structure for pub_repair
-- ----------------------------
DROP TABLE IF EXISTS `pub_repair`;
CREATE TABLE `pub_repair`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编码',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题描述',
  `picpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片路径',
  `uid` int(11) NOT NULL COMMENT '报修人ID 用户ID',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '维修地址',
  `addtime` int(11) NOT NULL COMMENT '报修时间',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态0：未处理 1：已处理',
  `did` int(11) NOT NULL COMMENT '设备ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_repair
-- ----------------------------
INSERT INTO `pub_repair` VALUES (1, '166753845596778', '泵坏了', '/Pic/2018-01-19/5a61c9834a3c3.jpg', 4, '广州市番禺区钟村8', 1516358019, 1, 1);
INSERT INTO `pub_repair` VALUES (2, '162753445555778', '设备安装调试问题', '/Pic/2018-01-20/5a629cbf005f4.jpg', 8, '广州市人民政府办公室', 1516412095, 1, 7);
INSERT INTO `pub_repair` VALUES (3, '155753845596778', '设备锁', '/Pic/2018-01-20/5a629d2dc4589.jpg', 3, '广州市天河区天河路', 1516412205, 1, 4);
INSERT INTO `pub_repair` VALUES (4, '166753845596778', '泵坏了', '/Pic/2018-01-20/5a62b7b828686.jpg', 4, '广州市番禺区钟村', 1516419000, 1, 1);
INSERT INTO `pub_repair` VALUES (5, '111133445596778', '摸摸摸', '/Pic/2018-01-20/5a63076b4dfe5.jpg', 3, '广州市天河区天河路', 1516439403, 1, 11);
INSERT INTO `pub_repair` VALUES (6, '111133445596778', '一名', '/Pic/2018-01-22/5a653d4cc8a8b.jpg', 3, '广州市天河区天河路', 1516584268, 0, 11);
INSERT INTO `pub_repair` VALUES (7, '112733445596668', '磨破蓉蓉', '/Pic/2018-01-22/5a654f6deb809.jpg', 3, '广州市天河区天河路', 1516588909, 0, 9);
INSERT INTO `pub_repair` VALUES (8, '112733445596668', '永发', '/Pic/2018-01-22/5a65506624ef0.jpg', 3, '广州市天河区天河路', 1516589158, 0, 9);
INSERT INTO `pub_repair` VALUES (9, '112733445596668', '羽绒', '/Pic/2018-01-22/5a6550ac46aa9.jpg', 3, '广州市天河区天河路', 1516589228, 1, 9);
INSERT INTO `pub_repair` VALUES (10, '112733445596668', '搭错车', '/Pic/2018-01-22/5a65513e64a41.jpg', 3, '广州市天河区天河路', 1516589374, 0, 9);
INSERT INTO `pub_repair` VALUES (11, '111133445596778', '哟哟', '/Pic/2018-01-22/5a6562289f598.jpg', 3, '广州市天河区天河路', 1516593704, 1, 11);
INSERT INTO `pub_repair` VALUES (12, '992833445596778', '设备不会出水', '/Pic/2018-01-22/5a657eed80053.jpg', 3, '广州市天河区天河中心', 1516601069, 0, 13);
INSERT INTO `pub_repair` VALUES (13, '112799945596778', '红米买', '/Pic/2018-01-23/5a66de4195f8a.jpg', 8, '广州市人民政府办公室', 1516691009, 0, 10);
INSERT INTO `pub_repair` VALUES (14, '112733445596668', '哈哈哈哈', '/Pic/2018-01-23/5a673fd6674c2.png', 1, '广州天河区各回各家', 1516715990, 0, 9);
INSERT INTO `pub_repair` VALUES (15, '111133445596778', '哈哈哈哈哈哈', '/Pic/2018-01-23/5a674f5968702.jpg', 6, '刚回家横杠红花岗哈哈哈哈就', 1516719961, 1, 11);
INSERT INTO `pub_repair` VALUES (16, '999999999999999', '师兄们', '/Pic/2018-01-24/5a6832cb8af06.png', 3, '广州市天河区天河路', 1516778187, 0, 17);
INSERT INTO `pub_repair` VALUES (17, '155753845596778', '你还好吗', '/Pic/2018-01-24/5a683e3b64815.jpg', 8, '怪你走下去抹红我', 1516781115, 0, 4);
INSERT INTO `pub_repair` VALUES (18, '992833445596778', '新秀', '/Pic/2018-01-24/5a6857fb70c39.jpg', 3, '广州市天河区天河区', 1516787707, 0, 13);
INSERT INTO `pub_repair` VALUES (19, '992833445596778', '你密码', '/Pic/2018-01-24/5a6858da5e318.png', 3, '广州市天河区天河', 1516787930, 1, 13);
INSERT INTO `pub_repair` VALUES (20, '112799945596778', '宜信普惠', '/Pic/2018-01-25/5a69344e3411e.jpg', 3, '广州市天河区天黑黑', 1516844110, 0, 10);
INSERT INTO `pub_repair` VALUES (21, '162753445555778', '工作', '/Pic/2018-01-25/5a69540d78e3b.jpg', 3, '广州市天河区天河路', 1516852237, 0, 7);
INSERT INTO `pub_repair` VALUES (22, '252633445596788', '有破损', '/Pic/2018-01-26/5a6a81bb37754.png', 3, '广州市天河区天河路', 1516929467, 1, 19);
INSERT INTO `pub_repair` VALUES (23, '252633445596788', '维修', '/Pic/2018-01-26/5a6ac4f4b1f97.jpg', 3, '广州市天河客运站', 1516946676, 1, 19);
INSERT INTO `pub_repair` VALUES (24, '252633445596788', '西西', '/Pic/2018-01-26/5a6ae138852a5.jpg', 3, '广州市天河客运站', 1516953912, 1, 19);
INSERT INTO `pub_repair` VALUES (25, '252633445596788', '明明', '/Pic/2018-01-27/5a6bd8bea8925.png', 3, '广州市天河客运站', 1517017278, 1, 19);
INSERT INTO `pub_repair` VALUES (26, '252633445596788', '漏水', '/Pic/2018-01-28/5a6d2c076d4b6.png', 3, '广州市天河客运站', 1517104135, 1, 19);
INSERT INTO `pub_repair` VALUES (27, '252633445596788', '问题', '/Pic/2018-01-28/5a6d82481db84.png', 3, '广州市天河区天河客运站', 1517126216, 1, 19);
INSERT INTO `pub_repair` VALUES (28, '252633445596788', '考虑考虑', '/Pic/2018-01-29/5a6e7deea852f.jpg', 3, '广州市天河客运站', 1517190638, 1, 19);
INSERT INTO `pub_repair` VALUES (29, '826733485596976', '工作', '/Pic/2018-01-30/5a6fe2c1ee983.png', 14, '广州市番禺区天河', 1517281985, 1, 24);
INSERT INTO `pub_repair` VALUES (30, '626733445596776', '设备', '/Pic/2018-01-31/5a7135f0f1b6c.jpg', 3, '广州市番禺区天河', 1517368816, 1, 23);
INSERT INTO `pub_repair` VALUES (31, '162753445596778', '和弦', '/Pic/2018-02-01/5a7287af3adda.jpg', 3, '广州市番禺区钟村', 1517455279, 0, 3);
INSERT INTO `pub_repair` VALUES (32, '162753445596778', '保修', '/Pic/2018-02-02/5a7402a441e37.jpg', 3, '广州市番禺区钟村街道办事处', 1517552292, 0, 3);
INSERT INTO `pub_repair` VALUES (33, '111133445596778', '命苦逼进不去', '/Pic/2018-02-05/5a785650dc079.jpg', 14, '广州市天河区元岗', 1517835856, 1, 11);
INSERT INTO `pub_repair` VALUES (34, '992833445596778', '来来来', '/Pic/2018-03-06/5a9e35f9c76b7.png', 3, '广州市番禺区钟村街道办事处', 1520317945, 1, 13);
INSERT INTO `pub_repair` VALUES (35, '992833445596778', '看看', '/Pic/2018-03-06/5a9e36ca25df5.jpg', 3, '广州市番禺区钟村街道办事处', 1520318154, 1, 13);
INSERT INTO `pub_repair` VALUES (36, '868575025674179', '哦让你周末', '/Pic/2018-03-06/5a9e6cf15bc4c.jpg', 2, '送哦破哦搜狗共魔幻', 1520332017, 1, 46);
INSERT INTO `pub_repair` VALUES (37, '868575025674179', '滤芯更换', '/Pic/2018-03-08/5aa10f99dace2.jpg', 2, '广东番禺区钟村镇', 1520504729, 1, 46);

-- ----------------------------
-- Table structure for pub_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_setmeal`;
CREATE TABLE `pub_setmeal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL COMMENT '产品类型ID',
  `remodel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '充值模式(0：流量1：时长)',
  `money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '套餐金额',
  `flow` int(11) NOT NULL COMMENT '套餐流量/时长',
  `describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '套餐描述',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_setmeal
-- ----------------------------
INSERT INTO `pub_setmeal` VALUES (22, 1, 0, 15000.00, 15, '150元15天', 1517282134);
INSERT INTO `pub_setmeal` VALUES (21, 1, 0, 10000.00, 10, '100元10天', 1517282107);
INSERT INTO `pub_setmeal` VALUES (32, 8, 0, 1.00, 365, '360元一年', 1520332202);
INSERT INTO `pub_setmeal` VALUES (33, 8, 0, 1.00, 300, '100元300天', 1520507877);
INSERT INTO `pub_setmeal` VALUES (8, 2, 1, 10000.00, 100, '100元100时长', 1516600885);
INSERT INTO `pub_setmeal` VALUES (29, 1, 0, 10000.00, 10, '100元10天', 1517291574);
INSERT INTO `pub_setmeal` VALUES (10, 2, 1, 30000.00, 300, '300元300时长', 1516605554);
INSERT INTO `pub_setmeal` VALUES (26, 2, 0, 20000.00, 20, '200元20天', 1517291491);
INSERT INTO `pub_setmeal` VALUES (25, 2, 0, 10000.00, 10, '100元10天', 1517291473);
INSERT INTO `pub_setmeal` VALUES (20, 1, 1, 40000.00, 200, '400元200天', 1517107862);
INSERT INTO `pub_setmeal` VALUES (31, 8, 0, 1.00, 100, '100元100天', 1520331683);
INSERT INTO `pub_setmeal` VALUES (17, 5, 1, 10000.00, 100, '100元100天', 1516852012);

-- ----------------------------
-- Table structure for pub_users
-- ----------------------------
DROP TABLE IF EXISTS `pub_users`;
CREATE TABLE `pub_users`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '用户状态',
  `login_time` int(11) NULL DEFAULT NULL COMMENT '最后登陆的时间',
  `login_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登陆的IP地址',
  `created_at` int(11) NOT NULL COMMENT '添加时间',
  `balance` int(10) NOT NULL DEFAULT 0 COMMENT '账户余额',
  `open_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联微信信息表',
  `did` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_users
-- ----------------------------
INSERT INTO `pub_users` VALUES (1, 1, 1516356004, '140.207.54.75', 1516356004, 0, 'oXwY4tw2AtbFpWEKrqz0Wel1MlAE', NULL);
INSERT INTO `pub_users` VALUES (2, 1, 1516356087, '140.207.54.80', 1516356087, 0, 'oXwY4t4JixLg4UJZdBDy7dCO4J6I', NULL);
INSERT INTO `pub_users` VALUES (3, 1, 1516356094, '140.207.54.76', 1516356094, 0, 'oXwY4t_vkTgtlD0CBTZ-vTbIMWHs', NULL);
INSERT INTO `pub_users` VALUES (4, 1, 1516356320, '140.207.54.80', 1516356320, 0, 'oXwY4txgG73v0tgcK57JWiR8SPys', NULL);
INSERT INTO `pub_users` VALUES (5, 1, 1516358226, '140.207.54.75', 1516358226, 0, 'oXwY4t0wVQtFC9IoS_R_t8LwvvTQ', NULL);
INSERT INTO `pub_users` VALUES (6, 1, 1516376316, '140.207.54.80', 1516376316, 0, 'oXwY4t6w6M5cPnSXL79sy352Tgzs', NULL);
INSERT INTO `pub_users` VALUES (7, 1, 1516377098, '140.207.54.75', 1516377098, 0, 'oXwY4txlP9OKwEDbVUMvUXP_7FhA', NULL);
INSERT INTO `pub_users` VALUES (8, 1, 1516411041, '140.207.54.76', 1516411041, 0, 'oXwY4t7hYDxtr2sMqqEa5ZVJpinU', NULL);
INSERT INTO `pub_users` VALUES (9, 1, 1516697631, '140.207.54.80', 1516697631, 0, 'oXwY4t7-xOzRDP0znhWAa1AzHOKk', NULL);
INSERT INTO `pub_users` VALUES (10, 0, 1516719128, '140.207.54.76', 1516719128, 0, 'oXwY4tzmil2SItRr5-x3Fo6Wl5Cw', NULL);
INSERT INTO `pub_users` VALUES (11, 1, 1516761563, '140.207.54.75', 1516761563, 0, 'oXwY4t-9clttAFWXjCcNRJrvch3w', NULL);
INSERT INTO `pub_users` VALUES (12, 1, 1516781295, '140.207.54.76', 1516781295, 0, 'oXwY4t5lI2g02V14O0bBLmY8o9fk', NULL);
INSERT INTO `pub_users` VALUES (13, 1, 1516794610, '140.207.54.75', 1516794610, 0, 'oXwY4t3-thjj7uXdFx60x8Df-ECY', NULL);
INSERT INTO `pub_users` VALUES (14, 1, 1516847168, '140.207.54.79', 1516847168, 0, 'oXwY4t1qkexB2gLIT7kcg3zxxLQQ', NULL);
INSERT INTO `pub_users` VALUES (15, 0, 1516889902, '140.207.54.79', 1516889902, 0, 'oXwY4t1Sr0YkozJkQyS76l6YJDFc', NULL);
INSERT INTO `pub_users` VALUES (16, 0, 1517038027, '140.207.54.76', 1517038027, 0, 'oXwY4tzyOldxr2th5CvZbgQprKhc', NULL);
INSERT INTO `pub_users` VALUES (17, 1, 1517204527, '140.207.54.75', 1517204527, 0, 'oXwY4t0eIEwtKnBupyTlpcziZ9m0', NULL);
INSERT INTO `pub_users` VALUES (18, 1, 1517996559, '140.207.54.80', 1517996559, 0, 'oXwY4t3KFaSzLYE0etGBVlgCZBDU', NULL);
INSERT INTO `pub_users` VALUES (19, 1, 1518622307, '140.207.54.76', 1518622307, 0, 'oXwY4t7EPctQgAVk5pMjBfbvcZso', NULL);
INSERT INTO `pub_users` VALUES (20, 0, 1519389172, '140.207.54.76', 1519389172, 0, 'oXwY4t1bzcGeeXf_tZ7Ziq7jMHuw', NULL);
INSERT INTO `pub_users` VALUES (21, 1, 1519812588, '140.207.54.76', 1519812588, 0, 'oXwY4t0KCz3j7KoLN_RdGRZHI-uQ', NULL);
INSERT INTO `pub_users` VALUES (22, 1, 1519828966, '140.207.54.76', 1519828966, 0, 'oXwY4t9YeHs6BJFojxpPXYQn14Sk', NULL);
INSERT INTO `pub_users` VALUES (23, 1, 1519893944, '140.207.54.79', 1519893944, 0, 'oXwY4twIlF-XCCt-3BEwHFhcO6VY', NULL);
INSERT INTO `pub_users` VALUES (24, 1, 1520040003, '140.207.54.80', 1520040003, 0, 'oXwY4t6VYh_rIoc5qtiWmgNr4R2A', NULL);
INSERT INTO `pub_users` VALUES (25, 1, 1520253932, '140.207.54.76', 1520253932, 0, 'oXwY4t-UGjIe4E6fyf6lgQ_NdVOY', NULL);
INSERT INTO `pub_users` VALUES (26, 1, 1520324384, '140.207.54.76', 1520324384, 0, 'oXwY4t0vVyiPTM7KERC6ky-Kh0WU', NULL);
INSERT INTO `pub_users` VALUES (27, 1, 1520580436, '140.207.54.79', 1520580436, 0, 'oXwY4txu3ufeaRA_E0iwAXiBhq9w', NULL);
INSERT INTO `pub_users` VALUES (28, 1, 1520619355, '140.207.54.80', 1520619355, 0, 'oXwY4tx091GnZFbD1eG8WQmZr2FU', NULL);
INSERT INTO `pub_users` VALUES (29, 1, 1520651722, '140.207.54.79', 1520651722, 0, 'oXwY4twW5zB_V68mRVIrrjZ0CzNU', NULL);
INSERT INTO `pub_users` VALUES (30, 1, 1520669610, '140.207.54.76', 1520669610, 0, 'oXwY4tw6-PiKFzcFzf3q-CsYWl8Q', NULL);
INSERT INTO `pub_users` VALUES (31, 1, 1520733754, '140.207.54.76', 1520733754, 0, 'oXwY4t1UWsgSxXS1iRfhWatDBU-Y', NULL);

-- ----------------------------
-- Table structure for pub_vendors
-- ----------------------------
DROP TABLE IF EXISTS `pub_vendors`;
CREATE TABLE `pub_vendors`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供销商登陆的用户名',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供销商的名字',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供销商登陆的密码',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供销商手机号码',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供销商邮箱',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供销商地址',
  `leavel` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '供销商级别：默认为“1”级',
  `pid` int(11) NOT NULL DEFAULT 1 COMMENT '经销商上级ID',
  `addtime` int(11) NOT NULL COMMENT '创建时间',
  `idcard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user`(`user`, `name`, `password`, `email`, `phone`, `leavel`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_vendors
-- ----------------------------
INSERT INTO `pub_vendors` VALUES (1, 'admin', '超级管理员', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '重庆市 重庆市 南岸区', 0, 0, 1515831917, '430122199610224517');
INSERT INTO `pub_vendors` VALUES (47, '夏夏', '夏夏', 'e10adc3949ba59abbe56e057f20f883e', '18902589652', '2589526@qq.com', '山东省 日照市 莒县', 1, 1, 1516589658, '412512199806082563');
INSERT INTO `pub_vendors` VALUES (48, '阳光', '阳光', 'e10adc3949ba59abbe56e057f20f883e', '14832653985', '269854@163.com', '黑龙江省 齐齐哈尔市 梅里斯达斡尔族区', 2, 1, 1516764017, '421589199806081256');
INSERT INTO `pub_vendors` VALUES (50, '嘻嘻', '嘻嘻', 'e10adc3949ba59abbe56e057f20f883e', '13526589652', '986521@163.com', '山西省 阳泉市 冠山镇', 1, 1, 1517281907, '412589199602252501');
INSERT INTO `pub_vendors` VALUES (51, '小妮', '妮妮', 'e10adc3949ba59abbe56e057f20f883e', '14698620236', '2598622@qq.com', '浙江省 衢州市 龙游县', 1, 1, 1517283863, '425132199802054265');
INSERT INTO `pub_vendors` VALUES (52, '林夕', '夕夕', 'e10adc3949ba59abbe56e057f20f883e', '14365892301', '2598@126.com', '内蒙古 巴彦淖尔市 巴音宝力格镇', 1, 1, 1517370343, '421589198902054202');
INSERT INTO `pub_vendors` VALUES (53, '袁效益', '小雨', 'e10adc3949ba59abbe56e057f20f883e', '13859862032', '2589522@QQ.COM', '吉林省 吉林市 磐石市', 1, 1, 1517456258, '452162185409014257');
INSERT INTO `pub_vendors` VALUES (54, '123', '一级', '202cb962ac59075b964b07152d234b70', '18002229021', '362112677@qq.com', '湖北省 荆州市 监利县', 1, 1, 1520507640, '130183198802240439');

-- ----------------------------
-- Table structure for pub_wechat
-- ----------------------------
DROP TABLE IF EXISTS `pub_wechat`;
CREATE TABLE `pub_wechat`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `open_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信的ID号',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信昵称',
  `head` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `sex` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '性别',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`open_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_wechat
-- ----------------------------
INSERT INTO `pub_wechat` VALUES (1, 'oXwY4tw2AtbFpWEKrqz0Wel1MlAE', '潘潘', 'http://wx.qlogo.cn/mmopen/SnnOkFO2wxibu64aqLPdicasbg0E1EIA5uk6TLhy2ecgQMvQqxmUcTibx7uRLoAsjPibzxLFICE3LiaU0HibWkLPb8j1NvtlttMT3L/132', 1, '湖南', '中国 湖南 长沙');
INSERT INTO `pub_wechat` VALUES (2, 'oXwY4t4JixLg4UJZdBDy7dCO4J6I', '彭龙召', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM5ExmoPWa7RV7sZC4GRYWImrD6swvyUSZ4sO7sFIoPKHib2zKOF9w540EibdBicticXgszr8VaXicf4vjg/132', 1, '河北', '中国 河北 石家庄');
INSERT INTO `pub_wechat` VALUES (3, 'oXwY4t_vkTgtlD0CBTZ-vTbIMWHs', '快乐翱翔', 'http://wx.qlogo.cn/mmopen/SnnOkFO2wxicJ3kkvXosHGKia14CzVTb51HMKXvx5blEQiaU9dXPPEib2S1iaFbztPia21t0hO1VQrf5Upsd3NoMC28SudibxQ2OBDib/132', 2, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (4, 'oXwY4txgG73v0tgcK57JWiR8SPys', '张华斌', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8ryk5BKvoJHzTib6nIb90MyPyGpRaUYNceTfB2DkNNzQFy473s8xIibrsyb7F7Wo7XOYhiaticHh8YeEibkdS8iaPt7Wp/132', 1, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (5, 'oXwY4t0wVQtFC9IoS_R_t8LwvvTQ', '小夏', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8pLIWzrabOoTvRUPG8dicKCD4sQbq3urZMp1NprIPGlsDwBjjiaIL2XjgsWZP4cYcicnRmbsMvlib3yaibHSGoKfUg1ia/132', 1, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (6, 'oXwY4t6w6M5cPnSXL79sy352Tgzs', '苏格拉没有底', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3ShK2dPsMiaYq4iaI11cMbGnoua5ptJYaF2wA74pX0QJfLJSkESLsSBpRRy0stHHIJHKqjkZMAN8AmjUeLj4DPfHF/132', 1, '', '安道尔  ');
INSERT INTO `pub_wechat` VALUES (7, 'oXwY4txlP9OKwEDbVUMvUXP_7FhA', '平常心', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8oShMxicsKArK4niaI3MNaEadB4LgUBia2JTSoiaj0f4ltR7rtaiaicjjwZpndY7myx7ufpzJGasRTKE2fTuq5vd3JMvu/132', 1, '广西', '中国 广西 桂林');
INSERT INTO `pub_wechat` VALUES (8, 'oXwY4t7hYDxtr2sMqqEa5ZVJpinU', 'Trc', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM4WO74R7tVYoTaXRH1CV3HV9F9IJ0AH8BNpt1dTM0ShmxKqRIs6vTjWUDJEeePA9xJHibE7uiaXf7d8XcmMmyEiaK3CPNYwOxUwfg/132', 2, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (9, 'oXwY4t7-xOzRDP0znhWAa1AzHOKk', 'V。', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8oDDLqwZLYABfAUGH7hmVM5hKsMG0utGoOSHYEibnH2HeX5ZDr2f1roORRHk6sdruPQNy4uGvibxdhta3omLTKsz5/132', 2, '', '安道尔  ');
INSERT INTO `pub_wechat` VALUES (10, 'oXwY4tzmil2SItRr5-x3Fo6Wl5Cw', '在⻊各上', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3THIBouQJgTKJUScsbhFo3nib4dNY8cgDXtZGnMl6YibbiasgHxibevWIm2lXqQ9Mx6j6Z3X5XKn0XD6K6PIVEiazZ7F/132', 1, '广东', '中国 广东 汕尾');
INSERT INTO `pub_wechat` VALUES (11, 'oXwY4t-9clttAFWXjCcNRJrvch3w', '吴智彬-13425492760', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM7c8mccHD5GtggHBFV4Jl1DTWFpyn7X4MWUibDdYGxicJyIQM2XRZZsiaLaia3ucQBhpAqpdqUrdjyCbTP58dxfpWoWUdqZN8et5A0/132', 1, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (12, 'oXwY4t5lI2g02V14O0bBLmY8o9fk', '点球-张显荣18202099099', 'http://wx.qlogo.cn/mmopen/puial0wTAiaTpic6UicP1IAnhsvdYd4rjb52ibx8Pv02m5MWaCccibib8u0NOdFYejL11ehq5f6iaNrUeza84pjeacYcUuWEicQF93rcX/132', 1, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (13, 'oXwY4t3-thjj7uXdFx60x8Df-ECY', '欧普诺净水总部赵先生 13418506119', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM4hkWIBEiaQJJKUiczZ26dyO8rtcIO6btY5ia8MD8ulA1tJibM2ILqsIWI3tDkT4aRazlZrYiaPutvIR3Eib09xtcMiaWoCj6dHGGLArg/132', 1, '广东', '中国 广东 深圳');
INSERT INTO `pub_wechat` VALUES (14, 'oXwY4t1qkexB2gLIT7kcg3zxxLQQ', '。。', '', 1, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (15, 'oXwY4t1Sr0YkozJkQyS76l6YJDFc', '星魂大人', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8pYTiaSkWxnN8qYWBqaYpmUHImyLDN1a4PfEopCahyesJPeib3Bs1H57tMIKr6G3Q5zQs6HIzq4ibAw4xQBzesRia2G/132', 1, '', '安道尔  ');
INSERT INTO `pub_wechat` VALUES (16, 'oXwY4tzyOldxr2th5CvZbgQprKhc', 'Gwynn', 'http://wx.qlogo.cn/mmopen/ajNVdqHZLLCUiaYFKdta5nI2qSv3R3oS5MmT5iaVB5p3m6hJE9dWbCA4OegEeG7R2D2H4sibeZXrGYDB1j9qkibSWA/132', 1, '广东', '中国 广东 汕头');
INSERT INTO `pub_wechat` VALUES (17, 'oXwY4t0eIEwtKnBupyTlpcziZ9m0', '广顺电器', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8roRNQT3vAkXmVHkVLrw6AONO0LRVqRrmfGQMmW8RXApsMic0VH2TpfN8tdjzqgaQQCtlP3yg9yiasz8pv8QXbK3F/132', 1, '福建', '中国 福建 漳州');
INSERT INTO `pub_wechat` VALUES (18, 'oXwY4t3KFaSzLYE0etGBVlgCZBDU', 'Keen frost(鹏)', 'http://wx.qlogo.cn/mmopen/PiajxSqBRaELnKzuHtPnV50tp8ibCPQwUwg2tbNYknQJlYicgTYcPbzszuLvkF0LL0oklhKs7wzzZxaJlTx1P67Rg/132', 1, '甘肃', '中国 甘肃 平凉');
INSERT INTO `pub_wechat` VALUES (19, 'oXwY4t7EPctQgAVk5pMjBfbvcZso', 'Huazai', 'http://thirdwx.qlogo.cn/mmopen/Q3auHgzwzM6fWthnsrt8adUoiaZUGosVXDmSqTY0O7rtbQIqicNpDUJ3Vk4oepf3ZL4teN4iaSicHdUw7TYzmVZufgp1DSCoXhBDATG47iaSQpYU/132', 1, '重庆', '中国 重庆 彭水');
INSERT INTO `pub_wechat` VALUES (20, 'oXwY4t1bzcGeeXf_tZ7Ziq7jMHuw', '天道酬勤', 'http://thirdwx.qlogo.cn/mmopen/SnnOkFO2wxicUU18iczVfONK3z4mHoH0y3OK4z83OK2YCHU7uUZt1bQGE7YoXtt4D0gwqiac8QvIbeJhpcPVbebNbPmanZ9Vx4D/132', 1, '内蒙古', '中国 内蒙古 通辽');
INSERT INTO `pub_wechat` VALUES (21, 'oXwY4t0KCz3j7KoLN_RdGRZHI-uQ', '点球电子人力资源', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaEJibNbgWnMSiazpRcLXib2qe1C6FXS817ico2ycI9gsCVPX6TjsCe5PPeB0JyPlTEy8osJZUJPmPppUgA/132', 2, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (22, 'oXwY4t9YeHs6BJFojxpPXYQn14Sk', '金子总能发光', 'http://thirdwx.qlogo.cn/mmopen/c33WYHOwu8roRNQT3vAkXt92UojOhRXiclQIPYHfEiaRMdcDVPoQFtOX38aib4j6wVr8dFibPHtxDM6BCmsE3Elh8fyIBa3CoSZ2/132', 1, '云南', '中国 云南 昆明');
INSERT INTO `pub_wechat` VALUES (23, 'oXwY4twIlF-XCCt-3BEwHFhcO6VY', '人生如戏', '', 1, '江苏', '中国 江苏 泰州');
INSERT INTO `pub_wechat` VALUES (24, 'oXwY4t6VYh_rIoc5qtiWmgNr4R2A', '605507', '', 0, '北京', '中国 北京 海淀');
INSERT INTO `pub_wechat` VALUES (25, 'oXwY4t-UGjIe4E6fyf6lgQ_NdVOY', '花香独秀', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaEJcgFyufezFVDKheZHZgqvQztiaRVroDLfjQZrReApDYiaU0qSGSxCcHVMeCticoHZHq08f2jicLq7gqg/132', 1, '福建', '中国 福建 泉州');
INSERT INTO `pub_wechat` VALUES (26, 'oXwY4t0vVyiPTM7KERC6ky-Kh0WU', '羽', 'http://thirdwx.qlogo.cn/mmopen/SnnOkFO2wxibjyvI97EuI9oHDicrFTzictSKvmnDhTczamjHzPuHcGaxRRbC1ROoVUNpjfyKSs8iamBSRsStgrYqoAHqLVgTXQtA/132', 1, '广东', '中国 广东 茂名');
INSERT INTO `pub_wechat` VALUES (27, 'oXwY4txu3ufeaRA_E0iwAXiBhq9w', 'W', 'http://thirdwx.qlogo.cn/mmopen/c33WYHOwu8r9V5PDBVqAM4iaxoyQCHTK3HJdJKys0ukk8LvjHdPfIPjeR2F1EZhnibYoOhB3iaOg4wia9X9MibxMQZLZM3xgOyoOs/132', 1, '布林迪西', '意大利 布林迪西 ');
INSERT INTO `pub_wechat` VALUES (28, 'oXwY4tx091GnZFbD1eG8WQmZr2FU', '晓鸿', 'http://thirdwx.qlogo.cn/mmopen/c33WYHOwu8oDDLqwZLYABaRoRWia9WWgLeK9ZmumRKeecyLuhwibIic0m2NgavYoCteahB0ibfQudsVlAZFWookwZfjvJ2ib9TT2H/132', 1, '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES (29, 'oXwY4twW5zB_V68mRVIrrjZ0CzNU', '芯智云苹果测试机', 'http://thirdwx.qlogo.cn/mmopen/RI3jqFXCxlXoY3posWNVK80ND9VhwJ0BNo7r6xY8GuSdh6Gu2c9pMRpzHhuA7tV97C7ayKuJajuVG7GJXeAZ1q4EreI0ic398/132', 0, '', '  ');
INSERT INTO `pub_wechat` VALUES (30, 'oXwY4tw6-PiKFzcFzf3q-CsYWl8Q', 'Maxonor', 'http://thirdwx.qlogo.cn/mmopen/lbk4D8nFV3R5ah6UicUH37oXkN4O4ueMBr7IZyvzTX70cJGYLU2AryZIiaET1BOMd9yXJUeAfw9SGWjeMt18cxtobVzjzMGJgA/132', 1, '湖南', '中国 湖南 常德');
INSERT INTO `pub_wechat` VALUES (31, 'oXwY4t1UWsgSxXS1iRfhWatDBU-Y', '懒蚕', 'http://thirdwx.qlogo.cn/mmopen/c33WYHOwu8rPiaNxdZvULhI8Str1iaKDIZDqC1p2dGibj4bUIAtaalgDjJEfHQVOnS0GpWujM63Qh3pTCMrTXgePjKl5PFalqdL/132', 1, '江西', '中国 江西 南昌');

-- ----------------------------
-- Table structure for pub_work
-- ----------------------------
DROP TABLE IF EXISTS `pub_work`;
CREATE TABLE `pub_work`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单编号',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处理人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处理人电话',
  `type` tinyint(1) NOT NULL COMMENT '工单类型(0：安装 1：维修 2：维护)',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '维护内容',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `result` tinyint(1) NOT NULL COMMENT '处理结果(0：未处理 1：正在处理 2：已处理)',
  `time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pub_work
-- ----------------------------
INSERT INTO `pub_work` VALUES (1, 'gb0012', '刘小姐', '18920365896', 0, '明天安装', '河北省 张家口市 下花园区', 2, '2018-01-20');
INSERT INTO `pub_work` VALUES (2, 'gb002', '何小姐', '13269865986', 0, '安装', '内蒙古 乌海市 海南区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (3, 'gb003', '袁小姐', '13589562330', 1, '维修', '天津市 天津市 河东区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (4, 'gb004', '小鱼', '13368954581', 0, '安装', '北京市 北京市 崇文区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (5, 'gb05', '王小姐', '13589562021', 0, '安装', '内蒙古 乌海市 乌达区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (6, 'gb006', '小心', '13598653265', 1, '维修', '黑龙江省 鸡西市 鸡东镇', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (7, 'gb006', '小仙', '13598657845', 2, '维护', '天津市 天津市 南开区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (8, 'gb007', '晓琳', '13896530215', 1, '维修', '西藏 日喀则地区 南木林县', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (9, 'gb007', '小秦', '18902563215', 2, '维护', '内蒙古 呼和浩特市 回民区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (10, 'gb008', '小圆', '13598620036', 2, '维护', '上海市 上海市 静安区', 2, '2018-01-22');
INSERT INTO `pub_work` VALUES (11, 'K0012', '雨雨', '13680803306', 0, '安装', '上海市 上海市 长宁区', 2, '2018-01-24');
INSERT INTO `pub_work` VALUES (12, '0125212', '小小', '14725896235', 0, '**&amp;  **8* ', '上海市 上海市 崇明县', 0, '2018-01-31');
INSERT INTO `pub_work` VALUES (13, '25621320002', '小琴', '15898560235', 0, '安装', '山西省 长治市 定昌镇', 0, '2018-02-01');
INSERT INTO `pub_work` VALUES (14, 'gb758', '何师傅', '18900230230', 0, '安装', '辽宁省 沈阳市 和平区', 1, '2018-03-06');
INSERT INTO `pub_work` VALUES (15, '123124432', '彭龙召', '18002229021', 0, 'wekflnlkndg', '山东省 菏泽市 城关镇', 2, '2018-03-07');

SET FOREIGN_KEY_CHECKS = 1;

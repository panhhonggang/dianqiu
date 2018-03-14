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

 Date: 12/03/2018 09:28:10
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

SET FOREIGN_KEY_CHECKS = 1;

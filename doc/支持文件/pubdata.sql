/*
Navicat MySQL Data Transfer

Source Server         : 120.27.12.1
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2018-01-12 11:47:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pub_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `pub_admin_menu`;
CREATE TABLE `pub_admin_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单表',
  `pid` int(11) unsigned DEFAULT '0' COMMENT '所属菜单',
  `name` varchar(15) DEFAULT '' COMMENT '菜单名称',
  `mca` varchar(255) DEFAULT '' COMMENT '模块、控制器、方法',
  `ico` varchar(20) DEFAULT '' COMMENT 'font-awesome图标',
  `order_number` int(11) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_admin_menu
-- ----------------------------
INSERT INTO `pub_admin_menu` VALUES ('43', '0', '设备管理', 'Admin/Devices', '', '2');
INSERT INTO `pub_admin_menu` VALUES ('44', '43', '设备列表', 'Admin/Devices/devicesList', '', '2');
INSERT INTO `pub_admin_menu` VALUES ('46', '0', '建议及报修', 'Admin/Feeds', '', '3');
INSERT INTO `pub_admin_menu` VALUES ('47', '46', '建议列表', 'Admin/Feeds/feedslist', '', null);
INSERT INTO `pub_admin_menu` VALUES ('48', '46', '报修列表', 'Admin/Feeds/repairlist', '', null);
INSERT INTO `pub_admin_menu` VALUES ('49', '0', '后台管理', 'Admin/Vendors', '', '2');
INSERT INTO `pub_admin_menu` VALUES ('50', '49', '经销商添加', 'Admin/Vendors/add', '', null);
INSERT INTO `pub_admin_menu` VALUES ('54', '49', '经销商列表', 'Admin/Vendors/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('52', '49', '设备归属', 'Admin/Vendors/devices_add', '', null);
INSERT INTO `pub_admin_menu` VALUES ('53', '49', '设备归属列表', 'Admin/Vendors/bindinglist', '', null);
INSERT INTO `pub_admin_menu` VALUES ('55', '0', '产品管理', 'Admin/Product', '', '4');
INSERT INTO `pub_admin_menu` VALUES ('56', '55', '滤芯设置', 'Admin/Product/filter_add', '', null);
INSERT INTO `pub_admin_menu` VALUES ('57', '55', '滤芯列表', 'Admin/Product/filterlist', '', null);
INSERT INTO `pub_admin_menu` VALUES ('58', '55', '产品类型设置', 'Admin/Product/add', '', null);
INSERT INTO `pub_admin_menu` VALUES ('59', '55', '产品类型列表', 'Admin/Product/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('60', '43', '设备添加', 'Admin/Devices/show_add_device', '', '1');
INSERT INTO `pub_admin_menu` VALUES ('61', '0', '订单管理', 'Admin/Orders', '', '5');
INSERT INTO `pub_admin_menu` VALUES ('62', '61', '订单列表', 'Admin/Orders/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('63', '0', '工单管理', 'Admin/Work', '', '6');
INSERT INTO `pub_admin_menu` VALUES ('64', '63', '工单添加', 'Admin/Work/add', '', null);
INSERT INTO `pub_admin_menu` VALUES ('65', '63', '工单列表', 'Admin/Work/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('66', '0', '用户管理', 'Admin/Users', '', '7');
INSERT INTO `pub_admin_menu` VALUES ('67', '66', '用户列表', 'Admin/Users/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('68', '66', '充值记录', 'Admin/Users/flow', '', null);
INSERT INTO `pub_admin_menu` VALUES ('69', '66', '消费记录', 'Admin/Users/consume', '', null);
INSERT INTO `pub_admin_menu` VALUES ('70', '0', '权限管理', 'Admin/Rule', '', '8');
INSERT INTO `pub_admin_menu` VALUES ('71', '70', '权限组', 'Admin/Rule/group', '', null);
INSERT INTO `pub_admin_menu` VALUES ('72', '70', '权限列表', 'Admin/Rule/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('74', '0', '首页', 'Admin/Test/welcome', '', '1');
INSERT INTO `pub_admin_menu` VALUES ('75', '0', '菜单管理', 'Admin/Menu', '', null);
INSERT INTO `pub_admin_menu` VALUES ('76', '75', '菜单编辑', 'Admin/Menu/index', '', null);
INSERT INTO `pub_admin_menu` VALUES ('77', '0', '套餐管理', 'Admin/Setmeal', '9', null);
INSERT INTO `pub_admin_menu` VALUES ('78', '77', '套餐设置', 'Admin/Setmeal/add', '', null);
INSERT INTO `pub_admin_menu` VALUES ('79', '77', '套餐列表', 'Admin/Setmeal/index', '', null);

-- ----------------------------
-- Table structure for pub_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `pub_auth_group`;
CREATE TABLE `pub_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text COMMENT '规则id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of pub_auth_group
-- ----------------------------
INSERT INTO `pub_auth_group` VALUES ('1', ' 超级管理员', '1', '3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37');
INSERT INTO `pub_auth_group` VALUES ('2', ' 普通管理员', '1', '1,2,38,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37');

-- ----------------------------
-- Table structure for pub_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `pub_auth_group_access`;
CREATE TABLE `pub_auth_group_access` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `group_id` int(11) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

-- ----------------------------
-- Records of pub_auth_group_access
-- ----------------------------
INSERT INTO `pub_auth_group_access` VALUES ('5', '2');
INSERT INTO `pub_auth_group_access` VALUES ('9', '2');
INSERT INTO `pub_auth_group_access` VALUES ('12', '2');
INSERT INTO `pub_auth_group_access` VALUES ('16', '2');

-- ----------------------------
-- Table structure for pub_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `pub_auth_rule`;
CREATE TABLE `pub_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of pub_auth_rule
-- ----------------------------
INSERT INTO `pub_auth_rule` VALUES ('1', '0', 'Admin/Index', '后台首页', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('2', '1', 'Admin/Index/index', '欢迎页面', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('3', '0', 'Admin/Vendors', '后台管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('4', '3', 'Admin/Vendors/add', '添加经销商', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('5', '3', 'Admin/Vendors/index', '经销商列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('6', '3', 'Admin/Vendors/devices_add', '设备归属', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('7', '3', 'Admin/Vendors/bindinglist', '设备归属列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('8', '0', 'Admin/Product', '产品管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('9', '8', 'Admin/Product/filter_add', '滤芯设置', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('10', '8', 'Admin/Product/filterlist', '滤芯列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('11', '8', 'Admin/Product/add', '产品类型设置', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('12', '8', 'Admin/Product/index', '产品类型列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('13', '0', 'Admin/Devices', '设备管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('18', '0', 'Admin/Orders', '订单管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('15', '13', 'Admin/Devices/devicesList', '设备列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('16', '13', 'Admin/Devices/show_add_device', '设备添加', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('19', '18', 'Admin/Orders/index', '订单列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('20', '0', 'Admin/Work', '工单管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('21', '20', 'Admin/Work/add', '工单添加', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('22', '20', 'Admin/Work/index', '工单列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('23', '0', 'Admin/Users', '用户管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('24', '23', 'Admin/Users/index', '用户列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('25', '23', 'Admin/Users/flow', '充值记录', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('26', '23', 'Admin/Users/consume', '消费记录', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('27', '0', 'Admin/Rule', '权限管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('28', '27', 'Admin/Rule/group', '权限组', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('29', '27', 'Admin/Rule/index', '权限列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('30', '0', 'Admin/Menu', '菜单管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('31', '30', 'Admin/Menu/index', '菜单编辑', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('32', '0', 'Admin/Setmeal', '套餐管理', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('33', '32', 'Admin/Setmeal/add', '套餐设置', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('34', '32', 'Admin/Setmeal/index', '套餐列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('35', '0', 'Admin/Feeds', '建议及报修', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('36', '35', 'Admin/Feeds/feedslist', '建议列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('37', '35', 'Admin/Feeds/repairlist', '报修列表', '1', '1', '');
INSERT INTO `pub_auth_rule` VALUES ('38', '1', 'Admin/Vendors/password', '修改密码', '1', '1', '');

-- ----------------------------
-- Table structure for pub_binding
-- ----------------------------
DROP TABLE IF EXISTS `pub_binding`;
CREATE TABLE `pub_binding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` int(11) NOT NULL COMMENT '经销商ID',
  `did` int(11) NOT NULL COMMENT '设备ID',
  `operator` varchar(255) NOT NULL COMMENT '操作人是谁',
  `addtime` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_binding
-- ----------------------------
INSERT INTO `pub_binding` VALUES ('21', '11', '6', '炒鸡管理员', '1515582133');
INSERT INTO `pub_binding` VALUES ('16', '9', '7', '炒鸡管理员', '1515551319');
INSERT INTO `pub_binding` VALUES ('17', '11', '8', '炒鸡管理员', '1515551330');
INSERT INTO `pub_binding` VALUES ('18', '11', '9', '炒鸡管理员', '1515551341');
INSERT INTO `pub_binding` VALUES ('23', '12', '41', '炒鸡管理员', '1515654422');
INSERT INTO `pub_binding` VALUES ('22', '9', '39', '炒鸡管理员', '1515582285');
INSERT INTO `pub_binding` VALUES ('24', '16', '40', '炒鸡管理员', '1515660485');
INSERT INTO `pub_binding` VALUES ('26', '1', '43', '炒鸡管理员', '1515660676');
INSERT INTO `pub_binding` VALUES ('27', '16', '44', '炒鸡管理员', '1515660683');
INSERT INTO `pub_binding` VALUES ('29', '15', '45', '炒鸡管理员', '1515660819');
INSERT INTO `pub_binding` VALUES ('30', '16', '46', '炒鸡管理员', '1515667639');
INSERT INTO `pub_binding` VALUES ('34', '16', '49', '炒鸡管理员', '1515723167');
INSERT INTO `pub_binding` VALUES ('35', '16', '50', '炒鸡管理员', '1515724171');

-- ----------------------------
-- Table structure for pub_cart_filters
-- ----------------------------
DROP TABLE IF EXISTS `pub_cart_filters`;
CREATE TABLE `pub_cart_filters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `fid` int(11) unsigned NOT NULL COMMENT '滤芯ID',
  `num` int(11) unsigned NOT NULL COMMENT '购物数量',
  `create_time` int(11) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=151 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_filters
-- ----------------------------
INSERT INTO `pub_cart_filters` VALUES ('146', '8', '6', '1', '1515724401', null);
INSERT INTO `pub_cart_filters` VALUES ('145', '5', '6', '5', '1515724257', '1515726536');

-- ----------------------------
-- Table structure for pub_cart_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_cart_setmeal`;
CREATE TABLE `pub_cart_setmeal` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `sid` int(11) unsigned NOT NULL COMMENT '套餐ID',
  `num` int(11) unsigned NOT NULL COMMENT '购物数量',
  `create_time` int(11) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=527 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_setmeal
-- ----------------------------
INSERT INTO `pub_cart_setmeal` VALUES ('444', '6', '8', '1', '1515582464', null);
INSERT INTO `pub_cart_setmeal` VALUES ('452', '11', '5', '1', '1515656849', null);
INSERT INTO `pub_cart_setmeal` VALUES ('454', '11', '13', '1', '1515656854', null);
INSERT INTO `pub_cart_setmeal` VALUES ('466', '5', '21', '1', '1515663914', null);
INSERT INTO `pub_cart_setmeal` VALUES ('456', '11', '14', '1', '1515656857', null);
INSERT INTO `pub_cart_setmeal` VALUES ('461', '5', '13', '1', '1515657873', null);
INSERT INTO `pub_cart_setmeal` VALUES ('458', '11', '15', '1', '1515656861', null);
INSERT INTO `pub_cart_setmeal` VALUES ('504', '8', '18', '1', '1515724397', null);

-- ----------------------------
-- Table structure for pub_charg
-- ----------------------------
DROP TABLE IF EXISTS `pub_charg`;
CREATE TABLE `pub_charg` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `vendors_id` int(11) unsigned NOT NULL COMMENT '关联的供销商ID号',
  `lease_way` tinyint(1) unsigned NOT NULL COMMENT '计费方式',
  `price` decimal(15,2) unsigned NOT NULL COMMENT '价格',
  `begin_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`),
  KEY `vendors_id` (`vendors_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_charg
-- ----------------------------

-- ----------------------------
-- Table structure for pub_consume
-- ----------------------------
DROP TABLE IF EXISTS `pub_consume`;
CREATE TABLE `pub_consume` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL COMMENT '设备ID',
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `icid` int(11) DEFAULT NULL COMMENT 'IC卡ID',
  `flow` int(10) NOT NULL COMMENT '消费流量',
  `address` varchar(255) DEFAULT NULL COMMENT '消费地点',
  `time` int(11) NOT NULL COMMENT '消费时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_consume
-- ----------------------------

-- ----------------------------
-- Table structure for pub_current_devices
-- ----------------------------
DROP TABLE IF EXISTS `pub_current_devices`;
CREATE TABLE `pub_current_devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL COMMENT '用户',
  `did` int(11) unsigned NOT NULL COMMENT '当前设备',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of pub_current_devices
-- ----------------------------
INSERT INTO `pub_current_devices` VALUES ('5', '5', '49');
INSERT INTO `pub_current_devices` VALUES ('6', '6', '39');
INSERT INTO `pub_current_devices` VALUES ('7', '7', '43');
INSERT INTO `pub_current_devices` VALUES ('8', '11', '40');
INSERT INTO `pub_current_devices` VALUES ('9', '7', '43');
INSERT INTO `pub_current_devices` VALUES ('10', '7', '43');
INSERT INTO `pub_current_devices` VALUES ('11', '7', '43');
INSERT INTO `pub_current_devices` VALUES ('12', '7', '43');
INSERT INTO `pub_current_devices` VALUES ('13', '7', '43');
INSERT INTO `pub_current_devices` VALUES ('14', '5', '49');
INSERT INTO `pub_current_devices` VALUES ('15', '8', '50');

-- ----------------------------
-- Table structure for pub_device_config
-- ----------------------------
DROP TABLE IF EXISTS `pub_device_config`;
CREATE TABLE `pub_device_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL COMMENT '设备ID',
  `dtid` int(11) NOT NULL COMMENT '设备类型ID',
  `vid` int(11) NOT NULL COMMENT '经销商ID',
  `leasingmode` tinyint(1) DEFAULT NULL COMMENT '租赁模式(0：时间 1：流量)',
  `addtime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_device_config
-- ----------------------------

-- ----------------------------
-- Table structure for pub_device_type
-- ----------------------------
DROP TABLE IF EXISTS `pub_device_type`;
CREATE TABLE `pub_device_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) NOT NULL COMMENT '类型名称',
  `filter1` varchar(30) DEFAULT NULL COMMENT '一级滤芯',
  `filter2` varchar(30) DEFAULT NULL,
  `filter3` varchar(30) DEFAULT NULL,
  `filter4` varchar(30) DEFAULT NULL,
  `filter5` varchar(30) DEFAULT NULL,
  `filter6` varchar(30) DEFAULT NULL,
  `filter7` varchar(30) DEFAULT NULL,
  `filter8` varchar(30) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_device_type
-- ----------------------------
INSERT INTO `pub_device_type` VALUES ('13', '滤芯', 'LV-LV1', '滤芯-滤A型', '', '', '', '', '', '', '1515480235');
INSERT INTO `pub_device_type` VALUES ('14', 'LVR', '滤芯-滤A型', '', '', '', '', '', '', '', '1515487206');
INSERT INTO `pub_device_type` VALUES ('15', 'LV1', '滤芯-滤A型', '', '', '', '', '', '', '', '1515487227');
INSERT INTO `pub_device_type` VALUES ('16', 'LV2', '滤芯-滤A型', '', '', '', '', '', '', '', '1515487303');
INSERT INTO `pub_device_type` VALUES ('17', 'LV3', 'MO-MO', '', '', '', '', '', '', '', '1515487581');
INSERT INTO `pub_device_type` VALUES ('18', 'LV4', 'LV5-LV5', '', '', '', '', '', '', '', '1515487605');
INSERT INTO `pub_device_type` VALUES ('19', 'LV5', 'MO-MO', '', '', '', '', '', '', '', '1515487626');
INSERT INTO `pub_device_type` VALUES ('20', 'LV6', 'MO-MO', '', '', '', '', '', '', '', '1515487639');
INSERT INTO `pub_device_type` VALUES ('21', 'LV7', '滤芯-滤A型', 'LV-LV1', 'LV5-LV5', '', '', '', '', '', '1515487653');
INSERT INTO `pub_device_type` VALUES ('22', '购物卡', 'IE-ie', '', '', '', '', '', '', '', '1515553823');
INSERT INTO `pub_device_type` VALUES ('23', '&amp;8877 &amp;&amp;^^  ', 'IE-ie', '', '', '', '', '', '', '', '1515565114');
INSERT INTO `pub_device_type` VALUES ('24', '**#  $$', 'LV5-LV5', '', '', '', '', '', '', '', '1515570440');
INSERT INTO `pub_device_type` VALUES ('25', '%%%   ……', 'LC-LC', '', '', '', '', '', '', '', '1515579761');
INSERT INTO `pub_device_type` VALUES ('26', '##$ ##', 'LC-LC', '', '', '', '', '', '', '', '1515582542');
INSERT INTO `pub_device_type` VALUES ('27', '#$%$  #', 'LC-LC', '', '', '', '', '', '', '', '1515634809');
INSERT INTO `pub_device_type` VALUES ('28', '#$  ##', 'LC-LC', '', '', '', '', '', '', '', '1515638324');
INSERT INTO `pub_device_type` VALUES ('29', '##￥……   #', 'LC-LC', '', '', '', '', '', '', '', '1515641307');
INSERT INTO `pub_device_type` VALUES ('30', '#￥%  #￥%', 'LC-LC', '', '', '', '', '', '', '', '1515649867');
INSERT INTO `pub_device_type` VALUES ('31', '###   ￥%', '滤芯-滤A型', '', '', '', '', '', '', '', '1515659075');

-- ----------------------------
-- Table structure for pub_devices
-- ----------------------------
DROP TABLE IF EXISTS `pub_devices`;
CREATE TABLE `pub_devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `device_code` varchar(20) NOT NULL COMMENT '设备编码',
  `device_statu` tinyint(1) unsigned NOT NULL COMMENT '设备状态：1已入库，2待激活，3已激活',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `binding_statu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否绑定经销商 0：未绑定 1：已绑定',
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `type_id` int(11) NOT NULL COMMENT '产品类型ID',
  `name` varchar(15) DEFAULT NULL COMMENT '聯係人名字',
  `address` varchar(255) DEFAULT NULL COMMENT '安裝地址',
  `phone` varchar(11) DEFAULT NULL COMMENT '聯係人手機號',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`device_code`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices
-- ----------------------------
INSERT INTO `pub_devices` VALUES ('6', '123456789987654', '1', '1515550382', '1', '5', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('7', '987654321321654', '1', '1515550966', '1', '7', '14', null, null, null);
INSERT INTO `pub_devices` VALUES ('8', '129258686542132', '1', '1515551108', '1', null, '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('9', '129258686542133', '1', '1515551108', '1', null, '14', null, null, null);
INSERT INTO `pub_devices` VALUES ('39', '123213213213213', '1', '1515582267', '1', '6', '22', null, null, null);
INSERT INTO `pub_devices` VALUES ('40', '012121212121212', '1', '1515647466', '1', '11', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('41', '112633445566778', '1', '1515654241', '1', '5', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('42', '123123123123123', '1', '1515660504', '0', '7', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('43', '236236236236236', '1', '1515660513', '1', '7', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('44', '256256256256256', '1', '1515660652', '1', '7', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('45', '963963963963963', '1', '1515660661', '1', '7', '13', '艺高一', '广州东圃吴智彬', '13613613652');
INSERT INTO `pub_devices` VALUES ('46', '112733445596778', '1', '1515667596', '1', '5', '14', null, null, null);
INSERT INTO `pub_devices` VALUES ('47', '162753445596778', '1', '1515667607', '0', null, '14', null, null, null);
INSERT INTO `pub_devices` VALUES ('48', '999999999999999', '1', '1515671223', '0', '5', '13', null, null, null);
INSERT INTO `pub_devices` VALUES ('49', '888888888888888', '1', '1515671269', '1', '5', '13', '冷冷冷', '广州市天河区天河路', '13690850085');
INSERT INTO `pub_devices` VALUES ('50', '123123456456456', '1', '1515724160', '1', '8', '13', '明咯哈', '广州市番禺区钟村镇文化广场', '15627907633');

-- ----------------------------
-- Table structure for pub_devices_statu
-- ----------------------------
DROP TABLE IF EXISTS `pub_devices_statu`;
CREATE TABLE `pub_devices_statu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `DeviceID` varchar(20) NOT NULL COMMENT '设备码',
  `DeviceStause` tinyint(2) DEFAULT '11' COMMENT '设备状态 0:制水 1:冲洗 2:水满 3:缺水 4漏水 5:检修 6:欠费停机 7:关机 8:开机(仅命令)',
  `ReFlow` int(10) DEFAULT NULL COMMENT '剩余流量 租赁用',
  `Reday` int(10) DEFAULT NULL COMMENT '剩余天数 租赁用',
  `RawTDS` int(10) DEFAULT NULL COMMENT '纯水',
  `PureTDS` int(10) DEFAULT NULL COMMENT '原水',
  `Temperature` int(10) DEFAULT NULL COMMENT '温度',
  `ReFlowFilter1` int(10) DEFAULT NULL COMMENT '滤芯1剩余流量',
  `ReDayFilter1` int(10) DEFAULT NULL COMMENT '滤芯1剩余天数',
  `ReFlowFilter2` int(10) DEFAULT NULL COMMENT '滤芯2剩余流量',
  `ReDayFilter2` int(10) DEFAULT NULL COMMENT '滤芯2剩余天数',
  `ReFlowFilter3` int(10) DEFAULT NULL COMMENT '滤芯3剩余流量',
  `ReDayFilter3` int(10) DEFAULT NULL COMMENT '滤芯3剩余天数',
  `ReFlowFilter4` int(10) DEFAULT NULL COMMENT '滤芯4剩余流量',
  `ReDayFilter4` int(10) DEFAULT NULL COMMENT '滤芯4剩余天数',
  `ReFlowFilter5` int(10) DEFAULT NULL COMMENT '滤芯5剩余流量',
  `ReDayFilter5` int(10) DEFAULT NULL COMMENT '滤芯5剩余天数',
  `ReFlowFilter6` int(10) DEFAULT NULL COMMENT '滤芯6剩余流量',
  `ReDayFilter6` int(10) DEFAULT NULL COMMENT '滤芯6剩余天数',
  `ReFlowFilter7` int(10) DEFAULT NULL COMMENT '滤芯7剩余流量',
  `ReDayFilter7` int(10) DEFAULT NULL COMMENT '滤芯7剩余天数',
  `ReFlowFilter8` int(10) DEFAULT NULL COMMENT '滤芯8剩余流量',
  `ReDayFilter8` int(10) DEFAULT NULL COMMENT '滤芯8剩余天数',
  `LeasingMode` tinyint(1) DEFAULT NULL COMMENT '租赁模式  0:零售型 1:按流量计费 2:按时间计费 3:时长和流量套餐',
  `AliveStause` tinyint(1) DEFAULT NULL,
  `SumFlow` int(10) DEFAULT NULL COMMENT '累计流量',
  `SumDay` int(10) DEFAULT NULL COMMENT '累计天数',
  `FilterMode` tinyint(1) DEFAULT NULL COMMENT '滤芯模式',
  `Device` varchar(10) DEFAULT NULL,
  `ICCID` varchar(20) DEFAULT NULL,
  `CSQ` int(3) DEFAULT NULL,
  `Loaction` varchar(200) DEFAULT NULL,
  `addtime` varchar(11) DEFAULT NULL,
  `updatetime` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`DeviceID`,`DeviceStause`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices_statu
-- ----------------------------
INSERT INTO `pub_devices_statu` VALUES ('5', '123456789987654', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('6', '123213213213213', '11', '58000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('7', '987654321321654', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('8', '112633445566778', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('9', '012121212121212', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('10', '112733445596778', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', null, null, null, 'GPRS', '11223344556677889900', '90', '10020\0\0\0\0\0', null, '1515669173');
INSERT INTO `pub_devices_statu` VALUES ('11', '999999999999999', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('12', '123123123123123', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('13', '256256256256256', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('14', '236236236236236', '11', '33000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('15', '236236236236236', '11', '33000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('16', '236236236236236', '11', '33000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('17', '236236236236236', '11', '33000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('18', '236236236236236', '11', '33000', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('19', '963963963963963', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('20', '963963963963963', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('21', '963963963963963', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('22', '888888888888888', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('23', '123123456456456', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('24', '112233445566778', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', null, null, null, 'GPRS', '11223344556677889900', '90', '10020\0\0\0\0\0', '1515728702', null);

-- ----------------------------
-- Table structure for pub_express_information
-- ----------------------------
DROP TABLE IF EXISTS `pub_express_information`;
CREATE TABLE `pub_express_information` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(11) unsigned NOT NULL COMMENT '关联的用户ID号',
  `name` varchar(30) NOT NULL COMMENT '收件人姓名',
  `phone` varchar(11) NOT NULL COMMENT '手机号码',
  `addres` varchar(255) NOT NULL COMMENT '收件地址',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_express_information
-- ----------------------------
INSERT INTO `pub_express_information` VALUES ('31', '5', '小琴', '13736589856', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('32', '5', '李斌您大驾', '13412345826', '你啊几点啊9名', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('33', '5', '小琴', '13580809655', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('34', '5', '小杰', '13725869805', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('35', '5', '小琴', '13719273611', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('36', '5', '小琴', '13718523698', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('37', '5', '小琴', '13856980854', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('38', '5', '小琴', '13890853695', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('39', '7', '吴智彬', '13425492760', '吴智彬吴智彬吴智彬', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('40', '6', '嘲人', '13425492785', '股份有限公司零用', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('41', '7', '吴智彬', '13425492760', '吴智彬吴智彬', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('42', '7', '吴智彬吴智彬', '13425492768', '吴智彬吴智彬', null, null, '0');

-- ----------------------------
-- Table structure for pub_feeds
-- ----------------------------
DROP TABLE IF EXISTS `pub_feeds`;
CREATE TABLE `pub_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL COMMENT '反馈内容',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `addtime` int(11) NOT NULL COMMENT '反馈时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_feeds
-- ----------------------------
INSERT INTO `pub_feeds` VALUES ('2', '', '5', '1515580448');
INSERT INTO `pub_feeds` VALUES ('3', '', '5', '1515580487');
INSERT INTO `pub_feeds` VALUES ('4', '', '5', '1515580504');
INSERT INTO `pub_feeds` VALUES ('5', '供给量', '5', '1515636413');
INSERT INTO `pub_feeds` VALUES ('9', '', '5', '1515648032');
INSERT INTO `pub_feeds` VALUES ('10', '', '5', '1515651865');
INSERT INTO `pub_feeds` VALUES ('11', '', '5', '1515654016');
INSERT INTO `pub_feeds` VALUES ('18', '你看看8', '5', '1515671735');
INSERT INTO `pub_feeds` VALUES ('13', '', '5', '1515654709');
INSERT INTO `pub_feeds` VALUES ('14', '', '5', '1515654754');
INSERT INTO `pub_feeds` VALUES ('15', '', '5', '1515654756');
INSERT INTO `pub_feeds` VALUES ('16', '维修设备\r\n', '5', '1515658297');
INSERT INTO `pub_feeds` VALUES ('17', '无纪律咯\r\n', '5', '1515658889');
INSERT INTO `pub_feeds` VALUES ('19', 'fdfds', '6', '1515672004');
INSERT INTO `pub_feeds` VALUES ('20', 'fdsfd', '6', '1515672017');
INSERT INTO `pub_feeds` VALUES ('21', '123321', '7', '1515672372');
INSERT INTO `pub_feeds` VALUES ('22', '321', '7', '1515672401');
INSERT INTO `pub_feeds` VALUES ('23', '1234', '7', '1515672506');
INSERT INTO `pub_feeds` VALUES ('24', '你好', '5', '1515720201');
INSERT INTO `pub_feeds` VALUES ('25', '设备有问题\r\n', '5', '1515723671');

-- ----------------------------
-- Table structure for pub_filters
-- ----------------------------
DROP TABLE IF EXISTS `pub_filters`;
CREATE TABLE `pub_filters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `filtername` varchar(30) NOT NULL COMMENT '滤芯名称',
  `alias` varchar(30) DEFAULT '暂无别名' COMMENT '滤芯别名',
  `picpath` varchar(255) NOT NULL COMMENT '滤芯图片',
  `timelife` int(11) unsigned NOT NULL COMMENT '时间寿命（小时）',
  `flowlife` int(11) unsigned NOT NULL COMMENT '流量寿命（升）',
  `balancatime` int(11) unsigned DEFAULT NULL COMMENT '时间寿命使能',
  `balancaflow` int(11) unsigned DEFAULT NULL COMMENT '流量寿命使能',
  `introduce` varchar(255) DEFAULT '暂无简介' COMMENT '滤芯简介',
  `url` varchar(255) DEFAULT NULL COMMENT '滤芯购买网址',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `price` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`filtername`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_filters
-- ----------------------------
INSERT INTO `pub_filters` VALUES ('6', 'LV', 'LV1', '/upload/2018-01-09/5a54629e5141f.jpg', '253', '32', null, null, '', '', '1515673463', '23.00');
INSERT INTO `pub_filters` VALUES ('7', '滤芯', '滤A型', '/upload/2018-01-09/5a54638302df6.jpg', '25', '68', null, null, '', '', '1515480064', '2650.00');
INSERT INTO `pub_filters` VALUES ('8', 'MO', 'MO', '/upload/2018-01-09/5a54809e06201.jpg', '20', '202', null, null, '', '', '1515487390', '200.00');
INSERT INTO `pub_filters` VALUES ('9', 'LV5', 'LV5', '/upload/2018-01-09/5a5480e7279bb.jpg', '200', '200', null, null, '', '', '1515660886', '20.00');
INSERT INTO `pub_filters` VALUES ('10', 'IE', 'ie', '/upload/2018-01-10/5a5583ee2f775.png', '200', '200', null, null, '', '', '1515553774', '200.00');
INSERT INTO `pub_filters` VALUES ('11', 'LC', 'LC', '/upload/2018-01-10/5a55bf1f335b0.jpg', '20', '20', null, null, '', '', '1515568938', '20.00');

-- ----------------------------
-- Table structure for pub_flow
-- ----------------------------
DROP TABLE IF EXISTS `pub_flow`;
CREATE TABLE `pub_flow` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '充值流水ID',
  `uid` int(11) unsigned NOT NULL COMMENT '用户ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单编号',
  `money` decimal(25,0) unsigned DEFAULT NULL COMMENT '充值金额',
  `mode` tinyint(1) unsigned DEFAULT NULL COMMENT '充值方式(0：系统赠送 1：微信 2：支付宝)',
  `flow` int(11) unsigned NOT NULL COMMENT '流量',
  `num` int(11) unsigned NOT NULL COMMENT '套餐数量',
  `describe` varchar(255) DEFAULT NULL COMMENT '套餐描述',
  `currentflow` int(11) unsigned DEFAULT NULL COMMENT '当前流量',
  `addtime` int(11) NOT NULL COMMENT '充值时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_flow
-- ----------------------------
INSERT INTO `pub_flow` VALUES ('29', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '2000', '1515666962');
INSERT INTO `pub_flow` VALUES ('30', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '4000', '1515667464');
INSERT INTO `pub_flow` VALUES ('31', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '6000', '1515667738');
INSERT INTO `pub_flow` VALUES ('32', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '16000', '1515668417');
INSERT INTO `pub_flow` VALUES ('33', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '18000', '1515668418');
INSERT INTO `pub_flow` VALUES ('34', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '20000', '1515668434');
INSERT INTO `pub_flow` VALUES ('35', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '22000', '1515668434');
INSERT INTO `pub_flow` VALUES ('36', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '24000', '1515668455');
INSERT INTO `pub_flow` VALUES ('37', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '26000', '1515668470');
INSERT INTO `pub_flow` VALUES ('38', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '28000', '1515668470');
INSERT INTO `pub_flow` VALUES ('39', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '30000', '1515668480');
INSERT INTO `pub_flow` VALUES ('40', '6', '715312724781693780', '200', '1', '2000', '1', '2元2000流量', '32000', '1515668583');
INSERT INTO `pub_flow` VALUES ('41', '6', '731318446940579826', '10000', '1', '1000', '1', '100元1000流量', '33000', '1515668872');
INSERT INTO `pub_flow` VALUES ('42', '6', '731318446940579826', '20000', '1', '4000', '1', '200元4000时长', '37000', '1515668872');
INSERT INTO `pub_flow` VALUES ('43', '6', '731318446940579826', '40000', '1', '8000', '1', '400元8000时长', '45000', '1515668872');
INSERT INTO `pub_flow` VALUES ('44', '6', '315037233979249849', '10000', '1', '1000', '1', '100元1000流量', '46000', '1515670854');
INSERT INTO `pub_flow` VALUES ('45', '6', '315037233979249849', '20000', '1', '4000', '1', '200元4000时长', '50000', '1515670854');
INSERT INTO `pub_flow` VALUES ('46', '6', '315037233979249849', '40000', '1', '8000', '1', '400元8000时长', '58000', '1515670854');
INSERT INTO `pub_flow` VALUES ('47', '7', '9125801742744327', '20000', '1', '4000', '1', '200元4000时长', '4000', '1515726679');
INSERT INTO `pub_flow` VALUES ('48', '704', '242779153043982842', '200', '1', '2000', '1', '2元2000流量', '2000', '1515726711');
INSERT INTO `pub_flow` VALUES ('49', '7', '2196660095575567', '20000', '1', '4000', '1', '200元4000时长', '8000', '1515726825');
INSERT INTO `pub_flow` VALUES ('50', '7', '2147138979801667', '10000', '1', '1000', '1', '100元1000流量', '9000', '1515726951');
INSERT INTO `pub_flow` VALUES ('51', '992666', '709110034835845911666', '40000', '1', '8000', '1', '400元8000时长', '8000', '1515727188');
INSERT INTO `pub_flow` VALUES ('52', '949', '739224923188335985', '40000', '1', '8000', '1', '400元8000时长', '8000', '1515727245');
INSERT INTO `pub_flow` VALUES ('53', '75', '777317185738035982', '40000', '1', '8000', '1', '400元8000时长', '8000', '1515727498');
INSERT INTO `pub_flow` VALUES ('54', '817', '316904214969787641', '20000', '1', '4000', '1', '200元4000时长', '4000', '1515727509');
INSERT INTO `pub_flow` VALUES ('55', '7', '4794345137408317', '40000', '1', '8000', '1', '400元8000时长', '17000', '1515727555');
INSERT INTO `pub_flow` VALUES ('56', '7', '4794345137408317', '200', '1', '2000', '1', '2元2000流量', '19000', '1515727555');
INSERT INTO `pub_flow` VALUES ('57', '7', '4794345137408317', '20000', '1', '4000', '1', '200元4000时长', '23000', '1515727555');
INSERT INTO `pub_flow` VALUES ('58', '4377', '1520671881409045977', '40000', '1', '8000', '1', '400元8000时长', '8000', '1515727851');
INSERT INTO `pub_flow` VALUES ('59', '287', '524564506243814875', '40000', '1', '8000', '1', '400元8000时长', '8000', '1515728301');
INSERT INTO `pub_flow` VALUES ('60', '7', '4544787626435907', '40000', '1', '8000', '1', '400元8000时长', '31000', '1515728341');
INSERT INTO `pub_flow` VALUES ('61', '7', '6499572483562587', '200', '1', '2000', '1', '2元2000流量', '33000', '1515728471');

-- ----------------------------
-- Table structure for pub_hire
-- ----------------------------
DROP TABLE IF EXISTS `pub_hire`;
CREATE TABLE `pub_hire` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `hire_id` int(11) unsigned NOT NULL COMMENT '租赁编号',
  `vendors_id` int(11) unsigned NOT NULL COMMENT '关联的供销商ID号',
  `device_id` int(11) unsigned NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) unsigned NOT NULL COMMENT '关联的用户ID号',
  `charg_id` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '关联的计费ID号',
  `begin_time` int(11) NOT NULL COMMENT '租赁开始时间',
  `end_time` int(11) NOT NULL COMMENT '租赁结束时间',
  PRIMARY KEY (`id`),
  KEY `hire_id` (`hire_id`,`device_id`,`user_id`,`vendors_id`,`charg_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_hire
-- ----------------------------

-- ----------------------------
-- Table structure for pub_leaevl
-- ----------------------------
DROP TABLE IF EXISTS `pub_leaevl`;
CREATE TABLE `pub_leaevl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `vendors_id` int(11) unsigned NOT NULL COMMENT '关联的供销商ID号',
  `parent_vid` int(11) unsigned NOT NULL COMMENT '供销商的父级ID',
  `path` varchar(11) NOT NULL COMMENT '供销商的层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_leaevl
-- ----------------------------

-- ----------------------------
-- Table structure for pub_loglist
-- ----------------------------
DROP TABLE IF EXISTS `pub_loglist`;
CREATE TABLE `pub_loglist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(11) unsigned NOT NULL COMMENT '关联的登陆ID号',
  `content` varchar(255) NOT NULL COMMENT '操作内容',
  `time` int(11) NOT NULL COMMENT '操作时间',
  `ip` varchar(15) NOT NULL COMMENT '操作IP',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_loglist
-- ----------------------------

-- ----------------------------
-- Table structure for pub_order_filter
-- ----------------------------
DROP TABLE IF EXISTS `pub_order_filter`;
CREATE TABLE `pub_order_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单编号',
  `filter_id` int(11) unsigned NOT NULL,
  `filtername` varchar(30) NOT NULL COMMENT '滤芯名称',
  `alias` varchar(30) DEFAULT '暂无别名' COMMENT '滤芯别名',
  `picpath` varchar(255) NOT NULL COMMENT '滤芯图片',
  `timelife` int(11) unsigned NOT NULL COMMENT '时间寿命（小时）',
  `flowlife` int(11) unsigned NOT NULL COMMENT '流量寿命（升）',
  `balancatime` int(11) unsigned DEFAULT NULL COMMENT '时间寿命使能',
  `balancaflow` int(11) unsigned DEFAULT NULL COMMENT '流量寿命使能',
  `introduce` varchar(255) DEFAULT '暂无简介' COMMENT '滤芯简介',
  `url` varchar(255) DEFAULT NULL COMMENT '滤芯购买网址',
  `price` decimal(15,2) NOT NULL,
  `goods_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) NOT NULL COMMENT '订单创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------
INSERT INTO `pub_order_filter` VALUES ('56', '2679589030441296', '10', 'IE', 'ie', '/upload/2018-01-10/5a5583ee2f775.png', '200', '200', null, null, '', '', '200.00', '3', '600.00', '1515728014', null);
INSERT INTO `pub_order_filter` VALUES ('57', '4068171535150127', '7', '滤芯', '滤A型', '/upload/2018-01-09/5a54638302df6.jpg', '25', '68', null, null, '', '', '2650.00', '11', '29150.00', '1515728152', null);
INSERT INTO `pub_order_filter` VALUES ('58', '7742180041965827', '7', '滤芯', '滤A型', '/upload/2018-01-09/5a54638302df6.jpg', '25', '68', null, null, '', '', '2650.00', '5', '13250.00', '1515728410', null);
INSERT INTO `pub_order_filter` VALUES ('59', '6499572483562587', '7', '滤芯', '滤A型', '/upload/2018-01-09/5a54638302df6.jpg', '25', '68', null, null, '', '', '2650.00', '1', '2650.00', '1515728465', null);

-- ----------------------------
-- Table structure for pub_order_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_order_setmeal`;
CREATE TABLE `pub_order_setmeal` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) NOT NULL,
  `setmeal_id` int(11) unsigned NOT NULL,
  `type_id` int(11) NOT NULL COMMENT '产品类型ID',
  `remodel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值模式(0：流量1：时长)',
  `money` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '套餐金额',
  `flow` int(11) NOT NULL COMMENT '套餐流量/时长',
  `describe` varchar(255) NOT NULL COMMENT '套餐描述',
  `goods_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) unsigned DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) unsigned DEFAULT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`(11))
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES ('374', '970995672036001739', '12', '13', '0', '10000.00', '2000', '100元2000流量', '1', '10000.00', '1515579938', null);
INSERT INTO `pub_order_setmeal` VALUES ('375', '756452912268078064', '4', '13', '0', '200.00', '1000', '2元1000流量', '1', '200.00', '1515641561', null);
INSERT INTO `pub_order_setmeal` VALUES ('376', '260008478351452037', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515642066', null);
INSERT INTO `pub_order_setmeal` VALUES ('377', '260008478351452037', '4', '13', '0', '200.00', '1000', '2元1000流量', '1', '200.00', '1515642066', null);
INSERT INTO `pub_order_setmeal` VALUES ('378', '175724981582317612', '4', '13', '0', '200.00', '1000', '2元1000流量', '1', '200.00', '1515653887', null);
INSERT INTO `pub_order_setmeal` VALUES ('379', '682372834119545257', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515657499', null);
INSERT INTO `pub_order_setmeal` VALUES ('380', '807372854359487048', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515665646', null);
INSERT INTO `pub_order_setmeal` VALUES ('381', '807372854359487048', '14', '15', '1', '100.00', '1000', '1元1000时长', '1', '100.00', '1515665646', null);
INSERT INTO `pub_order_setmeal` VALUES ('383', '652052117791162547', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515666296', null);
INSERT INTO `pub_order_setmeal` VALUES ('384', '715312724781693780', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515666444', null);
INSERT INTO `pub_order_setmeal` VALUES ('385', '773562145726788074', '17', '15', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515667160', null);
INSERT INTO `pub_order_setmeal` VALUES ('386', '773562145726788074', '20', '19', '1', '40000.00', '8000', '400元8000时长', '2', '80000.00', '1515667160', null);
INSERT INTO `pub_order_setmeal` VALUES ('387', '773562145726788074', '19', '16', '0', '30000.00', '5000', '300元5000流量', '1', '30000.00', '1515667160', null);
INSERT INTO `pub_order_setmeal` VALUES ('388', '498038570076890610', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515667278', null);
INSERT INTO `pub_order_setmeal` VALUES ('389', '472026536034024050', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515668649', null);
INSERT INTO `pub_order_setmeal` VALUES ('390', '681087200088697709', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515668761', null);
INSERT INTO `pub_order_setmeal` VALUES ('391', '731318446940579826', '15', '18', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515668786', null);
INSERT INTO `pub_order_setmeal` VALUES ('392', '731318446940579826', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515668786', null);
INSERT INTO `pub_order_setmeal` VALUES ('393', '731318446940579826', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515668786', null);
INSERT INTO `pub_order_setmeal` VALUES ('394', '274771003625279831', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515669438', null);
INSERT INTO `pub_order_setmeal` VALUES ('395', '618242409477306768', '17', '15', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515669561', null);
INSERT INTO `pub_order_setmeal` VALUES ('396', '618242409477306768', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515669561', null);
INSERT INTO `pub_order_setmeal` VALUES ('397', '618242409477306768', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515669561', null);
INSERT INTO `pub_order_setmeal` VALUES ('398', '484971035691270782', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515670136', null);
INSERT INTO `pub_order_setmeal` VALUES ('399', '364488092592252853', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515670189', null);
INSERT INTO `pub_order_setmeal` VALUES ('400', '374384610190809261', '17', '15', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515670400', null);
INSERT INTO `pub_order_setmeal` VALUES ('401', '374384610190809261', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515670400', null);
INSERT INTO `pub_order_setmeal` VALUES ('402', '374384610190809261', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515670400', null);
INSERT INTO `pub_order_setmeal` VALUES ('403', '315037233979249849', '15', '18', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515670757', null);
INSERT INTO `pub_order_setmeal` VALUES ('404', '315037233979249849', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515670757', null);
INSERT INTO `pub_order_setmeal` VALUES ('405', '315037233979249849', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515670757', null);
INSERT INTO `pub_order_setmeal` VALUES ('406', '911264505242384431', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515670900', null);
INSERT INTO `pub_order_setmeal` VALUES ('407', '483164022335060575', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515670996', null);
INSERT INTO `pub_order_setmeal` VALUES ('408', '688164935360291401', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515671208', null);
INSERT INTO `pub_order_setmeal` VALUES ('409', '133823502386070827', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515671337', null);
INSERT INTO `pub_order_setmeal` VALUES ('410', '133823502386070827', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515671337', null);
INSERT INTO `pub_order_setmeal` VALUES ('411', '541151472684486776', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515671612', null);
INSERT INTO `pub_order_setmeal` VALUES ('412', '242779153043982842', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515719255', null);
INSERT INTO `pub_order_setmeal` VALUES ('413', '739224923188335985', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515723391', null);
INSERT INTO `pub_order_setmeal` VALUES ('414', '316904214969787641', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515723651', null);
INSERT INTO `pub_order_setmeal` VALUES ('415', '482052780282581005', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515724245', null);
INSERT INTO `pub_order_setmeal` VALUES ('416', '524564506243814875', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515724447', null);
INSERT INTO `pub_order_setmeal` VALUES ('417', '123171360546464287', '15', '18', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515724697', null);
INSERT INTO `pub_order_setmeal` VALUES ('418', '946926631862657558', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515724833', null);
INSERT INTO `pub_order_setmeal` VALUES ('419', '739392487959713531', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515724903', null);
INSERT INTO `pub_order_setmeal` VALUES ('420', '709110034835845911666', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515725132', null);
INSERT INTO `pub_order_setmeal` VALUES ('421', '777317185738035982', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515725444', null);
INSERT INTO `pub_order_setmeal` VALUES ('422', '1520671881409045977', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515725798', null);
INSERT INTO `pub_order_setmeal` VALUES ('423', '4544787626435907', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515726288', null);
INSERT INTO `pub_order_setmeal` VALUES ('424', '2196660095575567', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515726572', null);
INSERT INTO `pub_order_setmeal` VALUES ('425', '9125801742744327', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515726673', null);
INSERT INTO `pub_order_setmeal` VALUES ('426', '2147138979801667', '15', '18', '0', '10000.00', '1000', '100元1000流量', '1', '10000.00', '1515726945', null);
INSERT INTO `pub_order_setmeal` VALUES ('427', '4794345137408317', '20', '19', '1', '40000.00', '8000', '400元8000时长', '1', '40000.00', '1515727546', null);
INSERT INTO `pub_order_setmeal` VALUES ('428', '4794345137408317', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515727546', null);
INSERT INTO `pub_order_setmeal` VALUES ('429', '4794345137408317', '18', '17', '1', '20000.00', '4000', '200元4000时长', '1', '20000.00', '1515727546', null);
INSERT INTO `pub_order_setmeal` VALUES ('437', '6499572483562587', '5', '13', '0', '200.00', '2000', '2元2000流量', '1', '200.00', '1515728465', null);

-- ----------------------------
-- Table structure for pub_orders
-- ----------------------------
DROP TABLE IF EXISTS `pub_orders`;
CREATE TABLE `pub_orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单编号',
  `device_id` int(11) unsigned NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) unsigned NOT NULL COMMENT '关联的用户ID号',
  `express_id` int(11) unsigned DEFAULT NULL COMMENT '关联快递信息ID号',
  `total_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `total_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '订单修改时间',
  `is_pay` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '付款状态(0：未付款1：已付款 2：已取消)',
  `is_receipt` tinyint(1) unsigned DEFAULT '0' COMMENT '发货状态(0：未发货1：已发货)',
  `is_ship` tinyint(1) unsigned DEFAULT '0' COMMENT '收货状态(0：未收货1：已收货)',
  `is_recharge` tinyint(1) unsigned DEFAULT '0' COMMENT '充值状态(0：未充值1：已充值)',
  `express` varchar(32) DEFAULT NULL COMMENT '快递名称',
  `mca` varchar(32) DEFAULT NULL COMMENT '快递订单号',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`device_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=627 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('405', '970995672036001739', '6', '5', null, '1', '10000.00', '1515579938', '1515654974', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('406', '756452912268078064', '6', '5', null, '1', '200.00', '1515641561', '1515654971', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('407', '260008478351452037', '7', '7', null, '2', '400.00', '1515642066', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('408', '175724981582317612', '6', '5', null, '1', '200.00', '1515653887', '1515654969', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('409', '682372834119545257', '7', '7', null, '1', '200.00', '1515657499', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('410', '807372854359487048', '6', '5', null, '2', '300.00', '1515665646', '1515668761', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('470', '652052117791162547', '7', '7', null, '1', '200.00', '1515666296', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('471', '715312724781693780', '7', '7', null, '1', '200.00', '1515666444', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('472', '773562145726788074', '7', '7', null, '4', '120000.00', '1515667160', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('473', '498038570076890610', '7', '7', null, '1', '40000.00', '1515667278', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('474', '472026536034024050', '7', '7', null, '1', '200.00', '1515668649', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('475', '681087200088697709', '7', '7', null, '1', '40000.00', '1515668761', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('476', '731318446940579826', '7', '7', null, '3', '70000.00', '1515668786', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('497', '274771003625279831', '7', '7', null, '1', '40000.00', '1515669438', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('498', '618242409477306768', '7', '7', null, '3', '70000.00', '1515669561', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('499', '484971035691270782', '7', '7', null, '1', '20000.00', '1515670136', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('500', '364488092592252853', '7', '7', null, '1', '20000.00', '1515670189', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('501', '374384610190809261', '7', '7', null, '3', '30200.00', '1515670400', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('502', '315037233979249849', '7', '7', null, '3', '70000.00', '1515670757', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('503', '911264505242384431', '7', '7', null, '1', '200.00', '1515670900', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('504', '483164022335060575', '7', '7', null, '1', '20000.00', '1515670996', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('505', '688164935360291401', '7', '7', null, '1', '20000.00', '1515671208', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('506', '133823502386070827', '7', '7', null, '2', '60000.00', '1515671337', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('507', '541151472684486776', '7', '7', null, '1', '40000.00', '1515671612', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('539', '242779153043982842', '7', '7', null, '1', '200.00', '1515719255', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('544', '739224923188335985', '7', '7', null, '1', '40000.00', '1515723391', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('545', '316904214969787641', '7', '7', null, '1', '20000.00', '1515723651', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('555', '482052780282581005', '6', '5', null, '1', '200.00', '1515724245', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('556', '524564506243814875', '7', '7', null, '1', '40000.00', '1515724447', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('557', '123171360546464287', '7', '7', null, '1', '10000.00', '1515724697', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('558', '946926631862657558', '7', '7', null, '1', '20000.00', '1515724833', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('559', '739392487959713531', '7', '7', null, '1', '20000.00', '1515724903', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('560', '709110034835845911666', '7', '7', null, '1', '40000.00', '1515725132', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('561', '777317185738035982', '7', '7', null, '1', '40000.00', '1515725444', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('562', '1520671881409045977', '7', '7', null, '1', '40000.00', '1515725798', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('563', '4544787626435907', '7', '7', null, '1', '40000.00', '1515726288', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('577', '2196660095575567', '7', '7', null, '1', '20000.00', '1515726572', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('579', '9125801742744327', '7', '7', null, '1', '20000.00', '1515726673', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('580', '2147138979801667', '7', '7', null, '1', '10000.00', '1515726945', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('581', '4794345137408317', '7', '7', null, '3', '60200.00', '1515727546', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('622', '2679589030441296', '39', '6', '0', '3', '600.00', '1515728014', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('623', '9859116052396946', '39', '6', '0', '0', '0.00', '1515728014', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('624', '4068171535150127', '7', '7', '39', '11', '29150.00', '1515728152', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('625', '7742180041965827', '7', '7', '41', '5', '13250.00', '1515728410', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('626', '6499572483562587', '7', '7', '42', '2', '2850.00', '1515728465', '1515728640', '1', '1', '1', '1', '申通', '131564684165');

-- ----------------------------
-- Table structure for pub_repair
-- ----------------------------
DROP TABLE IF EXISTS `pub_repair`;
CREATE TABLE `pub_repair` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_code` varchar(255) NOT NULL COMMENT '设备编码',
  `content` text NOT NULL COMMENT '问题描述',
  `picpath` varchar(255) NOT NULL COMMENT '图片路径',
  `uid` int(11) NOT NULL COMMENT '报修人ID 用户ID',
  `address` varchar(255) NOT NULL COMMENT '维修地址',
  `addtime` int(11) NOT NULL COMMENT '报修时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0：未处理 1：已处理',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_repair
-- ----------------------------

-- ----------------------------
-- Table structure for pub_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_setmeal`;
CREATE TABLE `pub_setmeal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL COMMENT '产品类型ID',
  `remodel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值模式(0：流量1：时长)',
  `money` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '套餐金额',
  `flow` int(11) NOT NULL COMMENT '套餐流量/时长',
  `describe` varchar(255) NOT NULL COMMENT '套餐描述',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_setmeal
-- ----------------------------
INSERT INTO `pub_setmeal` VALUES ('5', '13', '0', '200.00', '2000', '2元2000流量', '1515549384');
INSERT INTO `pub_setmeal` VALUES ('20', '19', '1', '40000.00', '8000', '400元8000时长', '1515658477');
INSERT INTO `pub_setmeal` VALUES ('18', '17', '1', '20000.00', '4000', '200元4000时长', '1515658421');
INSERT INTO `pub_setmeal` VALUES ('15', '18', '0', '10000.00', '1000', '100元1000流量', '1515655569');
INSERT INTO `pub_setmeal` VALUES ('17', '15', '0', '10000.00', '1000', '100元1000流量', '1515658366');
INSERT INTO `pub_setmeal` VALUES ('19', '16', '0', '30000.00', '5000', '300元5000流量', '1515658451');

-- ----------------------------
-- Table structure for pub_users
-- ----------------------------
DROP TABLE IF EXISTS `pub_users`;
CREATE TABLE `pub_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态',
  `login_time` int(11) DEFAULT NULL COMMENT '最后登陆的时间',
  `login_ip` varchar(15) DEFAULT NULL COMMENT '最后登陆的IP地址',
  `created_at` int(11) NOT NULL COMMENT '添加时间',
  `balance` int(10) NOT NULL DEFAULT '0' COMMENT '账户余额',
  `open_id` varchar(50) NOT NULL COMMENT '关联微信信息表',
  `did` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_users
-- ----------------------------
INSERT INTO `pub_users` VALUES ('5', '1', '1515551882', '140.207.54.75', '1515551882', '0', 'oXwY4t_vkTgtlD0CBTZ-vTbIMWHs', null);
INSERT INTO `pub_users` VALUES ('6', '0', '1515569111', '140.207.54.75', '1515569111', '0', 'oXwY4txlP9OKwEDbVUMvUXP_7FhA', null);
INSERT INTO `pub_users` VALUES ('7', '1', '1515569454', '140.207.54.75', '1515569454', '0', 'oXwY4t-9clttAFWXjCcNRJrvch3w', null);
INSERT INTO `pub_users` VALUES ('8', '1', '1515583082', '140.207.54.76', '1515583082', '0', 'oXwY4tzmil2SItRr5-x3Fo6Wl5Cw', null);
INSERT INTO `pub_users` VALUES ('9', '1', '1515640586', '140.207.54.79', '1515640586', '0', 'oXwY4t7-xOzRDP0znhWAa1AzHOKk', null);
INSERT INTO `pub_users` VALUES ('10', '0', '1515640846', '140.207.54.80', '1515640846', '0', 'oXwY4t6w6M5cPnSXL79sy352Tgzs', null);
INSERT INTO `pub_users` VALUES ('11', '0', '1515655705', '140.207.54.75', '1515655705', '0', 'oXwY4t7hYDxtr2sMqqEa5ZVJpinU', null);
INSERT INTO `pub_users` VALUES ('12', '1', '1515722466', '140.207.54.76', '1515722466', '0', 'oXwY4twQS5mjahui0qpQtxIw-mmk', null);
INSERT INTO `pub_users` VALUES ('13', '1', '1515728762', '140.207.54.80', '1515728762', '0', 'oXwY4t_AcFXkov6SdeQDz0VPEkXc', null);

-- ----------------------------
-- Table structure for pub_vendors
-- ----------------------------
DROP TABLE IF EXISTS `pub_vendors`;
CREATE TABLE `pub_vendors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user` varchar(32) NOT NULL COMMENT '供销商登陆的用户名',
  `name` varchar(32) NOT NULL COMMENT '供销商的名字',
  `password` varchar(32) NOT NULL COMMENT '供销商登陆的密码',
  `phone` varchar(11) NOT NULL COMMENT '供销商手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '供销商邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '供销商地址',
  `leavel` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '供销商级别：默认为“1”级',
  `pid` int(11) NOT NULL DEFAULT '1' COMMENT '经销商上级ID',
  `addtime` int(11) NOT NULL COMMENT '创建时间',
  `idcard` varchar(20) NOT NULL COMMENT '身份证号',
  PRIMARY KEY (`id`),
  KEY `user` (`user`,`name`,`password`,`email`,`phone`,`leavel`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_vendors
-- ----------------------------
INSERT INTO `pub_vendors` VALUES ('1', 'admin', '炒鸡管理员', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '内蒙古 赤峰市 天义镇', '0', '0', '1515638832', '430122199610224517');
INSERT INTO `pub_vendors` VALUES ('15', '晴天', '晴天', 'e10adc3949ba59abbe56e057f20f883e', '13596250251', '11@qq.com', '湖北省 荆门市 钟祥市', '1', '1', '1515660344', '412512199609084215');
INSERT INTO `pub_vendors` VALUES ('16', '雨甜', '雨甜', 'e10adc3949ba59abbe56e057f20f883e', '13526521132', '11@163.com', '河南省 信阳市 城关镇', '1', '1', '1515660391', '412512199803064215');

-- ----------------------------
-- Table structure for pub_wechat
-- ----------------------------
DROP TABLE IF EXISTS `pub_wechat`;
CREATE TABLE `pub_wechat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `open_id` varchar(50) NOT NULL COMMENT '微信的ID号',
  `nickname` varchar(50) NOT NULL COMMENT '微信昵称',
  `head` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` tinyint(1) unsigned DEFAULT NULL COMMENT '性别',
  `area` varchar(255) DEFAULT NULL COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `user_id` (`open_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_wechat
-- ----------------------------
INSERT INTO `pub_wechat` VALUES ('32', 'oXwY4t_vkTgtlD0CBTZ-vTbIMWHs', '快乐翱翔', 'http://wx.qlogo.cn/mmopen/SnnOkFO2wxicJ3kkvXosHGKia14CzVTb51HMKXvx5blEQiaU9dXPPEib2S1iaFbztPia21t0hO1VQrf5Upsd3NoMC28SudibxQ2OBDib/0', '2', '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES ('33', 'oXwY4txlP9OKwEDbVUMvUXP_7FhA', '平常心', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8oShMxicsKArK4niaI3MNaEadB4LgUBia2JTSoiaj0f4ltR7ia9PmqpwPq4nGzLn6Yu37goqHzWV9yROQOPaDeBGov4f/0', '1', '广西', '中国 广西 桂林');
INSERT INTO `pub_wechat` VALUES ('34', 'oXwY4t-9clttAFWXjCcNRJrvch3w', '吴智彬-13425492760', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8qyNnJ5VbBX8GfWLFN1hiaXCtNPcjFSd5mktEqADXrrXMslURMTZLNI08ricsI8TjvVmxuSpEv4MR21bEONUicEuRO/0', '1', '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES ('35', 'oXwY4tzmil2SItRr5-x3Fo6Wl5Cw', '在⻊各上', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3THIBouQJgTKJUScsbhFo3nib4dNY8cgDXtZGnMl6YibbiasgHxibevWIm2lXqQ9Mx6j6Z3X5XKn0XD6K6PIVEiazZ7F/0', '1', '广东', '中国 广东 汕尾');
INSERT INTO `pub_wechat` VALUES ('36', 'oXwY4t7-xOzRDP0znhWAa1AzHOKk', 'V。', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8oDDLqwZLYABfAUGH7hmVM5hKsMG0utGoOSHYEibnH2HeX5ZDr2f1roORRHk6sdruPQNy4uGvibxdhta3omLTKsz5/132', '2', '', '安道尔  ');
INSERT INTO `pub_wechat` VALUES ('37', 'oXwY4t6w6M5cPnSXL79sy352Tgzs', '苏格拉没有底', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3ShK2dPsMiaYq4iaI11cMbGnoua5ptJYaF2wA74pX0QJfLJSkESLsSBpRRy0stHHIJHKqjkZMAN8AmjUeLj4DPfHF/132', '1', '', '安道尔  ');
INSERT INTO `pub_wechat` VALUES ('38', 'oXwY4t7hYDxtr2sMqqEa5ZVJpinU', 'Trc', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM4WO74R7tVYoTaXRH1CV3HV9F9IJ0AH8BNpt1dTM0ShmxKqRIs6vTjWUDJEeePA9xJHibE7uiaXf7d8XcmMmyEiaK3CPNYwOxUwfg/132', '2', '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES ('39', 'oXwY4twQS5mjahui0qpQtxIw-mmk', 'A黄伟锋', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8roRNQT3vAkXmiaN8xItbp0mBJRwicr385pdmbjRV4GWK2iaN4RuR1OwzKaBDKNbVYu35jY29OSyb1n3j0FX6RMUh4/132', '1', '福建', '中国 福建 泉州');
INSERT INTO `pub_wechat` VALUES ('40', 'oXwY4t_AcFXkov6SdeQDz0VPEkXc', '芒果冰', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8roRNQT3vAkXkI4p8laCehyhHOZTq22ak4v50foicTVXatTAuaVy9vgvhh4NO7uibq0xNxLgMglg4iar7zf5lAnLag/132', '1', '广东', '中国 广东 清远');

-- ----------------------------
-- Table structure for pub_work
-- ----------------------------
DROP TABLE IF EXISTS `pub_work`;
CREATE TABLE `pub_work` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(30) NOT NULL COMMENT '工单编号',
  `name` varchar(50) NOT NULL COMMENT '处理人',
  `phone` varchar(11) NOT NULL COMMENT '处理人电话',
  `type` tinyint(1) NOT NULL COMMENT '工单类型(0：安装 1：维修 2：维护)',
  `content` text NOT NULL COMMENT '维护内容',
  `address` varchar(50) NOT NULL COMMENT '地址',
  `result` tinyint(1) NOT NULL COMMENT '处理结果(0：未处理 1：正在处理 2：已处理)',
  `time` varchar(30) NOT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_work
-- ----------------------------
INSERT INTO `pub_work` VALUES ('3', '你你', '赵小姐', '13265985215', '0', '安装', '山东省 聊城市 莘县', '0', '2018-01-09');
INSERT INTO `pub_work` VALUES ('4', '你好', '赵小姐', '13524216254', '0', '维修', '河南省 三门峡市 灵宝市', '2', '2018-01-10');
INSERT INTO `pub_work` VALUES ('5', 'ddd012120120120120120120120120', '赵小姐', '13524216254', '0', '安装', '河北省 秦皇岛市 卢龙县', '0', '2018-01-10');
INSERT INTO `pub_work` VALUES ('6', '012511', '圆圆', '13521520054', '0', '安装', '上海市 上海市 徐汇区', '0', '2018-01-10');
INSERT INTO `pub_work` VALUES ('7', '你好', '袁小姐', '13526530213', '0', '安装', '江西省 景德镇市 昌江区', '0', '2018-01-11');
INSERT INTO `pub_work` VALUES ('8', '你好', '胡小姐', '13656239865', '0', '安装', '山东省 东营市 垦利县', '0', '2018-01-11');
INSERT INTO `pub_work` VALUES ('9', '你好', '刘小姐', '13623023652', '0', '安装', '河南省 洛阳市 宜阳县', '0', '2018-01-11');

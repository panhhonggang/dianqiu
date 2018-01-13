/*
Navicat MySQL Data Transfer

Source Server         : 点球
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2018-01-13 12:05:13
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of pub_auth_group
-- ----------------------------
INSERT INTO `pub_auth_group` VALUES ('1', ' 超级管理员', '1', '1,2,38,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37');
INSERT INTO `pub_auth_group` VALUES ('2', ' 普通管理员', '1', '1,2,38,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37');
INSERT INTO `pub_auth_group` VALUES ('3', '游客', '1', null);

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
INSERT INTO `pub_auth_group_access` VALUES ('1', '1');
INSERT INTO `pub_auth_group_access` VALUES ('9', '2');
INSERT INTO `pub_auth_group_access` VALUES ('12', '2');
INSERT INTO `pub_auth_group_access` VALUES ('16', '2');
INSERT INTO `pub_auth_group_access` VALUES ('19', '2');

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
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_binding
-- ----------------------------
INSERT INTO `pub_binding` VALUES ('36', '19', '51', '炒鸡管理员', '1515737768');
INSERT INTO `pub_binding` VALUES ('37', '1', '52', '炒鸡管理员', '1515740314');
INSERT INTO `pub_binding` VALUES ('39', '19', '55', '炒鸡管理员', '1515744613');
INSERT INTO `pub_binding` VALUES ('40', '19', '57', '炒鸡管理员', '1515745360');
INSERT INTO `pub_binding` VALUES ('41', '19', '58', '炒鸡管理员', '1515746725');
INSERT INTO `pub_binding` VALUES ('42', '19', '59', '炒鸡管理员', '1515747146');
INSERT INTO `pub_binding` VALUES ('43', '19', '60', '炒鸡管理员', '1515750366');
INSERT INTO `pub_binding` VALUES ('45', '1', '53', '炒鸡管理员', '1515754195');
INSERT INTO `pub_binding` VALUES ('46', '1', '54', '炒鸡管理员', '1515754199');
INSERT INTO `pub_binding` VALUES ('47', '1', '56', '炒鸡管理员', '1515754204');
INSERT INTO `pub_binding` VALUES ('48', '1', '61', '炒鸡管理员', '1515754209');
INSERT INTO `pub_binding` VALUES ('49', '1', '62', '炒鸡管理员', '1515754214');
INSERT INTO `pub_binding` VALUES ('50', '1', '63', '炒鸡管理员', '1515754218');
INSERT INTO `pub_binding` VALUES ('52', '21', '64', '炒鸡管理员', '1515809740');

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
) ENGINE=MyISAM AUTO_INCREMENT=197 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_filters
-- ----------------------------
INSERT INTO `pub_cart_filters` VALUES ('172', '18', '12', '1', '1515747000', null);
INSERT INTO `pub_cart_filters` VALUES ('171', '18', '13', '1', '1515747000', null);
INSERT INTO `pub_cart_filters` VALUES ('193', '20', '12', '3', '1515808050', null);
INSERT INTO `pub_cart_filters` VALUES ('181', '19', '19', '1', '1515747614', null);

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
) ENGINE=MyISAM AUTO_INCREMENT=586 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_setmeal
-- ----------------------------
INSERT INTO `pub_cart_setmeal` VALUES ('555', '18', '30', '1', '1515746994', null);

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
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of pub_current_devices
-- ----------------------------
INSERT INTO `pub_current_devices` VALUES ('16', '14', '57');
INSERT INTO `pub_current_devices` VALUES ('17', '15', '51');
INSERT INTO `pub_current_devices` VALUES ('18', '16', '56');
INSERT INTO `pub_current_devices` VALUES ('19', '14', '57');
INSERT INTO `pub_current_devices` VALUES ('20', '14', '57');
INSERT INTO `pub_current_devices` VALUES ('21', '18', '58');
INSERT INTO `pub_current_devices` VALUES ('22', '19', '59');
INSERT INTO `pub_current_devices` VALUES ('23', '15', '51');
INSERT INTO `pub_current_devices` VALUES ('24', '15', '51');
INSERT INTO `pub_current_devices` VALUES ('25', '20', '63');

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
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_device_type
-- ----------------------------
INSERT INTO `pub_device_type` VALUES ('32', '滤芯', '滤芯-滤芯A型', '', '', '', '', '', '', '', '1515737743');
INSERT INTO `pub_device_type` VALUES ('33', '净水器', '滤芯-滤芯A型', 'PP-pp', 'UPD-upd', '', '', '', '', '', '1515739517');
INSERT INTO `pub_device_type` VALUES ('34', 'RO膜', '滤芯-滤芯A型', 'PP-pp', 'UPD-upd', 'LV-lv', 'IE-ie', '购物卡-shopping', 'cdp-CDP', 'pod-POD', '1515744232');
INSERT INTO `pub_device_type` VALUES ('35', '产品', 'pod-POD', 'cdp-CDP', '购物卡-shopping', 'IE-ie', 'LV-lv', 'UPD-upd', 'PP-pp', '', '1515809685');

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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices
-- ----------------------------
INSERT INTO `pub_devices` VALUES ('51', '888888888888888', '1', '1515737757', '1', '15', '32', '吴智彬', '吴智彬吴智彬', '13425468956');
INSERT INTO `pub_devices` VALUES ('52', '666666666666666', '1', '1515739545', '1', '14', '33', '晴天', '广州市天河区天河路', '13855690085');
INSERT INTO `pub_devices` VALUES ('53', '111111111123232', '1', '1515742079', '1', null, '32', null, null, null);
INSERT INTO `pub_devices` VALUES ('54', '123123123123123', '1', '1515742104', '1', null, '32', null, null, null);
INSERT INTO `pub_devices` VALUES ('55', '222222222222222', '1', '1515742141', '1', '14', '32', '小琴', '广州市天河区', '13758908070');
INSERT INTO `pub_devices` VALUES ('56', '333333333333333', '1', '1515744249', '1', '16', '34', null, null, null);
INSERT INTO `pub_devices` VALUES ('57', '112733445596778', '1', '1515745332', '1', '14', '34', '小琴', '广州市天河区天河路', '13800001234');
INSERT INTO `pub_devices` VALUES ('58', '444444444444444', '1', '1515746711', '1', '18', '34', '雨天', '广州市天河区龙洞', '13686593645');
INSERT INTO `pub_devices` VALUES ('59', '111111111111111', '1', '1515747098', '1', '15', '34', '至少要是', '牛逼逼着打完会', '13425492566');
INSERT INTO `pub_devices` VALUES ('60', '162753445596778', '1', '1515750357', '1', '15', '34', '太阳', '广州东圃宦溪兴到吴智彬', '13788901308');
INSERT INTO `pub_devices` VALUES ('61', '352425025336838', '1', '1515750605', '1', null, '32', null, null, null);
INSERT INTO `pub_devices` VALUES ('62', '101010101010101', '1', '1515753935', '1', null, '32', null, null, null);
INSERT INTO `pub_devices` VALUES ('63', '201201201201201', '1', '1515754026', '1', '20', '32', '清清', '广州市人民政府', '13809658653');
INSERT INTO `pub_devices` VALUES ('64', '000000000000000', '1', '1515809652', '1', null, '33', null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices_statu
-- ----------------------------
INSERT INTO `pub_devices_statu` VALUES ('25', '112233445566778', '0', '-1', '100', '100', '100', '-1', '100', '-1', '100', '-1', '100', '-1', '100', '-1', '100', '-1', null, null, null, null, null, null, '2', '1', '0', '0', null, 'GPRS', '11223344556677889900', '90', '10020\0\0\0\0\0', '1515737163', '1515748016');
INSERT INTO `pub_devices_statu` VALUES ('26', '666666666666666', '11', '15850', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('27', '888888888888888', '11', '1450', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('28', '333333333333333', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('29', '222222222222222', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('30', '112733445596778', '11', '1800', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', null, null, null, 'GPRS', '11223344556677889900', '90', '10020\0\0\0\0\0', null, '1515757175');
INSERT INTO `pub_devices_statu` VALUES ('31', '444444444444444', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('32', '111111111111111', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('33', '352425025336838', '1', '-1', '-1', '0', '0', '-1', '0', '11', '0', '22', '0', '11', '0', '11', '0', '11', null, null, null, null, null, null, '0', '0', '0', '0', null, 'GPRS', '898602b8191750155005', '30', '25cb,708d\0', '1515749049', '1515816256');
INSERT INTO `pub_devices_statu` VALUES ('34', '162753445596778', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('35', '111111111111111', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `pub_devices_statu` VALUES ('36', '865473039777571', '1', '-1', '-1', '0', '0', '-1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, null, null, '0', '0', '0', '32166', null, 'GPRS', '898602b8191750155005', '20', '25CB,708D\0', '1515756892', '1515757794');
INSERT INTO `pub_devices_statu` VALUES ('37', '201201201201201', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

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
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_express_information
-- ----------------------------
INSERT INTO `pub_express_information` VALUES ('43', '14', '小琴', '13758096589', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('44', '14', '小琴', '13858096985', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('45', '14', '小琴', '13580958865', '广州市天河区', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('46', '14', '小杰', '13850089085', '广州市天河区', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('47', '14', '小琴', '13800869991', '广州市番禺区钟村', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('48', '16', '小梅', '13805829635', '广州市番禺区', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('49', '19', '夏凯', '13580952358', '广州地铁站附近', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('50', '14', '小琴', '13758690089', '广州市天河区', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('51', '14', '胡小姐', '13796320856', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('52', '14', '小琴', '13808089632', '广州市天河区天河客运站', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('53', '14', '小琴', '13758620985', '广州市天河区天河路', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('54', '14', '小琴', '13780093652', '广州市天河区', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('55', '14', '秦青', '13580096985', '广州市天河区天河路', null, null, '0');

-- ----------------------------
-- Table structure for pub_feeds
-- ----------------------------
DROP TABLE IF EXISTS `pub_feeds`;
CREATE TABLE `pub_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL COMMENT '反馈内容',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `addtime` int(11) NOT NULL COMMENT '反馈时间',
  `did` int(11) NOT NULL COMMENT '设备ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_feeds
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_filters
-- ----------------------------
INSERT INTO `pub_filters` VALUES ('12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '1515737714', '200.00');
INSERT INTO `pub_filters` VALUES ('13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '1515739470', '500.00');
INSERT INTO `pub_filters` VALUES ('14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '1515739450', '500.00');
INSERT INTO `pub_filters` VALUES ('15', 'LV', 'lv', '/upload/2018-01-12/5a586b1513bfa.jpg', '100', '100', null, null, '净水器过滤掉净水器过滤掉', 'http://www,baidu.com', '1515810494', '100.00');
INSERT INTO `pub_filters` VALUES ('16', 'IE', 'ie', '/upload/2018-01-12/5a586b388e144.jpg', '200', '200', null, null, 'sfasfasfsa还富含', '', '1515744056', '230.00');
INSERT INTO `pub_filters` VALUES ('17', '购物卡', 'shopping', '/upload/2018-01-12/5a586b686b316.jpg', '200', '200', null, null, '在线购物', '', '1515744104', '200.00');
INSERT INTO `pub_filters` VALUES ('18', 'cdp', 'CDP', '/upload/2018-01-12/5a586b8d50917.jpg', '1000', '1000', null, null, '', '', '1515744141', '500.00');
INSERT INTO `pub_filters` VALUES ('19', 'pod', 'POD', '/upload/2018-01-12/5a586bc429da4.jpg', '600', '600', null, null, '净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器', '', '1515810360', '600.00');

-- ----------------------------
-- Table structure for pub_flow
-- ----------------------------
DROP TABLE IF EXISTS `pub_flow`;
CREATE TABLE `pub_flow` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '充值流水ID',
  `did` int(11) unsigned NOT NULL COMMENT '用户ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单编号',
  `money` decimal(25,0) unsigned DEFAULT NULL COMMENT '充值金额',
  `mode` tinyint(1) unsigned DEFAULT NULL COMMENT '充值方式(0：系统赠送 1：微信 2：支付宝)',
  `flow` int(11) unsigned NOT NULL COMMENT '流量',
  `num` int(11) unsigned NOT NULL COMMENT '套餐数量',
  `describe` varchar(255) DEFAULT NULL COMMENT '套餐描述',
  `currentflow` int(11) unsigned DEFAULT NULL COMMENT '当前流量',
  `addtime` int(11) NOT NULL COMMENT '充值时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_flow
-- ----------------------------
INSERT INTO `pub_flow` VALUES ('62', '14', '49642801493552614', '10000', '1', '200', '1', '100元200流量', '200', '1515742708');
INSERT INTO `pub_flow` VALUES ('63', '14', '49642801493552614', '20000', '1', '500', '1', '200元500流量', '700', '1515742708');
INSERT INTO `pub_flow` VALUES ('64', '14', '49642801493552614', '1000', '1', '50', '1', '10元50时长', '750', '1515742708');
INSERT INTO `pub_flow` VALUES ('65', '14', '49642801493552614', '1000', '1', '100', '1', '10元100流量', '850', '1515742708');
INSERT INTO `pub_flow` VALUES ('66', '14', '49642801493552614', '80000', '1', '5000', '1', '800元5000流量', '5850', '1515742708');
INSERT INTO `pub_flow` VALUES ('67', '14', '49642801493552614', '100000', '1', '10000', '1', '1000元10000流量', '15850', '1515742708');
INSERT INTO `pub_flow` VALUES ('68', '14', '48518206752508214', '20000', '1', '500', '1', '200元500流量', '500', '1515751612');
INSERT INTO `pub_flow` VALUES ('69', '14', '48518206752508214', '10000', '1', '200', '3', '100元200流量', '1100', '1515751612');
INSERT INTO `pub_flow` VALUES ('70', '14', '90297103548445114', '20000', '1', '500', '1', '200元500流量', '1600', '1515752250');
INSERT INTO `pub_flow` VALUES ('71', '51', '23575394306834351', '20000', '1', '500', '1', '200元500流量', '500', '1515754683');
INSERT INTO `pub_flow` VALUES ('72', '51', '31132575621693251', '1000', '1', '50', '1', '10元50时长', '550', '1515754701');
INSERT INTO `pub_flow` VALUES ('73', '51', '31132575621693251', '20000', '1', '500', '1', '200元500流量', '1050', '1515754701');
INSERT INTO `pub_flow` VALUES ('74', '51', '31132575621693251', '10000', '1', '200', '1', '100元200流量', '1250', '1515754701');
INSERT INTO `pub_flow` VALUES ('75', '51', '67138141971283951', '10000', '1', '200', '1', '100元200流量', '1450', '1515754814');
INSERT INTO `pub_flow` VALUES ('76', '57', '49006062995039657', '10000', '1', '200', '1', '100元200流量', '1800', '1515759148');

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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------
INSERT INTO `pub_order_filter` VALUES ('60', '90019326699616714', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '2', '400.00', '1515742996', null);
INSERT INTO `pub_order_filter` VALUES ('61', '94764559218400614', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '3', '600.00', '1515743128', null);
INSERT INTO `pub_order_filter` VALUES ('62', '99343320857523414', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '5', '1000.00', '1515743372', null);
INSERT INTO `pub_order_filter` VALUES ('63', '99343320857523414', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '3', '1500.00', '1515743372', null);
INSERT INTO `pub_order_filter` VALUES ('64', '63807380575091314', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '3', '1500.00', '1515744971', null);
INSERT INTO `pub_order_filter` VALUES ('65', '63807380575091314', '14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '500.00', '3', '1500.00', '1515744971', null);
INSERT INTO `pub_order_filter` VALUES ('66', '63807380575091314', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '5', '1000.00', '1515744971', null);
INSERT INTO `pub_order_filter` VALUES ('67', '29320615326789814', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '4', '800.00', '1515745196', null);
INSERT INTO `pub_order_filter` VALUES ('68', '29320615326789814', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '3', '1500.00', '1515745196', null);
INSERT INTO `pub_order_filter` VALUES ('69', '29320615326789814', '14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '500.00', '2', '1000.00', '1515745196', null);
INSERT INTO `pub_order_filter` VALUES ('70', '90655315293646416', '17', '购物卡', 'shopping', '/upload/2018-01-12/5a586b686b316.jpg', '200', '200', null, null, '在线购物', '', '200.00', '2', '400.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('71', '90655315293646416', '18', 'cdp', 'CDP', '/upload/2018-01-12/5a586b8d50917.jpg', '1000', '1000', null, null, '', '', '500.00', '2', '1000.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('72', '90655315293646416', '19', 'pod', 'POD', '/upload/2018-01-12/5a586bc429da4.jpg', '600', '600', null, null, '净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器', '', '600.00', '2', '1200.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('73', '90655315293646416', '16', 'IE', 'ie', '/upload/2018-01-12/5a586b388e144.jpg', '200', '200', null, null, 'sfasfasfsa还富含', '', '230.00', '2', '460.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('74', '90655315293646416', '15', 'LV', 'lv', '/upload/2018-01-12/5a586b1513bfa.jpg', '100', '100', null, null, '净水器过滤掉净水器过滤掉', 'http://www,baidu.com', '100.00', '3', '300.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('75', '90655315293646416', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '2', '1000.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('76', '90655315293646416', '14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '500.00', '1', '500.00', '1515746555', null);
INSERT INTO `pub_order_filter` VALUES ('77', '29311344528807519', '15', 'LV', 'lv', '/upload/2018-01-12/5a586b1513bfa.jpg', '100', '100', null, null, '净水器过滤掉净水器过滤掉', 'http://www,baidu.com', '100.00', '7', '700.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('78', '29311344528807519', '16', 'IE', 'ie', '/upload/2018-01-12/5a586b388e144.jpg', '200', '200', null, null, 'sfasfasfsa还富含', '', '230.00', '1', '230.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('79', '29311344528807519', '17', '购物卡', 'shopping', '/upload/2018-01-12/5a586b686b316.jpg', '200', '200', null, null, '在线购物', '', '200.00', '1', '200.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('80', '29311344528807519', '18', 'cdp', 'CDP', '/upload/2018-01-12/5a586b8d50917.jpg', '1000', '1000', null, null, '', '', '500.00', '7', '3500.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('81', '29311344528807519', '19', 'pod', 'POD', '/upload/2018-01-12/5a586bc429da4.jpg', '600', '600', null, null, '净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器净水器', '', '600.00', '1', '600.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('82', '29311344528807519', '14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '500.00', '1', '500.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('83', '29311344528807519', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '1', '500.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('84', '29311344528807519', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '1', '200.00', '1515747269', null);
INSERT INTO `pub_order_filter` VALUES ('85', '48518206752508214', '14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '500.00', '1', '500.00', '1515751605', null);
INSERT INTO `pub_order_filter` VALUES ('86', '48518206752508214', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '1', '500.00', '1515751605', null);
INSERT INTO `pub_order_filter` VALUES ('87', '48518206752508214', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '1', '200.00', '1515751605', null);
INSERT INTO `pub_order_filter` VALUES ('88', '68413621973676214', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '1', '500.00', '1515752804', null);
INSERT INTO `pub_order_filter` VALUES ('89', '68413621973676214', '14', 'UPD', 'upd', '/upload/2018-01-12/5a58593a4ec4d.jpg', '300', '600', null, null, 'upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤upd过滤，净水器过滤', 'http://www.baidu.com', '500.00', '2', '1000.00', '1515752804', null);
INSERT INTO `pub_order_filter` VALUES ('90', '68413621973676214', '15', 'LV', 'lv', '/upload/2018-01-12/5a586b1513bfa.jpg', '100', '100', null, null, '净水器过滤掉净水器过滤掉', 'http://www,baidu.com', '100.00', '2', '200.00', '1515752804', null);
INSERT INTO `pub_order_filter` VALUES ('91', '68413621973676214', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '2', '400.00', '1515752804', null);
INSERT INTO `pub_order_filter` VALUES ('92', '21098418283469514', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '2', '400.00', '1515753263', null);
INSERT INTO `pub_order_filter` VALUES ('93', '85179309469450557', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '2', '400.00', '1515756567', null);
INSERT INTO `pub_order_filter` VALUES ('94', '34233774865116257', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '2', '400.00', '1515806533', null);
INSERT INTO `pub_order_filter` VALUES ('95', '34233774865116257', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '3', '1500.00', '1515806533', null);
INSERT INTO `pub_order_filter` VALUES ('96', '77360316654111257', '13', 'PP', 'pp', '/upload/2018-01-12/5a5858dc55290.jpg', '200', '600', null, null, 'pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，pp净水器过滤，', '', '500.00', '3', '1500.00', '1515815527', null);
INSERT INTO `pub_order_filter` VALUES ('97', '77360316654111257', '12', '滤芯', '滤芯A型', '/upload/2018-01-12/5a5852642c776.jpg', '230', '3000', null, null, '设备滤芯，过滤，净水器，200元230小时，3000升流量', '', '200.00', '4', '800.00', '1515815527', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=491 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES ('438', '49642801493552614', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515742701', null);
INSERT INTO `pub_order_setmeal` VALUES ('439', '49642801493552614', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515742701', null);
INSERT INTO `pub_order_setmeal` VALUES ('440', '49642801493552614', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515742701', null);
INSERT INTO `pub_order_setmeal` VALUES ('441', '49642801493552614', '28', '32', '0', '1000.00', '100', '10元100流量', '1', '1000.00', '1515742701', null);
INSERT INTO `pub_order_setmeal` VALUES ('442', '49642801493552614', '30', '32', '0', '80000.00', '5000', '800元5000流量', '1', '80000.00', '1515742701', null);
INSERT INTO `pub_order_setmeal` VALUES ('443', '49642801493552614', '31', '32', '0', '100000.00', '10000', '1000元10000流量', '1', '100000.00', '1515742701', null);
INSERT INTO `pub_order_setmeal` VALUES ('444', '85745508149869514', '30', '32', '0', '80000.00', '5000', '800元5000流量', '1', '80000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('445', '85745508149869514', '29', '32', '1', '1000.00', '100', '10元100时长', '1', '1000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('446', '85745508149869514', '28', '32', '0', '1000.00', '100', '10元100流量', '1', '1000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('447', '85745508149869514', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('448', '85745508149869514', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('449', '85745508149869514', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('450', '85745508149869514', '31', '32', '0', '100000.00', '10000', '1000元10000流量', '1', '100000.00', '1515742880', null);
INSERT INTO `pub_order_setmeal` VALUES ('451', '33923218935964014', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515742929', null);
INSERT INTO `pub_order_setmeal` VALUES ('452', '92097984704948714', '31', '32', '0', '100000.00', '10000', '1000元10000流量', '1', '100000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('453', '92097984704948714', '30', '32', '0', '80000.00', '5000', '800元5000流量', '1', '80000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('454', '92097984704948714', '29', '32', '1', '1000.00', '100', '10元100时长', '1', '1000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('455', '92097984704948714', '28', '32', '0', '1000.00', '100', '10元100流量', '1', '1000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('456', '92097984704948714', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('457', '92097984704948714', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('458', '92097984704948714', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515743535', null);
INSERT INTO `pub_order_setmeal` VALUES ('459', '63807380575091314', '24', '32', '0', '10000.00', '200', '100元200流量', '2', '20000.00', '1515744971', null);
INSERT INTO `pub_order_setmeal` VALUES ('460', '68145198913015616', '31', '32', '0', '100000.00', '10000', '1000元10000流量', '1', '100000.00', '1515746004', null);
INSERT INTO `pub_order_setmeal` VALUES ('461', '68145198913015616', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515746004', null);
INSERT INTO `pub_order_setmeal` VALUES ('462', '68145198913015616', '29', '32', '1', '1000.00', '100', '10元100时长', '2', '2000.00', '1515746004', null);
INSERT INTO `pub_order_setmeal` VALUES ('463', '68145198913015616', '25', '32', '0', '20000.00', '500', '200元500流量', '2', '40000.00', '1515746004', null);
INSERT INTO `pub_order_setmeal` VALUES ('464', '68145198913015616', '28', '32', '0', '1000.00', '100', '10元100流量', '1', '1000.00', '1515746004', null);
INSERT INTO `pub_order_setmeal` VALUES ('465', '68145198913015616', '30', '32', '0', '80000.00', '5000', '800元5000流量', '1', '80000.00', '1515746004', null);
INSERT INTO `pub_order_setmeal` VALUES ('466', '48518206752508214', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515751605', null);
INSERT INTO `pub_order_setmeal` VALUES ('467', '48518206752508214', '24', '32', '0', '10000.00', '200', '100元200流量', '3', '30000.00', '1515751605', null);
INSERT INTO `pub_order_setmeal` VALUES ('468', '85411800489841914', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515752226', null);
INSERT INTO `pub_order_setmeal` VALUES ('469', '90297103548445114', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515752240', null);
INSERT INTO `pub_order_setmeal` VALUES ('470', '31132575621693251', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515754449', null);
INSERT INTO `pub_order_setmeal` VALUES ('471', '31132575621693251', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515754449', null);
INSERT INTO `pub_order_setmeal` VALUES ('472', '31132575621693251', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515754449', null);
INSERT INTO `pub_order_setmeal` VALUES ('473', '67138141971283951', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515754559', null);
INSERT INTO `pub_order_setmeal` VALUES ('474', '23575394306834351', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515754677', null);
INSERT INTO `pub_order_setmeal` VALUES ('475', '49006062995039657', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515759141', null);
INSERT INTO `pub_order_setmeal` VALUES ('476', '14953981426315057', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515807004', null);
INSERT INTO `pub_order_setmeal` VALUES ('477', '74478137241135757', '30', '32', '0', '80000.00', '5000', '800元5000流量', '1', '80000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('478', '74478137241135757', '29', '32', '1', '1000.00', '100', '10元100时长', '1', '1000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('479', '74478137241135757', '28', '32', '0', '1000.00', '100', '10元100流量', '1', '1000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('480', '74478137241135757', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('481', '74478137241135757', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('482', '74478137241135757', '24', '32', '0', '10000.00', '200', '100元200流量', '1', '10000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('483', '74478137241135757', '31', '32', '0', '100000.00', '10000', '1000元10000流量', '1', '100000.00', '1515807161', null);
INSERT INTO `pub_order_setmeal` VALUES ('484', '61296440826382857', '31', '32', '0', '100000.00', '10000', '1000元10000流量', '2', '200000.00', '1515807208', null);
INSERT INTO `pub_order_setmeal` VALUES ('485', '61296440826382857', '30', '32', '0', '80000.00', '5000', '800元5000流量', '1', '80000.00', '1515807208', null);
INSERT INTO `pub_order_setmeal` VALUES ('486', '61296440826382857', '29', '32', '1', '1000.00', '100', '10元100时长', '1', '1000.00', '1515807208', null);
INSERT INTO `pub_order_setmeal` VALUES ('487', '61296440826382857', '28', '32', '0', '1000.00', '100', '10元100流量', '1', '1000.00', '1515807208', null);
INSERT INTO `pub_order_setmeal` VALUES ('488', '61296440826382857', '26', '32', '1', '1000.00', '50', '10元50时长', '1', '1000.00', '1515807208', null);
INSERT INTO `pub_order_setmeal` VALUES ('489', '61296440826382857', '25', '32', '0', '20000.00', '500', '200元500流量', '1', '20000.00', '1515807208', null);
INSERT INTO `pub_order_setmeal` VALUES ('490', '61296440826382857', '24', '32', '0', '10000.00', '200', '100元200流量', '3', '30000.00', '1515807208', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=655 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('627', '49642801493552614', '52', '14', null, '6', '212000.00', '1515742701', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('628', '85745508149869514', '52', '14', null, '7', '213000.00', '1515742880', '1515743283', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('629', '33923218935964014', '52', '14', null, '1', '10000.00', '1515742929', '1515743314', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('630', '90019326699616714', '52', '14', '43', '2', '400.00', '1515742996', '1515743262', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('631', '94764559218400614', '52', '14', '44', '3', '600.00', '1515743128', '1515743258', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('632', '99343320857523414', '52', '14', '45', '8', '2500.00', '1515743372', '1515743436', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('633', '92097984704948714', '52', '14', null, '7', '213000.00', '1515743535', '1515815302', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('634', '63807380575091314', '52', '14', '46', '13', '24000.00', '1515744971', '1515747524', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('635', '29320615326789814', '52', '14', '47', '9', '3300.00', '1515745196', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('636', '68145198913015616', '56', '16', null, '8', '224000.00', '1515746004', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('637', '90655315293646416', '56', '16', '48', '14', '4860.00', '1515746555', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('638', '29311344528807519', '59', '19', '49', '20', '6430.00', '1515747269', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('639', '48518206752508214', '52', '14', '50', '7', '51200.00', '1515751605', '1515752145', '1', '1', '1', '1', '运通', '245115210210512540');
INSERT INTO `pub_orders` VALUES ('640', '81951899905163914', '52', '14', '50', '0', '0.00', '1515751606', '1515815297', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('641', '85411800489841914', '52', '14', null, '1', '10000.00', '1515752226', '1515815144', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('642', '90297103548445114', '52', '14', null, '1', '20000.00', '1515752240', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('643', '68413621973676214', '52', '14', '51', '7', '2100.00', '1515752804', '1515752880', '1', '1', '1', '0', '圆通', '213521252115221');
INSERT INTO `pub_orders` VALUES ('644', '21098418283469514', '52', '14', '52', '2', '400.00', '1515753263', '1515815096', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('645', '31132575621693251', '51', '15', null, '3', '31000.00', '1515754449', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('646', '67138141971283951', '51', '15', null, '1', '10000.00', '1515754559', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('647', '23575394306834351', '51', '15', null, '1', '20000.00', '1515754677', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('648', '85179309469450557', '52', '14', '53', '2', '400.00', '1515756567', '1515815038', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('649', '49006062995039657', '52', '14', null, '1', '10000.00', '1515759141', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('650', '34233774865116257', '52', '14', '54', '5', '1900.00', '1515806533', '1515806638', '1', '1', '1', '0', '顺丰', '123456123654');
INSERT INTO `pub_orders` VALUES ('651', '14953981426315057', '52', '14', null, '1', '10000.00', '1515807004', '1515815089', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('652', '74478137241135757', '52', '14', null, '7', '213000.00', '1515807161', '1515814981', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('653', '61296440826382857', '52', '14', null, '10', '333000.00', '1515807208', '1515815035', '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('654', '77360316654111257', '52', '14', '55', '7', '2300.00', '1515815527', '1515815665', '1', '1', '1', '0', '发任务', '121231241234123');

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
  `did` int(11) NOT NULL COMMENT '设备ID',
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
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_setmeal
-- ----------------------------
INSERT INTO `pub_setmeal` VALUES ('24', '32', '0', '10000.00', '200', '100元200流量', '1515738123');
INSERT INTO `pub_setmeal` VALUES ('25', '32', '0', '20000.00', '500', '200元500流量', '1515738165');
INSERT INTO `pub_setmeal` VALUES ('26', '32', '1', '1000.00', '50', '10元50时长', '1515738209');
INSERT INTO `pub_setmeal` VALUES ('28', '32', '0', '1000.00', '100', '10元100流量', '1515742370');
INSERT INTO `pub_setmeal` VALUES ('29', '32', '1', '1000.00', '100', '10元100时长', '1515742477');
INSERT INTO `pub_setmeal` VALUES ('30', '32', '0', '80000.00', '5000', '800元5000流量', '1515742523');
INSERT INTO `pub_setmeal` VALUES ('31', '32', '0', '100000.00', '10000', '1000元10000流量', '1515742560');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_users
-- ----------------------------
INSERT INTO `pub_users` VALUES ('14', '1', '1515741535', '140.207.54.76', '1515741535', '0', 'oXwY4t_vkTgtlD0CBTZ-vTbIMWHs', null);
INSERT INTO `pub_users` VALUES ('15', '1', '1515741995', '140.207.54.75', '1515741995', '0', 'oXwY4t-9clttAFWXjCcNRJrvch3w', null);
INSERT INTO `pub_users` VALUES ('16', '1', '1515743883', '140.207.54.79', '1515743883', '0', 'oXwY4t6w6M5cPnSXL79sy352Tgzs', null);
INSERT INTO `pub_users` VALUES ('17', '1', '1515746533', '140.207.54.75', '1515746533', '0', 'oXwY4txlP9OKwEDbVUMvUXP_7FhA', null);
INSERT INTO `pub_users` VALUES ('18', '1', '1515746864', '140.207.54.75', '1515746864', '0', 'oXwY4tzmil2SItRr5-x3Fo6Wl5Cw', null);
INSERT INTO `pub_users` VALUES ('19', '1', '1515747132', '140.207.54.79', '1515747132', '0', 'oXwY4t_AcFXkov6SdeQDz0VPEkXc', null);
INSERT INTO `pub_users` VALUES ('20', '1', '1515807419', '140.207.54.76', '1515807419', '0', 'oXwY4t7hYDxtr2sMqqEa5ZVJpinU', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_vendors
-- ----------------------------
INSERT INTO `pub_vendors` VALUES ('1', 'admin', '炒鸡管理员', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '内蒙古 赤峰市 天义镇', '0', '0', '1515638832', '430122199610224517');
INSERT INTO `pub_vendors` VALUES ('19', '小琴', '小琴', 'e10adc3949ba59abbe56e057f20f883e', '13524216254', '11@163.com', '上海市 上海市 徐汇区', '1', '1', '1515809897', '421532199809082563');
INSERT INTO `pub_vendors` VALUES ('21', '海洋', '大海', 'e10adc3949ba59abbe56e057f20f883e', '13526530021', '11@163.com', '重庆市 重庆市 沙坪坝区', '2', '1', '1515809853', '412512199605084215');

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_wechat
-- ----------------------------
INSERT INTO `pub_wechat` VALUES ('41', 'oXwY4t_vkTgtlD0CBTZ-vTbIMWHs', '快乐翱翔', 'http://wx.qlogo.cn/mmopen/SnnOkFO2wxicJ3kkvXosHGKia14CzVTb51HMKXvx5blEQiaU9dXPPEib2S1iaFbztPia21t0hO1VQrf5Upsd3NoMC28SudibxQ2OBDib/132', '2', '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES ('42', 'oXwY4t-9clttAFWXjCcNRJrvch3w', '吴智彬-13425492760', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8qyNnJ5VbBX8GfWLFN1hiaXCtNPcjFSd5mktEqADXrrXMslURMTZLNI08ricsI8TjvVmxuSpEv4MR21bEONUicEuRO/132', '1', '广东', '中国 广东 广州');
INSERT INTO `pub_wechat` VALUES ('43', 'oXwY4t6w6M5cPnSXL79sy352Tgzs', '苏格拉没有底', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3ShK2dPsMiaYq4iaI11cMbGnoua5ptJYaF2wA74pX0QJfLJSkESLsSBpRRy0stHHIJHKqjkZMAN8AmjUeLj4DPfHF/132', '1', '', '安道尔  ');
INSERT INTO `pub_wechat` VALUES ('44', 'oXwY4txlP9OKwEDbVUMvUXP_7FhA', '平常心', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8oShMxicsKArK4niaI3MNaEadB4LgUBia2JTSoiaj0f4ltR7ia9PmqpwPq4nGzLn6Yu37goqHzWV9yROQOPaDeBGov4f/132', '1', '广西', '中国 广西 桂林');
INSERT INTO `pub_wechat` VALUES ('45', 'oXwY4tzmil2SItRr5-x3Fo6Wl5Cw', '在⻊各上', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3THIBouQJgTKJUScsbhFo3nib4dNY8cgDXtZGnMl6YibbiasgHxibevWIm2lXqQ9Mx6j6Z3X5XKn0XD6K6PIVEiazZ7F/132', '1', '广东', '中国 广东 汕尾');
INSERT INTO `pub_wechat` VALUES ('46', 'oXwY4t_AcFXkov6SdeQDz0VPEkXc', '芒果冰', 'http://wx.qlogo.cn/mmopen/c33WYHOwu8roRNQT3vAkXkI4p8laCehyhHOZTq22ak4v50foicTVXatTAuaVy9vgvhh4NO7uibq0xNxLgMglg4iar7zf5lAnLag/132', '1', '广东', '中国 广东 清远');
INSERT INTO `pub_wechat` VALUES ('47', 'oXwY4t7hYDxtr2sMqqEa5ZVJpinU', 'Trc', 'http://wx.qlogo.cn/mmopen/Q3auHgzwzM4WO74R7tVYoTaXRH1CV3HV9F9IJ0AH8BNpt1dTM0ShmxKqRIs6vTjWUDJEeePA9xJHibE7uiaXf7d8XcmMmyEiaK3CPNYwOxUwfg/132', '2', '广东', '中国 广东 广州');

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

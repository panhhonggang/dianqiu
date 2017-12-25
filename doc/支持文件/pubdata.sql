/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-25 09:47:06
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
INSERT INTO `pub_auth_group` VALUES ('2', ' 普通管理员', '1', '1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26');

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
INSERT INTO `pub_auth_group_access` VALUES ('5', '2');

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
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='规则表';

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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_binding
-- ----------------------------
INSERT INTO `pub_binding` VALUES ('1', '2', '1', '炒鸡管理员', '12323123');
INSERT INTO `pub_binding` VALUES ('12', '3', '2', '炒鸡管理员', '1512460340');
INSERT INTO `pub_binding` VALUES ('13', '2', '3', '炒鸡管理员', '1512540689');

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
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_filters
-- ----------------------------

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
) ENGINE=MyISAM AUTO_INCREMENT=364 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_setmeal
-- ----------------------------

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
-- Table structure for pub_current_devices
-- ----------------------------
DROP TABLE IF EXISTS `pub_current_devices`;
CREATE TABLE `pub_current_devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(11) unsigned NOT NULL COMMENT '用户',
  `did` int(11) unsigned NOT NULL COMMENT '当前设备',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of pub_current_devices
-- ----------------------------
INSERT INTO `pub_current_devices` VALUES ('1', '10', '3');

-- ----------------------------
-- Table structure for pub_devices
-- ----------------------------
DROP TABLE IF EXISTS `pub_devices`;
CREATE TABLE `pub_devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `device_code` int(20) unsigned NOT NULL COMMENT '设备编码',
  `device_statu` tinyint(1) unsigned NOT NULL COMMENT '设备状态：1已入库，2待激活，3已激活',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `binding_statu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否绑定经销商 0：未绑定 1：已绑定',
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `type_id` int(11) NOT NULL COMMENT '产品类型ID',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`device_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices
-- ----------------------------
INSERT INTO `pub_devices` VALUES ('3', '2147483647', '1', '1512540680', '1', '10', '10');
INSERT INTO `pub_devices` VALUES ('4', '2147483647', '1', '1513049252', '0', null, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices_statu
-- ----------------------------
INSERT INTO `pub_devices_statu` VALUES ('1', '112233445566778', '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', null, null, null, 'GPRS', '11223344556677889900', '90', '10020\0\0\0\0\0', '1513238294', '1513299086');

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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_device_type
-- ----------------------------
INSERT INTO `pub_device_type` VALUES ('10', '高级型', 'RO膜-A型', 'RO膜PP-C型', 'RO膜2号-B型', '', '', '', '', '', '1513048485');

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
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_express_information
-- ----------------------------
INSERT INTO `pub_express_information` VALUES ('1', '10', '吴智彬', '13425492760', '中国广州东圃', null, null, '1');
INSERT INTO `pub_express_information` VALUES ('2', '10', '吴智彬', '13425492760', '辅导费多岁的', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('3', '10', '吴直播', '13425492760', '发的发幅度为', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('4', '10', '我都是', '13425462563', '中国观众讲的是', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('16', '10', '吴智彬号东圃', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('17', '10', '吴智彬无智彬', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('18', '10', '吴智彬中国', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('19', '10', '吴智彬废物', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('20', '10', '吴智彬废物任务十分', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('21', '10', '吴智彬都是', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('22', '10', '吴智彬范围', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('23', '10', '吴智彬uuu', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('24', '10', '吴智彬Hhj', '13425492760', '中国广州东圃', null, null, '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_feeds
-- ----------------------------
INSERT INTO `pub_feeds` VALUES ('1', '这个产品真不错啊', '10', '1566897799');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_filters
-- ----------------------------
INSERT INTO `pub_filters` VALUES ('1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1509673437', '1000.00');
INSERT INTO `pub_filters` VALUES ('2', 'PP棉', 'A型', '/Public/Home/images/ro_02.png', '123', '321', null, null, '凄凄切切我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1509607569', '2000.00');
INSERT INTO `pub_filters` VALUES ('3', 'PP棉2号', null, '/Public/Home/images/ro_02.png', '234', '432', null, null, '尺寸齐全我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1509607600', '3000.00');
INSERT INTO `pub_filters` VALUES ('4', 'RO膜2号', 'B型', '/Public/Home/images/ro_02.png', '5343', '3333', null, null, '望闻问切去我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1509673448', '4000.00');
INSERT INTO `pub_filters` VALUES ('5', 'PPRO', null, '/Public/Home/images/ro_02.png', '500', '2000', null, null, '啊啊按时到我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1509607666', '5000.00');
INSERT INTO `pub_filters` VALUES ('6', 'RO膜PP', 'C型', '/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1509673463', '6000.00');
INSERT INTO `pub_filters` VALUES ('7', 'RO膜PP1', '', '/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实', 'http://www.baidu.com', '1509673287', '7000.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('230', '20171221151383312016454761061309', '3', '10', '12', '2', '11000.00', '1513833120', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('231', '20171221151383332634814141852704', '3', '10', '1', '2', '11000.00', '1513833326', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('232', '20171221151383340685215153131405', '3', '10', '1', '3', '26000.00', '1513833406', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('233', '20171221151383386174182037136774', '3', '10', '1', '1', '1000.00', '1513833861', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('234', '20171221151383470857241102225325', '3', '10', '1', '2', '11000.00', '1513834708', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('235', '20171221151383480625343451397009', '3', '10', '1', '2', '11000.00', '1513834806', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('236', '20171221151383594380214727336508', '3', '10', null, '2', '11000.00', '1513835943', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('237', '20171221151383598674745321313165', '3', '10', '22', '3', '17000.00', '1513835986', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('238', '20171221151383629177584575658963', '3', '10', null, '1', '10000.00', '1513836291', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('239', '20171221151383631525878072281191', '3', '10', null, '1', '10000.00', '1513836315', null, '3', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('240', '20171221151383633437767370376508', '3', '10', null, '2', '30000.00', '1513836334', null, '2', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('241', '20171221151383636519516722199376', '3', '10', '23', '1', '1000.00', '1513836365', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('242', '20171221151383775641640485329328', '3', '10', '24', '1', '1000.00', '1513837756', null, '1', '1', '0', '0', '顺丰', '1324659945665645');
INSERT INTO `pub_orders` VALUES ('243', '20171221151383798395450778058350', '3', '10', '1', '1', '1000.00', '1513837983', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('244', '20171221151383815612241239011554', '3', '10', null, '1', '10000.00', '1513838156', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('245', '20171221151383817312271461223664', '3', '10', null, '1', '20000.00', '1513838173', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('246', '20171221151383819120695502558515', '3', '10', null, '2', '30000.00', '1513838191', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('247', '20171221151383821195945932887410', '3', '10', '1', '1', '1000.00', '1513838211', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('248', '20171221151383823191181960535688', '3', '10', '1', '3', '17000.00', '1513838231', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('249', '20171221151383829196069397281586', '3', '10', null, '1', '10000.00', '1513838291', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('250', '20171221151383869889439145439655', '3', '10', null, '1', '10000.00', '1513838698', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('251', '20171221151383874486932180949530', '3', '10', null, '1', '10000.00', '1513838744', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('252', '20171221151383921956667323285097', '3', '10', null, '1', '10000.00', '1513839219', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('253', '20171221151383923342537362335171', '3', '10', null, '1', '10000.00', '1513839233', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('254', '20171221151383936292277547018289', '3', '10', null, '1', '10000.00', '1513839362', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('255', '20171221151383938365618285663362', '3', '10', null, '2', '30000.00', '1513839383', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('256', '20171221151383941916078055606562', '3', '10', '1', '5', '51000.00', '1513839419', null, '1', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('257', '20171221151383947052925069831253', '3', '10', null, '1', '10000.00', '1513839470', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('258', '20171221151383952257678633593351', '3', '10', null, '2', '30000.00', '1513839522', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('259', '20171221151384274382589621265408', '3', '10', null, '1', '10000.00', '1513842743', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('260', '20171221151384274955438097739132', '3', '10', null, '1', '20000.00', '1513842749', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('261', '20171221151384275950872235577567', '3', '10', null, '1', '10000.00', '1513842759', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('262', '20171221151384278561680391728678', '3', '10', null, '1', '10000.00', '1513842785', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('263', '20171221151384283046561839091518', '3', '10', null, '1', '10000.00', '1513842830', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('264', '20171221151384283917894097083137', '3', '10', null, '1', '10000.00', '1513842839', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('265', '20171221151384302298245613771343', '3', '10', null, '1', '10000.00', '1513843022', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('266', '20171221151384303178265502886830', '3', '10', null, '1', '10000.00', '1513843031', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('267', '20171221151384304674439037172253', '3', '10', null, '2', '30000.00', '1513843046', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('268', '20171221151384320082146163498188', '3', '10', null, '1', '10000.00', '1513843200', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('269', '20171221151384359249882276725182', '3', '10', null, '1', '10000.00', '1513843592', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('270', '20171221151384361473756108596191', '3', '10', null, '1', '10000.00', '1513843614', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('271', '20171221151384366827724545614454', '3', '10', null, '2', '30000.00', '1513843668', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('272', '20171221151384370822261789973299', '3', '10', null, '2', '20000.00', '1513843708', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('273', '20171221151384381511445371302176', '3', '10', '25', '1', '1000.00', '1513843815', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('274', '20171221151384411967011501977210', '3', '10', '1', '28', '125000.00', '1513844119', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('275', '20171221151384424366548654105877', '3', '10', null, '1', '20000.00', '1513844243', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('276', '20171221151384507783115719058858', '3', '10', null, '1', '10000.00', '1513845077', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('277', '20171221151384591177335899907146', '3', '10', null, '1', '10000.00', '1513845911', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('278', '20171221151384592956097874378477', '3', '10', null, '2', '30000.00', '1513845929', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('279', '20171221151384595260745399812354', '3', '10', '1', '1', '1000.00', '1513845952', null, '0', null, null, null, null, null);
INSERT INTO `pub_orders` VALUES ('280', '20171221151384920297743045584269', '3', '10', null, '1', '10000.00', '1513849202', null, '0', null, null, null, null, null);

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
  `updated_at` int(11) NOT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------
INSERT INTO `pub_order_filter` VALUES ('8', '20171221151383312016454761061309', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513833120', '0');
INSERT INTO `pub_order_filter` VALUES ('9', '20171221151383332634814141852704', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513833326', '0');
INSERT INTO `pub_order_filter` VALUES ('10', '20171221151383340685215153131405', '6', 'RO膜PP', 'C型', '/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '1', '6000.00', '1513833406', '0');
INSERT INTO `pub_order_filter` VALUES ('11', '20171221151383386174182037136774', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513833861', '0');
INSERT INTO `pub_order_filter` VALUES ('12', '20171221151383470857241102225325', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513834708', '0');
INSERT INTO `pub_order_filter` VALUES ('13', '20171221151383480625343451397009', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513834806', '0');
INSERT INTO `pub_order_filter` VALUES ('14', '20171221151383594380214727336508', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513835943', '0');
INSERT INTO `pub_order_filter` VALUES ('15', '20171221151383598674745321313165', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513835986', '0');
INSERT INTO `pub_order_filter` VALUES ('16', '20171221151383598674745321313165', '6', 'RO膜PP', 'C型', '/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '1', '6000.00', '1513835986', '0');
INSERT INTO `pub_order_filter` VALUES ('17', '20171221151383636519516722199376', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513836365', '0');
INSERT INTO `pub_order_filter` VALUES ('18', '20171221151383775641640485329328', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513837756', '0');
INSERT INTO `pub_order_filter` VALUES ('19', '20171221151383798395450778058350', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513837983', '0');
INSERT INTO `pub_order_filter` VALUES ('20', '20171221151383821195945932887410', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513838211', '0');
INSERT INTO `pub_order_filter` VALUES ('21', '20171221151383823191181960535688', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513838231', '0');
INSERT INTO `pub_order_filter` VALUES ('22', '20171221151383823191181960535688', '6', 'RO膜PP', 'C型', '/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '1', '6000.00', '1513838231', '0');
INSERT INTO `pub_order_filter` VALUES ('23', '20171221151383941916078055606562', '1', 'RO膜', 'A型', '/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1513839419', '0');
INSERT INTO `pub_order_filter` VALUES ('24', '20171221151383941916078055606562', '6', 'RO膜PP', 'C型', '/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '1', '6000.00', '1513839419', '0');
INSERT INTO `pub_order_filter` VALUES ('25', '20171221151383941916078055606562', '4', 'RO膜2号', 'B型', '/Public/Home/images/ro_02.png', '5343', '3333', null, null, '望闻问切去我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '4000.00', '1', '4000.00', '1513839419', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES ('268', '20171221151383312016454761061309', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513833120', null);
INSERT INTO `pub_order_setmeal` VALUES ('269', '20171221151383332634814141852704', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513833326', null);
INSERT INTO `pub_order_setmeal` VALUES ('270', '20171221151383340685215153131405', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '2', '20000.00', '1513833406', null);
INSERT INTO `pub_order_setmeal` VALUES ('271', '20171221151383470857241102225325', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513834708', null);
INSERT INTO `pub_order_setmeal` VALUES ('272', '20171221151383480625343451397009', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513834806', null);
INSERT INTO `pub_order_setmeal` VALUES ('273', '20171221151383594380214727336508', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513835943', null);
INSERT INTO `pub_order_setmeal` VALUES ('274', '20171221151383598674745321313165', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513835986', null);
INSERT INTO `pub_order_setmeal` VALUES ('275', '20171221151383629177584575658963', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513836291', null);
INSERT INTO `pub_order_setmeal` VALUES ('276', '20171221151383631525878072281191', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513836315', null);
INSERT INTO `pub_order_setmeal` VALUES ('277', '20171221151383633437767370376508', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1', '20000.00', '1513836334', null);
INSERT INTO `pub_order_setmeal` VALUES ('278', '20171221151383633437767370376508', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513836334', null);
INSERT INTO `pub_order_setmeal` VALUES ('279', '20171221151383815612241239011554', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513838156', null);
INSERT INTO `pub_order_setmeal` VALUES ('280', '20171221151383817312271461223664', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1', '20000.00', '1513838173', null);
INSERT INTO `pub_order_setmeal` VALUES ('281', '20171221151383819120695502558515', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1', '20000.00', '1513838191', null);
INSERT INTO `pub_order_setmeal` VALUES ('282', '20171221151383819120695502558515', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513838191', null);
INSERT INTO `pub_order_setmeal` VALUES ('283', '20171221151383823191181960535688', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513838231', null);
INSERT INTO `pub_order_setmeal` VALUES ('284', '20171221151383829196069397281586', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513838291', null);
INSERT INTO `pub_order_setmeal` VALUES ('285', '20171221151383869889439145439655', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513838698', null);
INSERT INTO `pub_order_setmeal` VALUES ('286', '20171221151383874486932180949530', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513838744', null);
INSERT INTO `pub_order_setmeal` VALUES ('287', '20171221151383921956667323285097', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839219', null);
INSERT INTO `pub_order_setmeal` VALUES ('288', '20171221151383923342537362335171', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839233', null);
INSERT INTO `pub_order_setmeal` VALUES ('289', '20171221151383936292277547018289', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839362', null);
INSERT INTO `pub_order_setmeal` VALUES ('290', '20171221151383938365618285663362', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1', '20000.00', '1513839383', null);
INSERT INTO `pub_order_setmeal` VALUES ('291', '20171221151383938365618285663362', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839383', null);
INSERT INTO `pub_order_setmeal` VALUES ('292', '20171221151383941916078055606562', '3', '10', '0', '30000.00', '3000', '300元包3000升流量', '1', '30000.00', '1513839419', null);
INSERT INTO `pub_order_setmeal` VALUES ('293', '20171221151383941916078055606562', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839419', null);
INSERT INTO `pub_order_setmeal` VALUES ('294', '20171221151383947052925069831253', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839470', null);
INSERT INTO `pub_order_setmeal` VALUES ('295', '20171221151383952257678633593351', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1', '20000.00', '1513839522', null);
INSERT INTO `pub_order_setmeal` VALUES ('296', '20171221151383952257678633593351', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1513839522', null);

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
INSERT INTO `pub_repair` VALUES ('1', '2147483647', '今天设备开不了机了', '假装我是图片路径', '10', '广东广州', '1565494664', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_setmeal
-- ----------------------------
INSERT INTO `pub_setmeal` VALUES ('1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1512958408');
INSERT INTO `pub_setmeal` VALUES ('2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1512958436');
INSERT INTO `pub_setmeal` VALUES ('3', '10', '0', '30000.00', '3000', '300元包3000升流量', '1512958962');

-- ----------------------------
-- Table structure for pub_users
-- ----------------------------
DROP TABLE IF EXISTS `pub_users`;
CREATE TABLE `pub_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(15) DEFAULT NULL COMMENT '用户名字',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `user_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态',
  `login_time` int(11) DEFAULT NULL COMMENT '最后登陆的时间',
  `login_ip` varchar(15) DEFAULT NULL COMMENT '最后登陆的IP地址',
  `created_at` int(11) NOT NULL COMMENT '添加时间',
  `open_id` varchar(50) NOT NULL COMMENT '关联微信信息表',
  PRIMARY KEY (`id`),
  KEY `name` (`name`,`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_users
-- ----------------------------
INSERT INTO `pub_users` VALUES ('10', '测试', '13838381438', '1', '1513646091', '219.137.249.39', '1513646091', 'oXwY4t-9clttAFWXjCcNRJrvch3w');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_vendors
-- ----------------------------
INSERT INTO `pub_vendors` VALUES ('1', 'admin', '炒鸡管理员', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '天津市 天津市 和平区', '0', '0', '1512461767', '430122199610224517');
INSERT INTO `pub_vendors` VALUES ('2', '12', '我是经销商1', '3c59dc048e8850243be8079a5c74d079', '13838381438', '619328391@qq.com', '1212', '1', '1', '1508812510', '430122199610224517');
INSERT INTO `pub_vendors` VALUES ('3', '123', '经销商2', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '1212', '1', '1', '1508917638', '430122199610224517');
INSERT INTO `pub_vendors` VALUES ('4', '11', '12', 'd41d8cd98f00b204e9800998ecf8427e', '13838381438', '619328391@qq.com', '1212', '1', '1', '1508989286', '430122199610224517');
INSERT INTO `pub_vendors` VALUES ('5', 'ping', 'ping', 'df911f0151f9ef021d410b4be5060972', '13800138000', '13800138000@139.com', '123456', '1', '1', '1512522159', '138001380001380000');
INSERT INTO `pub_vendors` VALUES ('6', 'qwe', '鞍山市', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '1212', '1', '1', '1509585067', '430122199610224517');

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_wechat
-- ----------------------------
INSERT INTO `pub_wechat` VALUES ('27', 'oXwY4t-9clttAFWXjCcNRJrvch3w', '吴智彬-13425492760', 'http://wx.qlogo.cn/mmopen/PiajxSqBRaEL2BngN3rIJ4wfOVdEng1oeZq50oFxviaWnSFzYILvxiaeU2Y2eKZPsc6XAfEFb25OibVj7JKfn6qQGFS8rY2feXLudiakqWXPCoiaI/0', '1', '广东', '中国 广东 广州');

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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_work
-- ----------------------------

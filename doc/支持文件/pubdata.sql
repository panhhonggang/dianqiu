/*
Navicat MySQL Data Transfer

Source Server         : wuzhibin.cn
Source Server Version : 50173
Source Host           : sdm359768304.my3w.com:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-12-19 10:13:53
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
INSERT INTO `pub_admin_menu` VALUES ('46', '0', '反馈及报修', 'Admin/Feeds', '', '3');
INSERT INTO `pub_admin_menu` VALUES ('47', '46', '反馈列表', 'Admin/Feeds/feedslist', '', null);
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
INSERT INTO `pub_auth_group` VALUES ('1', ' 超级管理员', '1', '3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34');
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
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='规则表';

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
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=184 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_setmeal
-- ----------------------------
INSERT INTO `pub_cart_setmeal` VALUES ('183', '10', '1', '1', '1513647521', null);

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
  `device_id` int(11) unsigned NOT NULL COMMENT '关联的设备ID号',
  `device_statu` tinyint(1) unsigned NOT NULL COMMENT '设备状态',
  `updated_at` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`,`device_statu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_devices_statu
-- ----------------------------

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
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_express_information
-- ----------------------------
INSERT INTO `pub_express_information` VALUES ('1', '10', '吴智彬', '13425492760', '中国广州东圃', null, null, '1');

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
INSERT INTO `pub_feeds` VALUES ('1', '这个产品真不错啊', '1', '1566897799');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES ('8', '20171216151340720112016317641317', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513407201', null);
INSERT INTO `pub_order_setmeal` VALUES ('9', '20171216151341046412366446781281', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513410464', null);
INSERT INTO `pub_order_setmeal` VALUES ('10', '20171216151341064513982794231133', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513410645', null);
INSERT INTO `pub_order_setmeal` VALUES ('11', '20171216151341170712520724721219', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513411707', null);
INSERT INTO `pub_order_setmeal` VALUES ('12', '20171216151341179113020728201338', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513411791', null);
INSERT INTO `pub_order_setmeal` VALUES ('13', '20171216151341184013769198721379', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513411840', null);
INSERT INTO `pub_order_setmeal` VALUES ('14', '20171216151341208713497202951355', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513412087', null);
INSERT INTO `pub_order_setmeal` VALUES ('15', '20171216151341349013343258261376', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413490', null);
INSERT INTO `pub_order_setmeal` VALUES ('16', '20171216151341349413444911741129', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413494', null);
INSERT INTO `pub_order_setmeal` VALUES ('17', '20171216151341354713307633751402', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413547', null);
INSERT INTO `pub_order_setmeal` VALUES ('18', '20171216151341360614013567551118', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413606', null);
INSERT INTO `pub_order_setmeal` VALUES ('19', '20171216151341370513916951361155', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413705', null);
INSERT INTO `pub_order_setmeal` VALUES ('20', '20171216151341373113390899871123', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513413731', null);
INSERT INTO `pub_order_setmeal` VALUES ('21', '20171216151341393512947499581375', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413935', null);
INSERT INTO `pub_order_setmeal` VALUES ('22', '20171216151341399813622077381136', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513413998', null);
INSERT INTO `pub_order_setmeal` VALUES ('23', '20171216151341403111910415891388', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414031', null);
INSERT INTO `pub_order_setmeal` VALUES ('24', '20171216151341410212040997751210', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414102', null);
INSERT INTO `pub_order_setmeal` VALUES ('25', '20171216151341416212459119071353', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414162', null);
INSERT INTO `pub_order_setmeal` VALUES ('26', '20171216151341416513004652871293', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414165', null);
INSERT INTO `pub_order_setmeal` VALUES ('27', '20171216151341416513812735411243', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414165', null);
INSERT INTO `pub_order_setmeal` VALUES ('28', '20171216151341416512957975981302', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414165', null);
INSERT INTO `pub_order_setmeal` VALUES ('29', '20171216151341416611489874181368', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414166', null);
INSERT INTO `pub_order_setmeal` VALUES ('30', '20171216151341418813453628361308', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414188', null);
INSERT INTO `pub_order_setmeal` VALUES ('31', '20171216151341444011250858311114', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414440', null);
INSERT INTO `pub_order_setmeal` VALUES ('32', '20171216151341445114007973171216', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414451', null);
INSERT INTO `pub_order_setmeal` VALUES ('33', '20171216151341473712824060431288', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414737', null);
INSERT INTO `pub_order_setmeal` VALUES ('34', '20171216151341474112724181131324', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414741', null);
INSERT INTO `pub_order_setmeal` VALUES ('35', '20171216151341474312976822381362', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414743', null);
INSERT INTO `pub_order_setmeal` VALUES ('36', '20171216151341474413601151611117', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414744', null);
INSERT INTO `pub_order_setmeal` VALUES ('37', '20171216151341474612086273211256', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414746', null);
INSERT INTO `pub_order_setmeal` VALUES ('38', '20171216151341474813210651971221', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414748', null);
INSERT INTO `pub_order_setmeal` VALUES ('39', '20171216151341476012512276541126', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513414760', null);
INSERT INTO `pub_order_setmeal` VALUES ('40', '20171216151341481911827554331395', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414819', null);
INSERT INTO `pub_order_setmeal` VALUES ('41', '20171216151341485912297463991156', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513414859', null);
INSERT INTO `pub_order_setmeal` VALUES ('42', '20171216151341504214057892401395', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513415042', null);
INSERT INTO `pub_order_setmeal` VALUES ('43', '20171216151341506613345129331390', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513415066', null);
INSERT INTO `pub_order_setmeal` VALUES ('44', '20171216151341531912900528821244', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513415319', null);
INSERT INTO `pub_order_setmeal` VALUES ('45', '20171216151341541412480112781186', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513415414', null);
INSERT INTO `pub_order_setmeal` VALUES ('46', '20171216151341576911297395611285', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513415769', null);
INSERT INTO `pub_order_setmeal` VALUES ('47', '20171217151348002191902529699139', '3', '0', '0', '0.00', '0', '', '1', '30000.00', '1513480021', null);
INSERT INTO `pub_order_setmeal` VALUES ('48', '20171217151348029968228046189658', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513480299', null);
INSERT INTO `pub_order_setmeal` VALUES ('49', '20171217151348053751476270245351', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513480537', null);
INSERT INTO `pub_order_setmeal` VALUES ('50', '20171217151348057535505036633852', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513480575', null);
INSERT INTO `pub_order_setmeal` VALUES ('51', '20171217151348130961903032165246', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513481309', null);
INSERT INTO `pub_order_setmeal` VALUES ('52', '20171217151348134315972994107557', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513481343', null);
INSERT INTO `pub_order_setmeal` VALUES ('53', '20171217151348156764925358157174', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513481567', null);
INSERT INTO `pub_order_setmeal` VALUES ('54', '20171217151348163413328348558783', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513481634', null);
INSERT INTO `pub_order_setmeal` VALUES ('55', '20171217151348165199124436863397', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513481651', null);
INSERT INTO `pub_order_setmeal` VALUES ('56', '20171217151348447733985628514333', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513484477', null);
INSERT INTO `pub_order_setmeal` VALUES ('57', '20171217151348450725471473898109', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513484507', null);
INSERT INTO `pub_order_setmeal` VALUES ('58', '20171218151358209168492480497564', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582091', null);
INSERT INTO `pub_order_setmeal` VALUES ('59', '20171218151358256877202603596365', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582568', null);
INSERT INTO `pub_order_setmeal` VALUES ('60', '20171218151358259165368440252871', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582591', null);
INSERT INTO `pub_order_setmeal` VALUES ('61', '20171218151358266575850088525632', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582665', null);
INSERT INTO `pub_order_setmeal` VALUES ('62', '20171218151358275412997826518244', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582754', null);
INSERT INTO `pub_order_setmeal` VALUES ('63', '20171218151358279651403610694390', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582796', null);
INSERT INTO `pub_order_setmeal` VALUES ('64', '20171218151358282553870427355446', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582825', null);
INSERT INTO `pub_order_setmeal` VALUES ('65', '20171218151358286838076034395227', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513582868', null);
INSERT INTO `pub_order_setmeal` VALUES ('66', '20171218151358291858365181665481', '3', '0', '0', '0.00', '0', '', '1', '30000.00', '1513582918', null);
INSERT INTO `pub_order_setmeal` VALUES ('67', '20171218151358328986195159247511', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513583289', null);
INSERT INTO `pub_order_setmeal` VALUES ('68', '20171218151358388752734952837635', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513583887', null);
INSERT INTO `pub_order_setmeal` VALUES ('69', '20171218151358390459990469987807', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513583904', null);
INSERT INTO `pub_order_setmeal` VALUES ('70', '20171218151358664066544059959087', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513586640', null);
INSERT INTO `pub_order_setmeal` VALUES ('71', '20171218151358676432645322588034', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513586764', null);
INSERT INTO `pub_order_setmeal` VALUES ('72', '20171218151358678139602600458994', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513586781', null);
INSERT INTO `pub_order_setmeal` VALUES ('73', '20171218151358683085660356737233', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513586830', null);
INSERT INTO `pub_order_setmeal` VALUES ('74', '20171218151358700141696531655975', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587001', null);
INSERT INTO `pub_order_setmeal` VALUES ('75', '20171218151358702175259031973207', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587021', null);
INSERT INTO `pub_order_setmeal` VALUES ('76', '20171218151358765862313546948266', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587658', null);
INSERT INTO `pub_order_setmeal` VALUES ('77', '20171218151358766176755677035215', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587661', null);
INSERT INTO `pub_order_setmeal` VALUES ('78', '20171218151358766353372994804295', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587663', null);
INSERT INTO `pub_order_setmeal` VALUES ('79', '20171218151358769942446049092055', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587699', null);
INSERT INTO `pub_order_setmeal` VALUES ('80', '20171218151358774641435478838027', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587746', null);
INSERT INTO `pub_order_setmeal` VALUES ('81', '20171218151358786727178759043722', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587867', null);
INSERT INTO `pub_order_setmeal` VALUES ('82', '20171218151358787095006673531445', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587870', null);
INSERT INTO `pub_order_setmeal` VALUES ('83', '20171218151358787392764639484652', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587873', null);
INSERT INTO `pub_order_setmeal` VALUES ('84', '20171218151358790211435871523281', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587902', null);
INSERT INTO `pub_order_setmeal` VALUES ('85', '20171218151358798964511049829645', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513587989', null);
INSERT INTO `pub_order_setmeal` VALUES ('86', '20171218151358802624639474147414', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588026', null);
INSERT INTO `pub_order_setmeal` VALUES ('87', '20171218151358804231649901758719', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588042', null);
INSERT INTO `pub_order_setmeal` VALUES ('88', '20171218151358820218063290871126', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588202', null);
INSERT INTO `pub_order_setmeal` VALUES ('89', '20171218151358821374980543342145', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513588213', null);
INSERT INTO `pub_order_setmeal` VALUES ('90', '20171218151358822291330193475702', '3', '0', '0', '0.00', '0', '', '1', '30000.00', '1513588222', null);
INSERT INTO `pub_order_setmeal` VALUES ('91', '20171218151358833931461385343841', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588339', null);
INSERT INTO `pub_order_setmeal` VALUES ('92', '20171218151358859293763556287171', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588592', null);
INSERT INTO `pub_order_setmeal` VALUES ('93', '20171218151358859765399181719572', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588597', null);
INSERT INTO `pub_order_setmeal` VALUES ('94', '20171218151358859965266442673109', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588599', null);
INSERT INTO `pub_order_setmeal` VALUES ('95', '20171218151358860065335291296536', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588600', null);
INSERT INTO `pub_order_setmeal` VALUES ('96', '20171218151358860165980276464981', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588601', null);
INSERT INTO `pub_order_setmeal` VALUES ('97', '20171218151358860464773194692491', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513588604', null);
INSERT INTO `pub_order_setmeal` VALUES ('98', '20171218151358861765782087876141', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588617', null);
INSERT INTO `pub_order_setmeal` VALUES ('99', '20171218151358867569479283777778', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513588675', null);
INSERT INTO `pub_order_setmeal` VALUES ('100', '20171218151358867977093592909857', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513588679', null);
INSERT INTO `pub_order_setmeal` VALUES ('101', '20171218151358924095550229279604', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513589240', null);
INSERT INTO `pub_order_setmeal` VALUES ('102', '20171218151358924778930376677173', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513589247', null);
INSERT INTO `pub_order_setmeal` VALUES ('103', '20171218151358925531111835195285', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513589255', null);
INSERT INTO `pub_order_setmeal` VALUES ('104', '20171218151358926231043398252242', '3', '0', '0', '0.00', '0', '', '1', '30000.00', '1513589262', null);
INSERT INTO `pub_order_setmeal` VALUES ('105', '20171218151358938161857982108008', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513589381', null);
INSERT INTO `pub_order_setmeal` VALUES ('106', '20171218151358941143269919727211', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513589411', null);
INSERT INTO `pub_order_setmeal` VALUES ('107', '20171218151358964259864975559297', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513589642', null);
INSERT INTO `pub_order_setmeal` VALUES ('108', '20171218151358965781964684731882', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513589657', null);
INSERT INTO `pub_order_setmeal` VALUES ('109', '20171218151358966786393422346423', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513589667', null);
INSERT INTO `pub_order_setmeal` VALUES ('110', '20171218151359770050635625258859', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513597700', null);
INSERT INTO `pub_order_setmeal` VALUES ('111', '20171218151359774120641676414039', '2', '0', '0', '0.00', '0', '', '1', '20000.00', '1513597741', null);
INSERT INTO `pub_order_setmeal` VALUES ('112', '20171219151364155433648852345407', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513641554', null);
INSERT INTO `pub_order_setmeal` VALUES ('113', '20171219151364500565245355253237', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513645005', null);
INSERT INTO `pub_order_setmeal` VALUES ('114', '20171219151364650751965394571482', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513646507', null);
INSERT INTO `pub_order_setmeal` VALUES ('115', '20171219151364696440204896363882', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513646964', null);
INSERT INTO `pub_order_setmeal` VALUES ('116', '20171219151364750211773018575374', '1', '0', '0', '0.00', '0', '', '1', '10000.00', '1513647502', null);

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
  `is_pay` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '付款状态(0：未付款1：已付款)',
  `is_receipt` tinyint(1) unsigned DEFAULT NULL COMMENT '发货状态(0：未发货1：已发货)',
  `is_ship` tinyint(1) unsigned DEFAULT NULL COMMENT '收货状态(0：未收货1：已收货)',
  `is_recharge` tinyint(1) unsigned DEFAULT NULL COMMENT '充值状态(0：未充值1：已充值)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`device_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('25', '20171216151340720112016317641317', '3', '10', null, '1', '10000.00', '1513407201', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('26', '20171216151341046412366446781281', '3', '10', null, '1', '10000.00', '1513410464', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('27', '20171216151341064513982794231133', '3', '10', null, '1', '10000.00', '1513410645', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('28', '20171216151341170712520724721219', '3', '10', null, '1', '10000.00', '1513411707', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('29', '20171216151341179113020728201338', '3', '10', null, '1', '10000.00', '1513411791', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('30', '20171216151341184013769198721379', '3', '10', null, '1', '10000.00', '1513411840', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('31', '20171216151341208713497202951355', '3', '10', null, '1', '10000.00', '1513412087', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('32', '20171216151341349013343258261376', '3', '10', null, '1', '10000.00', '1513413490', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('33', '20171216151341349413444911741129', '3', '10', null, '1', '10000.00', '1513413494', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('34', '20171216151341354713307633751402', '3', '10', null, '1', '10000.00', '1513413547', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('35', '20171216151341360614013567551118', '3', '10', null, '1', '10000.00', '1513413606', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('36', '20171216151341370513916951361155', '3', '10', null, '1', '10000.00', '1513413705', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('37', '20171216151341373113390899871123', '3', '10', null, '1', '20000.00', '1513413731', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('38', '20171216151341393512947499581375', '3', '10', null, '1', '10000.00', '1513413935', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('39', '20171216151341399813622077381136', '3', '10', null, '1', '10000.00', '1513413998', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('40', '20171216151341403111910415891388', '3', '10', null, '1', '10000.00', '1513414031', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('41', '20171216151341410212040997751210', '3', '10', null, '1', '10000.00', '1513414102', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('42', '20171216151341416212459119071353', '3', '10', null, '1', '10000.00', '1513414162', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('43', '20171216151341416513004652871293', '3', '10', null, '1', '10000.00', '1513414165', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('44', '20171216151341416513812735411243', '3', '10', null, '1', '10000.00', '1513414165', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('45', '20171216151341416512957975981302', '3', '10', null, '1', '10000.00', '1513414165', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('46', '20171216151341416611489874181368', '3', '10', null, '1', '10000.00', '1513414166', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('47', '20171216151341418813453628361308', '3', '10', null, '1', '10000.00', '1513414188', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('48', '20171216151341444011250858311114', '3', '10', null, '1', '10000.00', '1513414440', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('49', '20171216151341445114007973171216', '3', '10', null, '1', '10000.00', '1513414451', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('50', '20171216151341473712824060431288', '3', '10', null, '1', '10000.00', '1513414737', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('51', '20171216151341474112724181131324', '3', '10', null, '1', '10000.00', '1513414741', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('52', '20171216151341474312976822381362', '3', '10', null, '1', '10000.00', '1513414743', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('53', '20171216151341474413601151611117', '3', '10', null, '1', '10000.00', '1513414744', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('54', '20171216151341474612086273211256', '3', '10', null, '1', '10000.00', '1513414746', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('55', '20171216151341474813210651971221', '3', '10', null, '1', '10000.00', '1513414748', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('56', '20171216151341476012512276541126', '3', '10', null, '1', '20000.00', '1513414760', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('57', '20171216151341481911827554331395', '3', '10', null, '1', '10000.00', '1513414819', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('58', '20171216151341485912297463991156', '3', '10', null, '1', '10000.00', '1513414859', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('59', '20171216151341504214057892401395', '3', '10', null, '1', '10000.00', '1513415042', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('60', '20171216151341506613345129331390', '3', '10', null, '1', '10000.00', '1513415066', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('61', '20171216151341531912900528821244', '3', '10', null, '1', '10000.00', '1513415319', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('62', '20171216151341541412480112781186', '3', '10', null, '1', '10000.00', '1513415414', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('63', '20171216151341576911297395611285', '3', '10', null, '1', '10000.00', '1513415769', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('64', '20171217151348002191902529699139', '3', '10', null, '1', '30000.00', '1513480021', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('65', '20171217151348029968228046189658', '3', '10', null, '1', '10000.00', '1513480299', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('66', '20171217151348053751476270245351', '3', '10', null, '1', '10000.00', '1513480537', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('67', '20171217151348057535505036633852', '3', '10', null, '1', '10000.00', '1513480575', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('68', '20171217151348130961903032165246', '3', '10', null, '1', '10000.00', '1513481309', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('69', '20171217151348134315972994107557', '3', '10', null, '1', '10000.00', '1513481343', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('70', '20171217151348156764925358157174', '3', '10', null, '1', '10000.00', '1513481567', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('71', '20171217151348163413328348558783', '3', '10', null, '1', '10000.00', '1513481634', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('72', '20171217151348165199124436863397', '3', '10', null, '1', '10000.00', '1513481651', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('73', '20171217151348447733985628514333', '3', '10', null, '1', '10000.00', '1513484477', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('74', '20171217151348450725471473898109', '3', '10', null, '1', '20000.00', '1513484507', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('75', '20171218151358209168492480497564', '3', '10', null, '1', '10000.00', '1513582091', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('76', '20171218151358256877202603596365', '3', '10', null, '1', '10000.00', '1513582568', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('77', '20171218151358259165368440252871', '3', '10', null, '1', '10000.00', '1513582591', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('78', '20171218151358266575850088525632', '3', '10', null, '1', '10000.00', '1513582665', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('79', '20171218151358275412997826518244', '3', '10', null, '1', '10000.00', '1513582754', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('80', '20171218151358279651403610694390', '3', '10', null, '1', '10000.00', '1513582796', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('81', '20171218151358282553870427355446', '3', '10', null, '1', '10000.00', '1513582825', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('82', '20171218151358286838076034395227', '3', '10', null, '1', '10000.00', '1513582868', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('83', '20171218151358291858365181665481', '3', '10', null, '1', '30000.00', '1513582918', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('84', '20171218151358328986195159247511', '3', '10', null, '1', '10000.00', '1513583289', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('85', '20171218151358388752734952837635', '3', '10', null, '1', '10000.00', '1513583887', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('86', '20171218151358390459990469987807', '3', '10', null, '1', '10000.00', '1513583904', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('88', '20171218151358664066544059959087', '3', '10', null, '1', '10000.00', '1513586640', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('89', '20171218151358676432645322588034', '3', '10', null, '1', '10000.00', '1513586764', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('90', '20171218151358678139602600458994', '3', '10', null, '1', '10000.00', '1513586781', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('91', '20171218151358683085660356737233', '3', '10', null, '1', '10000.00', '1513586830', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('92', '20171218151358700141696531655975', '3', '10', null, '1', '10000.00', '1513587001', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('93', '20171218151358702175259031973207', '3', '10', null, '1', '10000.00', '1513587021', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('94', '20171218151358765862313546948266', '3', '10', null, '1', '10000.00', '1513587658', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('95', '20171218151358766176755677035215', '3', '10', null, '1', '10000.00', '1513587661', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('96', '20171218151358766353372994804295', '3', '10', null, '1', '10000.00', '1513587663', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('97', '20171218151358769942446049092055', '3', '10', null, '1', '10000.00', '1513587699', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('98', '20171218151358774641435478838027', '3', '10', null, '1', '10000.00', '1513587746', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('99', '20171218151358786727178759043722', '3', '10', null, '1', '10000.00', '1513587867', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('100', '20171218151358787095006673531445', '3', '10', null, '1', '10000.00', '1513587870', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('101', '20171218151358787392764639484652', '3', '10', null, '1', '10000.00', '1513587873', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('102', '20171218151358790211435871523281', '3', '10', null, '1', '10000.00', '1513587902', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('103', '20171218151358798964511049829645', '3', '10', null, '1', '10000.00', '1513587989', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('104', '20171218151358802624639474147414', '3', '10', null, '1', '10000.00', '1513588026', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('105', '20171218151358804231649901758719', '3', '10', null, '1', '10000.00', '1513588042', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('106', '20171218151358820218063290871126', '3', '10', null, '1', '10000.00', '1513588202', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('107', '20171218151358821374980543342145', '3', '10', null, '1', '20000.00', '1513588213', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('108', '20171218151358822291330193475702', '3', '10', null, '1', '30000.00', '1513588222', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('109', '20171218151358833931461385343841', '3', '10', null, '1', '10000.00', '1513588339', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('110', '20171218151358859293763556287171', '3', '10', null, '1', '10000.00', '1513588592', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('111', '20171218151358859765399181719572', '3', '10', null, '1', '10000.00', '1513588597', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('112', '20171218151358859965266442673109', '3', '10', null, '1', '10000.00', '1513588599', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('113', '20171218151358860065335291296536', '3', '10', null, '1', '10000.00', '1513588600', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('114', '20171218151358860165980276464981', '3', '10', null, '1', '10000.00', '1513588601', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('115', '20171218151358860464773194692491', '3', '10', null, '1', '20000.00', '1513588604', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('116', '20171218151358861765782087876141', '3', '10', null, '1', '10000.00', '1513588617', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('117', '20171218151358867569479283777778', '3', '10', null, '1', '10000.00', '1513588675', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('118', '20171218151358867977093592909857', '3', '10', null, '1', '20000.00', '1513588679', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('119', '20171218151358924095550229279604', '3', '10', null, '1', '10000.00', '1513589240', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('120', '20171218151358924778930376677173', '3', '10', null, '1', '10000.00', '1513589247', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('121', '20171218151358925531111835195285', '3', '10', null, '1', '20000.00', '1513589255', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('122', '20171218151358926231043398252242', '3', '10', null, '1', '30000.00', '1513589262', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('123', '20171218151358938161857982108008', '3', '10', null, '1', '10000.00', '1513589381', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('124', '20171218151358941143269919727211', '3', '10', null, '1', '10000.00', '1513589411', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('125', '20171218151358964259864975559297', '3', '10', null, '1', '10000.00', '1513589642', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('126', '20171218151358965781964684731882', '3', '10', null, '1', '20000.00', '1513589657', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('127', '20171218151358966786393422346423', '3', '10', null, '1', '10000.00', '1513589667', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('128', '20171218151359770050635625258859', '3', '10', null, '1', '10000.00', '1513597700', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('129', '20171218151359774120641676414039', '3', '10', null, '1', '20000.00', '1513597741', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('130', '20171219151364155433648852345407', '3', '10', null, '1', '10000.00', '1513641554', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('131', '20171219151364500565245355253237', '3', '10', null, '1', '10000.00', '1513645005', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('132', '20171219151364650751965394571482', '3', '10', null, '1', '10000.00', '1513646507', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('133', '20171219151364696440204896363882', '3', '10', null, '1', '10000.00', '1513646964', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('134', '20171219151364750211773018575374', '3', '10', null, '1', '10000.00', '1513647502', null, '0', null, null, null);

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
INSERT INTO `pub_repair` VALUES ('1', '2147483647', '今天设备开不了机了', '假装我是图片路径', '1', '广东广州', '1565494664', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_users
-- ----------------------------
INSERT INTO `pub_users` VALUES ('10', null, null, '1', '1513646091', '219.137.249.39', '1513646091', 'oXwY4t-9clttAFWXjCcNRJrvch3w');

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

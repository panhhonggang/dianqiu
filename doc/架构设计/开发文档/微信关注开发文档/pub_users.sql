/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-12 16:25:23
*/

SET FOREIGN_KEY_CHECKS=0;

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
INSERT INTO `pub_users` VALUES ('1', '', '', '1', '1', '1', '1', 'oXwY4t2gearWoyg8z19ygjD34vDk');
INSERT INTO `pub_users` VALUES ('10', null, null, '1', '1512700661', '140.207.54.79', '1512700661', 'oXwY4t2gearWoyg8z19ygjD34vDk');

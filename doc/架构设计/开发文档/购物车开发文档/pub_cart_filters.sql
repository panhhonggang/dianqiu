/*
Navicat MySQL Data Transfer

Source Server         : wuzhibin.cn
Source Server Version : 50173
Source Host           : sdm359768304.my3w.com:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-12-28 14:54:58
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_filters
-- ----------------------------
INSERT INTO `pub_cart_filters` VALUES ('118', '10', '1', '1', '1514443265', null);
INSERT INTO `pub_cart_filters` VALUES ('116', '10', '6', '2', '1514274859', '1514443265');
INSERT INTO `pub_cart_filters` VALUES ('117', '10', '4', '3', '1514443265', null);

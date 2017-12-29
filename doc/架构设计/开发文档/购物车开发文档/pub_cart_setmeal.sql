/*
Navicat MySQL Data Transfer

Source Server         : wuzhibin.cn
Source Server Version : 50173
Source Host           : sdm359768304.my3w.com:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-12-28 14:55:05
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=MyISAM AUTO_INCREMENT=416 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_cart_setmeal
-- ----------------------------
INSERT INTO `pub_cart_setmeal` VALUES ('415', '10', '3', '1', '1514443257', null);
INSERT INTO `pub_cart_setmeal` VALUES ('414', '10', '2', '1', '1514443254', null);
INSERT INTO `pub_cart_setmeal` VALUES ('413', '10', '1', '1', '1514443249', null);

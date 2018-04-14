/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : pub_test

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2018-04-13 20:44:03
*/

SET FOREIGN_KEY_CHECKS=0;

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
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为首充套餐',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

/*
Navicat MySQL Data Transfer

Source Server         : wuzhibin.cn
Source Server Version : 50173
Source Host           : sdm359768304.my3w.com:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-12-28 13:48:40
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_setmeal
-- ----------------------------
INSERT INTO `pub_setmeal` VALUES ('1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1512958408');
INSERT INTO `pub_setmeal` VALUES ('2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1512958436');
INSERT INTO `pub_setmeal` VALUES ('3', '10', '0', '30000.00', '3000', '300元包3000升流量', '1512958962');

/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-16 10:56:42
*/

SET FOREIGN_KEY_CHECKS=0;

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

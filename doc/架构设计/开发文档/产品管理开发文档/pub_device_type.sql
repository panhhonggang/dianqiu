/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-08 16:59:48
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_device_type
-- ----------------------------
INSERT INTO `pub_device_type` VALUES ('8', '商务型', 'PP棉', 'RO膜', 'RO膜2号', 'RO膜PP', 'RO膜PP1', 'PP棉2号', '', '', '1510282247');
INSERT INTO `pub_device_type` VALUES ('7', '测试型', 'RO膜2号', 'RO膜PP', 'RO膜', '', '', '', '', '', '1510026151');
INSERT INTO `pub_device_type` VALUES ('9', '家用型', 'RO膜PP', 'RO膜2号', 'RO膜', '', '', '', '', '', '1510282291');

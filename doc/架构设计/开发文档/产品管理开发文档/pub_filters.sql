/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-08 16:56:40
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_filters
-- ----------------------------
INSERT INTO `pub_filters` VALUES ('1', 'RO膜', 'A型', '', '500', '2000', null, null, '我是滤芯简介', 'http://www.baidu.com', '1509673437', '0.00');
INSERT INTO `pub_filters` VALUES ('2', 'PP棉', null, '', '123', '321', null, null, '凄凄切切', 'http://www.baidu.com', '1509607569', '0.00');
INSERT INTO `pub_filters` VALUES ('3', 'PP棉2号', null, '', '234', '432', null, null, '尺寸齐全', 'http://www.baidu.com', '1509607600', '0.00');
INSERT INTO `pub_filters` VALUES ('4', 'RO膜2号', 'B型', '', '5343', '3333', null, null, '望闻问切去', 'http://www.baidu.com', '1509673448', '0.00');
INSERT INTO `pub_filters` VALUES ('5', 'PPRO', null, '', '500', '2000', null, null, '啊啊按时到', 'http://www.baidu.com', '1509607666', '0.00');
INSERT INTO `pub_filters` VALUES ('6', 'RO膜PP', 'C型', '', '444', '322', null, null, '啊实打实', 'http://www.baidu.com', '1509673463', '0.00');
INSERT INTO `pub_filters` VALUES ('7', 'RO膜PP1', '', '', '444', '322', null, null, '啊实打实', 'http://www.baidu.com', '1509673287', '0.00');
INSERT INTO `pub_filters` VALUES ('9', 'RO膜', 'B型', '/upload/2017-12-08/5a2a5240d65ec.jpg', '100', '321', null, null, '撒打算1', 'http://www.baidu.com', '1512723008', '2302.00');

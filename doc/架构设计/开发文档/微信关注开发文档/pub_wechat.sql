/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-12 16:25:06
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_wechat
-- ----------------------------
INSERT INTO `pub_wechat` VALUES ('24', 'oXwY4t2gearWoyg8z19ygjD34vDk', '馨品Mr\'feng', 'http://wx.qlogo.cn/mmopen/lbk4D8nFV3TBwoicSXcPoxia5iaIydTcZUBgibBvJUZBP67vsCUsWicmqK3EkDomcicB1A1o5rf4w7EP0QWDHMdLjA8snibHHxJOj5b/0', '2', '广东', '中国 广东 广州');

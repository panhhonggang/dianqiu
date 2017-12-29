/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-12-29 10:37:57
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
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_express_information
-- ----------------------------
INSERT INTO `pub_express_information` VALUES ('1', '10', '吴智彬', '13425492760', '中国广州东圃', null, null, '1');
INSERT INTO `pub_express_information` VALUES ('2', '10', '吴智彬', '13425492760', '辅导费多岁的', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('3', '10', '吴直播', '13425492760', '发的发幅度为', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('4', '10', '我都是', '13425462563', '中国观众讲的是', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('16', '10', '吴智彬号东圃', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('17', '10', '吴智彬无智彬', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('18', '10', '吴智彬中国', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('19', '10', '吴智彬废物', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('20', '10', '吴智彬废物任务十分', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('21', '10', '吴智彬都是', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('22', '10', '吴智彬范围', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('23', '10', '吴智彬uuu', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('24', '10', '吴智彬Hhj', '13425492760', '中国广州东圃', null, null, '0');
INSERT INTO `pub_express_information` VALUES ('25', '10', '吴智彬good', '13425492760', '中国广州东圃', null, null, '0');

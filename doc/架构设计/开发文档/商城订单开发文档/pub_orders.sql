/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-12-29 10:38:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pub_orders
-- ----------------------------
DROP TABLE IF EXISTS `pub_orders`;
CREATE TABLE `pub_orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单编号',
  `device_id` int(11) unsigned NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) unsigned NOT NULL COMMENT '关联的用户ID号',
  `express_id` int(11) unsigned DEFAULT NULL COMMENT '关联快递信息ID号',
  `total_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `total_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '订单修改时间',
  `is_pay` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '付款状态(0：未付款1：已付款 2：已取消)',
  `is_receipt` tinyint(1) unsigned DEFAULT '0' COMMENT '发货状态(0：未发货1：已发货)',
  `is_ship` tinyint(1) unsigned DEFAULT '0' COMMENT '收货状态(0：未收货1：已收货)',
  `is_recharge` tinyint(1) unsigned DEFAULT '0' COMMENT '充值状态(0：未充值1：已充值)',
  `express` varchar(32) DEFAULT NULL COMMENT '快递名称',
  `mca` varchar(32) DEFAULT NULL COMMENT '快递订单号',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`device_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('303', '970294217660737008', '3', '10', '1', '19', '254000.00', '1514265775', '1514265815', '1', '1', '1', '1', null, null);
INSERT INTO `pub_orders` VALUES ('304', '373440200299964027', '3', '10', null, '1', '10000.00', '1514266279', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('305', '157879036712097840', '3', '10', '1', '7', '35000.00', '1514266678', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('306', '160393629626761004', '3', '10', '25', '13', '56000.00', '1514266748', '1514267544', '1', '1', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('307', '787036001695699849', '3', '10', null, '1', '10000.00', '1514267597', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('308', '890131072049768713', '3', '10', null, '3', '60000.00', '1514267628', null, '1', '0', '0', '1', null, null);
INSERT INTO `pub_orders` VALUES ('309', '476493813094536543', '3', '10', '1', '6', '31000.00', '1514267672', null, '0', '0', '0', '0', null, null);
INSERT INTO `pub_orders` VALUES ('310', '352819442332884757', '3', '10', null, '8', '180000.00', '1514267723', null, '0', '0', '0', '0', null, null);

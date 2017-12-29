/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-12-29 10:38:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pub_order_setmeal
-- ----------------------------
DROP TABLE IF EXISTS `pub_order_setmeal`;
CREATE TABLE `pub_order_setmeal` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) NOT NULL,
  `setmeal_id` int(11) unsigned NOT NULL,
  `type_id` int(11) NOT NULL COMMENT '产品类型ID',
  `remodel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值模式(0：流量1：时长)',
  `money` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '套餐金额',
  `flow` int(11) NOT NULL COMMENT '套餐流量/时长',
  `describe` varchar(255) NOT NULL COMMENT '套餐描述',
  `goods_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) unsigned DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) unsigned DEFAULT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`(11))
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES ('328', '970294217660737008', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '3', '60000.00', '1514265775', null);
INSERT INTO `pub_order_setmeal` VALUES ('329', '970294217660737008', '3', '10', '0', '30000.00', '3000', '300元包3000升流量', '4', '120000.00', '1514265775', null);
INSERT INTO `pub_order_setmeal` VALUES ('330', '970294217660737008', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '6', '60000.00', '1514265775', null);
INSERT INTO `pub_order_setmeal` VALUES ('331', '373440200299964027', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1514266279', null);
INSERT INTO `pub_order_setmeal` VALUES ('332', '157879036712097840', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1514266678', null);
INSERT INTO `pub_order_setmeal` VALUES ('333', '160393629626761004', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1514266748', null);
INSERT INTO `pub_order_setmeal` VALUES ('334', '787036001695699849', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1514267597', null);
INSERT INTO `pub_order_setmeal` VALUES ('335', '890131072049768713', '3', '10', '0', '30000.00', '3000', '300元包3000升流量', '1', '30000.00', '1514267628', null);
INSERT INTO `pub_order_setmeal` VALUES ('336', '890131072049768713', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '1', '20000.00', '1514267628', null);
INSERT INTO `pub_order_setmeal` VALUES ('337', '890131072049768713', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1514267628', null);
INSERT INTO `pub_order_setmeal` VALUES ('338', '476493813094536543', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '1', '10000.00', '1514267672', null);
INSERT INTO `pub_order_setmeal` VALUES ('339', '352819442332884757', '3', '10', '0', '30000.00', '3000', '300元包3000升流量', '4', '120000.00', '1514267723', null);
INSERT INTO `pub_order_setmeal` VALUES ('340', '352819442332884757', '2', '10', '0', '20000.00', '1000', '200元包2000升流量', '2', '40000.00', '1514267723', null);
INSERT INTO `pub_order_setmeal` VALUES ('341', '352819442332884757', '1', '10', '0', '10000.00', '1000', '100元包1000升流量', '2', '20000.00', '1514267723', null);

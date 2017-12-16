/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-16 17:19:05
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
  `is_pay` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '付款状态(0：未付款1：已付款)',
  `is_receipt` tinyint(1) unsigned DEFAULT NULL COMMENT '发货状态(0：未发货1：已发货)',
  `is_ship` tinyint(1) unsigned DEFAULT NULL COMMENT '收货状态(0：未收货1：已收货)',
  `is_recharge` tinyint(1) unsigned DEFAULT NULL COMMENT '充值状态(0：未充值1：已充值)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`device_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('25', '20171216151340720112016317641317', '3', '10', null, '1', '10000.00', '1513407201', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('26', '20171216151341046412366446781281', '3', '10', null, '1', '10000.00', '1513410464', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('27', '20171216151341064513982794231133', '3', '10', null, '1', '10000.00', '1513410645', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('28', '20171216151341170712520724721219', '3', '10', null, '1', '10000.00', '1513411707', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('29', '20171216151341179113020728201338', '3', '10', null, '1', '10000.00', '1513411791', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('30', '20171216151341184013769198721379', '3', '10', null, '1', '10000.00', '1513411840', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('31', '20171216151341208713497202951355', '3', '10', null, '1', '10000.00', '1513412087', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('32', '20171216151341349013343258261376', '3', '10', null, '1', '10000.00', '1513413490', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('33', '20171216151341349413444911741129', '3', '10', null, '1', '10000.00', '1513413494', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('34', '20171216151341354713307633751402', '3', '10', null, '1', '10000.00', '1513413547', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('35', '20171216151341360614013567551118', '3', '10', null, '1', '10000.00', '1513413606', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('36', '20171216151341370513916951361155', '3', '10', null, '1', '10000.00', '1513413705', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('37', '20171216151341373113390899871123', '3', '10', null, '1', '20000.00', '1513413731', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('38', '20171216151341393512947499581375', '3', '10', null, '1', '10000.00', '1513413935', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('39', '20171216151341399813622077381136', '3', '10', null, '1', '10000.00', '1513413998', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('40', '20171216151341403111910415891388', '3', '10', null, '1', '10000.00', '1513414031', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('41', '20171216151341410212040997751210', '3', '10', null, '1', '10000.00', '1513414102', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('42', '20171216151341416212459119071353', '3', '10', null, '1', '10000.00', '1513414162', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('43', '20171216151341416513004652871293', '3', '10', null, '1', '10000.00', '1513414165', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('44', '20171216151341416513812735411243', '3', '10', null, '1', '10000.00', '1513414165', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('45', '20171216151341416512957975981302', '3', '10', null, '1', '10000.00', '1513414165', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('46', '20171216151341416611489874181368', '3', '10', null, '1', '10000.00', '1513414166', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('47', '20171216151341418813453628361308', '3', '10', null, '1', '10000.00', '1513414188', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('48', '20171216151341444011250858311114', '3', '10', null, '1', '10000.00', '1513414440', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('49', '20171216151341445114007973171216', '3', '10', null, '1', '10000.00', '1513414451', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('50', '20171216151341473712824060431288', '3', '10', null, '1', '10000.00', '1513414737', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('51', '20171216151341474112724181131324', '3', '10', null, '1', '10000.00', '1513414741', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('52', '20171216151341474312976822381362', '3', '10', null, '1', '10000.00', '1513414743', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('53', '20171216151341474413601151611117', '3', '10', null, '1', '10000.00', '1513414744', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('54', '20171216151341474612086273211256', '3', '10', null, '1', '10000.00', '1513414746', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('55', '20171216151341474813210651971221', '3', '10', null, '1', '10000.00', '1513414748', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('56', '20171216151341476012512276541126', '3', '10', null, '1', '20000.00', '1513414760', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('57', '20171216151341481911827554331395', '3', '10', null, '1', '10000.00', '1513414819', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('58', '20171216151341485912297463991156', '3', '10', null, '1', '10000.00', '1513414859', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('59', '20171216151341504214057892401395', '3', '10', null, '1', '10000.00', '1513415042', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('60', '20171216151341506613345129331390', '3', '10', null, '1', '10000.00', '1513415066', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('61', '20171216151341531912900528821244', '3', '10', null, '1', '10000.00', '1513415319', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('62', '20171216151341541412480112781186', '3', '10', null, '1', '10000.00', '1513415414', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('63', '20171216151341576911297395611285', '3', '10', null, '1', '10000.00', '1513415769', null, '0', null, null, null);

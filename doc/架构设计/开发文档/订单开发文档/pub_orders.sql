/*
Navicat MySQL Data Transfer

Source Server         : wuzhibin.cn
Source Server Version : 50173
Source Host           : sdm359768304.my3w.com:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-12-22 12:07:40
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
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`device_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_orders
-- ----------------------------
INSERT INTO `pub_orders` VALUES ('230', '20171221151383312016454761061309', '3', '10', '12', '2', '11000.00', '1513833120', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('231', '20171221151383332634814141852704', '3', '10', '1', '2', '11000.00', '1513833326', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('232', '20171221151383340685215153131405', '3', '10', '1', '3', '26000.00', '1513833406', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('233', '20171221151383386174182037136774', '3', '10', '1', '1', '1000.00', '1513833861', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('234', '20171221151383470857241102225325', '3', '10', '1', '2', '11000.00', '1513834708', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('235', '20171221151383480625343451397009', '3', '10', '1', '2', '11000.00', '1513834806', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('236', '20171221151383594380214727336508', '3', '10', null, '2', '11000.00', '1513835943', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('237', '20171221151383598674745321313165', '3', '10', '22', '3', '17000.00', '1513835986', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('238', '20171221151383629177584575658963', '3', '10', null, '1', '10000.00', '1513836291', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('239', '20171221151383631525878072281191', '3', '10', null, '1', '10000.00', '1513836315', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('240', '20171221151383633437767370376508', '3', '10', null, '2', '30000.00', '1513836334', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('241', '20171221151383636519516722199376', '3', '10', '23', '1', '1000.00', '1513836365', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('242', '20171221151383775641640485329328', '3', '10', '24', '1', '1000.00', '1513837756', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('243', '20171221151383798395450778058350', '3', '10', '1', '1', '1000.00', '1513837983', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('244', '20171221151383815612241239011554', '3', '10', null, '1', '10000.00', '1513838156', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('245', '20171221151383817312271461223664', '3', '10', null, '1', '20000.00', '1513838173', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('246', '20171221151383819120695502558515', '3', '10', null, '2', '30000.00', '1513838191', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('247', '20171221151383821195945932887410', '3', '10', '1', '1', '1000.00', '1513838211', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('248', '20171221151383823191181960535688', '3', '10', '1', '3', '17000.00', '1513838231', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('249', '20171221151383829196069397281586', '3', '10', null, '1', '10000.00', '1513838291', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('250', '20171221151383869889439145439655', '3', '10', null, '1', '10000.00', '1513838698', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('251', '20171221151383874486932180949530', '3', '10', null, '1', '10000.00', '1513838744', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('252', '20171221151383921956667323285097', '3', '10', null, '1', '10000.00', '1513839219', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('253', '20171221151383923342537362335171', '3', '10', null, '1', '10000.00', '1513839233', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('254', '20171221151383936292277547018289', '3', '10', null, '1', '10000.00', '1513839362', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('255', '20171221151383938365618285663362', '3', '10', null, '2', '30000.00', '1513839383', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('256', '20171221151383941916078055606562', '3', '10', '1', '5', '51000.00', '1513839419', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('257', '20171221151383947052925069831253', '3', '10', null, '1', '10000.00', '1513839470', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('258', '20171221151383952257678633593351', '3', '10', null, '2', '30000.00', '1513839522', null, '0', '0', '0', '0');
INSERT INTO `pub_orders` VALUES ('259', '20171221151384274382589621265408', '3', '10', null, '1', '10000.00', '1513842743', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('260', '20171221151384274955438097739132', '3', '10', null, '1', '20000.00', '1513842749', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('261', '20171221151384275950872235577567', '3', '10', null, '1', '10000.00', '1513842759', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('262', '20171221151384278561680391728678', '3', '10', null, '1', '10000.00', '1513842785', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('263', '20171221151384283046561839091518', '3', '10', null, '1', '10000.00', '1513842830', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('264', '20171221151384283917894097083137', '3', '10', null, '1', '10000.00', '1513842839', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('265', '20171221151384302298245613771343', '3', '10', null, '1', '10000.00', '1513843022', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('266', '20171221151384303178265502886830', '3', '10', null, '1', '10000.00', '1513843031', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('267', '20171221151384304674439037172253', '3', '10', null, '2', '30000.00', '1513843046', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('268', '20171221151384320082146163498188', '3', '10', null, '1', '10000.00', '1513843200', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('269', '20171221151384359249882276725182', '3', '10', null, '1', '10000.00', '1513843592', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('270', '20171221151384361473756108596191', '3', '10', null, '1', '10000.00', '1513843614', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('271', '20171221151384366827724545614454', '3', '10', null, '2', '30000.00', '1513843668', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('272', '20171221151384370822261789973299', '3', '10', null, '2', '20000.00', '1513843708', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('273', '20171221151384381511445371302176', '3', '10', '25', '1', '1000.00', '1513843815', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('274', '20171221151384411967011501977210', '3', '10', '1', '28', '125000.00', '1513844119', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('275', '20171221151384424366548654105877', '3', '10', null, '1', '20000.00', '1513844243', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('276', '20171221151384507783115719058858', '3', '10', null, '1', '10000.00', '1513845077', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('277', '20171221151384591177335899907146', '3', '10', null, '1', '10000.00', '1513845911', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('278', '20171221151384592956097874378477', '3', '10', null, '2', '30000.00', '1513845929', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('279', '20171221151384595260745399812354', '3', '10', '1', '1', '1000.00', '1513845952', null, '0', null, null, null);
INSERT INTO `pub_orders` VALUES ('280', '20171221151384920297743045584269', '3', '10', null, '1', '10000.00', '1513849202', null, '0', null, null, null);

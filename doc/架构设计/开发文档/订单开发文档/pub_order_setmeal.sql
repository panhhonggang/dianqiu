/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-16 17:18:53
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
  `goods_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) unsigned DEFAULT NULL COMMENT '订单创建时间',
  `updated_at` int(11) unsigned DEFAULT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`(11))
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_setmeal
-- ----------------------------
INSERT INTO `pub_order_setmeal` VALUES ('8', '20171216151340720112016317641317', '1', '1', '10000.00', '1513407201', null);
INSERT INTO `pub_order_setmeal` VALUES ('9', '20171216151341046412366446781281', '1', '1', '10000.00', '1513410464', null);
INSERT INTO `pub_order_setmeal` VALUES ('10', '20171216151341064513982794231133', '1', '1', '10000.00', '1513410645', null);
INSERT INTO `pub_order_setmeal` VALUES ('11', '20171216151341170712520724721219', '1', '1', '10000.00', '1513411707', null);
INSERT INTO `pub_order_setmeal` VALUES ('12', '20171216151341179113020728201338', '1', '1', '10000.00', '1513411791', null);
INSERT INTO `pub_order_setmeal` VALUES ('13', '20171216151341184013769198721379', '1', '1', '10000.00', '1513411840', null);
INSERT INTO `pub_order_setmeal` VALUES ('14', '20171216151341208713497202951355', '1', '1', '10000.00', '1513412087', null);
INSERT INTO `pub_order_setmeal` VALUES ('15', '20171216151341349013343258261376', '1', '1', '10000.00', '1513413490', null);
INSERT INTO `pub_order_setmeal` VALUES ('16', '20171216151341349413444911741129', '1', '1', '10000.00', '1513413494', null);
INSERT INTO `pub_order_setmeal` VALUES ('17', '20171216151341354713307633751402', '1', '1', '10000.00', '1513413547', null);
INSERT INTO `pub_order_setmeal` VALUES ('18', '20171216151341360614013567551118', '1', '1', '10000.00', '1513413606', null);
INSERT INTO `pub_order_setmeal` VALUES ('19', '20171216151341370513916951361155', '1', '1', '10000.00', '1513413705', null);
INSERT INTO `pub_order_setmeal` VALUES ('20', '20171216151341373113390899871123', '2', '1', '20000.00', '1513413731', null);
INSERT INTO `pub_order_setmeal` VALUES ('21', '20171216151341393512947499581375', '1', '1', '10000.00', '1513413935', null);
INSERT INTO `pub_order_setmeal` VALUES ('22', '20171216151341399813622077381136', '1', '1', '10000.00', '1513413998', null);
INSERT INTO `pub_order_setmeal` VALUES ('23', '20171216151341403111910415891388', '1', '1', '10000.00', '1513414031', null);
INSERT INTO `pub_order_setmeal` VALUES ('24', '20171216151341410212040997751210', '1', '1', '10000.00', '1513414102', null);
INSERT INTO `pub_order_setmeal` VALUES ('25', '20171216151341416212459119071353', '1', '1', '10000.00', '1513414162', null);
INSERT INTO `pub_order_setmeal` VALUES ('26', '20171216151341416513004652871293', '1', '1', '10000.00', '1513414165', null);
INSERT INTO `pub_order_setmeal` VALUES ('27', '20171216151341416513812735411243', '1', '1', '10000.00', '1513414165', null);
INSERT INTO `pub_order_setmeal` VALUES ('28', '20171216151341416512957975981302', '1', '1', '10000.00', '1513414165', null);
INSERT INTO `pub_order_setmeal` VALUES ('29', '20171216151341416611489874181368', '1', '1', '10000.00', '1513414166', null);
INSERT INTO `pub_order_setmeal` VALUES ('30', '20171216151341418813453628361308', '1', '1', '10000.00', '1513414188', null);
INSERT INTO `pub_order_setmeal` VALUES ('31', '20171216151341444011250858311114', '1', '1', '10000.00', '1513414440', null);
INSERT INTO `pub_order_setmeal` VALUES ('32', '20171216151341445114007973171216', '1', '1', '10000.00', '1513414451', null);
INSERT INTO `pub_order_setmeal` VALUES ('33', '20171216151341473712824060431288', '1', '1', '10000.00', '1513414737', null);
INSERT INTO `pub_order_setmeal` VALUES ('34', '20171216151341474112724181131324', '1', '1', '10000.00', '1513414741', null);
INSERT INTO `pub_order_setmeal` VALUES ('35', '20171216151341474312976822381362', '1', '1', '10000.00', '1513414743', null);
INSERT INTO `pub_order_setmeal` VALUES ('36', '20171216151341474413601151611117', '1', '1', '10000.00', '1513414744', null);
INSERT INTO `pub_order_setmeal` VALUES ('37', '20171216151341474612086273211256', '1', '1', '10000.00', '1513414746', null);
INSERT INTO `pub_order_setmeal` VALUES ('38', '20171216151341474813210651971221', '1', '1', '10000.00', '1513414748', null);
INSERT INTO `pub_order_setmeal` VALUES ('39', '20171216151341476012512276541126', '2', '1', '20000.00', '1513414760', null);
INSERT INTO `pub_order_setmeal` VALUES ('40', '20171216151341481911827554331395', '1', '1', '10000.00', '1513414819', null);
INSERT INTO `pub_order_setmeal` VALUES ('41', '20171216151341485912297463991156', '1', '1', '10000.00', '1513414859', null);
INSERT INTO `pub_order_setmeal` VALUES ('42', '20171216151341504214057892401395', '1', '1', '10000.00', '1513415042', null);
INSERT INTO `pub_order_setmeal` VALUES ('43', '20171216151341506613345129331390', '1', '1', '10000.00', '1513415066', null);
INSERT INTO `pub_order_setmeal` VALUES ('44', '20171216151341531912900528821244', '1', '1', '10000.00', '1513415319', null);
INSERT INTO `pub_order_setmeal` VALUES ('45', '20171216151341541412480112781186', '1', '1', '10000.00', '1513415414', null);
INSERT INTO `pub_order_setmeal` VALUES ('46', '20171216151341576911297395611285', '1', '1', '10000.00', '1513415769', null);

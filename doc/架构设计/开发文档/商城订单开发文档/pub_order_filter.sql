/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : pubdata

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-12-29 10:38:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pub_order_filter
-- ----------------------------
DROP TABLE IF EXISTS `pub_order_filter`;
CREATE TABLE `pub_order_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单编号',
  `filter_id` int(11) unsigned NOT NULL,
  `filtername` varchar(30) NOT NULL COMMENT '滤芯名称',
  `alias` varchar(30) DEFAULT '暂无别名' COMMENT '滤芯别名',
  `picpath` varchar(255) NOT NULL COMMENT '滤芯图片',
  `timelife` int(11) unsigned NOT NULL COMMENT '时间寿命（小时）',
  `flowlife` int(11) unsigned NOT NULL COMMENT '流量寿命（升）',
  `balancatime` int(11) unsigned DEFAULT NULL COMMENT '时间寿命使能',
  `balancaflow` int(11) unsigned DEFAULT NULL COMMENT '流量寿命使能',
  `introduce` varchar(255) DEFAULT '暂无简介' COMMENT '滤芯简介',
  `url` varchar(255) DEFAULT NULL COMMENT '滤芯购买网址',
  `price` decimal(15,2) NOT NULL,
  `goods_num` int(11) unsigned NOT NULL COMMENT '商品的购买总数量',
  `goods_price` decimal(15,2) unsigned NOT NULL COMMENT '商品的购买总金额',
  `created_at` int(11) NOT NULL COMMENT '订单创建时间',
  `updated_at` int(11) NOT NULL COMMENT '订单修改时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------
INSERT INTO `pub_order_filter` VALUES ('44', '970294217660737008', '1', 'RO膜', 'A型', '/dianqiu/project/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '4', '4000.00', '1514265775', '0');
INSERT INTO `pub_order_filter` VALUES ('45', '970294217660737008', '6', 'RO膜PP', 'C型', '/dianqiu/project/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '1', '6000.00', '1514265775', '0');
INSERT INTO `pub_order_filter` VALUES ('46', '970294217660737008', '4', 'RO膜2号', 'B型', '/dianqiu/project/Public/Home/images/ro_02.png', '5343', '3333', null, null, '望闻问切去我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '4000.00', '1', '4000.00', '1514265775', '0');
INSERT INTO `pub_order_filter` VALUES ('47', '157879036712097840', '1', 'RO膜', 'A型', '/dianqiu/project/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1514266678', '0');
INSERT INTO `pub_order_filter` VALUES ('48', '157879036712097840', '6', 'RO膜PP', 'C型', '/dianqiu/project/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '2', '12000.00', '1514266678', '0');
INSERT INTO `pub_order_filter` VALUES ('49', '157879036712097840', '4', 'RO膜2号', 'B型', '/dianqiu/project/Public/Home/images/ro_02.png', '5343', '3333', null, null, '望闻问切去我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '4000.00', '3', '12000.00', '1514266678', '0');
INSERT INTO `pub_order_filter` VALUES ('50', '160393629626761004', '1', 'RO膜', 'A型', '/dianqiu/project/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '4', '4000.00', '1514266748', '0');
INSERT INTO `pub_order_filter` VALUES ('51', '160393629626761004', '6', 'RO膜PP', 'C型', '/dianqiu/project/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '5', '30000.00', '1514266748', '0');
INSERT INTO `pub_order_filter` VALUES ('52', '160393629626761004', '4', 'RO膜2号', 'B型', '/dianqiu/project/Public/Home/images/ro_02.png', '5343', '3333', null, null, '望闻问切去我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '4000.00', '3', '12000.00', '1514266748', '0');
INSERT INTO `pub_order_filter` VALUES ('53', '476493813094536543', '1', 'RO膜', 'A型', '/dianqiu/project/Public/Home/images/ro_02.png', '500', '2000', null, null, '我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '1000.00', '1', '1000.00', '1514267672', '0');
INSERT INTO `pub_order_filter` VALUES ('54', '476493813094536543', '6', 'RO膜PP', 'C型', '/dianqiu/project/Public/Home/images/ro_02.png', '444', '322', null, null, '啊实打实我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '6000.00', '2', '12000.00', '1514267672', '0');
INSERT INTO `pub_order_filter` VALUES ('55', '476493813094536543', '4', 'RO膜2号', 'B型', '/dianqiu/project/Public/Home/images/ro_02.png', '5343', '3333', null, null, '望闻问切去我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介我是滤芯简介', 'http://www.baidu.com', '4000.00', '2', '8000.00', '1514267672', '0');

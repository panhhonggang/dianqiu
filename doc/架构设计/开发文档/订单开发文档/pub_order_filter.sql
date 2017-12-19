/*
Navicat MySQL Data Transfer

Source Server         : wuzhibin.cn
Source Server Version : 50173
Source Host           : sdm359768304.my3w.com:3306
Source Database       : sdm359768304_db

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-12-19 10:12:51
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pub_order_filter
-- ----------------------------

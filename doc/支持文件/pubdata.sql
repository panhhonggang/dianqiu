-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-12-09 04:06:20
-- 服务器版本： 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sdm359768304_db`
--

-- --------------------------------------------------------

--
-- 表的结构 `pub_auth_group`
--

CREATE TABLE `pub_auth_group` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text COMMENT '规则id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组表';

--
-- 转存表中的数据 `pub_auth_group`
--

INSERT INTO `pub_auth_group` (`id`, `title`, `status`, `rules`) VALUES
(6, '  工', 1, '126,127'),
(7, 'fdfd', 1, NULL),
(8, '测试人员', 1, '126,127,{$v[\'id\']},130,131,132');

-- --------------------------------------------------------

--
-- 表的结构 `pub_auth_group_access`
--

CREATE TABLE `pub_auth_group_access` (
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `group_id` int(11) UNSIGNED NOT NULL COMMENT '用户组id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

--
-- 转存表中的数据 `pub_auth_group_access`
--

INSERT INTO `pub_auth_group_access` (`uid`, `group_id`) VALUES
(1, 0),
(1, 6),
(5, 6),
(5, 8);

-- --------------------------------------------------------

--
-- 表的结构 `pub_auth_rule`
--

CREATE TABLE `pub_auth_rule` (
  `id` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='规则表';

--
-- 转存表中的数据 `pub_auth_rule`
--

INSERT INTO `pub_auth_rule` (`id`, `pid`, `name`, `title`, `status`, `type`, `condition`) VALUES
(126, 0, 'Admin/Devices', '设备', 1, 1, ''),
(127, 126, 'Admin/Devices/deviceDetail', '设备详情', 1, 1, ''),
(129, 0, 'Admin/Index/index', '后台首页', 1, 1, ''),
(130, 0, 'Admin/Vendors/index', '后台管理', 1, 1, ''),
(131, 130, 'Admin/Vendors/add', '添加经销商', 1, 1, ''),
(132, 130, 'Admin/Vendors/devices_add', '绑定机组', 1, 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `pub_binding`
--

CREATE TABLE `pub_binding` (
  `id` int(11) NOT NULL,
  `vid` int(11) NOT NULL COMMENT '经销商ID',
  `did` int(11) NOT NULL COMMENT '设备ID',
  `operator` varchar(255) NOT NULL COMMENT '操作人是谁',
  `addtime` int(11) NOT NULL COMMENT '操作时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pub_binding`
--

INSERT INTO `pub_binding` (`id`, `vid`, `did`, `operator`, `addtime`) VALUES
(1, 2, 1, '炒鸡管理员', 12323123),
(12, 3, 2, '炒鸡管理员', 1512460340),
(13, 2, 3, '炒鸡管理员', 1512540689);

-- --------------------------------------------------------

--
-- 表的结构 `pub_charg`
--

CREATE TABLE `pub_charg` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `vendors_id` int(11) UNSIGNED NOT NULL COMMENT '关联的供销商ID号',
  `lease_way` tinyint(1) UNSIGNED NOT NULL COMMENT '计费方式',
  `price` decimal(15,2) UNSIGNED NOT NULL COMMENT '价格',
  `begin_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_devices`
--

CREATE TABLE `pub_devices` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `device_code` int(20) UNSIGNED NOT NULL COMMENT '设备编码',
  `device_statu` tinyint(1) UNSIGNED NOT NULL COMMENT '设备状态：1已入库，2待激活，3已激活',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `binding_statu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否绑定经销商 0：未绑定 1：已绑定',
  `uid` int(11) DEFAULT NULL COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pub_devices`
--

INSERT INTO `pub_devices` (`id`, `device_code`, `device_statu`, `addtime`, `binding_statu`, `uid`) VALUES
(3, 2147483647, 1, 1512540680, 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `pub_devices_statu`
--

CREATE TABLE `pub_devices_statu` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `device_id` int(11) UNSIGNED NOT NULL COMMENT '关联的设备ID号',
  `device_statu` tinyint(1) UNSIGNED NOT NULL COMMENT '设备状态',
  `updated_at` int(11) NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_device_config`
--

CREATE TABLE `pub_device_config` (
  `id` int(11) NOT NULL,
  `did` int(11) NOT NULL COMMENT '设备ID',
  `dtid` int(11) NOT NULL COMMENT '设备类型ID',
  `vid` int(11) NOT NULL COMMENT '经销商ID',
  `leasingmode` tinyint(1) DEFAULT NULL COMMENT '租赁模式(0：时间 1：流量)',
  `addtime` int(11) NOT NULL COMMENT '创建时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_device_type`
--

CREATE TABLE `pub_device_type` (
  `id` int(11) NOT NULL,
  `typename` varchar(255) NOT NULL COMMENT '类型名称',
  `filter1` varchar(30) DEFAULT NULL COMMENT '一级滤芯',
  `filter2` varchar(30) DEFAULT NULL,
  `filter3` varchar(30) DEFAULT NULL,
  `filter4` varchar(30) DEFAULT NULL,
  `filter5` varchar(30) DEFAULT NULL,
  `filter6` varchar(30) DEFAULT NULL,
  `filter7` varchar(30) DEFAULT NULL,
  `filter8` varchar(30) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pub_device_type`
--

INSERT INTO `pub_device_type` (`id`, `typename`, `filter1`, `filter2`, `filter3`, `filter4`, `filter5`, `filter6`, `filter7`, `filter8`, `addtime`) VALUES
(8, '商务型', 'PP棉', 'RO膜', 'RO膜2号', 'RO膜PP', 'RO膜PP1', 'PP棉2号', '', '', 1510282247),
(7, '测试型', 'RO膜2号', 'RO膜PP', 'RO膜', '', '', '', '', '', 1510026151),
(9, '家用型', 'RO膜PP', 'RO膜2号', 'RO膜', '', '', '', '', '', 1510282291);

-- --------------------------------------------------------

--
-- 表的结构 `pub_filters`
--

CREATE TABLE `pub_filters` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `filtername` varchar(30) NOT NULL COMMENT '滤芯名称',
  `alias` varchar(30) DEFAULT '暂无别名' COMMENT '滤芯别名',
  `picpath` varchar(255) NOT NULL COMMENT '滤芯图片',
  `timelife` int(11) UNSIGNED NOT NULL COMMENT '时间寿命（小时）',
  `flowlife` int(11) UNSIGNED NOT NULL COMMENT '流量寿命（升）',
  `balancatime` int(11) UNSIGNED DEFAULT NULL COMMENT '时间寿命使能',
  `balancaflow` int(11) UNSIGNED DEFAULT NULL COMMENT '流量寿命使能',
  `introduce` varchar(255) DEFAULT '暂无简介' COMMENT '滤芯简介',
  `url` varchar(255) DEFAULT NULL COMMENT '滤芯购买网址',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `price` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pub_filters`
--

INSERT INTO `pub_filters` (`id`, `filtername`, `alias`, `picpath`, `timelife`, `flowlife`, `balancatime`, `balancaflow`, `introduce`, `url`, `addtime`, `price`) VALUES
(1, 'RO膜', 'A型', '', 500, 2000, NULL, NULL, '我是滤芯简介', 'http://www.baidu.com', 1509673437, '0.00'),
(2, 'PP棉', NULL, '', 123, 321, NULL, NULL, '凄凄切切', 'http://www.baidu.com', 1509607569, '0.00'),
(3, 'PP棉2号', NULL, '', 234, 432, NULL, NULL, '尺寸齐全', 'http://www.baidu.com', 1509607600, '0.00'),
(4, 'RO膜2号', 'B型', '', 5343, 3333, NULL, NULL, '望闻问切去', 'http://www.baidu.com', 1509673448, '0.00'),
(5, 'PPRO', NULL, '', 500, 2000, NULL, NULL, '啊啊按时到', 'http://www.baidu.com', 1509607666, '0.00'),
(6, 'RO膜PP', 'C型', '', 444, 322, NULL, NULL, '啊实打实', 'http://www.baidu.com', 1509673463, '0.00'),
(7, 'RO膜PP1', '', '', 444, 322, NULL, NULL, '啊实打实', 'http://www.baidu.com', 1509673287, '0.00'),
(9, 'RO膜', 'B型', '/upload/2017-12-08/5a2a5240d65ec.jpg', 100, 321, NULL, NULL, '撒打算1', 'http://www.baidu.com', 1512723008, '2302.00');

-- --------------------------------------------------------

--
-- 表的结构 `pub_hire`
--

CREATE TABLE `pub_hire` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `hire_id` int(11) UNSIGNED NOT NULL COMMENT '租赁编号',
  `vendors_id` int(11) UNSIGNED NOT NULL COMMENT '关联的供销商ID号',
  `device_id` int(11) UNSIGNED NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的用户ID号',
  `charg_id` int(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT '关联的计费ID号',
  `begin_time` int(11) NOT NULL COMMENT '租赁开始时间',
  `end_time` int(11) NOT NULL COMMENT '租赁结束时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_leaevl`
--

CREATE TABLE `pub_leaevl` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `vendors_id` int(11) UNSIGNED NOT NULL COMMENT '关联的供销商ID号',
  `parent_vid` int(11) UNSIGNED NOT NULL COMMENT '供销商的父级ID',
  `path` varchar(11) NOT NULL COMMENT '供销商的层级关系'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_loglist`
--

CREATE TABLE `pub_loglist` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的登陆ID号',
  `content` varchar(255) NOT NULL COMMENT '操作内容',
  `time` int(11) NOT NULL COMMENT '操作时间',
  `ip` varchar(15) NOT NULL COMMENT '操作IP'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_orders`
--

CREATE TABLE `pub_orders` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `order_id` int(11) UNSIGNED NOT NULL COMMENT '订单编号',
  `device_id` int(11) UNSIGNED NOT NULL COMMENT '关联的设备ID号',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '关联的用户ID号',
  `goods_num` int(11) UNSIGNED NOT NULL COMMENT '商品的购买数量',
  `goods_price` decimal(15,2) UNSIGNED NOT NULL COMMENT '商品的购买单价',
  `goods_total` decimal(15,2) UNSIGNED NOT NULL COMMENT '商品总金额',
  `created_at` int(11) NOT NULL COMMENT '订单创建时间',
  `updated_at` int(11) NOT NULL COMMENT '订单修改时间',
  `filter_id` int(11) NOT NULL COMMENT '滤芯ID',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态(0：未付款1：已付款2：未发货3：已发货4：已签收)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_setmeal`
--

CREATE TABLE `pub_setmeal` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `money` decimal(25,0) UNSIGNED DEFAULT NULL COMMENT '套餐金额',
  `flow` int(11) UNSIGNED DEFAULT NULL COMMENT '套餐流量',
  `describe` varchar(255) DEFAULT NULL COMMENT '套餐描述'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_users`
--

CREATE TABLE `pub_users` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `name` varchar(15) NOT NULL COMMENT '用户名字',
  `phone` varchar(11) NOT NULL COMMENT '手机号码',
  `user_status` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户状态',
  `login_time` int(11) DEFAULT NULL COMMENT '最后登陆的时间',
  `login_ip` varchar(15) DEFAULT NULL COMMENT '最后登陆的IP地址',
  `created_at` int(11) NOT NULL COMMENT '添加时间',
  `open_id` int(11) NOT NULL COMMENT '关联微信信息表'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_vendors`
--

CREATE TABLE `pub_vendors` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `user` varchar(32) NOT NULL COMMENT '供销商登陆的用户名',
  `name` varchar(32) NOT NULL COMMENT '供销商的名字',
  `password` varchar(32) NOT NULL COMMENT '供销商登陆的密码',
  `phone` varchar(11) NOT NULL COMMENT '供销商手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '供销商邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '供销商地址',
  `leavel` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '供销商级别：默认为“1”级',
  `pid` int(11) NOT NULL DEFAULT '1' COMMENT '经销商上级ID',
  `addtime` int(11) NOT NULL COMMENT '创建时间',
  `idcard` varchar(20) NOT NULL COMMENT '身份证号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pub_vendors`
--

INSERT INTO `pub_vendors` (`id`, `user`, `name`, `password`, `phone`, `email`, `address`, `leavel`, `pid`, `addtime`, `idcard`) VALUES
(1, 'admin', '炒鸡管理员', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '天津市 天津市 和平区', 0, 0, 1512461767, '430122199610224517'),
(2, '12', '我是经销商1', '3c59dc048e8850243be8079a5c74d079', '13838381438', '619328391@qq.com', '1212', 1, 1, 1508812510, '430122199610224517'),
(3, '123', '经销商2', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '1212', 1, 1, 1508917638, '430122199610224517'),
(4, '11', '12', 'd41d8cd98f00b204e9800998ecf8427e', '13838381438', '619328391@qq.com', '1212', 1, 1, 1508989286, '430122199610224517'),
(5, 'ping', 'ping', 'df911f0151f9ef021d410b4be5060972', '13800138000', '13800138000@139.com', '123456', 1, 1, 1512522159, '138001380001380000'),
(6, 'qwe', '鞍山市', '202cb962ac59075b964b07152d234b70', '13838381438', '619328391@qq.com', '1212', 1, 1, 1509585067, '430122199610224517');

-- --------------------------------------------------------

--
-- 表的结构 `pub_wechat`
--

CREATE TABLE `pub_wechat` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增ID',
  `open_id` varchar(50) NOT NULL COMMENT '微信的ID号',
  `nickname` varchar(50) NOT NULL COMMENT '微信昵称',
  `head` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` tinyint(1) UNSIGNED DEFAULT NULL COMMENT '性别',
  `area` varchar(255) DEFAULT NULL COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `pub_work`
--

CREATE TABLE `pub_work` (
  `id` int(11) NOT NULL,
  `number` varchar(30) NOT NULL COMMENT '工单编号',
  `name` varchar(50) NOT NULL COMMENT '处理人',
  `phone` varchar(11) NOT NULL COMMENT '处理人电话',
  `type` tinyint(1) NOT NULL COMMENT '工单类型(0：安装 1：维修 2：维护)',
  `content` text NOT NULL COMMENT '维护内容',
  `address` varchar(50) NOT NULL COMMENT '地址',
  `result` tinyint(1) NOT NULL COMMENT '处理结果(0：未处理 1：正在处理 2：已处理)',
  `time` varchar(30) NOT NULL COMMENT '处理时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pub_auth_group`
--
ALTER TABLE `pub_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pub_auth_group_access`
--
ALTER TABLE `pub_auth_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `pub_auth_rule`
--
ALTER TABLE `pub_auth_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `pub_binding`
--
ALTER TABLE `pub_binding`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pub_charg`
--
ALTER TABLE `pub_charg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendors_id` (`vendors_id`);

--
-- Indexes for table `pub_devices`
--
ALTER TABLE `pub_devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`,`device_code`);

--
-- Indexes for table `pub_devices_statu`
--
ALTER TABLE `pub_devices_statu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_id` (`device_id`,`device_statu`);

--
-- Indexes for table `pub_device_config`
--
ALTER TABLE `pub_device_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pub_device_type`
--
ALTER TABLE `pub_device_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pub_filters`
--
ALTER TABLE `pub_filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_id` (`filtername`);

--
-- Indexes for table `pub_hire`
--
ALTER TABLE `pub_hire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hire_id` (`hire_id`,`device_id`,`user_id`,`vendors_id`,`charg_id`) USING BTREE;

--
-- Indexes for table `pub_leaevl`
--
ALTER TABLE `pub_leaevl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pub_loglist`
--
ALTER TABLE `pub_loglist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pub_orders`
--
ALTER TABLE `pub_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`,`device_id`,`user_id`);

--
-- Indexes for table `pub_setmeal`
--
ALTER TABLE `pub_setmeal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pub_users`
--
ALTER TABLE `pub_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`,`phone`);

--
-- Indexes for table `pub_vendors`
--
ALTER TABLE `pub_vendors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`,`name`,`password`,`email`,`phone`,`leavel`);

--
-- Indexes for table `pub_wechat`
--
ALTER TABLE `pub_wechat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`open_id`);

--
-- Indexes for table `pub_work`
--
ALTER TABLE `pub_work`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `pub_auth_group`
--
ALTER TABLE `pub_auth_group`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- 使用表AUTO_INCREMENT `pub_auth_rule`
--
ALTER TABLE `pub_auth_rule`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;
--
-- 使用表AUTO_INCREMENT `pub_binding`
--
ALTER TABLE `pub_binding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- 使用表AUTO_INCREMENT `pub_charg`
--
ALTER TABLE `pub_charg`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_devices`
--
ALTER TABLE `pub_devices`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `pub_devices_statu`
--
ALTER TABLE `pub_devices_statu`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_device_config`
--
ALTER TABLE `pub_device_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `pub_device_type`
--
ALTER TABLE `pub_device_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- 使用表AUTO_INCREMENT `pub_filters`
--
ALTER TABLE `pub_filters`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=10;
--
-- 使用表AUTO_INCREMENT `pub_hire`
--
ALTER TABLE `pub_hire`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_leaevl`
--
ALTER TABLE `pub_leaevl`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_loglist`
--
ALTER TABLE `pub_loglist`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_orders`
--
ALTER TABLE `pub_orders`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_setmeal`
--
ALTER TABLE `pub_setmeal`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_users`
--
ALTER TABLE `pub_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_vendors`
--
ALTER TABLE `pub_vendors`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=7;
--
-- 使用表AUTO_INCREMENT `pub_wechat`
--
ALTER TABLE `pub_wechat`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `pub_work`
--
ALTER TABLE `pub_work`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

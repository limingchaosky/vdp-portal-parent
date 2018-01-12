/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.140
Source Server Version : 50713
Source Host           : 192.168.0.140:3306
Source Database       : goldencis_vdp

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2018-01-11 22:39:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `act_id_user`
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '0.等于被删除,1.启用,2.tsa用户',
  `department` varchar(32) COLLATE utf8_bin DEFAULT '1',
  `role_type` tinyint(4) DEFAULT NULL,
  `phone` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `user_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `platform_account` int(11) DEFAULT '0' COMMENT '0不是 1是',
  `error_login_count` int(3) DEFAULT '0' COMMENT '错误登录次数',
  `error_login_last_time` timestamp NULL DEFAULT NULL COMMENT '最近错误登录时间',
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------
INSERT INTO `act_id_user` VALUES ('-1', null, '超级管理员', null, '--', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', null, '1', '1', null, '--', 'system', '0', '0', '2017-12-26 16:02:44', null);

-- ----------------------------
-- Table structure for `t_app_mobile_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_app_mobile_info`;
CREATE TABLE `t_app_mobile_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '用户id',
  `secret_key` varchar(500) COLLATE utf8_bin NOT NULL COMMENT 'token',
  `imei` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `mobile_info` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '用户终端信息',
  `update_date` timestamp NULL DEFAULT NULL COMMENT '最近登录时间',
  `invalid_date` timestamp NULL DEFAULT NULL COMMENT '失效时间',
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='手机端登录信息表';

-- ----------------------------
-- Records of t_app_mobile_info
-- ----------------------------

-- ----------------------------
-- Table structure for `t_app_version`
-- ----------------------------
DROP TABLE IF EXISTS `t_app_version`;
CREATE TABLE `t_app_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_version` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'app版本',
  `app_code` int(11) NOT NULL COMMENT 'app版本code',
  `app_file_size` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '文件大小',
  `app_down_load_url` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '文件下载地址',
  `app_file_url` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '文件所在物理地址',
  `app_package_name` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '文件包名',
  `app_icon_url` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'icon地址',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上传时间',
  `app_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='app版本控制表';

-- ----------------------------
-- Records of t_app_version
-- ----------------------------

-- ----------------------------
-- Table structure for `t_client_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_client_user`;
CREATE TABLE `t_client_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` char(36) NOT NULL COMMENT '用户唯一标识',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(200) NOT NULL COMMENT '密码',
  `truename` varchar(32) NOT NULL COMMENT '真实姓名',
  `deptguid` int(11) NOT NULL COMMENT '所属部门id',
  `computerguid` char(36) DEFAULT NULL COMMENT '计算机唯一标识',
  `computername` varchar(32) DEFAULT NULL COMMENT '计算机名',
  `ip` varchar(18) DEFAULT NULL COMMENT 'ip',
  `regtime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `policyid` int(11) DEFAULT '0' COMMENT '策略id',
  `isbinded_usbkey` int(11) NOT NULL,
  `online` char(1) NOT NULL DEFAULT '0' COMMENT '是否在线',
  `online_time` timestamp NULL DEFAULT NULL COMMENT '上线时间',
  `offline_time` timestamp NULL DEFAULT NULL COMMENT '离线时间',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `index_vdpusers_guid` (`guid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_client_user
-- ----------------------------
INSERT INTO `t_client_user` VALUES ('30', '81a5a35f-a80c-471c-a241-8a3879ab2cc3', 'restful', 'B93119DC89AF43769AF115320EE4BD992FC2D6DFC87BCC7553DE116A061C78A1', 'restful', '45', null, null, null, '2018-01-05 16:42:23', '92', '1', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('31', '1371852d-93aa-492a-909f-9e63ff768acd', 'departmentTest', '0115390276431D2D056D9AB3A29C5D8F821207617576D9B482D919DD7FAE52CA', 'departmentTest', '2', null, null, null, '2018-01-05 19:40:20', '92', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('32', 'd3fe313a-6619-4776-956e-f02961faae83', 'departmentTest2', '0115390276431D2D056D9AB3A29C5D8F821207617576D9B482D919DD7FAE52CA', 'departmentTest', '2', null, null, null, '2018-01-05 19:40:35', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('33', '0b48646a-658c-40dc-9ad6-1558b4e8d008', 'deptguid', '6A0EF21C3C5BC5A629527C7E8147BFEB9B7A8741BBFFA2055E885D02E17BDF0D', 'deptguid', '2', null, null, null, '2018-01-05 11:51:33', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('34', 'e436938c-6377-426f-ad7b-d7e690472561', 'deptguid2', '6A0EF21C3C5BC5A629527C7E8147BFEB9B7A8741BBFFA2055E885D02E17BDF0D', 'deptguid', '2', null, null, null, '2018-01-05 11:51:45', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('35', '55dd912a-8cf6-4717-b662-eeb05a1272a6', 'chengl', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', 'chengl', '1', null, null, null, '2018-01-08 07:00:05', '1', '0', '1', '2018-01-11 08:04:35', '2018-01-09 22:09:21', null);
INSERT INTO `t_client_user` VALUES ('36', 'e0572a7e-0fec-42d7-bf0f-9a61108eab23', 'zhangs', '0FD345E522CB9037DEB1D6C7FDA4E78FDDBB609B0A5484C65139C79B35CA579E', 'zs', '1', null, null, null, '2018-01-09 12:57:29', '1', '0', '1', '2018-01-10 08:10:52', null, null);
INSERT INTO `t_client_user` VALUES ('37', '78a28459-1c39-4c93-9467-193a88867b2b', 'chent', '0FD345E522CB9037DEB1D6C7FDA4E78FDDBB609B0A5484C65139C79B35CA579E', '陈涛', '2', null, null, null, '2018-01-10 03:10:41', '1', '0', '1', '2018-01-10 04:50:23', null, null);
INSERT INTO `t_client_user` VALUES ('38', 'a04287a9-7c7b-491a-8fc8-fe1d3a4b6c02', 'zs', '0FD345E522CB9037DEB1D6C7FDA4E78FDDBB609B0A5484C65139C79B35CA579E', 'zs', '1', null, null, null, '2018-01-10 06:52:51', '1', '0', '1', '2018-01-10 07:01:59', null, null);
INSERT INTO `t_client_user` VALUES ('39', 'cc7e5b08-f84d-4a83-a014-d62265c1fab5', '111', '96739A2B15FAE2FA5634DDC677E05064328E595F0F7F12645F94ED5EF515EA9F', '111', '1', null, null, null, '2018-01-10 13:48:56', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('40', 'b203386a-da96-4eb4-945e-f8338d195a9d', '1111', '96739A2B15FAE2FA5634DDC677E05064328E595F0F7F12645F94ED5EF515EA9F', '111', '1', null, null, null, '2018-01-10 13:49:12', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('41', '3a6ca091-72ce-4654-b3f8-f1351b916b1d', '222', '6F89D444A393D889E58CFC3C3D972E19E98448BD1D24FFFD9750C47CAFAD3BDB', '222', '1', null, null, null, '2018-01-10 13:49:21', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('42', '3da1ca5c-4213-453a-881f-53eeb3fc5201', '2', '6F89D444A393D889E58CFC3C3D972E19E98448BD1D24FFFD9750C47CAFAD3BDB', '2', '1', null, null, null, '2018-01-10 13:49:43', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('43', 'db26d8cc-e176-4713-937d-c6637b6bb9ba', '1', '96739A2B15FAE2FA5634DDC677E05064328E595F0F7F12645F94ED5EF515EA9F', '1', '1', null, null, null, '2018-01-10 13:49:51', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('44', 'e5d37310-f3e9-48b3-b51b-98e75f563c76', '5', '0F7AF9DFA74BDC45D8E81115FC036DD31D682F245BCA3A950A280AB393A2437C', '5', '1', null, null, null, '2018-01-10 13:50:06', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('45', 'b100b338-3e49-4543-9fd2-5e20692e6179', '55', '0F7AF9DFA74BDC45D8E81115FC036DD31D682F245BCA3A950A280AB393A2437C', '55', '1', null, null, null, '2018-01-10 13:50:14', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('46', '3ae6f4be-293d-4cd3-bbe2-84570e95fdb0', 'w', 'C1914DD659030BB13F99AABDF7DA19C01591E6C058DEDAAC10DB9A1B1FFF1878', 'w', '1', null, null, null, '2018-01-10 13:50:30', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('47', 'a83de67a-118a-4524-8833-d428d8e6fc71', 'ww', 'C1914DD659030BB13F99AABDF7DA19C01591E6C058DEDAAC10DB9A1B1FFF1878', 'ww', '1', null, null, null, '2018-01-10 13:50:37', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('48', '3d1c438c-202d-4685-92a8-361143884f9a', 'www', 'C1914DD659030BB13F99AABDF7DA19C01591E6C058DEDAAC10DB9A1B1FFF1878', 'www', '1', null, null, null, '2018-01-10 13:50:45', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('49', 'b1da2aa3-d4c3-450e-abd1-5ad61f6a1036', 'e', 'F386CE51851D5C25F0B61E61C893CB799D6FDFD481D29FB972E62EA6382F23DF', 'e', '1', null, null, null, '2018-01-10 13:50:52', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('50', 'd6e62a75-4a23-4d5d-ba5c-4007e07e3094', 'ee', 'F386CE51851D5C25F0B61E61C893CB799D6FDFD481D29FB972E62EA6382F23DF', 'ee', '1', null, null, null, '2018-01-10 13:51:07', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('51', 'bbbaa79d-6426-4681-9d00-f216a6bf56e9', 'eee', 'F386CE51851D5C25F0B61E61C893CB799D6FDFD481D29FB972E62EA6382F23DF', 'eee', '1', null, null, null, '2018-01-10 13:51:15', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('52', 'a11eaba6-d50c-4c70-8abf-0eb7d2a84d69', 'a', '317DD43941488826ACDAEF423365B246A2E4FE95A248C8738584351379F5051F', 'a', '1', null, null, null, '2018-01-10 13:53:50', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('53', '6cd51b42-52c3-4e98-8e8f-e2cbe3fb8493', 'aa', '317DD43941488826ACDAEF423365B246A2E4FE95A248C8738584351379F5051F', 'aa', '1', null, null, null, '2018-01-10 13:53:59', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('54', '58f37d35-ff8e-4b50-b2fc-25c80c474ba8', 'aaa', '317DD43941488826ACDAEF423365B246A2E4FE95A248C8738584351379F5051F', 'aaa', '1', null, null, null, '2018-01-10 13:54:06', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('55', '60b408e8-8627-4a74-b2e2-d215fc3f7e01', 's', '2A7931D8B41AD9E94EAD2B82F7FAC2FD40D68506A4A53B20F54B0E89D256B40F', 's', '1', null, null, null, '2018-01-10 13:54:20', '1', '0', '0', null, null, null);
INSERT INTO `t_client_user` VALUES ('56', '75c58437-9f1d-46fa-a0aa-ac007833355c', 'ss', '2A7931D8B41AD9E94EAD2B82F7FAC2FD40D68506A4A53B20F54B0E89D256B40F', 'ss', '1', null, null, null, '2018-01-10 13:54:46', '1', '0', '0', null, null, null);

-- ----------------------------
-- Table structure for `t_department`
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '部门名称',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级部门Id',
  `department_remark` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `owner` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '部门负责人',
  `department_tel` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '部门电话',
  `ip_part` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '所属IP段',
  `tree_path` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '路径',
  `status` int(11) unsigned DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='部门信息表';

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('1', '顶级部门', '-1', null, 'chen', '13188885555', null, ',', '1');
INSERT INTO `t_department` VALUES ('2', '未分组', '1', null, 'chen111', '13188885555', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('44', '测试部', '1', null, 'a', '12345678910', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('45', '测试一部', '44', null, '', '', null, ',1,44,', '1');
INSERT INTO `t_department` VALUES ('46', '测试二部', '44', null, '', '', null, ',1,44,', '1');
INSERT INTO `t_department` VALUES ('47', '测试三部', '44', null, '', '', null, ',1,44,', '1');
INSERT INTO `t_department` VALUES ('48', '测试一部一组', '45', null, '', '', null, ',1,44,45,', '1');
INSERT INTO `t_department` VALUES ('49', '测试一部二组', '45', null, '', '', null, ',1,44,45,', '1');
INSERT INTO `t_department` VALUES ('50', '研发部', '1', null, '', '', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('51', '财务部', '1', null, '', '', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('52', '行政部', '1', null, '', '', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('53', '研发一部', '50', null, '', '', null, ',1,50,', '1');
INSERT INTO `t_department` VALUES ('54', '研发二部', '50', null, '', '', null, ',1,50,', '1');
INSERT INTO `t_department` VALUES ('55', '研发三部', '50', null, '', '', null, ',1,50,', '1');
INSERT INTO `t_department` VALUES ('56', 'VDP', '54', null, '', '', null, ',1,50,54,', '1');
INSERT INTO `t_department` VALUES ('57', 'MDM', '54', null, '', '', null, ',1,50,54,', '1');
INSERT INTO `t_department` VALUES ('58', '会计组', '51', null, '', '', null, ',1,51,', '1');
INSERT INTO `t_department` VALUES ('59', '审计组', '51', null, '', '', null, ',1,51,', '1');
INSERT INTO `t_department` VALUES ('63', 'BBB', '51', null, '', '', null, ',1,51,', '1');
INSERT INTO `t_department` VALUES ('64', '2222222', '1', null, '', '', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('65', 'ddd', '1', null, '', '', null, ',1,', '1');
INSERT INTO `t_department` VALUES ('68', 'asdas', '48', null, '', '', null, ',1,44,45,48,', '1');
INSERT INTO `t_department` VALUES ('69', 'sss', '68', null, '', '', null, ',1,44,45,48,68,', '1');
INSERT INTO `t_department` VALUES ('70', 'a', '69', null, '', '', null, ',1,44,45,48,68,69,', '1');
INSERT INTO `t_department` VALUES ('71', 'assss', '70', null, '', '', null, ',1,44,45,48,68,69,70,', '1');
INSERT INTO `t_department` VALUES ('72', 'zzzz', '71', null, '', '', null, ',1,44,45,48,68,69,70,71,', '1');

-- ----------------------------
-- Table structure for `t_deployment_status`
-- ----------------------------
DROP TABLE IF EXISTS `t_deployment_status`;
CREATE TABLE `t_deployment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deployment_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '部署ID',
  `status` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='流程部署状态';

-- ----------------------------
-- Records of t_deployment_status
-- ----------------------------

-- ----------------------------
-- Table structure for `t_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `t_dictionary`;
CREATE TABLE `t_dictionary` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '字典类型',
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '值',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `sort_by` int(50) DEFAULT NULL COMMENT '排序',
  `status` int(11) unsigned DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据字典';

-- ----------------------------
-- Records of t_dictionary
-- ----------------------------
INSERT INTO `t_dictionary` VALUES ('1', 'formProperty', 'string', '字符', '1', '1');
INSERT INTO `t_dictionary` VALUES ('2', 'formProperty', 'long', '长整型', '2', '1');
INSERT INTO `t_dictionary` VALUES ('3', 'formProperty', 'date', '时间', '3', '1');
INSERT INTO `t_dictionary` VALUES ('4', 'formProperty', 'editor', '富文本编辑器', '4', '1');
INSERT INTO `t_dictionary` VALUES ('5', 'taskListener', '${screenCandidatesByDepartmentTaskListener}', '自动筛选用户', '1', '1');
INSERT INTO `t_dictionary` VALUES ('6', 'priority', '2', '紧急', '2', '1');
INSERT INTO `t_dictionary` VALUES ('7', 'priority', '1', '普通', '1', '1');
INSERT INTO `t_dictionary` VALUES ('10', 'workUpdateState', '0', '异常', '5', '0');
INSERT INTO `t_dictionary` VALUES ('11', 'workUpdateState', '1', '待处理', '1', '1');
INSERT INTO `t_dictionary` VALUES ('12', 'workUpdateState', '2', '处理中', '2', '1');
INSERT INTO `t_dictionary` VALUES ('13', 'workUpdateState', '3', '挂起', '3', '0');
INSERT INTO `t_dictionary` VALUES ('14', 'workUpdateState', '4', '已完成', '4', '1');
INSERT INTO `t_dictionary` VALUES ('15', 'knowledgeType', '0', '设备维修', '1', '1');
INSERT INTO `t_dictionary` VALUES ('16', 'formProperty', 'examine', '审批结果', '5', '1');
INSERT INTO `t_dictionary` VALUES ('17', 'formProperty', 'double', '数字(带小数)', null, '1');
INSERT INTO `t_dictionary` VALUES ('18', 'evaluateType', 'quality', '服务质量', '3', '1');
INSERT INTO `t_dictionary` VALUES ('19', 'evaluateType', 'speciality', '专业性', '2', '1');
INSERT INTO `t_dictionary` VALUES ('20', 'evaluateType', 'timely', '及时性', '1', '1');
INSERT INTO `t_dictionary` VALUES ('21', 'formProperty', 'enum', '下拉框', '5', '1');
INSERT INTO `t_dictionary` VALUES ('25', 'autoKnowledge', '4', '评分为4自动转知识库', '1', '1');
INSERT INTO `t_dictionary` VALUES ('59', 'workType', 'Availability', '离线', '1', '1');
INSERT INTO `t_dictionary` VALUES ('60', 'workType', 'Spoofing', '冒用', '2', '1');
INSERT INTO `t_dictionary` VALUES ('61', 'workType', 'Invasion', '入侵', '3', '1');

-- ----------------------------
-- Table structure for `t_navigation`
-- ----------------------------
DROP TABLE IF EXISTS `t_navigation`;
CREATE TABLE `t_navigation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键（自增长）',
  `compositor` int(10) unsigned NOT NULL COMMENT '排序',
  `title` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '页签显示名称',
  `url` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '页签跳转链接',
  `parent_id` int(10) DEFAULT NULL COMMENT '父级页签Id',
  `icon_url` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '页签图标',
  `n_level` int(10) unsigned NOT NULL COMMENT '页签级别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='页签-导航信息表';

-- ----------------------------
-- Records of t_navigation
-- ----------------------------
INSERT INTO `t_navigation` VALUES ('1', '1', '首页', '/homepage/index?navId=1', null, 'nav_home', '1');
INSERT INTO `t_navigation` VALUES ('2', '2', '用户', '', null, 'nav_user', '1');
INSERT INTO `t_navigation` VALUES ('3', '3', '准入', '/access/index?navId=1', null, 'nav_check', '1');
INSERT INTO `t_navigation` VALUES ('4', '4', '策略', '', null, 'nav_policy', '1');
INSERT INTO `t_navigation` VALUES ('5', '5', '审批', '', null, 'nav_approve', '1');
INSERT INTO `t_navigation` VALUES ('6', '6', '报表', '/report/index', null, 'nav_report', '1');
INSERT INTO `t_navigation` VALUES ('7', '7', '系统', '', null, 'nav_system', '1');
INSERT INTO `t_navigation` VALUES ('8', '8', '关于', '/about/index', null, 'nav_about', '1');
INSERT INTO `t_navigation` VALUES ('9', '9', '用户管理', '/clientUser/index', '2', null, '2');
INSERT INTO `t_navigation` VALUES ('10', '10', '部门管理', '/department/index', '2', null, '2');
INSERT INTO `t_navigation` VALUES ('11', '11', '客户端', '/systemClient/index', '7', '', '2');
INSERT INTO `t_navigation` VALUES ('12', '12', 'USBKEY库', '/usbKey/index', '7', null, '2');
INSERT INTO `t_navigation` VALUES ('13', '13', '系统日志', '/clientUser/index', '7', null, '2');
INSERT INTO `t_navigation` VALUES ('14', '14', '系统设置', '/systemSetting/index', '7', null, '2');
INSERT INTO `t_navigation` VALUES ('15', '15', '审批流程', '111111', '5', null, '2');
INSERT INTO `t_navigation` VALUES ('16', '16', '审批请求', '111111111', '5', null, '2');

-- ----------------------------
-- Table structure for `t_permission`
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键（自增长）',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '权限名称',
  `visible` int(1) DEFAULT '1' COMMENT '是否可见',
  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限信息表';

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', '默认角色', '1', null);

-- ----------------------------
-- Table structure for `t_permission_navigation`
-- ----------------------------
DROP TABLE IF EXISTS `t_permission_navigation`;
CREATE TABLE `t_permission_navigation` (
  `permission_id` int(10) unsigned NOT NULL COMMENT '权限Id',
  `navigation_id` int(10) unsigned NOT NULL COMMENT '权限关联导航Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限与页签关联关系';

-- ----------------------------
-- Records of t_permission_navigation
-- ----------------------------
INSERT INTO `t_permission_navigation` VALUES ('1', '1');
INSERT INTO `t_permission_navigation` VALUES ('1', '2');
INSERT INTO `t_permission_navigation` VALUES ('1', '3');
INSERT INTO `t_permission_navigation` VALUES ('1', '4');
INSERT INTO `t_permission_navigation` VALUES ('1', '8');
INSERT INTO `t_permission_navigation` VALUES ('1', '6');
INSERT INTO `t_permission_navigation` VALUES ('1', '5');
INSERT INTO `t_permission_navigation` VALUES ('1', '7');
INSERT INTO `t_permission_navigation` VALUES ('2', '1');
INSERT INTO `t_permission_navigation` VALUES ('2', '2');
INSERT INTO `t_permission_navigation` VALUES ('2', '3');
INSERT INTO `t_permission_navigation` VALUES ('3', '1');
INSERT INTO `t_permission_navigation` VALUES ('3', '8');
INSERT INTO `t_permission_navigation` VALUES ('1', '9');
INSERT INTO `t_permission_navigation` VALUES ('1', '10');

-- ----------------------------
-- Table structure for `t_policy`
-- ----------------------------
DROP TABLE IF EXISTS `t_policy`;
CREATE TABLE `t_policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '策略名',
  `path` varchar(2000) DEFAULT NULL COMMENT '策略所在路径',
  `default_id` int(11) DEFAULT NULL COMMENT '是否是默认策略',
  `modify_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_policy
-- ----------------------------
INSERT INTO `t_policy` VALUES ('1', '默认', '/resource/policy/1/bdppolicy.json', '1', '2018-01-11 12:26:41');
INSERT INTO `t_policy` VALUES ('92', 'wqeqwe', '/resource/policy/92/bdppolicy.json', '0', '2018-01-09 06:40:05');
INSERT INTO `t_policy` VALUES ('93', '123123', '/resource/policy/93/bdppolicy.json', '0', '2018-01-09 06:40:09');
INSERT INTO `t_policy` VALUES ('94', '234234', '/resource/policy/94/bdppolicy.json', '0', '2018-01-09 06:40:36');
INSERT INTO `t_policy` VALUES ('95', 'zhangs', '/resource/policy/95/bdppolicy.json', '0', '2018-01-10 07:27:08');

-- ----------------------------
-- Table structure for `t_prompt_refuse`
-- ----------------------------
DROP TABLE IF EXISTS `t_prompt_refuse`;
CREATE TABLE `t_prompt_refuse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='提示白名单用户表';

-- ----------------------------
-- Records of t_prompt_refuse
-- ----------------------------

-- ----------------------------
-- Table structure for `t_sequence`
-- ----------------------------
DROP TABLE IF EXISTS `t_sequence`;
CREATE TABLE `t_sequence` (
  `NAME` varchar(50) NOT NULL,
  `current_value` int(11) NOT NULL,
  `increment` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sequence
-- ----------------------------
INSERT INTO `t_sequence` VALUES ('GroupSeq', '11', '1');

-- ----------------------------
-- Table structure for `t_suspend_info`
-- ----------------------------
DROP TABLE IF EXISTS `t_suspend_info`;
CREATE TABLE `t_suspend_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proc_inst_id` varchar(64) NOT NULL COMMENT '流程实例ID',
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `task_id` varchar(64) NOT NULL COMMENT '任务ID',
  `suspend_time` timestamp NULL DEFAULT NULL COMMENT '挂起时间',
  `activate_time` timestamp NULL DEFAULT NULL COMMENT '激活时间',
  `suspend_total_time` int(11) DEFAULT NULL COMMENT '挂起时长',
  `description` varchar(500) DEFAULT NULL COMMENT '挂起理由',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂起激活信息表';

-- ----------------------------
-- Records of t_suspend_info
-- ----------------------------

-- ----------------------------
-- Table structure for `t_svg_xml`
-- ----------------------------
DROP TABLE IF EXISTS `t_svg_xml`;
CREATE TABLE `t_svg_xml` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `svg_xml` text COLLATE utf8_bin,
  `model_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT=' svg信息表';

-- ----------------------------
-- Records of t_svg_xml
-- ----------------------------

-- ----------------------------
-- Table structure for `t_system_validate`
-- ----------------------------
DROP TABLE IF EXISTS `t_system_validate`;
CREATE TABLE `t_system_validate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `system_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '系统id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统验证表,接口认证';

-- ----------------------------
-- Records of t_system_validate
-- ----------------------------
INSERT INTO `t_system_validate` VALUES ('1', 'system', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', 'tsaNB');

-- ----------------------------
-- Table structure for `t_usbkey`
-- ----------------------------
DROP TABLE IF EXISTS `t_usbkey`;
CREATE TABLE `t_usbkey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '昵称',
  `keysn` varchar(36) DEFAULT NULL COMMENT '设备标识',
  `keynum` varchar(36) DEFAULT NULL COMMENT '唯一标识',
  `regtime` timestamp NULL DEFAULT NULL COMMENT '注册时间',
  `userguid` varchar(36) DEFAULT NULL COMMENT '绑定的用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_usbkey
-- ----------------------------
INSERT INTO `t_usbkey` VALUES ('1', 'usbKey1', '123456789', '123456789', '2018-01-04 21:31:58', '0');
INSERT INTO `t_usbkey` VALUES ('2', 'usbKey2', '123456789', '123456789', '2018-01-04 21:34:24', '0');
INSERT INTO `t_usbkey` VALUES ('3', 'usbKey3', '123456789', '123456789', '2018-01-05 11:28:51', '81a5a35f-a80c-471c-a241-8a3879ab2cc3');
INSERT INTO `t_usbkey` VALUES ('4', 'usbKey4', '123456789', '123456789', '2018-01-05 11:29:52', '0');
INSERT INTO `t_usbkey` VALUES ('5', 'usbKey5', '123456789', '123456789', '2018-01-05 11:29:54', '0');
INSERT INTO `t_usbkey` VALUES ('6', 'usbKey6', '123456789', '123456789', '2018-01-05 11:30:26', '0');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(36) NOT NULL COMMENT '主键（自增长）',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `department` int(11) DEFAULT NULL COMMENT '所属部门',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `sex` int(11) DEFAULT '0' COMMENT '性别',
  `visible` int(11) DEFAULT '0' COMMENT '是否可见',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(15) NOT NULL COMMENT '电话号码',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `status` int(10) unsigned DEFAULT '1' COMMENT '管理员状态',
  `role_type` int(11) NOT NULL DEFAULT '0' COMMENT '管理员角色类型0管理员、1操作员、2审计员',
  `readonly` int(11) NOT NULL DEFAULT '0' COMMENT '策略只读',
  `skin` varchar(15) DEFAULT 'blue',
  `error_login_count` int(3) DEFAULT '0' COMMENT '错误登录次数',
  `error_login_last_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最近错误登录时间',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表-定义用户基本信息';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '2222222', 'BA37E4FDA3B1244F87A960A4C0849CE7D6AD90C22C2A61B86D45DA197C0B53E5', '0', '2222222', '0', '0', null, '22222222222', null, '11', '1', '1', 'blue', '0', null, '2018-01-08 01:38:07');
INSERT INTO `t_user` VALUES ('1', 'SYSTEM', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', '1', '超级管理员', '0', '0', 'tsa@neiwang.cn', '', '', '11', '0', '0', 'black', '0', null, null);
INSERT INTO `t_user` VALUES ('2', 'ADMIN', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', '1', '管理员', '0', '0', 'tsa@neiwang.cn', '', '', '11', '1', '0', 'blue', '0', null, null);
INSERT INTO `t_user` VALUES ('3', 'OPERATOR', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', '1', '操作员', '0', '0', 'tsa@neiwang.cn', '', '', '11', '2', '0', 'blue', '0', null, null);
INSERT INTO `t_user` VALUES ('3145a62a-2961-4532-953a-3466c5434075', 'nnnnnnnnn', '835D1CDD62BA4D0E20ECD4C493935546131D4D644F6E9C14BA7F283CDD5A8B5E', '0', 'nnnnnnnnnn', '0', '0', null, '12111111111', null, '11', '1', '0', 'blue', '0', '2018-01-08 10:15:35', '2018-01-08 10:15:35');
INSERT INTO `t_user` VALUES ('4', 'AUDITOR', 'F1FEA6DCDBE21260484F946A1BDFCB4D46C8253B320910E8AC2206EA302A7751', '1', '审计员', '0', '0', 'tsa@neiwang.cn', '', '', '11', '3', '0', 'blue', '0', null, null);
INSERT INTO `t_user` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '3333333333', '5E9F6BC0BB45C1E22CFA809D9A24AA75CC2DFCB8D3486962835B33FB02DA0184', '0', '111111', '0', '0', null, '111111111111111', null, '11', '1', '1', 'blue', '0', '2018-01-08 09:48:40', '2018-01-08 09:48:40');
INSERT INTO `t_user` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', 'vvvvvvvvvv', 'EA3AC0B0A26AD3B09FCE4D6846392E333159936E08B128675CF69BF645F6D3E4', '0', 'vvvvvvv', '0', '0', null, '11111111111', null, '11', '1', '0', 'blue', '0', '2018-01-08 10:13:36', '2018-01-08 10:13:36');

-- ----------------------------
-- Table structure for `t_user_bak`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_bak`;
CREATE TABLE `t_user_bak` (
  `id` varchar(36) NOT NULL COMMENT '主键（自增长）',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `department` int(11) DEFAULT NULL COMMENT '所属部门',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `sex` int(11) DEFAULT '0' COMMENT '性别',
  `visible` int(11) DEFAULT '0' COMMENT '是否可见',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `phone` varchar(15) NOT NULL COMMENT '电话号码',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `status` int(10) unsigned DEFAULT '1' COMMENT '管理员状态',
  `role_type` int(11) DEFAULT '0' COMMENT '管理员角色类型0管理员、1操作员、2审计员',
  `skin` varchar(15) DEFAULT 'blue',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户信息表-定义用户基本信息';

-- ----------------------------
-- Records of t_user_bak
-- ----------------------------

-- ----------------------------
-- Table structure for `t_user_department`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_department`;
CREATE TABLE `t_user_department` (
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '用户id',
  `department_id` int(10) unsigned NOT NULL COMMENT '部门Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户部门关联';

-- ----------------------------
-- Records of t_user_department
-- ----------------------------
INSERT INTO `t_user_department` VALUES ('1', '1');
INSERT INTO `t_user_department` VALUES ('1', '2');
INSERT INTO `t_user_department` VALUES ('1', '44');
INSERT INTO `t_user_department` VALUES ('1', '45');
INSERT INTO `t_user_department` VALUES ('1', '46');
INSERT INTO `t_user_department` VALUES ('1', '47');
INSERT INTO `t_user_department` VALUES ('1', '48');
INSERT INTO `t_user_department` VALUES ('1', '49');
INSERT INTO `t_user_department` VALUES ('1', '50');
INSERT INTO `t_user_department` VALUES ('1', '51');
INSERT INTO `t_user_department` VALUES ('1', '52');
INSERT INTO `t_user_department` VALUES ('1', '53');
INSERT INTO `t_user_department` VALUES ('1', '54');
INSERT INTO `t_user_department` VALUES ('1', '55');
INSERT INTO `t_user_department` VALUES ('1', '56');
INSERT INTO `t_user_department` VALUES ('1', '57');
INSERT INTO `t_user_department` VALUES ('1', '58');
INSERT INTO `t_user_department` VALUES ('1', '59');
INSERT INTO `t_user_department` VALUES ('1', '63');
INSERT INTO `t_user_department` VALUES ('1', '64');
INSERT INTO `t_user_department` VALUES ('1', '65');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '1');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '44');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '45');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '48');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '49');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '46');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '47');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '50');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '53');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '54');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '56');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '57');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '55');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '51');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '58');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '59');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '63');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '52');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '64');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '65');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '2');
INSERT INTO `t_user_department` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '1');
INSERT INTO `t_user_department` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '44');
INSERT INTO `t_user_department` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '46');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '1');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '44');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '45');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '48');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '46');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '47');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '1');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '50');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '53');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '54');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '56');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '57');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '55');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '51');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '58');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '59');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '63');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '52');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '64');
INSERT INTO `t_user_department` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '65');
INSERT INTO `t_user_department` VALUES ('1', '68');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '68');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '68');
INSERT INTO `t_user_department` VALUES ('1', '69');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '69');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '69');
INSERT INTO `t_user_department` VALUES ('1', '70');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '70');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '70');
INSERT INTO `t_user_department` VALUES ('1', '71');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '71');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '71');
INSERT INTO `t_user_department` VALUES ('1', '72');
INSERT INTO `t_user_department` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '72');
INSERT INTO `t_user_department` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '72');

-- ----------------------------
-- Table structure for `t_user_navigation`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_navigation`;
CREATE TABLE `t_user_navigation` (
  `user_id` varchar(36) NOT NULL COMMENT '用户id',
  `navigation_id` int(10) unsigned NOT NULL COMMENT '权限关联导航Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与页签关联关系';

-- ----------------------------
-- Records of t_user_navigation
-- ----------------------------
INSERT INTO `t_user_navigation` VALUES ('2', '1');
INSERT INTO `t_user_navigation` VALUES ('2', '2');
INSERT INTO `t_user_navigation` VALUES ('2', '5');
INSERT INTO `t_user_navigation` VALUES ('2', '8');
INSERT INTO `t_user_navigation` VALUES ('2', '9');
INSERT INTO `t_user_navigation` VALUES ('2', '10');
INSERT INTO `t_user_navigation` VALUES ('2', '11');
INSERT INTO `t_user_navigation` VALUES ('2', '12');
INSERT INTO `t_user_navigation` VALUES ('2', '13');
INSERT INTO `t_user_navigation` VALUES ('2', '14');
INSERT INTO `t_user_navigation` VALUES ('2', '15');
INSERT INTO `t_user_navigation` VALUES ('2', '16');
INSERT INTO `t_user_navigation` VALUES ('2', '17');
INSERT INTO `t_user_navigation` VALUES ('2', '18');
INSERT INTO `t_user_navigation` VALUES ('2', '19');
INSERT INTO `t_user_navigation` VALUES ('2', '20');
INSERT INTO `t_user_navigation` VALUES ('2', '21');
INSERT INTO `t_user_navigation` VALUES ('2', '23');
INSERT INTO `t_user_navigation` VALUES ('2', '24');
INSERT INTO `t_user_navigation` VALUES ('2', '30');
INSERT INTO `t_user_navigation` VALUES ('2', '31');
INSERT INTO `t_user_navigation` VALUES ('2', '32');
INSERT INTO `t_user_navigation` VALUES ('3', '1');
INSERT INTO `t_user_navigation` VALUES ('3', '2');
INSERT INTO `t_user_navigation` VALUES ('3', '3');
INSERT INTO `t_user_navigation` VALUES ('3', '4');
INSERT INTO `t_user_navigation` VALUES ('3', '5');
INSERT INTO `t_user_navigation` VALUES ('3', '6');
INSERT INTO `t_user_navigation` VALUES ('3', '9');
INSERT INTO `t_user_navigation` VALUES ('3', '10');
INSERT INTO `t_user_navigation` VALUES ('3', '11');
INSERT INTO `t_user_navigation` VALUES ('4', '1');
INSERT INTO `t_user_navigation` VALUES ('4', '7');
INSERT INTO `t_user_navigation` VALUES ('4', '6');
INSERT INTO `t_user_navigation` VALUES ('4', '25');
INSERT INTO `t_user_navigation` VALUES ('4', '26');
INSERT INTO `t_user_navigation` VALUES ('4', '27');
INSERT INTO `t_user_navigation` VALUES ('4', '28');
INSERT INTO `t_user_navigation` VALUES ('4', '29');
INSERT INTO `t_user_navigation` VALUES ('2', '35');
INSERT INTO `t_user_navigation` VALUES ('sss', '99');
INSERT INTO `t_user_navigation` VALUES ('ss', '99');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '1');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '2');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '9');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '10');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '3');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '4');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '5');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '6');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '7');
INSERT INTO `t_user_navigation` VALUES ('7542fa4b-2fdc-402f-95c9-62d178f899f9', '8');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '1');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '2');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '9');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '10');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '3');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '4');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '5');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '6');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '7');
INSERT INTO `t_user_navigation` VALUES ('eab589d2-d0cc-42f1-bb1c-b3942f88c6ba', '8');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '1');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '2');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '9');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '10');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '3');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '4');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '5');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '6');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '7');
INSERT INTO `t_user_navigation` VALUES ('3145a62a-2961-4532-953a-3466c5434075', '8');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '1');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '2');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '9');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '10');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '3');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '4');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '5');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '6');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '7');
INSERT INTO `t_user_navigation` VALUES ('008df5cb-bdb2-487c-b5e5-e91ef2c3150e', '8');

-- ----------------------------
-- Table structure for `t_vedio_logon_access`
-- ----------------------------
DROP TABLE IF EXISTS `t_vedio_logon_access`;
CREATE TABLE `t_vedio_logon_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT '业务名称',
  `start_method` varchar(50) DEFAULT NULL COMMENT '启动方式',
  `start_path` varchar(2000) DEFAULT NULL COMMENT '启动路径',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_vedio_logon_access
-- ----------------------------
INSERT INTO `t_vedio_logon_access` VALUES ('1', '撒大声地', '0', 'sad撒多', '2018-01-10 09:35:21');
INSERT INTO `t_vedio_logon_access` VALUES ('2', '斯蒂芬斯蒂芬斯蒂芬', '0', '适当方式的方式', '2018-01-10 01:35:33');

-- ----------------------------
-- Table structure for `t_vedio_net_access`
-- ----------------------------
DROP TABLE IF EXISTS `t_vedio_net_access`;
CREATE TABLE `t_vedio_net_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) NOT NULL COMMENT 'ip/ip段',
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_vedio_net_access
-- ----------------------------
INSERT INTO `t_vedio_net_access` VALUES ('2', '192.168.222.222-192.168.222.254', null);
INSERT INTO `t_vedio_net_access` VALUES ('13', '192.168.1.1', '2018-01-10 01:45:28');
INSERT INTO `t_vedio_net_access` VALUES ('14', '192.168.1.2', '2018-01-10 01:45:30');
INSERT INTO `t_vedio_net_access` VALUES ('15', '192.168.1.3', '2018-01-10 01:45:32');
INSERT INTO `t_vedio_net_access` VALUES ('16', '192.168.1.4', '2018-01-10 01:45:33');
INSERT INTO `t_vedio_net_access` VALUES ('17', '192.168.1.5', '2018-01-10 01:45:37');

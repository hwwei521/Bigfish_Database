/*
 Navicat MySQL Data Transfer

 Source Server         : tengxun
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 49.232.251.166:3306
 Source Schema         : acs

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 20/07/2021 17:55:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for wx_device
-- ----------------------------
DROP TABLE IF EXISTS `wx_device`;
CREATE TABLE `wx_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户设备自增id',
  `open_id` char(30) COLLATE utf8_bin DEFAULT NULL COMMENT '所属用户的open_id',
  `imei` char(17) COLLATE utf8_bin NOT NULL COMMENT '设备imei号',
  `device_id` char(40) COLLATE utf8_bin DEFAULT NULL COMMENT 'ctwing平台设备ID',
  `onenet_device_id` int(10) DEFAULT NULL COMMENT '移动平台设备id',
  `device_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '设备名称',
  `device_img` varchar(150) COLLATE utf8_bin DEFAULT NULL COMMENT '设备头像',
  `device_battery` tinyint(4) DEFAULT NULL COMMENT '设备电量',
  `heartbeat_period` tinyint(4) DEFAULT '1' COMMENT '心跳周期(分钟)',
  `gps_period` tinyint(4) DEFAULT '1' COMMENT 'gps周期(分钟)',
  `nb_period` tinyint(4) DEFAULT '5' COMMENT '上报周期(分钟)',
  `auto_observer` tinyint(1) DEFAULT '1' COMMENT '订阅 0 自动订阅',
  `is_show` tinyint(1) DEFAULT '1' COMMENT '1.显示，2.不显示',
  `status` tinyint(1) DEFAULT NULL COMMENT '设备状态1.待机2.追踪 3.记录',
  `sim_type` tinyint(1) DEFAULT '1' COMMENT 'sim卡：1.电信 2.移动',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for wx_device_error
-- ----------------------------
DROP TABLE IF EXISTS `wx_device_error`;
CREATE TABLE `wx_device_error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` char(40) COLLATE utf8_bin DEFAULT NULL COMMENT '电信平台设备id',
  `type` tinyint(1) DEFAULT NULL COMMENT '1.上报长度不对，2.db没有MasterKey，3.执行下发失败，4.插入db失败',
  `error_msg` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '失败msg',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='设备上报下发错误记录表';

-- ----------------------------
-- Table structure for wx_device_warn
-- ----------------------------
DROP TABLE IF EXISTS `wx_device_warn`;
CREATE TABLE `wx_device_warn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` char(40) COLLATE utf8_bin DEFAULT NULL COMMENT '电信平台的设备ID',
  `open_id` char(30) COLLATE utf8_bin DEFAULT NULL COMMENT '用户id',
  `type` tinyint(1) DEFAULT NULL COMMENT '1，电量低于20%，2、出围栏，3、启动sos',
  `warn_msg` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '警告msg',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='设备警告记录表';

-- ----------------------------
-- Table structure for wx_gps
-- ----------------------------
DROP TABLE IF EXISTS `wx_gps`;
CREATE TABLE `wx_gps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dev_id` char(40) COLLATE utf8_bin NOT NULL COMMENT '设备id',
  `imei` char(17) COLLATE utf8_bin DEFAULT NULL COMMENT '设备imei号',
  `flag` tinyint(6) DEFAULT NULL,
  `number` tinyint(4) DEFAULT NULL,
  `latitude` char(15) COLLATE utf8_bin DEFAULT NULL COMMENT '纬度',
  `longitude` char(15) COLLATE utf8_bin DEFAULT NULL COMMENT '经度',
  `speed` int(11) DEFAULT NULL COMMENT '速度',
  `report_time` int(11) DEFAULT NULL COMMENT '数据包内的上报时间',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `dev_id` (`dev_id`) USING BTREE,
  KEY `imei` (`imei`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='设备gps包记录表';

-- ----------------------------
-- Table structure for wx_heartbeat
-- ----------------------------
DROP TABLE IF EXISTS `wx_heartbeat`;
CREATE TABLE `wx_heartbeat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dev_id` char(40) COLLATE utf8_bin NOT NULL COMMENT '设备id',
  `imei` char(17) COLLATE utf8_bin DEFAULT NULL COMMENT '设备imei号',
  `flag` tinyint(6) DEFAULT NULL,
  `current_mode` tinyint(1) DEFAULT NULL COMMENT '1关机，2待机，3记录，4跟踪，5监控，6用户自定义',
  `battery_level` int(4) DEFAULT NULL COMMENT '电量',
  `reboot_reason` int(11) DEFAULT NULL,
  `free_memory_sram` int(11) DEFAULT NULL,
  `free_memory_flash` int(11) DEFAULT NULL,
  `rsrp_signal` int(11) DEFAULT NULL COMMENT '功率信号',
  `snr` int(11) DEFAULT NULL,
  `device_status` tinyint(1) DEFAULT NULL COMMENT '1运动,2静止,3室内,4室外',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `dev_id` (`dev_id`) USING BTREE,
  KEY `imei` (`imei`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for wx_user
-- ----------------------------
DROP TABLE IF EXISTS `wx_user`;
CREATE TABLE `wx_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户自增id',
  `open_id` char(40) COLLATE utf8_bin NOT NULL COMMENT '用户唯一标识(微信)',
  `nick_name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '用户昵称',
  `avatar_url` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '用户头像，用户没有头像时传个默认头像。若用户更换头像，原有头像URL将失效。',
  `gender` tinyint(1) NOT NULL COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `city` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '用户所在城市',
  `province` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '用户所在省份',
  `country` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户所在国家',
  `language` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'zh_CN' COMMENT '用户的语言，简体中文为zh_CN',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  KEY `account` (`open_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

SET FOREIGN_KEY_CHECKS = 1;

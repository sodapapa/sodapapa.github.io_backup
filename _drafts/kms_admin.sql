/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.3.18-MariaDB : Database - kms_admin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`kms_admin` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `kms_admin`;

/*Table structure for table `new_table` */

DROP TABLE IF EXISTS `new_table`;

CREATE TABLE `new_table` (
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_config` */

DROP TABLE IF EXISTS `tb_config`;

CREATE TABLE `tb_config` (
  `CONF_CD` varchar(50) NOT NULL,
  `CONF_VAL` varchar(1000) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`CONF_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_consumer_key_store` */

DROP TABLE IF EXISTS `tb_consumer_key_store`;

CREATE TABLE `tb_consumer_key_store` (
  `LINK_ID` int(11) NOT NULL,
  `DEFAULT_KEY_SIZE` int(11) DEFAULT NULL,
  `MAX_KEY_CNT` int(11) DEFAULT NULL,
  `MAX_KEY_CNT_PER_REQ` int(11) DEFAULT NULL,
  `MAX_KEY_SIZE` int(11) DEFAULT NULL,
  `MIN_KEY_SIZE` int(11) DEFAULT NULL,
  `KEY_REQ_INTERVAL` int(11) DEFAULT NULL,
  `MIN_STORE_RATE` int(11) DEFAULT NULL,
  `MAJ_STORE_RATE` int(11) DEFAULT NULL,
  `CRT_STORE_RATE` int(11) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`LINK_ID`),
  CONSTRAINT `tb_consumer_key_store_ibfk_1` FOREIGN KEY (`LINK_ID`) REFERENCES `tb_link_consumer` (`LINK_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_element` */

DROP TABLE IF EXISTS `tb_element`;

CREATE TABLE `tb_element` (
  `ELMT_ID` int(11) NOT NULL,
  `GRP_ID` int(11) DEFAULT NULL,
  `ELMT_NM` varchar(200) DEFAULT NULL,
  `VENDOR` varchar(5) DEFAULT NULL COMMENT 'SKT, NOKIA, IDQ, CIENA',
  `I_PORT` int(11) DEFAULT NULL,
  `E_PORT` int(11) DEFAULT NULL,
  `A_PORT` int(11) DEFAULT NULL,
  `P_PORT` int(11) DEFAULT NULL COMMENT 'KMS에서는 admin port\nConsumer/Provider에서는 protocol port',
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  `ELMT_TYPE` varchar(5) DEFAULT NULL COMMENT 'Consumer : 0, Provider : 1, KMS : 2',
  `LOC_X` int(11) DEFAULT 0 COMMENT 'network 좌표 X',
  `LOC_Y` int(11) DEFAULT 0 COMMENT 'network 좌표 Y',
  `LOC_YN` char(1) DEFAULT 'N' COMMENT '좌표 저장여부',
  `KMS_ID` int(11) DEFAULT NULL,
  `KMS_USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `KMS_STATUS` varchar(5) DEFAULT '00' COMMENT '접속상태',
  PRIMARY KEY (`ELMT_ID`),
  UNIQUE KEY `ELMT_NM` (`ELMT_NM`),
  KEY `GRP_ID` (`GRP_ID`),
  CONSTRAINT `tb_element_ibfk_1` FOREIGN KEY (`GRP_ID`) REFERENCES `tb_group` (`GRP_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_element_consumer` */

DROP TABLE IF EXISTS `tb_element_consumer`;

CREATE TABLE `tb_element_consumer` (
  `ELMT_ID` int(11) NOT NULL,
  `C_AUTH_PROTOCOL_CD` varchar(20) DEFAULT NULL COMMENT 'MD5, SHA',
  `C_PRIV_PROTOCOL_CD` varchar(20) DEFAULT NULL COMMENT 'AES128, AES256',
  `C_IP` varchar(50) DEFAULT NULL,
  `C_PORT` int(11) DEFAULT NULL,
  `C_SECURITY_NAME` varchar(50) DEFAULT NULL,
  `C_PRIV_PASSWORD` varchar(100) DEFAULT NULL,
  `C_AUTH_PASSWORD` varchar(100) DEFAULT NULL,
  `A_AUTH_PROTOCOL_CD` varchar(20) DEFAULT NULL,
  `A_PRIV_PROTOCOL_CD` varchar(20) DEFAULT NULL,
  `A_IP` varchar(50) DEFAULT NULL,
  `A_PORT` int(11) DEFAULT NULL,
  `A_SECURITY_NAME` varchar(50) DEFAULT NULL,
  `A_PRIV_PASSWORD` varchar(100) DEFAULT NULL,
  `A_AUTH_PASSWORD` varchar(100) DEFAULT NULL,
  `PROCESS_CD` varchar(20) DEFAULT NULL COMMENT 'process_code',
  KEY `ELMT_ID` (`ELMT_ID`),
  CONSTRAINT `tb_element_consumer_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_element_kms` */

DROP TABLE IF EXISTS `tb_element_kms`;

CREATE TABLE `tb_element_kms` (
  `ELMT_ID` int(11) NOT NULL,
  `UNIQUE_ID` varchar(50) DEFAULT NULL,
  `CERT_FILE` varchar(200) DEFAULT NULL COMMENT 'KMS 접속 인증서',
  `LAST_AUDIT_LOG_TIME` varchar(40) DEFAULT NULL COMMENT '감사로그 최종 요청시간',
  `LAST_STATISTICS_LOG_TIME` varchar(40) DEFAULT NULL COMMENT '통계로그 최종 요청시간',
  KEY `ELMT_ID` (`ELMT_ID`),
  CONSTRAINT `tb_element_kms_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_element_kms_port` */

DROP TABLE IF EXISTS `tb_element_kms_port`;

CREATE TABLE `tb_element_kms_port` (
  `ELMT_ID` int(11) NOT NULL,
  `PROCESS_CD` varchar(20) NOT NULL,
  `PORT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ELMT_ID`,`PROCESS_CD`),
  CONSTRAINT `tb_element_kms_port_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_group` */

DROP TABLE IF EXISTS `tb_group`;

CREATE TABLE `tb_group` (
  `GRP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GRP_NM` varchar(200) DEFAULT NULL,
  `GRP_DESC` text DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  `LOCATION` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`GRP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

/*Table structure for table `tb_interface` */

DROP TABLE IF EXISTS `tb_interface`;

CREATE TABLE `tb_interface` (
  `ELMT_ID` int(11) NOT NULL,
  `INTF_IP` varchar(50) NOT NULL,
  `IP_TYPE_CD` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ELMT_ID`,`INTF_IP`),
  CONSTRAINT `tb_interface_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_interface_consumer` */

DROP TABLE IF EXISTS `tb_interface_consumer`;

CREATE TABLE `tb_interface_consumer` (
  `ELMT_ID` int(11) NOT NULL,
  `VID` varchar(50) NOT NULL,
  `PROTOCOL_ID` varchar(50) DEFAULT NULL,
  `SUBJECT_DN` varchar(300) DEFAULT NULL COMMENT 'vendor가 RESTFUL인 경우 사용',
  `PROCESS_CD` varchar(20) DEFAULT NULL,
  `KEY_TYPE_CD` varchar(20) DEFAULT NULL COMMENT 'QKey, ECDH',
  `STATUS_CD` varchar(20) DEFAULT NULL,
  `STATUS_UPDATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`VID`),
  KEY `ELMT_ID` (`ELMT_ID`),
  CONSTRAINT `tb_interface_consumer_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_interface_provider` */

DROP TABLE IF EXISTS `tb_interface_provider`;

CREATE TABLE `tb_interface_provider` (
  `ELMT_ID` int(11) NOT NULL,
  `KMS_VID` varchar(50) NOT NULL,
  `KMS_PROTOCOL_ID` varchar(50) DEFAULT NULL,
  `PROV_PROTOCOL_ID` varchar(50) DEFAULT NULL,
  `PROCESS_CD` varchar(20) DEFAULT NULL,
  `STATUS_CD` varchar(20) DEFAULT NULL,
  `STATUS_UPDATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`KMS_VID`),
  KEY `ELMT_ID` (`ELMT_ID`),
  CONSTRAINT `tb_interface_provider_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_link` */

DROP TABLE IF EXISTS `tb_link`;

CREATE TABLE `tb_link` (
  `LINK_ID` int(11) NOT NULL,
  `LINK_NM` varchar(200) DEFAULT NULL,
  `LINK_TYPE_CD` varchar(20) DEFAULT NULL COMMENT 'External:K to K\nInternal:K to C, K to P\nProtocl:K to C, K to P',
  `ALGORITHM_CD` int(11) DEFAULT NULL COMMENT '0:none, 1:otp, 2:ARIA256',
  `WEIGHT` int(11) DEFAULT NULL COMMENT 'K to K만 해당. 경로계산시 사용',
  `SRC_ELMT_ID` int(11) DEFAULT NULL,
  `SRC_INTF_IP` varchar(50) DEFAULT NULL,
  `DST_ELMT_ID` int(11) DEFAULT NULL,
  `DST_INTF_IP` varchar(50) DEFAULT NULL,
  `STATUS_CD` varchar(20) DEFAULT NULL COMMENT 'status',
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  `STATUS_UPDATE_TIME` datetime DEFAULT NULL COMMENT 'status updatetiem',
  `ID_INSERT` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`LINK_ID`),
  KEY `SRC_ELMT_ID` (`SRC_ELMT_ID`,`SRC_INTF_IP`),
  KEY `DST_ELMT_ID` (`DST_ELMT_ID`,`DST_INTF_IP`),
  CONSTRAINT `tb_link_ibfk_1` FOREIGN KEY (`SRC_ELMT_ID`, `SRC_INTF_IP`) REFERENCES `tb_interface` (`ELMT_ID`, `INTF_IP`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tb_link_ibfk_2` FOREIGN KEY (`DST_ELMT_ID`, `DST_INTF_IP`) REFERENCES `tb_interface` (`ELMT_ID`, `INTF_IP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_link_consumer` */

DROP TABLE IF EXISTS `tb_link_consumer`;

CREATE TABLE `tb_link_consumer` (
  `LINK_ID` int(11) NOT NULL,
  `LINK_NM` varchar(200) DEFAULT NULL,
  `OPER_MODE_CD` varchar(20) DEFAULT NULL COMMENT '0:master, 1:slave',
  `PRESHARED_KEY` varchar(150) DEFAULT NULL,
  `SRC_VID` varchar(50) DEFAULT NULL,
  `DST_VID` varchar(50) DEFAULT NULL,
  `STATUS_CD` varchar(20) DEFAULT NULL,
  `STATUS_UPDATE_TIME` datetime DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`LINK_ID`),
  KEY `SRC_VID` (`SRC_VID`),
  KEY `DST_VID` (`DST_VID`),
  CONSTRAINT `tb_link_consumer_ibfk_1` FOREIGN KEY (`SRC_VID`) REFERENCES `tb_interface_consumer` (`VID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tb_link_consumer_ibfk_2` FOREIGN KEY (`DST_VID`) REFERENCES `tb_interface_consumer` (`VID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_link_path` */

DROP TABLE IF EXISTS `tb_link_path`;

CREATE TABLE `tb_link_path` (
  `LINK_ID` int(11) NOT NULL,
  `PATH_ID` int(11) NOT NULL,
  PRIMARY KEY (`LINK_ID`,`PATH_ID`),
  KEY `PATH_ID` (`PATH_ID`),
  CONSTRAINT `tb_link_path_ibfk_1` FOREIGN KEY (`LINK_ID`) REFERENCES `tb_link_consumer` (`LINK_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tb_link_path_ibfk_2` FOREIGN KEY (`PATH_ID`) REFERENCES `tb_path` (`PATH_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_link_provider` */

DROP TABLE IF EXISTS `tb_link_provider`;

CREATE TABLE `tb_link_provider` (
  `LINK_ID` int(11) NOT NULL,
  `LINK_NM` varchar(200) DEFAULT NULL,
  `OPER_MODE_CD` varchar(20) DEFAULT NULL COMMENT '0:master, 1:slave',
  `SRC_KMS_VID` varchar(50) DEFAULT NULL,
  `DST_KMS_VID` varchar(50) DEFAULT NULL,
  `STATUS_CD` varchar(20) DEFAULT NULL,
  `STATUS_UPDATE_TIME` datetime DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`LINK_ID`),
  KEY `SRC_KMS_VID` (`SRC_KMS_VID`),
  KEY `DST_KMS_VID` (`DST_KMS_VID`),
  CONSTRAINT `tb_link_provider_ibfk_1` FOREIGN KEY (`SRC_KMS_VID`) REFERENCES `tb_interface_provider` (`KMS_VID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tb_link_provider_ibfk_2` FOREIGN KEY (`DST_KMS_VID`) REFERENCES `tb_interface_provider` (`KMS_VID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_audit` */

DROP TABLE IF EXISTS `tb_log_audit`;

CREATE TABLE `tb_log_audit` (
  `WORK_ID` varchar(10) DEFAULT NULL,
  `WORK_DT` datetime DEFAULT NULL,
  `WORK_KIND` varchar(5) DEFAULT NULL COMMENT 'KMS관리/Consumer관리 등',
  `WORK_TYPE` varchar(5) DEFAULT NULL COMMENT '등록/수정/삭제 등',
  `WORK_RESULT` varchar(5) DEFAULT NULL COMMENT 'Success/Fail',
  `WORK_CONTENT` text DEFAULT NULL,
  `WORK_IP` varchar(50) DEFAULT NULL,
  `WORK_REASON` text DEFAULT NULL COMMENT '작업 실패시 실패 사유',
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_event` */

DROP TABLE IF EXISTS `tb_log_event`;

CREATE TABLE `tb_log_event` (
  `KMS_ID` int(11) DEFAULT NULL,
  `ELMT_ID` int(11) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `LINK_ID` int(11) DEFAULT NULL,
  `OCCUR_TIME` varchar(40) DEFAULT NULL,
  `CONFIRM_YN` varchar(1) DEFAULT 'N',
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `EVENT_ID` varchar(10) NOT NULL,
  `SRC_SYS_NAME` varchar(20) DEFAULT NULL,
  `SRC_INTERFACE` varchar(40) DEFAULT NULL,
  `DST_SYS_NAME` varchar(20) DEFAULT NULL,
  `DST_INTERFACE` varchar(40) DEFAULT NULL,
  KEY `EVENT_ID` (`EVENT_ID`),
  KEY `ELMT_ID` (`ELMT_ID`,`APP_NAME`,`EVENT_ID`,`CONFIRM_YN`),
  CONSTRAINT `tb_log_event_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `tb_log_event_config` (`EVENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_event_config` */

DROP TABLE IF EXISTS `tb_log_event_config`;

CREATE TABLE `tb_log_event_config` (
  `EVENT_ID` varchar(10) NOT NULL,
  `RATE_CD` varchar(20) DEFAULT NULL,
  `EVENT_KIND` varchar(10) DEFAULT NULL,
  `EVENT_TYPE` varchar(20) NOT NULL,
  `EVENT_MSG` varchar(100) DEFAULT NULL,
  `EVENT_DESC` varchar(200) DEFAULT NULL,
  `AUTO_CONFIRM_YN` varchar(1) DEFAULT 'N',
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`EVENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_event_config_lang` */

DROP TABLE IF EXISTS `tb_log_event_config_lang`;

CREATE TABLE `tb_log_event_config_lang` (
  `EVENT_ID` varchar(10) NOT NULL,
  `FG_LANG` varchar(5) NOT NULL,
  `EVENT_MSG` varchar(100) DEFAULT NULL,
  `EVENT_DESC` varchar(200) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`EVENT_ID`,`FG_LANG`),
  CONSTRAINT `tb_log_event_config_lang_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `tb_log_event_config` (`EVENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_audit` */

DROP TABLE IF EXISTS `tb_log_report_audit`;

CREATE TABLE `tb_log_report_audit` (
  `DT_INSERT` datetime DEFAULT NULL,
  `CREATE_TIME` varchar(40) DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `OP_TYPE` varchar(5) DEFAULT NULL,
  `RESULT_CODE` int(11) DEFAULT NULL,
  `PATH` text DEFAULT NULL,
  `HMAC` varchar(100) DEFAULT NULL,
  KEY `SYS_NAME` (`SYS_NAME`),
  KEY `CREATE_TIME` (`CREATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_brk` */

DROP TABLE IF EXISTS `tb_log_report_brk`;

CREATE TABLE `tb_log_report_brk` (
  `DT_INSERT` datetime DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `CONN_STS` int(11) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SZ_SRC_NAME` varchar(20) DEFAULT NULL,
  `SZ_SRC_IP` varchar(40) DEFAULT NULL,
  `SZ_DST_NAME` varchar(20) DEFAULT NULL,
  `SZ_DST_IP` varchar(20) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_con_svc` */

DROP TABLE IF EXISTS `tb_log_report_con_svc`;

CREATE TABLE `tb_log_report_con_svc` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `IS_FAULT` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_enccall` */

DROP TABLE IF EXISTS `tb_log_report_enccall`;

CREATE TABLE `tb_log_report_enccall` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `C_VID` varchar(40) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL,
  `REGISTER_LASTTIME` varchar(40) DEFAULT NULL,
  `KEEPALIVE_LASTTIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_encryptor` */

DROP TABLE IF EXISTS `tb_log_report_encryptor`;

CREATE TABLE `tb_log_report_encryptor` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `C_VID` varchar(40) DEFAULT NULL,
  `DST_C_VID` varchar(40) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL,
  `STATUS` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_key_fail` */

DROP TABLE IF EXISTS `tb_log_report_key_fail`;

CREATE TABLE `tb_log_report_key_fail` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `REASON` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_keyset` */

DROP TABLE IF EXISTS `tb_log_report_keyset`;

CREATE TABLE `tb_log_report_keyset` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_kkey_buffer` */

DROP TABLE IF EXISTS `tb_log_report_kkey_buffer`;

CREATE TABLE `tb_log_report_kkey_buffer` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `RATE` int(11) DEFAULT NULL,
  `LEVEL` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_overload` */

DROP TABLE IF EXISTS `tb_log_report_overload`;

CREATE TABLE `tb_log_report_overload` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL,
  `MESSAGE` varchar(260) DEFAULT NULL,
  `OVERLOAD_STS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_path` */

DROP TABLE IF EXISTS `tb_log_report_path`;

CREATE TABLE `tb_log_report_path` (
  `DT_INSERT` datetime DEFAULT NULL,
  `N_PRIORITY` int(11) DEFAULT NULL,
  `SZ_SRC_SYS_NAME` varchar(20) DEFAULT NULL,
  `SZ_DST_SYS_NAME` varchar(20) DEFAULT NULL,
  `SZ_PATH` varchar(600) DEFAULT NULL,
  `IS_USE` int(11) DEFAULT NULL,
  `IS_FAULT` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_process` */

DROP TABLE IF EXISTS `tb_log_report_process`;

CREATE TABLE `tb_log_report_process` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `STATUS` varchar(20) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_process_queue` */

DROP TABLE IF EXISTS `tb_log_report_process_queue`;

CREATE TABLE `tb_log_report_process_queue` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `Q_KEY` int(11) DEFAULT NULL,
  `Q_COUNT` int(11) DEFAULT NULL,
  `Q_USAGE` int(11) DEFAULT NULL,
  `Q_SIZE` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL,
  `VERSION` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_prov_svc` */

DROP TABLE IF EXISTS `tb_log_report_prov_svc`;

CREATE TABLE `tb_log_report_prov_svc` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `IS_FAULT` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_qkd` */

DROP TABLE IF EXISTS `tb_log_report_qkd`;

CREATE TABLE `tb_log_report_qkd` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `QKD_VID` varchar(40) DEFAULT NULL,
  `ENC_VID` varchar(40) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL,
  `STATUS` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_report_qkey_buffer` */

DROP TABLE IF EXISTS `tb_log_report_qkey_buffer`;

CREATE TABLE `tb_log_report_qkey_buffer` (
  `DT_INSERT` datetime DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `KMS_VID` varchar(40) DEFAULT NULL,
  `TARGET_KMS_VID` varchar(40) DEFAULT NULL,
  `RATE` int(11) DEFAULT NULL,
  `LEVEL` int(11) DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_warning` */

DROP TABLE IF EXISTS `tb_log_warning`;

CREATE TABLE `tb_log_warning` (
  `SEQ` varchar(100) NOT NULL,
  `KMS_ID` int(11) DEFAULT NULL,
  `ELMT_ID` int(11) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `LINK_ID` int(11) DEFAULT NULL,
  `OCCUR_TIME` varchar(40) DEFAULT NULL,
  `WARN_DTL` varchar(1000) DEFAULT NULL,
  `WARN_RELEASE` varchar(10) DEFAULT NULL,
  `RELEASE_TIME` varchar(40) DEFAULT NULL,
  `CONFIRM_YN` varchar(1) DEFAULT 'N',
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `WARN_ID` varchar(10) NOT NULL,
  `SRC_SYS_NAME` varchar(20) DEFAULT NULL,
  `SRC_INTERFACE` varchar(40) DEFAULT NULL,
  `DST_SYS_NAME` varchar(20) DEFAULT NULL,
  `DST_INTERFACE` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`SEQ`),
  KEY `WARN_ID` (`WARN_ID`),
  KEY `CONFIRM_YN` (`CONFIRM_YN`),
  KEY `ELMT_ID` (`ELMT_ID`),
  KEY `APP_NAME` (`APP_NAME`),
  KEY `SRC_SYS_NAME` (`SRC_SYS_NAME`),
  KEY `SRC_INTERFACE` (`SRC_INTERFACE`),
  KEY `DST_SYS_NAME` (`DST_SYS_NAME`),
  KEY `DST_INTERFACE` (`DST_INTERFACE`),
  CONSTRAINT `tb_log_warning_ibfk_1` FOREIGN KEY (`WARN_ID`) REFERENCES `tb_log_warning_config` (`WARN_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_warning_config` */

DROP TABLE IF EXISTS `tb_log_warning_config`;

CREATE TABLE `tb_log_warning_config` (
  `WARN_ID` varchar(10) NOT NULL,
  `RATE_CD` varchar(20) DEFAULT NULL,
  `WARN_KIND` varchar(10) DEFAULT NULL,
  `WARN_OCCUR` varchar(10) DEFAULT NULL,
  `WARN_MSG` varchar(100) DEFAULT NULL,
  `WARN_DESC` varchar(200) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`WARN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_warning_config_lang` */

DROP TABLE IF EXISTS `tb_log_warning_config_lang`;

CREATE TABLE `tb_log_warning_config_lang` (
  `WARN_ID` varchar(10) NOT NULL,
  `FG_LANG` varchar(5) NOT NULL,
  `WARN_MSG` varchar(100) DEFAULT NULL,
  `WARN_DESC` varchar(200) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`WARN_ID`,`FG_LANG`),
  CONSTRAINT `tb_log_warning_config_lang_ibfk_1` FOREIGN KEY (`WARN_ID`) REFERENCES `tb_log_warning_config` (`WARN_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_log_warning_config_release` */

DROP TABLE IF EXISTS `tb_log_warning_config_release`;

CREATE TABLE `tb_log_warning_config_release` (
  `WARN_ID` varchar(10) NOT NULL,
  `WARN_RELEASE` varchar(10) NOT NULL,
  `AUTO_CONFIRM_YN` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`WARN_ID`,`WARN_RELEASE`),
  CONSTRAINT `tb_log_warning_config_release_ibfk_1` FOREIGN KEY (`WARN_ID`) REFERENCES `tb_log_warning_config` (`WARN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_path` */

DROP TABLE IF EXISTS `tb_path`;

CREATE TABLE `tb_path` (
  `PATH_ID` int(11) NOT NULL,
  `SRC_KMS_ID` int(11) DEFAULT NULL,
  `DST_KMS_ID` int(11) DEFAULT NULL,
  `PATH_DESC_0` text DEFAULT NULL COMMENT '소스부터 목적지까지 ,로 구분된 path',
  `PATH_DESC_1` text DEFAULT NULL COMMENT '소스부터 목적지까지 ,로 구분된 path',
  `MEMO` text DEFAULT NULL,
  `DEPLOY_DT` datetime DEFAULT NULL,
  `DEPLOY_KEY` varchar(50) DEFAULT NULL COMMENT '배포키',
  `DEPLOY_DT_DST` datetime DEFAULT NULL,
  `DEPLOY_KEY_DST` varchar(50) DEFAULT NULL,
  `PATH_USE_0` varchar(20) DEFAULT NULL,
  `PATH_USE_1` varchar(20) DEFAULT NULL,
  `PATH_STATUS_0` varchar(20) DEFAULT NULL,
  `PATH_STATUS_1` varchar(20) DEFAULT NULL,
  `STATUS_UPDATE_TIME_0` datetime DEFAULT NULL,
  `STATUS_UPDATE_TIME_1` datetime DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`PATH_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_path_dtl` */

DROP TABLE IF EXISTS `tb_path_dtl`;

CREATE TABLE `tb_path_dtl` (
  `PATH_ID` int(11) NOT NULL,
  `PRIORIY` varchar(5) NOT NULL,
  `SEQ` int(11) NOT NULL,
  `KMS_LINK_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PATH_ID`,`PRIORIY`,`SEQ`),
  KEY `KMS_LINK_ID` (`KMS_LINK_ID`),
  CONSTRAINT `tb_path_dtl_ibfk_2` FOREIGN KEY (`PATH_ID`) REFERENCES `tb_path` (`PATH_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_path_hist` */

DROP TABLE IF EXISTS `tb_path_hist`;

CREATE TABLE `tb_path_hist` (
  `SRC_KMS_ID` int(11) DEFAULT NULL,
  `SRC_C_VID` varchar(50) DEFAULT NULL,
  `DST_KMS_ID` int(11) DEFAULT NULL,
  `DST_C_VID` varchar(50) DEFAULT NULL,
  `PRIORIY` varchar(5) DEFAULT NULL,
  `PATH_DESC` text DEFAULT NULL COMMENT '소스부터 목적지까지 ,로 구분된 path',
  `MEMO` text DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_process` */

DROP TABLE IF EXISTS `tb_process`;

CREATE TABLE `tb_process` (
  `ELMT_ID` int(11) NOT NULL,
  `PROC_NAME` varchar(20) NOT NULL,
  `VERSION` varchar(20) DEFAULT NULL,
  `STATUS_CD` varchar(20) DEFAULT NULL COMMENT 'RUN, STOP',
  `RATE` int(11) DEFAULT NULL,
  `REPLY_TIMEOUT` int(11) DEFAULT NULL,
  `KEEPALIVE` int(11) DEFAULT NULL,
  `STATUS_UPDATE_TIME` datetime DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ELMT_ID`,`PROC_NAME`),
  CONSTRAINT `tb_process_ibfk_1` FOREIGN KEY (`ELMT_ID`) REFERENCES `tb_element` (`ELMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_process_list` */

DROP TABLE IF EXISTS `tb_process_list`;

CREATE TABLE `tb_process_list` (
  `PROC_TYPE` varchar(20) NOT NULL,
  `PROCESS_CD` varchar(20) NOT NULL,
  `PROC_NM` varchar(50) NOT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`PROC_TYPE`,`PROCESS_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_q_key_store` */

DROP TABLE IF EXISTS `tb_q_key_store`;

CREATE TABLE `tb_q_key_store` (
  `SRC_KMS_ID` int(11) NOT NULL,
  `DST_KMS_ID` int(11) NOT NULL,
  `DEFAULT_KEY_SIZE` int(11) DEFAULT NULL,
  `MAX_KEY_CNT` int(11) DEFAULT NULL,
  `MAX_KEY_CNT_PER_REQ` int(11) DEFAULT NULL,
  `MAX_KEY_SIZE` int(11) DEFAULT NULL,
  `MIN_KEY_SIZE` int(11) DEFAULT NULL,
  `KEY_REQ_INTERVAL` int(11) DEFAULT NULL,
  `MIN_STORE_RATE` int(11) DEFAULT NULL,
  `MAJ_STORE_RATE` int(11) DEFAULT NULL,
  `CRT_STORE_RATE` int(11) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`SRC_KMS_ID`,`DST_KMS_ID`),
  KEY `DST_KMS_ID` (`DST_KMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_statistics_log` */

DROP TABLE IF EXISTS `tb_statistics_log`;

CREATE TABLE `tb_statistics_log` (
  `DT_INSERT` datetime DEFAULT NULL,
  `UPDATE_TIME` varchar(40) DEFAULT NULL,
  `SYS_NAME` varchar(20) DEFAULT NULL,
  `APP_NAME` varchar(10) DEFAULT NULL,
  `SRC_VID` varchar(40) DEFAULT NULL,
  `TARGET_VID` varchar(40) DEFAULT NULL,
  `KEY_REQ_TRY_CNT` int(11) DEFAULT NULL,
  `KEY_REQ_SUCC_CNT` int(11) DEFAULT NULL,
  `KEY_SYNC_TRY_CNT` int(11) DEFAULT NULL,
  `KEY_SYNC_SUCC_CNT` int(11) DEFAULT NULL,
  `OVERLOAD_REJECT` int(11) DEFAULT NULL,
  `KEY_REQ_TIMEOUT` int(11) DEFAULT NULL,
  `KEY_SYNC_TIMEOUT` int(11) DEFAULT NULL,
  `AUTH_FAIL` int(11) DEFAULT NULL,
  `ETC_FAIL` int(11) DEFAULT NULL,
  KEY `SYS_NAME` (`SYS_NAME`),
  KEY `UPDATE_TIME` (`UPDATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_swdeploy` */

DROP TABLE IF EXISTS `tb_swdeploy`;

CREATE TABLE `tb_swdeploy` (
  `DEPLOY_ID` int(11) NOT NULL,
  `DEPLOY_TITLE` varchar(100) DEFAULT NULL,
  `DEPLOY_DESC` text DEFAULT NULL,
  `DEPLOY_START_DT` datetime DEFAULT NULL,
  `DEPLOY_UNIT` varchar(10) DEFAULT NULL,
  `DEPLOY_INTERVAL` varchar(10) DEFAULT NULL,
  `DEPLOY_STATUS_CD` varchar(20) DEFAULT NULL,
  `FILE_VERSION` varchar(32) DEFAULT NULL,
  `FILE_SIZE` int(11) DEFAULT NULL,
  `FILE_PATH` varchar(200) DEFAULT NULL,
  `PROC_TYPE` varchar(20) DEFAULT NULL,
  `PROCESS_CD` varchar(20) DEFAULT NULL,
  `DOWNLOAD_URL` varchar(200) DEFAULT NULL,
  `DT_INSERT` datetime DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`DEPLOY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tb_swdeploy_dtl` */

DROP TABLE IF EXISTS `tb_swdeploy_dtl`;

CREATE TABLE `tb_swdeploy_dtl` (
  `DEPLOY_ID` int(11) NOT NULL,
  `ELMT_ID` int(11) NOT NULL,
  `PROC_NM` varchar(50) NOT NULL,
  `DEPLOY_STATUS_CD` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`DEPLOY_ID`,`ELMT_ID`,`PROC_NM`),
  CONSTRAINT `tb_swdeploy_dtl_ibfk_1` FOREIGN KEY (`DEPLOY_ID`) REFERENCES `tb_swdeploy` (`DEPLOY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tm_cd` */

DROP TABLE IF EXISTS `tm_cd`;

CREATE TABLE `tm_cd` (
  `CD_GRP` varchar(20) NOT NULL COMMENT 'CD_GRP',
  `NO_CD` varchar(20) NOT NULL COMMENT 'NO_CD',
  `FG_LANG` varchar(2) NOT NULL COMMENT 'FG_LANG',
  `NM_CD` varchar(80) NOT NULL COMMENT 'NM_CD',
  `DESC_CD` varchar(100) DEFAULT NULL COMMENT 'DESC_CD',
  `NO_ORDER` int(11) DEFAULT NULL COMMENT 'NO_ORDER',
  `YN_USE` char(1) NOT NULL DEFAULT 'Y' COMMENT 'YN_USE',
  `ID_INSERT` varchar(10) DEFAULT NULL COMMENT 'ID_INSERT',
  `DT_INSERT` date DEFAULT NULL COMMENT 'DT_INSERT',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT 'ID_UPDATE',
  `DT_UPDATE` date DEFAULT NULL COMMENT 'DT_UPDATE',
  PRIMARY KEY (`CD_GRP`,`NO_CD`,`FG_LANG`),
  KEY `tm_cd_ibfk_1` (`CD_GRP`,`FG_LANG`),
  CONSTRAINT `tm_cd_ibfk_1` FOREIGN KEY (`CD_GRP`, `FG_LANG`) REFERENCES `tm_cdgrp` (`CD_GRP`, `FG_LANG`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='코드';

/*Table structure for table `tm_cdgrp` */

DROP TABLE IF EXISTS `tm_cdgrp`;

CREATE TABLE `tm_cdgrp` (
  `CD_GRP` varchar(20) NOT NULL COMMENT 'CD_GRP',
  `FG_LANG` varchar(2) NOT NULL COMMENT 'FG_LANG',
  `NM_GRP` varchar(80) NOT NULL COMMENT 'NM_GRP',
  `DESC_GRP` varchar(100) DEFAULT NULL COMMENT 'DESC_GRP',
  `YN_USE` char(1) NOT NULL DEFAULT 'Y' COMMENT 'YN_USE',
  `ID_INSERT` varchar(10) NOT NULL COMMENT 'ID_INSERT',
  `DT_INSERT` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'DT_INSERT',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT 'ID_UPDATE',
  `DT_UPDATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'DT_UPDATE',
  PRIMARY KEY (`CD_GRP`,`FG_LANG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='코드그룹';

/*Table structure for table `tm_conf` */

DROP TABLE IF EXISTS `tm_conf`;

CREATE TABLE `tm_conf` (
  `ID_CONF` int(11) NOT NULL AUTO_INCREMENT COMMENT '설정ID',
  `LOG_INOUT_YN` varchar(1) DEFAULT NULL COMMENT '접속로그여부',
  `LOG_RES_YN` varchar(1) DEFAULT NULL COMMENT '응답시간로그여부',
  `LOG_ACTION_YN` varchar(1) DEFAULT NULL COMMENT '수행업무로그여부',
  `LOG_ERROR_YN` varchar(1) DEFAULT NULL COMMENT '에러로그여부',
  `DF_LANG` varchar(4) DEFAULT 'KR' COMMENT '기본 언어',
  `PERIOD` varchar(4) DEFAULT NULL COMMENT '로그 보관기한',
  `ID_INSERT` varchar(10) DEFAULT NULL COMMENT '등록자',
  `DT_INSERT` datetime DEFAULT NULL COMMENT '등록일시',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT '수정자',
  `DT_UPDATE` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`ID_CONF`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='기본설정';

/*Table structure for table `tm_log_action` */

DROP TABLE IF EXISTS `tm_log_action`;

CREATE TABLE `tm_log_action` (
  `ID_USER` varchar(10) NOT NULL COMMENT '사용자ID',
  `ID_MENU` varchar(10) NOT NULL COMMENT '메뉴ID',
  `REQ_DT` datetime NOT NULL COMMENT '요청일시',
  `ACTION_URL` varchar(256) NOT NULL COMMENT '요청URL',
  `ACTION` char(1) DEFAULT NULL COMMENT '작업 타입(1 조회,2 신규/수정)',
  `IS_SUCCESS` char(1) DEFAULT NULL COMMENT '작업결과',
  `ERR_TYPE` varchar(2) DEFAULT NULL COMMENT '에러종류',
  `DU_TIME` varchar(10) DEFAULT NULL COMMENT '작업시간'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='수행업무로그';

/*Table structure for table `tm_log_conn` */

DROP TABLE IF EXISTS `tm_log_conn`;

CREATE TABLE `tm_log_conn` (
  `ID_USER` varchar(10) NOT NULL COMMENT '사용자ID',
  `ID_SESSION` varchar(255) NOT NULL COMMENT '세션ID',
  `LOGIN_DT` datetime NOT NULL COMMENT '로그인일시',
  `LOGOUT_DT` datetime DEFAULT NULL COMMENT '로그아웃일시',
  `DU_TIME` int(11) DEFAULT NULL COMMENT '유지시간_초',
  `REMOTE_IP` varchar(40) DEFAULT NULL COMMENT '접속IP',
  `USER_AGENT` varchar(256) DEFAULT NULL COMMENT '접속단말',
  PRIMARY KEY (`ID_USER`,`ID_SESSION`,`LOGIN_DT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='접속로그';

/*Table structure for table `tm_log_error` */

DROP TABLE IF EXISTS `tm_log_error`;

CREATE TABLE `tm_log_error` (
  `ID_USER` varchar(10) NOT NULL COMMENT '사용자ID',
  `ID_MENU` varchar(10) NOT NULL COMMENT '메뉴ID',
  `ERROR_DT` datetime NOT NULL COMMENT '에러발생일시',
  `ACTION_URL` varchar(256) DEFAULT NULL COMMENT '요청URL',
  `CD_ERROR` varchar(5) DEFAULT NULL COMMENT '에러코드',
  `CD_ORG_ERROR` varchar(100) DEFAULT NULL COMMENT 'CD_ORG_ERROR',
  `DESC_ERROR` varchar(3500) DEFAULT NULL COMMENT '에러내용',
  PRIMARY KEY (`ID_USER`,`ID_MENU`,`ERROR_DT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='에러로그';

/*Table structure for table `tm_menu` */

DROP TABLE IF EXISTS `tm_menu`;

CREATE TABLE `tm_menu` (
  `ID_MENU` varchar(4) NOT NULL COMMENT 'ID_MENU',
  `ACTION_URL` varchar(255) DEFAULT NULL COMMENT 'ACTION_URL',
  `PA_MENU` varchar(4) NOT NULL DEFAULT '0' COMMENT 'PA_MENU',
  `DEPTH` char(1) NOT NULL COMMENT 'DEPTH',
  `IMG_MENU` varchar(100) DEFAULT NULL COMMENT 'IMG_MENU',
  `DESC_MENU` varchar(30) DEFAULT NULL COMMENT 'DESC_MENU',
  `NO_ORDER` varchar(2) DEFAULT NULL COMMENT 'NO_ORDER',
  `YN_USE` char(1) NOT NULL DEFAULT 'Y' COMMENT 'YN_USE',
  `VIEW_TYPE` varchar(4) DEFAULT NULL COMMENT '뷰타입',
  `ID_INSERT` varchar(10) NOT NULL COMMENT 'ID_INSERT',
  `DT_INSERT` date NOT NULL COMMENT 'DT_INSERT',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT 'ID_UPDATE',
  `DT_UPDATE` date DEFAULT NULL COMMENT 'DT_UPDATE',
  PRIMARY KEY (`ID_MENU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴정보';

/*Table structure for table `tm_menu_dtl` */

DROP TABLE IF EXISTS `tm_menu_dtl`;

CREATE TABLE `tm_menu_dtl` (
  `id_menu` varchar(4) NOT NULL COMMENT 'ID_MENU',
  `fg_lang` varchar(5) NOT NULL COMMENT 'FG_LANG',
  `nm_menu` varchar(50) DEFAULT NULL COMMENT 'NM_MENU',
  PRIMARY KEY (`id_menu`,`fg_lang`),
  CONSTRAINT `tm_menu_dtl_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `tm_menu` (`ID_MENU`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴상세';

/*Table structure for table `tm_msg` */

DROP TABLE IF EXISTS `tm_msg`;

CREATE TABLE `tm_msg` (
  `CD_SYS` varchar(4) NOT NULL,
  `CD_MSG` varchar(4) NOT NULL,
  `NO_MSG` varchar(6) NOT NULL,
  `FG_LANG` varchar(2) NOT NULL,
  `NM_MSG` varchar(255) NOT NULL,
  `DESC_MSG` varchar(255) DEFAULT NULL,
  `ID_INSERT` varchar(10) DEFAULT NULL,
  `DT_INSERT` date DEFAULT NULL,
  `ID_UPDATE` varchar(10) DEFAULT NULL,
  `DT_UPDATE` date DEFAULT NULL,
  PRIMARY KEY (`CD_SYS`,`CD_MSG`,`NO_MSG`,`FG_LANG`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `tm_role` */

DROP TABLE IF EXISTS `tm_role`;

CREATE TABLE `tm_role` (
  `ID_ROLE` varchar(4) NOT NULL COMMENT 'ID_ROLE',
  `NM_ROLE` varchar(30) NOT NULL COMMENT 'NM_ROLE',
  `DESC_ROLE` varchar(100) DEFAULT NULL COMMENT 'DESC_ROLE',
  `YN_USE` char(1) NOT NULL DEFAULT 'Y' COMMENT 'YN_USE',
  `ID_INSERT` varchar(10) NOT NULL COMMENT 'ID_INSERT',
  `DT_INSERT` date NOT NULL COMMENT 'DT_INSERT',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT 'ID_UPDATE',
  `DT_UPDATE` date DEFAULT NULL COMMENT 'DT_UPDATE',
  PRIMARY KEY (`ID_ROLE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='권한그룹';

/*Table structure for table `tm_role_menu` */

DROP TABLE IF EXISTS `tm_role_menu`;

CREATE TABLE `tm_role_menu` (
  `ID_ROLE` varchar(4) NOT NULL COMMENT 'ID_ROLE',
  `ID_MENU` varchar(4) NOT NULL COMMENT 'ID_MENU',
  `YN_SELECT` char(1) NOT NULL DEFAULT 'N' COMMENT 'YN_SELECT',
  `YN_INSERT` char(1) NOT NULL DEFAULT 'N' COMMENT 'YN_INSERT',
  `YN_UPDATE` char(1) NOT NULL DEFAULT 'N' COMMENT 'YN_UPDATE',
  `YN_DELETE` char(1) NOT NULL DEFAULT 'N' COMMENT 'YN_DELETE',
  `YN_EXCEL` char(1) NOT NULL DEFAULT 'N' COMMENT 'YN_EXCEL',
  `YN_REPORT` char(1) NOT NULL DEFAULT 'N' COMMENT 'YN_REPORT',
  `ID_INSERT` varchar(10) NOT NULL COMMENT 'ID_INSERT',
  `DT_INSERT` date NOT NULL COMMENT 'DT_INSERT',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT 'ID_UPDATE',
  `DT_UPDATE` date DEFAULT NULL COMMENT 'DT_UPDATE',
  PRIMARY KEY (`ID_ROLE`,`ID_MENU`),
  KEY `ID_MENU` (`ID_MENU`),
  CONSTRAINT `tm_role_menu_ibfk_1` FOREIGN KEY (`ID_MENU`) REFERENCES `tm_menu` (`ID_MENU`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tm_role_menu_ibfk_2` FOREIGN KEY (`ID_ROLE`) REFERENCES `tm_role` (`ID_ROLE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴권한';

/*Table structure for table `tm_user` */

DROP TABLE IF EXISTS `tm_user`;

CREATE TABLE `tm_user` (
  `ID_USER` varchar(5) NOT NULL COMMENT '사용자ID',
  `NM_USER` varchar(50) DEFAULT NULL COMMENT '이름',
  `USER_TYPE` varchar(4) DEFAULT NULL COMMENT '사용자구분 : 운영자(01), CS(02), 번역자(03), 연예인매니저(04), DJ(05), 큐레이터(06), 테스터(99)',
  `ID_LOGIN` varchar(10) DEFAULT NULL COMMENT '로그인ID',
  `PWD` varchar(200) DEFAULT NULL COMMENT '패스워드',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT '이메일',
  `MOB_NO` varchar(12) DEFAULT NULL COMMENT '휴대폰번호',
  `TEL_NO` varchar(12) DEFAULT NULL COMMENT '전화번호',
  `NM_COM` varchar(50) DEFAULT NULL COMMENT '소속회사명',
  `NM_DEPT` varchar(50) DEFAULT NULL COMMENT '소속부서명',
  `LANG` varchar(4) DEFAULT NULL COMMENT '언어 : 한국어(KR)\n일본어(JP)\n영어(EN)',
  `MEMO` text DEFAULT NULL COMMENT '메모',
  `RANDOM_PW_YN` char(1) DEFAULT 'N' COMMENT '임시비번 여부',
  `DEL_YN` varchar(4) DEFAULT NULL COMMENT '삭제여부',
  `CUST_ID` varchar(10) DEFAULT NULL COMMENT '회사ID',
  `CUST_GROUP_ID` varchar(13) DEFAULT NULL COMMENT '그룹ID',
  `ID_INSERT` varchar(10) DEFAULT NULL COMMENT '등록자',
  `DT_INSERT` datetime DEFAULT NULL COMMENT '등록일시',
  `ID_UPDATE` varchar(10) DEFAULT NULL COMMENT '수정자',
  `DT_UPDATE` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`ID_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자정보';

/*Table structure for table `tm_user_role` */

DROP TABLE IF EXISTS `tm_user_role`;

CREATE TABLE `tm_user_role` (
  `ID_ROLE` varchar(4) NOT NULL COMMENT 'ID_ROLE',
  `ID_USER` varchar(5) NOT NULL COMMENT '사용자ID',
  `ID_INSERT` varchar(10) NOT NULL COMMENT 'ID_INSERT',
  `DT_INSERT` date NOT NULL COMMENT 'DT_INSERT',
  PRIMARY KEY (`ID_ROLE`,`ID_USER`),
  KEY `ID_USER` (`ID_USER`),
  CONSTRAINT `tm_user_role_ibfk_1` FOREIGN KEY (`ID_ROLE`) REFERENCES `tm_role` (`ID_ROLE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tm_user_role_ibfk_2` FOREIGN KEY (`ID_USER`) REFERENCES `tm_user` (`ID_USER`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자권한';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

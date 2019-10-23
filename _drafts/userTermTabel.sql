/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.7.17-log : Database - dycis_mobile_dev
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dycis_mobile_dev` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dycis_mobile_dev`;

/*Table structure for table `tn_term_info` */

DROP TABLE IF EXISTS `tn_term_info`;

CREATE TABLE `tn_term_info` (
  `TERM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TERM_TYPE` varchar(8) DEFAULT NULL,
  `TERM_NM` varchar(100) DEFAULT NULL,
  `TERM_VERSION` int(11) DEFAULT NULL,
  `TERM_CONTENTS` text,
  `TERM_URL` varchar(100) DEFAULT NULL,
  `REG_ID` varchar(11) DEFAULT NULL,
  `REG_DT` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TERM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `tn_user_term_agree` */

DROP TABLE IF EXISTS `tn_user_term_agree`;

CREATE TABLE `tn_user_term_agree` (
  `USER_ID` int(11) DEFAULT NULL,
  `TERM_ID` int(11) DEFAULT NULL,
  `AGREE_YN` varchar(1) DEFAULT NULL,
  `AGREE_DT` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;










FieldTypeComment
BI_IDint(11) NOT NULL게시물 ID
BILLBOARD_IDint(11) NOT NULL게시판 ID
BI_TITLEvarchar(11) NULL게시물 제목
BI_CONTENTStext NULL게시물 내용
P_BI_IDint(11) NULL게시물 ID(최상위)
R_BI_IDint(11) NULL게시물 ID(상위)
BI_DEPTHint(11) NULL답글순서
NOTICE_YNchar(1) NULL공지여부
DELETE_YNchar(1) NULL삭제여부
PWD_VALUEvarchar(100) NULL게시물 비밀번호
REG_TYPEvarchar(8) NULL등록자 구분(U:사용자, C:센터, M:관리자)
REG_IDvarchar(11) NULL등록자 ID
REG_DTdatetime NULL등록일시
MOD_TYPEvarchar(8) NULL수정자 구분(U:사용자, C:센터, M:관리자)
MOD_IDvarchar(11) NULL수정자 ID
MOD_DTdatetime NULL수정일시

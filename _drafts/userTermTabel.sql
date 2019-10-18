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

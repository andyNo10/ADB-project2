# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.17-0ubuntu0.16.04.2)
# Database: adb-project
# Generation Time: 2017-05-07 06:38:54 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Admin`;

CREATE TABLE `Admin` (
  `adminID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(16) NOT NULL DEFAULT '',
  `userID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`adminID`),
  KEY `fk_adminID` (`userID`),
  CONSTRAINT `fk_adminID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;

INSERT INTO `Admin` (`adminID`, `name`, `userID`)
VALUES
	(2,'admin',1);

/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Classroom
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Classroom`;

CREATE TABLE `Classroom` (
  `roomID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `room_size` char(11) NOT NULL DEFAULT '',
  `name` char(16) DEFAULT NULL,
  PRIMARY KEY (`roomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Classroom` WRITE;
/*!40000 ALTER TABLE `Classroom` DISABLE KEYS */;

INSERT INTO `Classroom` (`roomID`, `room_size`, `name`)
VALUES
	(1,'90','I1-311'),
	(2,'100','I1-312');

/*!40000 ALTER TABLE `Classroom` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table dateOff
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dateOff`;

CREATE TABLE `dateOff` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `adminID` int(11) unsigned NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dateoff_admin` (`adminID`),
  CONSTRAINT `fk_dateoff_admin` FOREIGN KEY (`adminID`) REFERENCES `Admin` (`adminID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Member`;

CREATE TABLE `Member` (
  `memID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(16) NOT NULL DEFAULT '',
  `position` char(16) NOT NULL DEFAULT '',
  `userID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`memID`),
  KEY `fk_mem_userID` (`userID`),
  CONSTRAINT `fk_mem_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;

INSERT INTO `Member` (`memID`, `name`, `position`, `userID`)
VALUES
	(1,'member','student',2);

/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(3,'2014_10_12_000000_create_users_table',1),
	(4,'2014_10_12_100000_create_password_resets_table',1);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table RentPeriod
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RentPeriod`;

CREATE TABLE `RentPeriod` (
  `periodID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `startTime` char(16) NOT NULL DEFAULT '',
  `endTime` char(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`periodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `RentPeriod` WRITE;
/*!40000 ALTER TABLE `RentPeriod` DISABLE KEYS */;

INSERT INTO `RentPeriod` (`periodID`, `startTime`, `endTime`)
VALUES
	(1,'8:00','9:00'),
	(2,'9:00','10:00');

/*!40000 ALTER TABLE `RentPeriod` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table RentRecord
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RentRecord`;

CREATE TABLE `RentRecord` (
  `recordID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `periodID` int(11) unsigned NOT NULL,
  `roomID` int(11) unsigned NOT NULL,
  `Date` date NOT NULL,
  `memID` int(11) unsigned NOT NULL,
  `status` char(16) DEFAULT NULL,
  PRIMARY KEY (`recordID`),
  KEY `fk_rent_period` (`periodID`),
  KEY `fk_rent_classroom` (`roomID`),
  KEY `fk_rent_member` (`memID`),
  CONSTRAINT `fk_rent_classroom` FOREIGN KEY (`roomID`) REFERENCES `Classroom` (`roomID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_member` FOREIGN KEY (`memID`) REFERENCES `Member` (`memID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_period` FOREIGN KEY (`periodID`) REFERENCES `RentPeriod` (`periodID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `RentRecord` WRITE;
/*!40000 ALTER TABLE `RentRecord` DISABLE KEYS */;

INSERT INTO `RentRecord` (`recordID`, `periodID`, `roomID`, `Date`, `memID`, `status`)
VALUES
	(105,1,1,'2017-05-02',1,'已取消'),
	(106,1,1,'2017-05-01',1,'已過期'),
	(107,1,1,'2017-05-03',1,'已過期');

/*!40000 ALTER TABLE `RentRecord` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table RentRecord_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RentRecord_history`;

CREATE TABLE `RentRecord_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `recordID` int(11) unsigned NOT NULL,
  `periodID` int(11) unsigned NOT NULL,
  `roomID` int(11) unsigned NOT NULL,
  `memID` int(10) unsigned NOT NULL,
  `Date` date NOT NULL,
  `record_datetime` datetime NOT NULL,
  `action` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `RentRecord_history` WRITE;
/*!40000 ALTER TABLE `RentRecord_history` DISABLE KEYS */;

INSERT INTO `RentRecord_history` (`id`, `recordID`, `periodID`, `roomID`, `memID`, `Date`, `record_datetime`, `action`)
VALUES
	(9,105,1,1,1,'2017-05-02','2017-05-07 06:36:16','預約中'),
	(10,105,1,1,1,'2017-05-02','2017-05-07 06:36:31','已取消'),
	(11,106,1,1,1,'2017-05-01','2017-05-07 06:36:43','預約中'),
	(12,107,1,1,1,'2017-05-03','2017-05-07 06:37:39','預約中'),
	(13,107,1,1,1,'2017-05-03','2017-05-07 06:38:00','已過期');

/*!40000 ALTER TABLE `RentRecord_history` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table roomOfftime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roomOfftime`;

CREATE TABLE `roomOfftime` (
  `ID` int(11) NOT NULL,
  `roomID` int(11) unsigned NOT NULL,
  `adminID` int(11) unsigned NOT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_room_manager` (`adminID`),
  KEY `fk_classroom` (`roomID`),
  CONSTRAINT `fk_classroom` FOREIGN KEY (`roomID`) REFERENCES `Classroom` (`roomID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_manager` FOREIGN KEY (`adminID`) REFERENCES `Admin` (`adminID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sys_param
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_param`;

CREATE TABLE `sys_param` (
  `systemID` int(11) NOT NULL,
  `name` char(16) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `update_by` int(11) unsigned NOT NULL,
  PRIMARY KEY (`systemID`),
  KEY `fk_admin_update` (`update_by`),
  CONSTRAINT `fk_admin_update` FOREIGN KEY (`update_by`) REFERENCES `Admin` (`adminID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_account_unique` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `account`, `password`, `userType`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(1,'admin','admin','$2y$10$uGLNWLQNXk//u4rpZgfFX.Vcmf2uCUk76CHnY0UNfxEfUBFjfGavS','Admin','tRavV2F8kFmbrbAWRkyRgtP6k0WYaUfYvJheoU3DXEf1vZGaZEhDVTKW9Ou2',NULL,NULL),
	(2,'member','member','$2y$10$VE/AcUxsJ/92mfT.X6Ll/e51t3XBpq0/hdIIzUzb0fceykSCFok7W','Member','0M9aVlU4CZz6qolsxGia7vY2KlwreNd2d1xBFtgDb9ssCikvoatPJyv2ZqT1',NULL,NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table v_admintotalrentrecord
# ------------------------------------------------------------

DROP VIEW IF EXISTS `v_admintotalrentrecord`;

CREATE TABLE `v_admintotalrentrecord` (
   `memID` INT(11) UNSIGNED NOT NULL,
   `Date` DATE NOT NULL,
   `periodID` INT(11) UNSIGNED NOT NULL,
   `roomID` INT(11) UNSIGNED NOT NULL,
   `status` CHAR(16) NULL DEFAULT NULL,
   `classroomName` CHAR(16) NULL DEFAULT NULL,
   `startTime` CHAR(16) NOT NULL DEFAULT '',
   `endTime` CHAR(16) NOT NULL DEFAULT '',
   `memberName` CHAR(16) NOT NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table v_totalrentrecord
# ------------------------------------------------------------

DROP VIEW IF EXISTS `v_totalrentrecord`;

CREATE TABLE `v_totalrentrecord` (
   `memID` INT(11) UNSIGNED NOT NULL,
   `Date` DATE NOT NULL,
   `periodID` INT(11) UNSIGNED NOT NULL,
   `roomID` INT(11) UNSIGNED NOT NULL,
   `status` CHAR(16) NULL DEFAULT NULL,
   `name` CHAR(16) NULL DEFAULT NULL,
   `startTime` CHAR(16) NOT NULL DEFAULT '',
   `endTime` CHAR(16) NOT NULL DEFAULT ''
) ENGINE=MyISAM;





# Replace placeholder table for v_admintotalrentrecord with correct view syntax
# ------------------------------------------------------------

DROP TABLE `v_admintotalrentrecord`;

CREATE ALGORITHM=UNDEFINED DEFINER=`homestead`@`%` SQL SECURITY DEFINER VIEW `v_admintotalrentrecord`
AS SELECT
   `RentRecord`.`memID` AS `memID`,
   `RentRecord`.`Date` AS `Date`,
   `RentRecord`.`periodID` AS `periodID`,
   `RentRecord`.`roomID` AS `roomID`,
   `RentRecord`.`status` AS `status`,
   `Classroom`.`name` AS `classroomName`,
   `RentPeriod`.`startTime` AS `startTime`,
   `RentPeriod`.`endTime` AS `endTime`,
   `Member`.`name` AS `memberName`
FROM (((`RentRecord` join `Classroom` on((`RentRecord`.`roomID` = `Classroom`.`roomID`))) join `RentPeriod` on((`RentRecord`.`periodID` = `RentPeriod`.`periodID`))) join `Member` on((`RentRecord`.`memID` = `Member`.`memID`)));


# Replace placeholder table for v_totalrentrecord with correct view syntax
# ------------------------------------------------------------

DROP TABLE `v_totalrentrecord`;

CREATE ALGORITHM=UNDEFINED DEFINER=`homestead`@`%` SQL SECURITY DEFINER VIEW `v_totalrentrecord`
AS SELECT
   `RentRecord`.`memID` AS `memID`,
   `RentRecord`.`Date` AS `Date`,
   `RentRecord`.`periodID` AS `periodID`,
   `RentRecord`.`roomID` AS `roomID`,
   `RentRecord`.`status` AS `status`,
   `Classroom`.`name` AS `name`,
   `RentPeriod`.`startTime` AS `startTime`,
   `RentPeriod`.`endTime` AS `endTime`
FROM ((`RentRecord` join `Classroom` on((`RentRecord`.`roomID` = `Classroom`.`roomID`))) join `RentPeriod` on((`RentRecord`.`periodID` = `RentPeriod`.`periodID`)));

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

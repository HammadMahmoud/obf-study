-- MySQL dump 10.13  Distrib 5.7.13, for osx10.11 (x86_64)
--
-- Host: localhost    Database: obf
-- ------------------------------------------------------
-- Server version	5.7.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `app_date`
--

DROP TABLE IF EXISTS `app_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_date` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_malicious` int(11) DEFAULT NULL,
  `app` varchar(256) DEFAULT NULL,
  `pkg` varchar(128) DEFAULT NULL,
  `dex_year` int(11) DEFAULT NULL,
  `dex_month` int(11) DEFAULT NULL,
  `dex_day` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_UNIQUE` (`app`)
) ENGINE=InnoDB AUTO_INCREMENT=5887 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `apps`
--

DROP TABLE IF EXISTS `apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scan_id` varchar(128) DEFAULT NULL,
  `sha256` varchar(128) DEFAULT NULL,
  `analysis_link` varchar(128) DEFAULT NULL,
  `app` varchar(256) DEFAULT NULL,
  `dataset` varchar(45) DEFAULT NULL,
  `minor_dataset` varchar(45) DEFAULT NULL,
  `obfuscator` varchar(45) DEFAULT NULL,
  `obf_strategy` varchar(45) DEFAULT NULL,
  `app_year` int(11) DEFAULT NULL,
  `app_month` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_name_UNIQUE` (`app`),
  KEY `idx_scan_id` (`scan_id`),
  KEY `apps_ds_idx` (`dataset`)
) ENGINE=InnoDB AUTO_INCREMENT=79673 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--

-- Temporary view structure for view `av_detection_rate`
--

DROP TABLE IF EXISTS `av_detection_rate`;
/*!50001 DROP VIEW IF EXISTS `av_detection_rate`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `av_detection_rate` AS SELECT 
 1 AS `av`,
 1 AS `is_malicious`,
 1 AS `correct`,
 1 AS `cnt`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `av_products`
--

DROP TABLE IF EXISTS `av_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `av_products` (
  `av` varchar(64) NOT NULL,
  `related_work` varchar(128) DEFAULT NULL,
  `notes` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`av`),
  UNIQUE KEY `av_UNIQUE` (`av`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
--
-- Table structure for table `av_results_all_malicious`
--

DROP TABLE IF EXISTS `av_results_all_malicious`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `av_results_all_malicious` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `scan_id` varchar(128) NOT NULL,
  `av` varchar(128) DEFAULT NULL,
  `result` varchar(128) DEFAULT NULL,
  `is_malicious` int(11) DEFAULT NULL,
  `marked_malicious` int(11) DEFAULT NULL,
  `correct` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scan_id_UNIQUE` (`scan_id`),
  KEY `all_mal_idx_av` (`av`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `av_results_benign`
--

DROP TABLE IF EXISTS `av_results_benign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `av_results_benign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scan_id` varchar(128) DEFAULT NULL,
  `av` varchar(128) DEFAULT NULL,
  `result` varchar(128) DEFAULT NULL,
  `is_malicious` int(11) DEFAULT NULL,
  `marked_malicious` int(11) DEFAULT NULL,
  `correct` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_results_scan_id` (`scan_id`),
  KEY `benign_idx_av` (`av`)
) ENGINE=InnoDB AUTO_INCREMENT=4584126 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `av_results_benign_selected_avs`
--

DROP TABLE IF EXISTS `av_results_benign_selected_avs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `av_results_benign_selected_avs` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `scan_id` varchar(128) DEFAULT NULL,
  `av` varchar(128) DEFAULT NULL,
  `result` varchar(128) DEFAULT NULL,
  `is_malicious` int(11) DEFAULT NULL,
  `marked_malicious` int(11) DEFAULT NULL,
  `correct` int(11) DEFAULT NULL,
  KEY `ben_sel_av_idx` (`av`),
  KEY `be_sel_scan_id` (`scan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `av_results_malicious_selected_avs`
--

DROP TABLE IF EXISTS `av_results_malicious_selected_avs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `av_results_malicious_selected_avs` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `scan_id` varchar(128) NOT NULL,
  `av` varchar(128) DEFAULT NULL,
  `result` varchar(128) DEFAULT NULL,
  `is_malicious` int(11) DEFAULT NULL,
  `marked_malicious` int(11) DEFAULT NULL,
  `correct` int(11) DEFAULT NULL,
  KEY `mal_sel_av_idx` (`av`),
  KEY `mal_sel_scan_id_idx` (`scan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `installability_results`
--

DROP TABLE IF EXISTS `installability_results`;
/*!50001 DROP VIEW IF EXISTS `installability_results`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `installability_results` AS SELECT 
 1 AS `obfuscator`,
 1 AS `Installed Apps`,
 1 AS `Installability`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `installable_runnable_apps`
--

DROP TABLE IF EXISTS `installable_runnable_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `installable_runnable_apps` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `scan_id` varchar(128) DEFAULT NULL,
  `sha256` varchar(128) DEFAULT NULL,
  `analysis_link` varchar(128) DEFAULT NULL,
  `app` varchar(256) DEFAULT NULL,
  `dataset` varchar(45) DEFAULT NULL,
  `minor_dataset` varchar(45) DEFAULT NULL,
  `obfuscator` varchar(45) DEFAULT NULL,
  `obf_strategy` varchar(45) DEFAULT NULL,
  `app_year` int(11) DEFAULT NULL,
  `app_month` int(11) DEFAULT NULL,
  `included` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `installed_apps_results`
--

DROP TABLE IF EXISTS `installed_apps_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `installed_apps_results` (
  `Obfuscator` varchar(128) NOT NULL,
  `app_dir` varchar(512) DEFAULT NULL,
  `apk_path` varchar(512) NOT NULL,
  `pkg` varchar(512) DEFAULT NULL,
  `trans` varchar(128) DEFAULT NULL,
  `success` int(11) DEFAULT NULL,
  `trans_output` varchar(512) DEFAULT NULL,
  `start_time` varchar(45) DEFAULT NULL,
  `end_time` varchar(45) DEFAULT NULL,
  `total_time` varchar(45) DEFAULT NULL,
  `included` int(11) DEFAULT '1',
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `successfully_exercised_original_apps`
--

DROP TABLE IF EXISTS `successfully_exercised_original_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `successfully_exercised_original_apps` (
  `app` varchar(255) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `included` int(11) DEFAULT NULL,
  PRIMARY KEY (`app`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `av_detection_rate`
--

/*!50001 DROP VIEW IF EXISTS `av_detection_rate`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mahmoud`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `av_detection_rate` AS select `av_results_all_malicious`.`av` AS `av`,`av_results_all_malicious`.`is_malicious` AS `is_malicious`,`av_results_all_malicious`.`correct` AS `correct`,count(0) AS `cnt` from `av_results_all_malicious` group by `av_results_all_malicious`.`av`,`av_results_all_malicious`.`is_malicious`,`av_results_all_malicious`.`correct` union all select `av_results_benign`.`av` AS `av`,`av_results_benign`.`is_malicious` AS `is_malicious`,`av_results_benign`.`correct` AS `correct`,count(0) AS `cnt` from `av_results_benign` group by `av_results_benign`.`av`,`av_results_benign`.`is_malicious`,`av_results_benign`.`correct` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `installability_results`
--

/*!50001 DROP VIEW IF EXISTS `installability_results`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mahmoud`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `installability_results` AS select `a`.`Obfuscator` AS `obfuscator`,sum(`a`.`success`) AS `Installed Apps`,((sum(`a`.`success`) / 250) * 100) AS `Installability` from `installed_apps_results` `a` where ((`a`.`trans` = 'install') and `a`.`app_dir` in (select `b`.`app` from `successfully_exercised_original_apps` `b` where (`b`.`included` = 1))) group by `a`.`Obfuscator` order by ((sum(`a`.`success`) / 250) * 100) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-23 11:58:39

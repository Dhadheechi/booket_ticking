-- MySQL dump 10.13  Distrib 9.0.1, for Win64 (x86_64)
--
-- Host: localhost    Database: booket_ticking
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int NOT NULL,
  `user_id` int NOT NULL,
  `admin_role` varchar(50) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add event',7,'add_event'),(26,'Can change event',7,'change_event'),(27,'Can delete event',7,'delete_event'),(28,'Can view event',7,'view_event'),(29,'Can add screen',8,'add_screen'),(30,'Can change screen',8,'change_screen'),(31,'Can delete screen',8,'delete_screen'),(32,'Can view screen',8,'view_screen'),(33,'Can add customer',9,'add_customer'),(34,'Can change customer',9,'change_customer'),(35,'Can delete customer',9,'delete_customer'),(36,'Can view customer',9,'view_customer'),(37,'Can add seat',10,'add_seat'),(38,'Can change seat',10,'change_seat'),(39,'Can delete seat',10,'delete_seat'),(40,'Can view seat',10,'view_seat'),(41,'Can add booking',11,'add_booking'),(42,'Can change booking',11,'change_booking'),(43,'Can delete booking',11,'delete_booking'),(44,'Can view booking',11,'view_booking'),(45,'Can add organizer',12,'add_organizer'),(46,'Can change organizer',12,'change_organizer'),(47,'Can delete organizer',12,'delete_organizer'),(48,'Can view organizer',12,'view_organizer'),(49,'Can add transaction',13,'add_transaction'),(50,'Can change transaction',13,'change_transaction'),(51,'Can delete transaction',13,'delete_transaction'),(52,'Can view transaction',13,'view_transaction'),(53,'Can add theatre',14,'add_theatre'),(54,'Can change theatre',14,'change_theatre'),(55,'Can delete theatre',14,'delete_theatre'),(56,'Can view theatre',14,'view_theatre'),(57,'Can add cancellation',15,'add_cancellation'),(58,'Can change cancellation',15,'change_cancellation'),(59,'Can delete cancellation',15,'delete_cancellation'),(60,'Can view cancellation',15,'view_cancellation'),(61,'Can add admin',16,'add_admin'),(62,'Can change admin',16,'change_admin'),(63,'Can delete admin',16,'delete_admin'),(64,'Can view admin',16,'view_admin'),(65,'Can add city',17,'add_city'),(66,'Can change city',17,'change_city'),(67,'Can delete city',17,'delete_city'),(68,'Can view city',17,'view_city'),(69,'Can add showtime',18,'add_showtime'),(70,'Can change showtime',18,'change_showtime'),(71,'Can delete showtime',18,'delete_showtime'),(72,'Can view showtime',18,'view_showtime'),(73,'Can add tier',19,'add_tier'),(74,'Can change tier',19,'change_tier'),(75,'Can delete tier',19,'delete_tier'),(76,'Can view tier',19,'view_tier'),(77,'Can add customer',20,'add_customer'),(78,'Can change customer',20,'change_customer'),(79,'Can delete customer',20,'delete_customer'),(80,'Can view customer',20,'view_customer'),(81,'Can add date',21,'add_date'),(82,'Can change date',21,'change_date'),(83,'Can delete date',21,'delete_date'),(84,'Can view date',21,'view_date'),(85,'Can add unique seat booking',22,'add_uniqueseatbooking'),(86,'Can change unique seat booking',22,'change_uniqueseatbooking'),(87,'Can delete unique seat booking',22,'delete_uniqueseatbooking'),(88,'Can view unique seat booking',22,'view_uniqueseatbooking');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$CHiPWLTeIWucYfKmFl0twk$vYqmXRRGXshrpmFaoQOOak1g3R7xUV4//HPNX7rVSfY=','2025-03-14 13:09:03.212436',1,'billy_56','','','billyboy18497@gmail.com',1,1,'2025-03-11 08:55:33.307832'),(6,'pbkdf2_sha256$870000$O3YRWOD51Uzpkxf1PQcbQv$zUkSlHIxhLXvVRspELCMpSv0wnw5lRtrEcXW8DegRl4=','2025-03-12 06:50:24.083453',0,'hello','','','hello@1',0,1,'2025-03-12 06:42:58.635117'),(8,'pbkdf2_sha256$870000$1bcZL1lwn6QDyUedTe71TY$dCOqk6XPyLZWvq325ybtDYYjDFcM47g9/YQuqh13fKs=','2025-03-12 06:57:42.938155',0,'hi1','','','hi@1',0,1,'2025-03-12 06:57:35.951941'),(9,'pbkdf2_sha256$870000$pHgPj6PzPI3xw4IYpNhsvi$hUAU5Ik3cgUChCGMKj+W5vLr4F3kINIu0M4PKQA48AM=',NULL,0,'hi2','','','hi@2',0,1,'2025-03-12 07:01:27.607773'),(10,'pbkdf2_sha256$870000$zNEtrvgizVlQeVgvIqe4Si$l58h0lsOMfGZxqYxIryVtG4G5LQ1VOVCMi1WB+z1xOI=',NULL,0,'hi3','','','hi@3',0,1,'2025-03-12 07:05:07.467400'),(11,'pbkdf2_sha256$870000$CbDhQTsWBVGXykbsfjJctL$h7j3W++K/+cyfk9fZIz1DmDOQaNjTa+SKmybBBAxaYs=','2025-03-12 07:23:59.148079',0,'hi4','','','hi@4',0,1,'2025-03-12 07:08:37.537828'),(12,'pbkdf2_sha256$870000$Tlhru9cnFjn24gxGLHlqnp$ydVn5kwx87Zvr2E/5ekMkbNF0TtUbj/GFg99ks94xM4=','2025-03-12 07:25:52.907198',0,'hi5','','','hi@5',0,1,'2025-03-12 07:25:47.561577'),(13,'pbkdf2_sha256$870000$AxnQ8jOFULypfEMIM4KkbO$Fyra7hVJiYtsUD1Aof+fTa8WsYbSq8XTH09pa15ZQTU=',NULL,0,'hi6','','','hi@6',0,1,'2025-03-12 07:29:41.607703'),(14,'pbkdf2_sha256$870000$7vgvEo0YOxGMnwArQnNJYT$2LZrPNWTsQ3fiXUttzTZYKOI7KWL4YEoPDNTkMoGl9E=','2025-03-13 06:44:43.617297',0,'hi8','','','hi@8',0,1,'2025-03-13 05:29:43.946569'),(15,'pbkdf2_sha256$870000$b69gKRFQgDWBOcbODmfyau$/IIwdPlopsIkOPNRFMWqeNMKur77pnm3/CFzzcbM+FY=','2025-03-14 13:08:33.922050',0,'hi9','','','hi@9',0,1,'2025-03-13 06:45:59.257108'),(16,'pbkdf2_sha256$870000$4JpEsZRsF2cfCjYFSwgXz3$fRpy6b6AMJsq4A7eoS2zuuEEKaAb/PbSmkrJMFgYEug=','2025-03-13 14:24:20.972797',0,'hi10','','','hi@10',0,1,'2025-03-13 14:24:16.544585'),(17,'pbkdf2_sha256$870000$8yXK3E2bqv6A96rzUh8D04$JSl6RvOSH/F2aMD+iJcRma5cWiMSlm8rFT70JRR3mmE=','2025-03-17 11:41:54.459329',0,'hi11','','','hi@11',0,1,'2025-03-16 15:17:50.970233');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `show_id` int NOT NULL,
  `seat_id` int NOT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `stat` varchar(10) NOT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `customer_id` (`customer_id`),
  KEY `show_id` (`show_id`),
  KEY `seat_id` (`seat_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`show_id`) REFERENCES `showtimes` (`show_id`),
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`),
  CONSTRAINT `bookings_chk_1` CHECK ((`stat` in (_utf8mb4'cancelled',_utf8mb4'confirmed')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_admin`
--

DROP TABLE IF EXISTS `bookings_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_admin` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_role` varchar(50) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `bookings_admin_user_id_01d686cc_fk_bookings_customer_id` FOREIGN KEY (`user_id`) REFERENCES `bookings_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_admin`
--

LOCK TABLES `bookings_admin` WRITE;
/*!40000 ALTER TABLE `bookings_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_booking`
--

DROP TABLE IF EXISTS `bookings_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booking_date` datetime(6) NOT NULL,
  `status` varchar(10) NOT NULL,
  `customer_id` bigint NOT NULL,
  `seat_id` bigint NOT NULL,
  `show_id` bigint NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_booking_customer_id_6b4bdaa9_fk_bookings_customer_id` (`customer_id`),
  KEY `bookings_booking_seat_id_764de9cf_fk_bookings_seat_id` (`seat_id`),
  KEY `bookings_booking_show_id_10221a5a_fk_bookings_showtime_id` (`show_id`),
  KEY `bookings_booking_user_id_834dfc23_fk_auth_user_id` (`user_id`),
  CONSTRAINT `bookings_booking_customer_id_6b4bdaa9_fk_bookings_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `bookings_customer` (`id`),
  CONSTRAINT `bookings_booking_seat_id_764de9cf_fk_bookings_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `bookings_seat` (`id`),
  CONSTRAINT `bookings_booking_show_id_10221a5a_fk_bookings_showtime_id` FOREIGN KEY (`show_id`) REFERENCES `bookings_showtime` (`id`),
  CONSTRAINT `bookings_booking_user_id_834dfc23_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_booking`
--

LOCK TABLES `bookings_booking` WRITE;
/*!40000 ALTER TABLE `bookings_booking` DISABLE KEYS */;
INSERT INTO `bookings_booking` VALUES (4,'2025-03-13 14:23:20.878195','confirmed',7,29,144,NULL),(5,'2025-03-13 14:24:35.507378','confirmed',8,26,273,NULL),(6,'2025-03-14 13:08:47.058270','confirmed',7,28,37,NULL);
/*!40000 ALTER TABLE `bookings_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_cancellation`
--

DROP TABLE IF EXISTS `bookings_cancellation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_cancellation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cancel_date` datetime(6) NOT NULL,
  `refund_status` varchar(10) NOT NULL,
  `booking_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_cancellation_booking_id_08be4ba0_fk_bookings_booking_id` (`booking_id`),
  CONSTRAINT `bookings_cancellation_booking_id_08be4ba0_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_cancellation`
--

LOCK TABLES `bookings_cancellation` WRITE;
/*!40000 ALTER TABLE `bookings_cancellation` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings_cancellation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_city`
--

DROP TABLE IF EXISTS `bookings_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_city` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_city`
--

LOCK TABLES `bookings_city` WRITE;
/*!40000 ALTER TABLE `bookings_city` DISABLE KEYS */;
INSERT INTO `bookings_city` VALUES (1,'Mumbai'),(2,'Delhi'),(3,'Bangalore'),(4,'Hyderabad'),(5,'Chennai'),(6,'Kolkata'),(7,'Pune'),(8,'Ahmedabad'),(9,'Jaipur'),(10,'Lucknow');
/*!40000 ALTER TABLE `bookings_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_customer`
--

DROP TABLE IF EXISTS `bookings_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) NOT NULL,
  `email_id` varchar(254) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `phone_no` (`phone_no`),
  UNIQUE KEY `uuser_id` (`user_id`),
  CONSTRAINT `bookings_customer_user_id_2ec5e30c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_customer`
--

LOCK TABLES `bookings_customer` WRITE;
/*!40000 ALTER TABLE `bookings_customer` DISABLE KEYS */;
INSERT INTO `bookings_customer` VALUES (1,'hi1','hi@1','',8),(3,'hi4','hi@4','4',11),(4,'hi5','hi@5','5',12),(6,'hi8','hi@8','8',14),(7,'hi9','hi@9','9',15),(8,'hi10','hi@10','10',16),(9,'hi11','hi@11','11',17);
/*!40000 ALTER TABLE `bookings_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_date`
--

DROP TABLE IF EXISTS `bookings_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_date` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `show_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `show_date` (`show_date`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_date`
--

LOCK TABLES `bookings_date` WRITE;
/*!40000 ALTER TABLE `bookings_date` DISABLE KEYS */;
INSERT INTO `bookings_date` VALUES (1,'2025-03-16'),(2,'2025-03-17'),(3,'2025-03-18'),(4,'2025-03-19'),(5,'2025-03-20'),(6,'2025-03-21'),(7,'2025-03-22'),(8,'2025-03-23'),(9,'2025-03-24'),(10,'2025-03-25'),(11,'2025-03-26'),(12,'2025-03-27'),(13,'2025-03-28'),(14,'2025-03-29'),(15,'2025-03-30'),(16,'2025-03-31'),(17,'2025-04-01'),(18,'2025-04-02'),(19,'2025-04-03'),(20,'2025-04-04'),(21,'2025-04-05'),(22,'2025-04-06'),(23,'2025-04-07'),(24,'2025-04-08'),(25,'2025-04-09'),(26,'2025-04-10'),(27,'2025-04-11'),(28,'2025-04-12'),(29,'2025-04-13'),(30,'2025-04-14');
/*!40000 ALTER TABLE `bookings_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_event`
--

DROP TABLE IF EXISTS `bookings_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) NOT NULL,
  `event_type` varchar(10) NOT NULL,
  `duration` int unsigned NOT NULL,
  `lang` varchar(50) NOT NULL,
  `organizer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_event_organizer_id_908d490e_fk_bookings_organizer_id` (`organizer_id`),
  CONSTRAINT `bookings_event_organizer_id_908d490e_fk_bookings_organizer_id` FOREIGN KEY (`organizer_id`) REFERENCES `bookings_organizer` (`id`),
  CONSTRAINT `bookings_event_chk_1` CHECK ((`duration` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_event`
--

LOCK TABLES `bookings_event` WRITE;
/*!40000 ALTER TABLE `bookings_event` DISABLE KEYS */;
INSERT INTO `bookings_event` VALUES (1,'Animal','movie',95,'Hindi',1),(2,'Fighter','movie',120,'Hindi',1),(3,'Tillu Square','movie',153,'Telugu',1),(4,'Shaitaan','movie',132,'Hindi',1),(5,'Article 370','movie',166,'Hindi',1),(6,'Crew','movie',116,'Hindi',2),(7,'Yodha','movie',117,'Hindi',2),(8,'Laapataa Ladies','movie',142,'Hindi',2),(9,'Bastar','movie',173,'Hindi',2),(10,'Ae Watan Mere Watan','movie',109,'Hindi',2),(11,'Diljit Dosanjh Concert','concert',153,'Punjabi',3),(12,'Arijit Singh Live','concert',105,'Hindi',3),(13,'Shreya Ghoshal Live','concert',107,'Hindi',3),(14,'Sonu Nigam Concert','concert',179,'Hindi',3),(15,'Neha Kakkar Live','concert',101,'Hindi',3),(16,'Pritam Concert','concert',120,'Hindi',4),(17,'A.R. Rahman Live','concert',115,'Tamil',4),(18,'Sunidhi Chauhan Concert','concert',108,'Hindi',4),(19,'KK Tribute Night','concert',153,'Hindi',4),(20,'Lucky Ali Live','concert',150,'Hindi',4),(21,'Kalki 2898 AD','movie',160,'Telugu',5),(22,'Pushpa 2','movie',156,'Telugu',5),(23,'Bhool Bhulaiyaa 3','movie',157,'Hindi',5),(24,'Vikram','movie',142,'Tamil',5),(25,'KGF Chapter 3','movie',131,'Kannada',5),(26,'Jawaan','movie',129,'Hindi',6),(27,'Leo','movie',156,'Tamil',6),(28,'Bade Miyan Chote Miyan','movie',134,'Hindi',6),(29,'Singham Again','movie',153,'Hindi',6),(30,'Brahmastra 2','movie',157,'Hindi',6),(31,'Atif Aslam Live','concert',180,'Urdu',7),(32,'Armaan Malik Concert','concert',155,'Hindi',7),(33,'Badshah Live','concert',132,'Hindi',7),(34,'Hardy Sandhu Live','concert',151,'Punjabi',7),(35,'Honey Singh Concert','concert',167,'Hindi',7),(36,'Vishal-Shekhar Live','concert',102,'Hindi',8),(37,'Shankar-Ehsaan-Loy Concert','concert',141,'Hindi',8),(38,'Gurdas Maan Live','concert',164,'Punjabi',8),(39,'Amit Trivedi Live','concert',177,'Hindi',8),(40,'Jubin Nautiyal Concert','concert',150,'Hindi',8),(41,'Jailer','movie',149,'Tamil',9),(42,'Salaar','movie',110,'Telugu',9),(43,'Indian 2','movie',135,'Tamil',9),(44,'Mad 2','movie',139,'telugu',9),(45,'Adipurush','movie',108,'Hindi',9),(46,'RRR','movie',111,'Telugu',10),(47,'Pathaan','movie',114,'Hindi',10),(48,'Kantara','movie',175,'Kannada',10),(49,'Baahubali 2','movie',117,'Telugu',10),(50,'Vikram Vedha','movie',116,'Hindi',10);
/*!40000 ALTER TABLE `bookings_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_organizer`
--

DROP TABLE IF EXISTS `bookings_organizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_organizer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `organizer_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organizer_name` (`organizer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_organizer`
--

LOCK TABLES `bookings_organizer` WRITE;
/*!40000 ALTER TABLE `bookings_organizer` DISABLE KEYS */;
INSERT INTO `bookings_organizer` VALUES (6,'Amanda Phillips'),(1,'Chase Bentley'),(10,'Christopher Perez'),(7,'James Bowman'),(8,'Kelly Sims'),(5,'Maria Taylor'),(3,'Martin Harper'),(2,'Mrs. Megan Hall'),(9,'Mrs. Rebecca Cross'),(4,'Vincent Valdez');
/*!40000 ALTER TABLE `bookings_organizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_screen`
--

DROP TABLE IF EXISTS `bookings_screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_screen` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `screen_name` varchar(100) NOT NULL,
  `total_seats` int unsigned NOT NULL,
  `theatre_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_screen_theatre_id_d927fdf0_fk_bookings_theatre_id` (`theatre_id`),
  CONSTRAINT `bookings_screen_theatre_id_d927fdf0_fk_bookings_theatre_id` FOREIGN KEY (`theatre_id`) REFERENCES `bookings_theatre` (`id`),
  CONSTRAINT `bookings_screen_chk_1` CHECK ((`total_seats` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_screen`
--

LOCK TABLES `bookings_screen` WRITE;
/*!40000 ALTER TABLE `bookings_screen` DISABLE KEYS */;
INSERT INTO `bookings_screen` VALUES (1,'me',97,1),(2,'owner',156,1),(3,'instead',190,1),(4,'effect',169,1),(5,'including',193,2),(6,'successful',156,2),(7,'security',95,2),(8,'among',183,3),(9,'similar',85,3),(10,'then',168,3),(11,'population',116,4),(12,'huge',114,4),(13,'war',177,4),(14,'major',169,4),(15,'reveal',54,4),(16,'group',74,4),(17,'large',74,5),(18,'long',174,5),(19,'serve',69,5),(20,'rule',132,5),(21,'team',162,6),(22,'debate',132,6),(23,'film',84,6),(24,'against',142,6),(25,'moment',197,6),(26,'prevent',181,7),(27,'certainly',69,7),(28,'never',200,7),(29,'choose',116,7),(30,'drop',93,7),(31,'garden',115,7),(32,'response',156,7),(33,'long',164,7),(34,'sign',126,8),(35,'say',56,8),(36,'contain',130,8),(37,'play',125,8),(38,'social',114,9),(39,'surface',147,9),(40,'picture',155,9),(41,'choose',106,10),(42,'smile',140,10),(43,'capital',192,10),(44,'answer',91,11),(45,'if',59,11),(46,'here',58,11),(47,'can',138,11),(48,'poor',146,11),(49,'other',91,11),(50,'surface',177,11),(51,'culture',156,11),(52,'country',51,11),(53,'often',65,11),(54,'across',189,12),(55,'type',163,12),(56,'alone',94,12),(57,'performance',94,12),(58,'receive',191,12),(59,'ahead',195,12),(60,'return',60,12),(61,'parent',90,12),(62,'trip',196,12),(63,'have',130,13),(64,'color',172,13),(65,'focus',134,13),(66,'job',55,13),(67,'process',136,13),(68,'hotel',143,13),(69,'peace',129,13),(70,'mouth',98,13),(71,'history',172,13),(72,'thing',73,13),(73,'beautiful',190,14),(74,'approach',132,14),(75,'management',58,14),(76,'whom',147,14),(77,'himself',168,14),(78,'throw',103,14),(79,'ok',148,15),(80,'test',51,15),(81,'close',101,15),(82,'treatment',81,15),(83,'such',68,15),(84,'within',76,15),(85,'discover',172,15),(86,'thousand',148,16),(87,'last',142,16),(88,'production',128,16),(89,'customer',190,17),(90,'area',105,17),(91,'option',144,17),(92,'if',92,17),(93,'walk',167,17),(94,'seat',185,17),(95,'pressure',179,17),(96,'certain',91,17),(97,'place',151,17),(98,'laugh',137,18),(99,'success',179,18),(100,'believe',79,18),(101,'loss',191,19),(102,'chair',199,19),(103,'everybody',95,19),(104,'adult',105,19),(105,'oil',56,19),(106,'anything',199,19),(107,'during',80,19),(108,'table',137,20),(109,'direction',161,20),(110,'degree',197,20),(111,'truth',131,20),(112,'too',66,20),(113,'bank',67,20),(114,'fill',71,20),(115,'international',144,21),(116,'window',67,21),(117,'city',88,21),(118,'job',77,21),(119,'who',186,21),(120,'whole',175,21),(121,'this',96,21),(122,'dream',139,21),(123,'book',197,21),(124,'run',164,21),(125,'increase',99,22),(126,'wait',66,22),(127,'go',54,22),(128,'call',83,23),(129,'study',192,23),(130,'later',62,23),(131,'impact',80,23),(132,'television',162,23),(133,'approach',146,23),(134,'another',161,23),(135,'prepare',113,23),(136,'away',191,24),(137,'red',88,24),(138,'artist',131,24),(139,'including',83,24),(140,'already',140,25),(141,'fund',141,25),(142,'recent',141,25),(143,'imagine',104,25),(144,'base',163,25),(145,'believe',138,25),(146,'set',92,26),(147,'trouble',187,26),(148,'far',123,26),(149,'attention',90,26),(150,'crime',169,26),(151,'because',112,26),(152,'cell',90,26),(153,'Mr',117,27),(154,'media',177,27),(155,'total',65,27),(156,'yet',192,27),(157,'dark',120,28),(158,'science',124,28),(159,'seven',178,28),(160,'southern',155,28),(161,'structure',71,28),(162,'us',55,28),(163,'cold',88,29),(164,'end',166,29),(165,'area',156,29),(166,'cause',166,29),(167,'walk',113,29),(168,'town',112,29),(169,'house',190,29),(170,'out',186,29),(171,'be',86,29),(172,'better',183,29),(173,'report',182,30),(174,'they',174,30),(175,'prepare',98,30),(176,'then',134,30),(177,'all',53,30),(178,'down',127,30),(179,'character',159,30),(180,'unit',164,30),(181,'eat',151,31),(182,'marriage',146,31),(183,'man',137,31),(184,'top',82,31),(185,'than',139,31),(186,'executive',80,31),(187,'present',124,31),(188,'particularly',110,31),(189,'drive',76,31),(190,'value',185,32),(191,'home',107,32),(192,'next',101,32),(193,'design',85,32),(194,'top',186,33),(195,'several',171,33),(196,'thousand',85,33),(197,'community',87,34),(198,'pressure',73,34),(199,'economic',199,34),(200,'film',113,34),(201,'capital',81,34),(202,'participant',62,34),(203,'range',99,34),(204,'such',97,34),(205,'course',146,35),(206,'agreement',135,35),(207,'model',104,35),(208,'interest',130,35),(209,'none',125,35),(210,'management',70,35),(211,'debate',181,35),(212,'for',152,35),(213,'view',64,35),(214,'rather',182,35);
/*!40000 ALTER TABLE `bookings_screen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_seat`
--

DROP TABLE IF EXISTS `bookings_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_seat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seat_number` varchar(10) NOT NULL,
  `tier_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookings_seat_seat_number_e4762d18_uniq` (`seat_number`),
  KEY `bookings_seat_tier_id_4ac26d2f_fk_bookings_tier_id` (`tier_id`),
  CONSTRAINT `bookings_seat_tier_id_4ac26d2f_fk_bookings_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `bookings_tier` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_seat`
--

LOCK TABLES `bookings_seat` WRITE;
/*!40000 ALTER TABLE `bookings_seat` DISABLE KEYS */;
INSERT INTO `bookings_seat` VALUES (4,'A1',1),(5,'A2',1),(6,'B1',2),(25,'Z1',1),(26,'X2',1),(27,'A3',1),(28,'Y1',2),(29,'B2',2),(30,'B3',2),(31,'C1',3),(32,'C2',3),(33,'C3',3),(34,'P1',1),(35,'P2',1),(36,'P3',1),(37,'P4',1),(38,'P5',1),(39,'P6',1),(40,'P7',1),(41,'P8',1),(42,'P9',1),(43,'P10',1),(44,'Q1',2),(45,'Q2',2),(46,'Q3',2),(47,'Q4',2),(48,'Q5',2),(49,'Q6',2),(50,'Q7',2),(51,'Q8',2),(52,'Q9',2),(53,'Q10',2),(54,'R1',3),(55,'R2',3),(56,'R3',3),(57,'R4',3),(58,'R5',3),(59,'R6',3),(60,'R7',3),(61,'R8',3),(62,'R9',3),(63,'R10',3),(64,'M1',4),(65,'M2',4),(66,'M3',4),(67,'M4',4),(68,'M5',4),(69,'M6',4),(70,'M7',4),(71,'M8',4),(72,'M9',4),(73,'M10',4),(74,'N1',5),(75,'N2',5),(76,'N3',5),(77,'N4',5),(78,'N5',5),(79,'N6',5),(80,'N7',5),(81,'N8',5),(82,'N9',5),(83,'N10',5);
/*!40000 ALTER TABLE `bookings_seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_showtime`
--

DROP TABLE IF EXISTS `bookings_showtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_showtime` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `show_date` date NOT NULL,
  `slot_time` time(6) NOT NULL,
  `available_seats` int unsigned NOT NULL,
  `event_id` bigint NOT NULL,
  `screen_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_showtime_event_id_6e7f8b54_fk_bookings_event_id` (`event_id`),
  KEY `bookings_showtime_screen_id_78497e60_fk_bookings_screen_id` (`screen_id`),
  CONSTRAINT `bookings_showtime_event_id_6e7f8b54_fk_bookings_event_id` FOREIGN KEY (`event_id`) REFERENCES `bookings_event` (`id`),
  CONSTRAINT `bookings_showtime_screen_id_78497e60_fk_bookings_screen_id` FOREIGN KEY (`screen_id`) REFERENCES `bookings_screen` (`id`),
  CONSTRAINT `bookings_showtime_chk_1` CHECK ((`available_seats` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_showtime`
--

LOCK TABLES `bookings_showtime` WRITE;
/*!40000 ALTER TABLE `bookings_showtime` DISABLE KEYS */;
INSERT INTO `bookings_showtime` VALUES (1,'2025-02-18','15:14:09.000000',75,1,207),(2,'2025-03-10','17:40:05.000000',50,1,22),(3,'2025-02-08','23:15:15.000000',68,1,195),(4,'2025-01-20','03:59:45.000000',16,1,44),(5,'2025-02-23','16:01:23.000000',45,1,111),(6,'2025-02-20','21:47:07.000000',32,1,209),(7,'2025-02-17','14:42:50.000000',92,2,172),(8,'2025-01-17','12:22:31.000000',29,2,31),(9,'2025-01-19','03:20:05.000000',35,2,202),(10,'2025-03-01','04:04:10.000000',17,3,171),(11,'2025-02-17','12:42:09.000000',40,3,191),(12,'2025-02-19','20:13:40.000000',91,3,131),(13,'2025-02-03','19:42:57.000000',48,3,168),(14,'2025-02-02','11:38:58.000000',13,4,49),(15,'2025-01-05','19:53:12.000000',44,4,25),(16,'2025-01-23','10:11:06.000000',51,4,197),(17,'2025-02-07','16:38:33.000000',85,5,90),(18,'2025-02-19','06:25:23.000000',61,5,167),(19,'2025-02-17','04:25:31.000000',19,5,20),(20,'2025-02-01','16:26:21.000000',19,5,69),(21,'2025-02-10','09:47:01.000000',94,5,109),(22,'2025-01-19','04:28:48.000000',54,5,15),(23,'2025-01-31','16:43:32.000000',71,5,122),(24,'2025-01-30','21:04:54.000000',49,5,166),(25,'2025-01-26','01:09:29.000000',35,5,67),(26,'2025-02-16','13:52:21.000000',47,6,119),(27,'2025-01-04','08:14:38.000000',53,6,189),(28,'2025-03-10','22:52:27.000000',45,6,213),(29,'2025-01-15','16:19:04.000000',97,6,206),(30,'2025-02-22','19:37:10.000000',56,6,148),(31,'2025-03-04','11:17:54.000000',51,6,97),(32,'2025-03-07','14:42:41.000000',63,7,75),(33,'2025-02-24','22:23:04.000000',48,7,205),(34,'2025-01-04','00:44:50.000000',97,7,96),(35,'2025-02-16','04:15:48.000000',64,7,121),(36,'2025-03-04','00:55:20.000000',82,7,141),(37,'2025-01-13','22:39:00.000000',32,7,75),(38,'2025-01-18','08:04:18.000000',38,7,37),(39,'2025-02-08','05:13:51.000000',32,7,128),(40,'2025-03-10','00:52:05.000000',91,7,3),(41,'2025-03-03','15:36:23.000000',56,7,154),(42,'2025-01-04','04:11:10.000000',48,8,84),(43,'2025-02-25','13:27:13.000000',56,8,88),(44,'2025-01-13','05:29:27.000000',24,8,184),(45,'2025-01-21','04:55:12.000000',28,9,148),(46,'2025-01-16','10:03:46.000000',49,9,197),(47,'2025-01-08','10:10:26.000000',87,9,84),(48,'2025-02-19','10:02:29.000000',54,9,213),(49,'2025-01-08','05:31:28.000000',38,9,172),(50,'2025-01-15','20:35:43.000000',55,10,130),(51,'2025-03-08','16:05:14.000000',27,10,118),(52,'2025-01-21','18:17:55.000000',47,10,70),(53,'2025-01-23','14:32:02.000000',30,10,174),(54,'2025-02-22','17:28:11.000000',78,10,125),(55,'2025-01-21','17:16:08.000000',31,10,138),(56,'2025-01-23','06:03:31.000000',97,10,212),(57,'2025-01-14','03:55:35.000000',89,11,108),(58,'2025-02-12','14:01:34.000000',72,11,37),(59,'2025-01-17','01:33:07.000000',22,11,157),(60,'2025-02-19','03:09:56.000000',22,11,190),(61,'2025-02-22','18:10:12.000000',22,11,157),(62,'2025-01-21','07:46:36.000000',35,11,141),(63,'2025-01-20','19:58:13.000000',26,11,21),(64,'2025-01-21','08:43:33.000000',61,11,157),(65,'2025-01-27','15:10:52.000000',36,11,143),(66,'2025-01-16','13:16:13.000000',71,12,21),(67,'2025-01-07','01:26:35.000000',64,12,28),(68,'2025-01-07','16:33:54.000000',33,12,211),(69,'2025-02-10','11:43:24.000000',74,12,41),(70,'2025-02-16','19:11:24.000000',12,12,85),(71,'2025-01-15','13:04:27.000000',23,12,68),(72,'2025-01-17','11:53:48.000000',28,12,158),(73,'2025-01-25','08:31:40.000000',28,12,213),(74,'2025-01-21','14:20:47.000000',90,13,72),(75,'2025-01-05','16:41:11.000000',31,13,64),(76,'2025-02-04','05:43:58.000000',55,13,87),(77,'2025-01-07','21:16:11.000000',98,13,94),(78,'2025-01-24','17:44:11.000000',16,13,184),(79,'2025-02-18','20:49:36.000000',94,13,205),(80,'2025-01-03','05:02:26.000000',14,13,130),(81,'2025-02-19','21:29:07.000000',76,14,51),(82,'2025-01-28','17:39:45.000000',34,14,57),(83,'2025-01-14','11:44:02.000000',70,14,70),(84,'2025-02-17','09:05:17.000000',50,14,168),(85,'2025-02-08','17:29:05.000000',42,14,80),(86,'2025-02-12','13:51:46.000000',51,14,213),(87,'2025-01-19','06:19:54.000000',49,14,201),(88,'2025-01-11','07:26:58.000000',67,14,150),(89,'2025-02-13','00:13:49.000000',40,15,53),(90,'2025-01-28','03:51:47.000000',88,15,201),(91,'2025-02-17','15:14:07.000000',35,15,103),(92,'2025-02-05','07:07:13.000000',12,15,76),(93,'2025-01-09','23:50:40.000000',57,15,2),(94,'2025-01-14','06:19:46.000000',82,15,194),(95,'2025-02-17','23:53:41.000000',35,15,194),(96,'2025-02-27','22:07:50.000000',49,15,21),(97,'2025-01-04','03:29:30.000000',88,15,125),(98,'2025-01-31','20:28:36.000000',31,15,188),(99,'2025-01-08','19:35:31.000000',47,16,79),(100,'2025-01-27','18:34:08.000000',63,16,116),(101,'2025-02-25','07:24:03.000000',14,16,10),(102,'2025-02-15','11:47:37.000000',60,17,92),(103,'2025-02-19','09:34:43.000000',44,17,63),(104,'2025-01-09','18:23:33.000000',45,17,124),(105,'2025-02-28','06:59:34.000000',94,17,209),(106,'2025-02-14','01:42:53.000000',74,18,97),(107,'2025-01-04','09:40:33.000000',40,18,200),(108,'2025-01-25','14:54:49.000000',87,18,32),(109,'2025-02-04','20:29:46.000000',64,18,59),(110,'2025-03-03','20:27:10.000000',57,18,206),(111,'2025-02-17','23:16:42.000000',79,18,74),(112,'2025-01-09','12:42:47.000000',53,18,183),(113,'2025-03-06','20:49:29.000000',13,18,9),(114,'2025-01-22','20:25:29.000000',10,18,24),(115,'2025-01-22','11:45:21.000000',59,19,87),(116,'2025-02-05','04:14:08.000000',95,19,41),(117,'2025-02-12','22:35:27.000000',60,19,196),(118,'2025-02-21','08:36:08.000000',24,19,177),(119,'2025-02-09','14:46:48.000000',36,19,79),(120,'2025-01-25','21:38:03.000000',47,20,50),(121,'2025-01-25','06:41:44.000000',96,20,213),(122,'2025-01-10','05:18:50.000000',26,20,126),(123,'2025-01-22','12:04:23.000000',76,21,188),(124,'2025-01-31','03:41:38.000000',20,21,120),(125,'2025-03-05','15:17:16.000000',59,21,13),(126,'2025-01-26','00:56:50.000000',14,21,3),(127,'2025-02-24','17:34:38.000000',43,21,46),(128,'2025-03-03','18:24:29.000000',91,21,182),(129,'2025-02-22','12:12:09.000000',75,21,129),(130,'2025-01-15','05:21:38.000000',33,22,10),(131,'2025-02-02','09:31:59.000000',60,22,2),(132,'2025-02-25','15:05:39.000000',12,22,63),(133,'2025-01-23','02:51:27.000000',21,22,193),(134,'2025-01-07','07:20:28.000000',80,22,119),(135,'2025-03-09','19:46:54.000000',16,23,183),(136,'2025-03-06','21:48:43.000000',24,23,59),(137,'2025-02-10','20:09:48.000000',91,23,8),(138,'2025-02-01','17:08:27.000000',51,23,108),(139,'2025-01-16','04:38:58.000000',14,23,177),(140,'2025-02-13','00:31:42.000000',29,23,151),(141,'2025-01-06','22:27:23.000000',77,23,98),(142,'2025-01-16','15:21:26.000000',53,24,71),(143,'2025-01-18','01:52:07.000000',20,24,16),(144,'2025-02-08','14:01:04.000000',84,24,126),(145,'2025-03-06','23:23:07.000000',13,25,48),(146,'2025-02-27','05:32:45.000000',97,25,151),(147,'2025-02-21','04:04:55.000000',32,25,104),(148,'2025-02-28','17:36:59.000000',75,25,94),(149,'2025-02-16','16:09:50.000000',55,25,174),(150,'2025-01-25','07:26:55.000000',78,25,123),(151,'2025-01-08','15:00:50.000000',22,25,25),(152,'2025-02-06','09:57:15.000000',52,25,108),(153,'2025-01-14','00:23:21.000000',29,25,210),(154,'2025-01-05','07:54:15.000000',100,26,182),(155,'2025-03-08','22:15:37.000000',38,26,132),(156,'2025-02-23','18:55:10.000000',72,26,163),(157,'2025-02-06','01:25:56.000000',33,26,118),(158,'2025-02-18','20:41:34.000000',63,27,169),(159,'2025-02-12','14:39:39.000000',88,27,61),(160,'2025-02-25','00:57:06.000000',16,27,76),(161,'2025-01-14','05:39:42.000000',28,27,68),(162,'2025-01-03','23:07:28.000000',17,27,140),(163,'2025-02-25','17:18:28.000000',49,27,78),(164,'2025-02-03','10:50:42.000000',84,27,59),(165,'2025-03-06','01:08:31.000000',14,28,46),(166,'2025-01-17','13:51:28.000000',27,28,174),(167,'2025-02-02','14:38:09.000000',95,28,38),(168,'2025-03-04','17:12:49.000000',14,28,190),(169,'2025-02-13','05:19:28.000000',93,28,148),(170,'2025-02-23','16:34:12.000000',25,29,140),(171,'2025-01-26','14:59:07.000000',22,29,86),(172,'2025-02-13','17:41:42.000000',39,29,75),(173,'2025-01-25','11:15:27.000000',91,29,103),(174,'2025-01-05','08:35:19.000000',60,29,4),(175,'2025-02-17','00:41:05.000000',83,30,155),(176,'2025-02-15','01:14:09.000000',59,30,88),(177,'2025-01-09','12:09:51.000000',98,30,30),(178,'2025-03-03','03:47:45.000000',39,30,95),(179,'2025-01-28','15:54:05.000000',71,30,169),(180,'2025-02-05','22:49:07.000000',29,30,144),(181,'2025-01-07','09:42:30.000000',10,30,94),(182,'2025-02-03','13:46:07.000000',79,30,186),(183,'2025-02-05','04:20:52.000000',59,30,122),(184,'2025-02-25','04:20:41.000000',63,30,81),(185,'2025-01-27','05:06:30.000000',11,31,128),(186,'2025-02-26','23:19:24.000000',92,31,152),(187,'2025-01-25','06:52:02.000000',16,31,101),(188,'2025-01-10','00:19:23.000000',45,31,160),(189,'2025-02-28','13:58:04.000000',30,32,153),(190,'2025-01-31','14:17:53.000000',84,32,8),(191,'2025-01-20','15:09:04.000000',96,32,105),(192,'2025-02-11','13:57:48.000000',30,32,191),(193,'2025-01-07','11:15:37.000000',78,33,70),(194,'2025-01-07','17:48:57.000000',47,33,154),(195,'2025-02-19','19:00:55.000000',12,33,185),(196,'2025-01-16','01:18:44.000000',71,33,35),(197,'2025-03-09','01:43:34.000000',45,33,211),(198,'2025-02-23','06:58:56.000000',94,33,181),(199,'2025-01-07','02:00:57.000000',95,33,29),(200,'2025-01-07','08:44:05.000000',53,33,27),(201,'2025-01-16','05:19:12.000000',67,34,2),(202,'2025-02-06','07:20:07.000000',89,34,27),(203,'2025-03-07','05:56:24.000000',90,34,49),(204,'2025-02-10','16:00:59.000000',22,34,160),(205,'2025-02-18','13:56:23.000000',26,34,165),(206,'2025-01-01','12:36:58.000000',88,34,162),(207,'2025-01-11','10:22:13.000000',69,35,207),(208,'2025-01-21','16:06:17.000000',68,35,26),(209,'2025-03-01','04:55:41.000000',10,35,95),(210,'2025-01-18','09:25:38.000000',49,35,106),(211,'2025-01-12','21:07:56.000000',48,35,67),(212,'2025-01-05','10:27:28.000000',59,35,207),(213,'2025-02-05','19:54:10.000000',59,35,140),(214,'2025-02-10','06:47:02.000000',85,35,86),(215,'2025-01-22','13:01:01.000000',17,35,4),(216,'2025-02-07','09:49:22.000000',57,35,93),(217,'2025-03-07','19:14:34.000000',74,36,170),(218,'2025-02-28','23:44:21.000000',15,36,179),(219,'2025-02-28','00:37:40.000000',53,36,161),(220,'2025-01-29','03:58:36.000000',66,36,193),(221,'2025-02-19','02:33:42.000000',59,36,46),(222,'2025-01-06','14:19:45.000000',57,36,47),(223,'2025-02-17','04:56:19.000000',33,37,176),(224,'2025-01-15','18:43:25.000000',58,37,140),(225,'2025-02-22','01:20:02.000000',86,37,214),(226,'2025-01-05','09:13:27.000000',47,37,96),(227,'2025-02-23','09:11:30.000000',51,37,24),(228,'2025-01-29','11:16:22.000000',81,38,25),(229,'2025-01-26','01:56:38.000000',85,38,86),(230,'2025-01-28','03:53:44.000000',10,38,36),(231,'2025-01-30','13:29:22.000000',27,38,165),(232,'2025-02-21','15:48:13.000000',45,38,128),(233,'2025-02-20','12:02:30.000000',34,38,146),(234,'2025-02-08','00:04:52.000000',15,38,75),(235,'2025-02-20','07:06:07.000000',36,38,196),(236,'2025-01-28','04:25:47.000000',29,38,151),(237,'2025-01-05','07:54:09.000000',49,38,136),(238,'2025-02-10','10:57:49.000000',10,39,98),(239,'2025-02-28','20:28:29.000000',84,39,20),(240,'2025-02-24','01:59:14.000000',52,39,53),(241,'2025-01-11','13:15:41.000000',88,39,137),(242,'2025-03-07','06:55:38.000000',10,39,19),(243,'2025-03-09','13:14:34.000000',14,39,164),(244,'2025-01-24','19:26:43.000000',10,39,134),(245,'2025-02-14','16:23:24.000000',33,39,7),(246,'2025-01-14','20:57:05.000000',58,39,9),(247,'2025-02-01','11:21:43.000000',92,40,194),(248,'2025-01-30','03:48:11.000000',39,40,192),(249,'2025-01-12','19:18:23.000000',16,40,71),(250,'2025-02-07','00:36:55.000000',21,40,120),(251,'2025-01-28','03:15:31.000000',60,40,102),(252,'2025-02-13','00:39:01.000000',71,40,126),(253,'2025-01-07','15:18:17.000000',79,41,75),(254,'2025-01-20','14:34:46.000000',67,41,108),(255,'2025-01-20','14:51:59.000000',90,41,99),(256,'2025-03-05','09:23:41.000000',65,41,26),(257,'2025-01-16','05:51:07.000000',18,41,26),(258,'2025-01-07','12:44:33.000000',79,41,102),(259,'2025-02-04','00:28:00.000000',91,41,35),(260,'2025-01-03','22:23:29.000000',30,41,128),(261,'2025-02-20','03:52:48.000000',88,41,84),(262,'2025-01-17','14:26:59.000000',54,41,184),(263,'2025-03-05','11:38:54.000000',89,42,46),(264,'2025-01-16','17:47:55.000000',92,42,54),(265,'2025-01-10','03:35:23.000000',74,42,112),(266,'2025-01-02','21:40:51.000000',82,42,34),(267,'2025-02-12','09:59:25.000000',43,42,154),(268,'2025-01-03','22:40:38.000000',20,42,153),(269,'2025-02-06','20:47:41.000000',20,42,78),(270,'2025-02-09','16:34:22.000000',75,43,5),(271,'2025-01-17','12:58:20.000000',68,43,90),(272,'2025-01-03','05:16:22.000000',19,43,61),(273,'2025-01-13','01:29:15.000000',61,43,175),(274,'2025-02-01','15:24:29.000000',68,44,61),(275,'2025-01-24','17:01:56.000000',67,44,73),(276,'2025-01-27','05:59:02.000000',15,44,30),(277,'2025-01-06','15:18:54.000000',95,44,44),(278,'2025-03-03','19:01:43.000000',25,44,37),(279,'2025-02-12','03:27:53.000000',21,44,142),(280,'2025-02-23','02:40:42.000000',47,44,111),(281,'2025-02-13','18:21:22.000000',58,45,106),(282,'2025-03-08','21:41:39.000000',78,45,170),(283,'2025-01-24','11:49:39.000000',27,45,88),(284,'2025-01-10','13:14:53.000000',20,45,127),(285,'2025-01-09','11:29:56.000000',67,45,202),(286,'2025-01-25','08:08:31.000000',19,45,193),(287,'2025-01-10','07:21:42.000000',12,45,74),(288,'2025-01-28','00:27:30.000000',76,45,139),(289,'2025-01-18','18:54:38.000000',35,45,21),(290,'2025-01-06','03:36:49.000000',21,46,83),(291,'2025-02-21','11:52:02.000000',49,46,210),(292,'2025-02-27','12:25:24.000000',28,46,17),(293,'2025-02-08','19:15:29.000000',54,46,60),(294,'2025-03-10','00:39:04.000000',69,46,116),(295,'2025-02-28','20:26:55.000000',53,46,135),(296,'2025-02-20','04:31:37.000000',57,46,139),(297,'2025-01-08','08:14:43.000000',18,46,31),(298,'2025-01-16','06:01:44.000000',45,47,17),(299,'2025-02-26','01:24:54.000000',69,47,118),(300,'2025-01-02','16:34:26.000000',78,47,88),(301,'2025-03-03','14:08:17.000000',74,47,159),(302,'2025-02-05','18:02:10.000000',81,47,92),(303,'2025-01-27','08:28:20.000000',68,47,133),(304,'2025-02-03','02:14:29.000000',17,47,184),(305,'2025-03-07','12:48:17.000000',24,47,10),(306,'2025-02-27','07:15:13.000000',61,47,160),(307,'2025-02-24','07:09:48.000000',35,47,195),(308,'2025-02-17','09:27:33.000000',43,48,22),(309,'2025-01-16','22:04:59.000000',44,48,123),(310,'2025-01-18','15:39:39.000000',40,48,55),(311,'2025-01-17','08:15:50.000000',75,48,133),(312,'2025-03-08','11:49:33.000000',83,48,53),(313,'2025-01-17','10:02:06.000000',95,48,114),(314,'2025-01-18','15:28:16.000000',14,48,2),(315,'2025-01-22','10:28:32.000000',36,48,61),(316,'2025-01-28','00:04:20.000000',79,48,172),(317,'2025-02-04','22:08:26.000000',40,48,118),(318,'2025-02-26','11:52:57.000000',98,49,37),(319,'2025-02-02','10:18:41.000000',90,49,138),(320,'2025-01-21','03:05:57.000000',22,49,5),(321,'2025-01-07','19:30:47.000000',19,49,31),(322,'2025-02-02','06:41:37.000000',72,49,126),(323,'2025-02-22','15:46:17.000000',28,49,103),(324,'2025-01-18','23:13:32.000000',65,49,67),(325,'2025-02-24','11:34:40.000000',39,50,155),(326,'2025-01-13','00:35:43.000000',32,50,8),(327,'2025-02-16','15:16:59.000000',78,50,91);
/*!40000 ALTER TABLE `bookings_showtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_theatre`
--

DROP TABLE IF EXISTS `bookings_theatre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_theatre` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `theatre_name` varchar(255) NOT NULL,
  `loc` varchar(255) NOT NULL,
  `total_screens` int unsigned NOT NULL,
  `city_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_theatre_city_id_95ab56bd_fk_bookings_city_id` (`city_id`),
  CONSTRAINT `bookings_theatre_city_id_95ab56bd_fk_bookings_city_id` FOREIGN KEY (`city_id`) REFERENCES `bookings_city` (`id`),
  CONSTRAINT `bookings_theatre_chk_1` CHECK ((`total_screens` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_theatre`
--

LOCK TABLES `bookings_theatre` WRITE;
/*!40000 ALTER TABLE `bookings_theatre` DISABLE KEYS */;
INSERT INTO `bookings_theatre` VALUES (1,'Dominguez-Gardner','29744 Erickson Bypass\nPort Lucaschester, PA 33673',4,1),(2,'Cooper-Anthony','067 Marshall Heights\nRickberg, PW 55147',3,1),(3,'Hall, Davis and Singleton','6698 Hernandez Motorway Apt. 949\nChristensenhaven, SC 26535',3,2),(4,'Stevenson-Young','2616 Rodriguez Stravenue Apt. 853\nGarrettburgh, KS 50786',6,2),(5,'Watkins-Reed','0645 Vaughn Greens\nEast Hectorburgh, KY 95485',4,2),(6,'Chan PLC','691 Jacqueline Inlet\nScottfurt, MA 18984',5,3),(7,'Brown Group','499 Humphrey Trace\nSouth Lindaside, DE 62423',8,3),(8,'Carr, Bates and Dawson','318 Kyle Pass Suite 975\nDrewland, MI 70674',4,3),(9,'Schultz-Watson','88694 Christina Plains Apt. 351\nNew Matthewfurt, CA 42642',3,4),(10,'Smith PLC','2391 Kristy Canyon Apt. 658\nPort Wesleyberg, PA 89132',3,4),(11,'Little-Cruz','Unit 4906 Box 0408\nDPO AE 95947',10,4),(12,'Jimenez-Jones','00024 Alyssa Extensions Apt. 422\nMichellehaven, GU 65725',9,4),(13,'Horton-Glover','451 Michelle Pass Suite 224\nNorth Robertview, VI 83745',10,5),(14,'Mccormick, Brown and Martin','6681 Kimberly Locks\nNathantown, RI 58356',6,5),(15,'Goodwin Ltd','369 Derrick Vista\nBucktown, MO 44662',7,5),(16,'Lewis-Brown','38606 Joseph Glens\nPenachester, NV 82277',3,5),(17,'Fields, Johnson and Pace','99832 Garcia Way Apt. 706\nAlyssaside, NY 03500',9,6),(18,'Vargas-Hubbard','Unit 9169 Box 1466\nDPO AA 92616',3,6),(19,'Woods LLC','59980 Wood Drive\nThomaschester, NV 33727',7,6),(20,'Simmons-Carey','069 Smith Knoll\nJasonville, NV 73130',7,7),(21,'Marshall-Davis','9591 Clark Island Suite 198\nNew Allison, TN 41351',10,7),(22,'Hunter LLC','59217 Perry Center\nPort Amy, ND 23120',3,7),(23,'Kramer, Gray and Stewart','2842 Rogers Unions Suite 081\nMichaelborough, RI 39057',8,7),(24,'Anderson-Hardy','66704 Lee Ports\nWest Brooke, MD 84203',4,7),(25,'Bennett Group','898 David Lock Apt. 548\nHurleyburgh, CO 92374',6,8),(26,'Meyer-Patel','473 Sandy Divide\nPort William, MP 37202',7,8),(27,'Pena-Dalton','11791 Traci Manors Suite 529\nSteventon, WY 05610',4,8),(28,'Hinton, Gordon and Taylor','015 Ross Gateway Apt. 838\nHicksland, AZ 80169',6,8),(29,'Sosa, Reed and Robinson','PSC 9890, Box 7691\nAPO AP 21760',10,9),(30,'Blankenship-Lin','79389 Walton Common Suite 206\nPort Samuel, IA 87423',8,9),(31,'Simpson, Schmidt and Mercado','447 Timothy Estates Apt. 602\nNew Robertborough, ND 35842',9,9),(32,'Stuart Inc','99180 Steven Lights\nGeraldmouth, DC 55427',4,10),(33,'Fowler and Sons','PSC 1644, Box 2142\nAPO AP 47116',3,10),(34,'Johnson Group','117 Krystal Station\nSmithfurt, MH 99554',8,10),(35,'Smith Group','661 Holt Trace\nGarciaton, OR 80592',10,10);
/*!40000 ALTER TABLE `bookings_theatre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_tier`
--

DROP TABLE IF EXISTS `bookings_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_tier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(10) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `screen_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_tier_screen_id_4b715857_fk_bookings_screen_id` (`screen_id`),
  CONSTRAINT `bookings_tier_screen_id_4b715857_fk_bookings_screen_id` FOREIGN KEY (`screen_id`) REFERENCES `bookings_screen` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_tier`
--

LOCK TABLES `bookings_tier` WRITE;
/*!40000 ALTER TABLE `bookings_tier` DISABLE KEYS */;
INSERT INTO `bookings_tier` VALUES (1,'Gold',500.00,1),(2,'Silver',300.00,1),(3,'VIP',500.00,1),(4,'Premium',350.00,1),(5,'Regular',200.00,1);
/*!40000 ALTER TABLE `bookings_tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_transaction`
--

DROP TABLE IF EXISTS `bookings_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `transaction_date` datetime(6) NOT NULL,
  `booking_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_transaction_booking_id_8a2915ee_fk_bookings_booking_id` (`booking_id`),
  CONSTRAINT `bookings_transaction_booking_id_8a2915ee_fk_bookings_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings_booking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_transaction`
--

LOCK TABLES `bookings_transaction` WRITE;
/*!40000 ALTER TABLE `bookings_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cancellations`
--

DROP TABLE IF EXISTS `cancellations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancellations` (
  `cancellation_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `cancel_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `refund_status` varchar(10) NOT NULL,
  PRIMARY KEY (`cancellation_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `cancellations_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  CONSTRAINT `cancellations_chk_1` CHECK ((`refund_status` in (_utf8mb4'processed',_utf8mb4'pending')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancellations`
--

LOCK TABLES `cancellations` WRITE;
/*!40000 ALTER TABLE `cancellations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cancellations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `city_id` int NOT NULL,
  `city_name` varchar(255) NOT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `phone_no` (`phone_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dates`
--

DROP TABLE IF EXISTS `dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dates` (
  `date_id` int NOT NULL AUTO_INCREMENT,
  `show_date` date DEFAULT NULL,
  PRIMARY KEY (`date_id`),
  UNIQUE KEY `show_date` (`show_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dates`
--

LOCK TABLES `dates` WRITE;
/*!40000 ALTER TABLE `dates` DISABLE KEYS */;
/*!40000 ALTER TABLE `dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-03-11 10:32:22.944446','3','1',3,'',4,1),(2,'2025-03-11 10:32:22.944527','5','1234',3,'',4,1),(3,'2025-03-11 10:32:22.944555','4','as',3,'',4,1),(4,'2025-03-11 10:32:22.944573','2','billy',3,'',4,1),(5,'2025-03-13 13:22:15.557467','3','hi8 - Programmable impactful task-force',3,'',11,1),(6,'2025-03-13 13:22:15.557526','2','hi5 - Advanced clear-thinking open architecture',3,'',11,1),(7,'2025-03-13 13:22:15.557554','1','hi4 - Polarized interactive architecture',3,'',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(16,'bookings','admin'),(11,'bookings','booking'),(15,'bookings','cancellation'),(17,'bookings','city'),(9,'bookings','customer'),(21,'bookings','date'),(7,'bookings','event'),(12,'bookings','organizer'),(8,'bookings','screen'),(10,'bookings','seat'),(18,'bookings','showtime'),(14,'bookings','theatre'),(19,'bookings','tier'),(13,'bookings','transaction'),(22,'bookings','uniqueseatbooking'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(20,'users','customer');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-03-10 17:45:36.631155'),(2,'auth','0001_initial','2025-03-10 17:45:37.088977'),(3,'admin','0001_initial','2025-03-10 17:45:37.208537'),(4,'admin','0002_logentry_remove_auto_add','2025-03-10 17:45:37.219870'),(5,'admin','0003_logentry_add_action_flag_choices','2025-03-10 17:45:37.230884'),(6,'contenttypes','0002_remove_content_type_name','2025-03-10 17:45:37.306927'),(7,'auth','0002_alter_permission_name_max_length','2025-03-10 17:45:37.355820'),(8,'auth','0003_alter_user_email_max_length','2025-03-10 17:45:37.380173'),(9,'auth','0004_alter_user_username_opts','2025-03-10 17:45:37.387773'),(10,'auth','0005_alter_user_last_login_null','2025-03-10 17:45:37.435596'),(11,'auth','0006_require_contenttypes_0002','2025-03-10 17:45:37.440971'),(12,'auth','0007_alter_validators_add_error_messages','2025-03-10 17:45:37.453421'),(13,'auth','0008_alter_user_username_max_length','2025-03-10 17:45:37.508532'),(14,'auth','0009_alter_user_last_name_max_length','2025-03-10 17:45:37.568157'),(15,'auth','0010_alter_group_name_max_length','2025-03-10 17:45:37.586951'),(16,'auth','0011_update_proxy_permissions','2025-03-10 17:45:37.595870'),(17,'auth','0012_alter_user_first_name_max_length','2025-03-10 17:45:37.647062'),(18,'sessions','0001_initial','2025-03-10 17:45:37.675005'),(19,'bookings','0001_initial','2025-03-11 08:44:11.048738'),(20,'bookings','0002_customer_uuser','2025-03-11 10:09:07.932668'),(21,'bookings','0003_rename_uuser_customer_user','2025-03-11 10:10:58.650048'),(22,'users','0001_initial','2025-03-11 10:15:06.217292'),(23,'users','0002_customer_user','2025-03-11 10:18:17.892621'),(24,'users','0003_alter_customer_user','2025-03-11 10:19:37.197965'),(25,'users','0004_alter_customer_phone_no','2025-03-11 10:24:24.122353'),(26,'bookings','0004_alter_seat_seat_number_alter_seat_status','2025-03-12 07:10:38.413600'),(27,'bookings','0005_alter_seat_tier','2025-03-12 07:23:43.968286'),(28,'bookings','0006_booking_user_alter_screen_theatre','2025-03-13 14:16:04.534219'),(29,'bookings','0002_alter_uniqueseatbooking_unique_together_and_more','2025-03-16 15:53:59.917101'),(30,'bookings','0003_rename_showtime_uniqueseatbooking_show','2025-03-17 10:59:26.210528'),(31,'bookings','0004_alter_uniqueseatbooking_show','2025-03-17 10:59:26.214759'),(32,'bookings','0005_remove_uniqueseatbooking_city_and_more','2025-03-17 11:31:53.511866'),(33,'bookings','0006_auto_20250317_1131','2025-03-17 11:31:53.515055');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ca1w80ochs8jyrn9y4qirbbkzrohu78s','.eJxVjsEOgjAQRP-lZ9Ok3YWCR-9-Q7PsbgUlkNByMMZ_FyIHvc6beZmXibSWPq5ZlziIORsXzOk37IgfOu1E7jTdZsvzVJahs3vFHjTb6yw6Xo7un6Cn3G_rtnItKgpoIkkJxSUONbKHDtAhMTUK3rcMwUMtAUAIKkTwGBga3KRZR-WiEnkoz-9bNO8PdDM_Vg:1tu8rd:MaW-qCjHzluQ4r3Z6LZS4k14t504EhCl1HaZjr3v23I','2025-03-31 11:42:37.555930'),('cjir79aq87gk06vnzy4hb18y176i3lg3','.eJxVjEEOwiAQRe_C2hAoyKBL9z0DGWZAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hYnEVWpx-t4j0THUH_MB6b5JaXeYpyl2RB-1ybJxet8P9OyjYy1ZTZB48GnDkY86YLDptNZB1SilvMidQGhU68NacN24yAgxIni-skvh8AfrvOFQ:1tsiVT:O86pCk9byfqLkzQcLAJdDf_Kf9Djv49NrfxMbpvOW3c','2025-03-27 13:21:51.389943'),('eogiwy9d6wp8qozm9mv7jelqlbgby7z8','.eJxVjEEOwiAQRe_C2hAoyKBL9z0DGWZAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hYnEVWpx-t4j0THUH_MB6b5JaXeYpyl2RB-1ybJxet8P9OyjYy1ZTZB48GnDkY86YLDptNZB1SilvMidQGhU68NacN24yAgxIni-skvh8AfrvOFQ:1tt4md:YeU9VfS_D-iS9403atdtTgVETfGcLxHEnsIjmbdLrCM','2025-03-28 13:09:03.217432'),('f8ovug523h5wstzs77egb7rseyeh5r32','.eJxVjDsOwjAQBe_iGllm8S-U9DmDtbu2cQDZUpxUiLuTSCmgnZn33iLgupSw9jSHKYqrMOL0ywj5meou4gPrvUludZknknsiD9vl2GJ63Y7276BgL9vaMhFH6xQDODuwSRmy16iGs9UaAY2n6LUDJNIXcJS8QSCfMW8sK_H5AvKBOF4:1trwt6:X1_U6sWGOR9lbJBJnUNJ1f6ECfmP_HrlYR-q_9atYM8','2025-03-25 10:31:04.874317'),('mfv4iaq3ifkq2tyw1ju9j363a1wkfi1a','.eJxVjsEKwjAQRP8lZwmJmyaNR-9-Q9jsrrZaWmjSg4j_bos96G2YNzzmpRIutUtLkTn1rE7KenX4LTPSQ8aN8B3H26RpGuvcZ71N9E6Lvkwsw3nf_gk6LN3mdSAmRmxNAIAr5sZyazGHIETgDTow4hHX1GTHbqWeIdDReoqhtau0yCBUhRP19fl9G9X7A1UzP0g:1tsjTz:gp75FLVM8yg4WYrVfdaj0DVZAIDF3HIlemQBiYJT5_s','2025-03-27 14:24:23.468229'),('xxbwsigeds72y5sc98fjsalnvkmffpzh','.eJxVjEEOwiAQRe_C2hAoyKBL9z0DGWZAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hYnEVWpx-t4j0THUH_MB6b5JaXeYpyl2RB-1ybJxet8P9OyjYy1ZTZB48GnDkY86YLDptNZB1SilvMidQGhU68NacN24yAgxIni-skvh8AfrvOFQ:1tsdc9:DFJ0O1FJmydTd5VUjFltXB3pFHKmbsP9emP8k3prK3g','2025-03-27 08:08:25.771556'),('zkmb87ucj9pzss30ahjrpqbnl4tfgz4a','.eJxVjEEOwiAQRe_C2hAoyKBL9z0DGWZAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hYnEVWpx-t4j0THUH_MB6b5JaXeYpyl2RB-1ybJxet8P9OyjYy1ZTZB48GnDkY86YLDptNZB1SilvMidQGhU68NacN24yAgxIni-skvh8AfrvOFQ:1tsGNq:Z4S6HkNHUobvLc7Of3z4abSS32JCHN51Fyts5PiU3CE','2025-03-26 07:20:06.602341');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `event_type` varchar(10) NOT NULL,
  `duration` int DEFAULT NULL,
  `lang` varchar(50) NOT NULL,
  `organizer_id` int NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `organizer_id` (`organizer_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`organizer_id`) REFERENCES `organizers` (`organizer_id`),
  CONSTRAINT `events_chk_1` CHECK ((`event_type` in (_utf8mb4'movie',_utf8mb4'concert'))),
  CONSTRAINT `events_chk_2` CHECK ((`duration` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizers`
--

DROP TABLE IF EXISTS `organizers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizers` (
  `organizer_id` int NOT NULL,
  `organizer_name` varchar(255) NOT NULL,
  PRIMARY KEY (`organizer_id`),
  UNIQUE KEY `organizer_name` (`organizer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizers`
--

LOCK TABLES `organizers` WRITE;
/*!40000 ALTER TABLE `organizers` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `screens` (
  `screen_id` int NOT NULL,
  `theatre_id` int NOT NULL,
  `screen_name` varchar(100) NOT NULL,
  `total_seats` int DEFAULT NULL,
  PRIMARY KEY (`screen_id`),
  KEY `theatre_id` (`theatre_id`),
  CONSTRAINT `screens_ibfk_1` FOREIGN KEY (`theatre_id`) REFERENCES `theatres` (`theatre_id`),
  CONSTRAINT `screens_chk_1` CHECK ((`total_seats` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
  `seat_id` int NOT NULL,
  `tier_id` int NOT NULL,
  `seat_number` int NOT NULL,
  `stat` varchar(10) NOT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `tier_id` (`tier_id`),
  CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`tier_id`) REFERENCES `tiers` (`tier_id`),
  CONSTRAINT `seats_chk_1` CHECK ((`seat_number` > 0)),
  CONSTRAINT `seats_chk_2` CHECK ((`stat` in (_utf8mb4'available',_utf8mb4'booked')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showtimes`
--

DROP TABLE IF EXISTS `showtimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showtimes` (
  `show_id` int NOT NULL,
  `event_id` int NOT NULL,
  `screen_id` int NOT NULL,
  `show_date` date NOT NULL,
  `slot_time` time NOT NULL,
  `available_seats` int DEFAULT NULL,
  PRIMARY KEY (`show_id`),
  KEY `event_id` (`event_id`),
  KEY `screen_id` (`screen_id`),
  CONSTRAINT `showtimes_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  CONSTRAINT `showtimes_ibfk_2` FOREIGN KEY (`screen_id`) REFERENCES `screens` (`screen_id`),
  CONSTRAINT `showtimes_chk_1` CHECK ((`available_seats` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showtimes`
--

LOCK TABLES `showtimes` WRITE;
/*!40000 ALTER TABLE `showtimes` DISABLE KEYS */;
/*!40000 ALTER TABLE `showtimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theatres`
--

DROP TABLE IF EXISTS `theatres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theatres` (
  `theatre_id` int NOT NULL,
  `city_id` int NOT NULL,
  `theatre_name` varchar(255) NOT NULL,
  `loc` varchar(255) NOT NULL,
  `total_screens` int DEFAULT NULL,
  PRIMARY KEY (`theatre_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `theatres_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`),
  CONSTRAINT `theatres_chk_1` CHECK ((`total_screens` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theatres`
--

LOCK TABLES `theatres` WRITE;
/*!40000 ALTER TABLE `theatres` DISABLE KEYS */;
/*!40000 ALTER TABLE `theatres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiers`
--

DROP TABLE IF EXISTS `tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiers` (
  `tier_id` int NOT NULL,
  `screen_id` int NOT NULL,
  `tier_name` varchar(10) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`tier_id`),
  KEY `screen_id` (`screen_id`),
  CONSTRAINT `tiers_ibfk_1` FOREIGN KEY (`screen_id`) REFERENCES `screens` (`screen_id`),
  CONSTRAINT `tiers_chk_1` CHECK ((`tier_name` in (_utf8mb4'Platinum',_utf8mb4'Gold',_utf8mb4'Silver'))),
  CONSTRAINT `tiers_chk_2` CHECK ((`price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiers`
--

LOCK TABLES `tiers` WRITE;
/*!40000 ALTER TABLE `tiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `transaction_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  CONSTRAINT `transactions_chk_1` CHECK ((`amount_paid` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unique_seat_booking`
--

DROP TABLE IF EXISTS `unique_seat_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unique_seat_booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` varchar(20) NOT NULL,
  `unique_seat_id` varchar(255) DEFAULT NULL,
  `city_id` int NOT NULL,
  `event_id` int NOT NULL,
  `screen_id` int NOT NULL,
  `seat_id` int NOT NULL,
  `show_id` int NOT NULL,
  `tier_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_seat_id` (`unique_seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unique_seat_booking`
--

LOCK TABLES `unique_seat_booking` WRITE;
/*!40000 ALTER TABLE `unique_seat_booking` DISABLE KEYS */;
INSERT INTO `unique_seat_booking` VALUES (5,'2025-03-22','6-None-None-29-173-2025-03-22-2-48',6,29,1,48,173,2);
/*!40000 ALTER TABLE `unique_seat_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customer`
--

DROP TABLE IF EXISTS `users_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) NOT NULL,
  `email_id` varchar(254) NOT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_customer_user_id_a09bb4be_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customer`
--

LOCK TABLES `users_customer` WRITE;
/*!40000 ALTER TABLE `users_customer` DISABLE KEYS */;
INSERT INTO `users_customer` VALUES (1,'billy_56','billyboy18497@gmail.com',NULL,1),(6,'hello','hello@1',NULL,6),(7,'hi1','hi@1',NULL,8),(8,'hi2','hi@2',NULL,9),(9,'hi3','hi@3',NULL,10),(10,'hi4','hi@4',NULL,11),(11,'hi5','hi@5',NULL,12),(12,'hi6','hi@6',NULL,13),(13,'hi8','hi@8',NULL,14),(14,'hi9','hi@9',NULL,15),(15,'hi10','hi@10',NULL,16),(16,'hi11','hi@11',NULL,17);
/*!40000 ALTER TABLE `users_customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-28  0:27:47

-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: myfirsttrial
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `department` varchar(45) NOT NULL,
  `grade` varchar(10) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  `adress` varchar(100) DEFAULT NULL,
  `gpa` double DEFAULT NULL,
  `isActive` tinyint NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Mehmet Utku','Meşe','male','software engineering','3/4','mutkumese@gmail.com','05060513419','merkezefendi mahallesi çiek sokak no:19/ Denizli',2.89,1,'https://avatars.githubusercontent.com/u/94257756?v=4'),(2,'Aslı','Aslan','famale','compiter engineering','2/4','aslııa@hotmail.com','05467596812','istanbul esenler çiçiek sokak no:32',3.02,1,NULL),(3,'Talha','Gedik','male','compiter engineering','1/4',NULL,'05124566846','kemalpaşa mahallesi çiçiek sokak no:2',2.12,1,'https://avatars.githubusercontent.com/u/17102578?v=4'),(4,'Murat Han','Dikmen','male','bialogy','6/4','hanmurat@gmail.com','04569152418','asrın mahallesi 169/4 sokak no:14 kat: 2',1.87,0,NULL),(5,'İlayda','Can','famale','software engineering','1/4','iloo@gmail.com','05462586149','sürsürü mahallesi 158 sokak no:6 kat:5/ Elazığ',3.22,1,'https://media.licdn.com/dms/image/D4D03AQGPqW2lSvqedg/profile-displayphoto-shrink_400_400/0/1685549565513?e=1699488000&v=beta&t=gZvhi955xXWk_L4g_X8foEedZrq1sziXetwf96Jiu_o'),(6,'Tahsin','Küçük',NULL,'medicine','2/5',NULL,NULL,NULL,NULL,1,NULL),(7,'Kerime','Mala',NULL,'Mecatronic Engineering','1/4',NULL,NULL,NULL,NULL,1,NULL),(8,'Kamil','Keskin',NULL,'Mecatronic Engineering','4/4','kamile@windows.com',NULL,NULL,NULL,1,NULL),(9,'Aslı Han','Nural',NULL,'Electronic','1/4',NULL,NULL,NULL,NULL,1,NULL),(11,'Doğukan','Yaşar','male','Software Engineer','3/4','dogukan35@gmail.com','06589457315','buca ahmetpaşa mahallesi 35 sokak no:35/İzmir',3.08,1,'https://avatars.githubusercontent.com/u/95578982?v=4'),(12,'Yeşim','Yıldırım','famale','Dentistry','4/5',NULL,'05468594785','kiremitçi mahallesi 458 sokak no:8 /Burdur',2.2,1,'https://randomuser.me/api/portraits/women/43.jpg'),(13,'Ahmet','Baz','male','Civil Engineering','1/4',NULL,'05468543458','sultan mahallesi rait sokak no:7 /Burdur',2.8,1,'https://randomuser.me/api/portraits/men/14.jpg'),(31,'nurdane','özhan','famale','Pharmacy','5/5','nurdaneoz@gmail.com','04891558354',NULL,3.7,1,NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-14 19:20:53

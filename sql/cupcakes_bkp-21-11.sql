-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cupcakestore
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `costumer_orders`
--

DROP TABLE IF EXISTS `costumer_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `costumer_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `costumers_id` int(11) NOT NULL,
  `total_amount` decimal(10,0) NOT NULL,
  `status` enum('Pending','Paid','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
  `date_registry` varchar(45) DEFAULT NULL,
  `costumers_orderscol` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_costumers_orders_costumers1_idx` (`costumers_id`),
  CONSTRAINT `fk_costumers_orders_costumers1` FOREIGN KEY (`costumers_id`) REFERENCES `costumers` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costumer_orders`
--

LOCK TABLES `costumer_orders` WRITE;
/*!40000 ALTER TABLE `costumer_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `costumer_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `costumers`
--

DROP TABLE IF EXISTS `costumers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `costumers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `date_registry` datetime DEFAULT current_timestamp(),
  `date_modify` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costumers`
--

LOCK TABLES `costumers` WRITE;
/*!40000 ALTER TABLE `costumers` DISABLE KEYS */;
INSERT INTO `costumers` VALUES (3,'Jansen','Lira','jan100sys@gmail.com','(61) 99929-9906','$2y$10$Uz38ur95Zgw1AtLy5UZY1OgMKgYGFVHpjNInIpyvQY7kBt7TqJccS','2024-11-20 11:50:07',NULL),(6,'Jan','Li','ead.etg@gmail.com','(61) 99999-9999','$2y$10$JEzbjSA3J19uSKqvVZn3debbfr3LvIcYTlHtjr.lZoStwCTcZDCoq','2024-11-21 10:31:03',NULL);
/*!40000 ALTER TABLE `costumers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES (0,'manager','$2y$10$NfpQXz97GS0Qd8NqrRFxE.rgmCdwnlBoU2VRyYZKjR5NeWEXkwxUK');
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(4) DEFAULT NULL,
  `price_unit` decimal(5,2) DEFAULT NULL,
  `products_id` int(11) NOT NULL,
  `costumer_orders_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_order_items_products1_idx` (`products_id`),
  KEY `fk_order_items_costumer_orders1_idx` (`costumer_orders_id`),
  CONSTRAINT `fk_order_items_costumer_orders1` FOREIGN KEY (`costumer_orders_id`) REFERENCES `costumer_orders` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` varchar(200) NOT NULL,
  `code` varchar(45) NOT NULL,
  `short` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(5,2) NOT NULL,
  `date_registry` datetime DEFAULT current_timestamp(),
  `date_modify` datetime DEFAULT NULL,
  `published` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `product_UNIQUE` (`product`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Cupcake de Amarula','cp001','','Lorem',19.79,NULL,NULL,0),(2,'Café Colonial','cp002','','<div><b>Teste dddd</b>vvvvv</div>',5.56,NULL,NULL,0),(12,'Chocolate Dark','cp012','','<div>Choco</div>',23.45,NULL,NULL,0),(13,'Baunilha','cp013','','<div>Teste</div>',16.00,NULL,NULL,0),(26,'Ovomaltine','ovomaltine','9 unidades','<div><br></div>',21.60,NULL,NULL,0),(27,'Chocolate com Morango','manga','9 unidades','<div><br></div>',23.00,NULL,NULL,0),(29,'Floresta Negra','choloco','Texto descritivo','',23.78,'2024-11-17 18:47:38',NULL,0),(30,'Nutella','franciscano','9 unidades','',17.50,'2024-11-18 15:27:32',NULL,0),(31,'Natalino','navegador','9 unidades','',20.45,'2024-11-18 15:28:09',NULL,0),(32,'Amor em pedaços','amor-em-pedacos','','',18.78,'2024-11-18 15:28:41',NULL,0),(33,'Romeu e Julieta','romeu-e-julieta','9 unidades','<div><span style=\"font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">Surpreenda seu paladar com o nosso irresistível </span><strong style=\"font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Cupcake</strong><span style=\"font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">! Feito com uma massa macia e aveludada, sua textura única combina perfeitamente com o recheio cremoso</span><i style=\"font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;</i><span style=\"font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">e um toque de sabor único. Coberto por uma delicada cobertura artesanal, este cupcake é decorado perfeitamente para um acabamento perfeito. Produzido com ingredientes selecionados e de alta qualidade, farinha especial e ovos frescos, ele é a escolha ideal para momentos especiais ou simplesmente para adoçar o seu dia.&nbsp;</span><span style=\"font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">Experimente agora e encante-se!</span></div><div><div><b><br></b></div><div><b>Contém:</b>&nbsp;</div><div>9 unidades.</div><div><br></div></div><div><div><strong>Ingredientes:</strong><br>Farinha de trigo enriquecida com ferro e ácido fólico, açúcar, manteiga, ovos, cacau em pó, creme de leite fresco, cream cheese, chocolate branco, essência de baunilha, fermento químico (bicarbonato de sódio, pirofosfato de sódio, amido de milho), corante alimentício vermelho, sal.</div><div><br></div><div><strong>Alérgicos:</strong> Contém derivados de trigo, leite, ovos e soja. Pode conter traços de castanhas.</div></div>',20.45,'2024-11-18 15:29:11',NULL,0),(34,'Capuccino','capuccino','','',21.00,'2024-11-18 20:54:33',NULL,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_images`
--

DROP TABLE IF EXISTS `products_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `url_image` varchar(255) NOT NULL,
  `date_upload` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `products_id` (`products_id`),
  CONSTRAINT `products_images_ibfk_1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_images`
--

LOCK TABLES `products_images` WRITE;
/*!40000 ALTER TABLE `products_images` DISABLE KEYS */;
INSERT INTO `products_images` VALUES (18,33,'33_673bc80fb1145.jpg','2024-11-18 20:04:47'),(19,1,'1_673bc881063d0.jpeg','2024-11-18 20:06:41'),(20,2,'2_673bc8f2deef3.jpg','2024-11-18 20:08:35'),(21,27,'27_673bca3c930b3.JPG','2024-11-18 20:14:04'),(22,26,'26_673bcae201b0a.jpg','2024-11-18 20:16:50'),(23,12,'12_673bcce7a7e96.jpg','2024-11-18 20:25:27'),(24,13,'13_673bd188cb860.jpeg','2024-11-18 20:45:13'),(25,29,'29_673bd1ff8cd3a.jpeg','2024-11-18 20:47:11'),(26,30,'30_673bd2832328d.jpeg','2024-11-18 20:49:23'),(27,32,'32_673bd2ebb4bda.jpeg','2024-11-18 20:51:07'),(29,34,'34_673bd3b98c402.jpg','2024-11-18 20:54:33'),(30,31,'31_673f4567397a6.jpg','2024-11-21 11:36:23'),(31,31,'31_673f45ad92576.jpg','2024-11-21 11:37:33');
/*!40000 ALTER TABLE `products_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_products_images`
--

DROP TABLE IF EXISTS `view_products_images`;
/*!50001 DROP VIEW IF EXISTS `view_products_images`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_products_images` AS SELECT 
 1 AS `id`,
 1 AS `product`,
 1 AS `code`,
 1 AS `short`,
 1 AS `description`,
 1 AS `price`,
 1 AS `date_registry`,
 1 AS `date_modify`,
 1 AS `published`,
 1 AS `url_image`,
 1 AS `images_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'cupcakestore'
--

--
-- Dumping routines for database 'cupcakestore'
--

--
-- Final view structure for view `view_products_images`
--

/*!50001 DROP VIEW IF EXISTS `view_products_images`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_products_images` AS select `p`.`id` AS `id`,`p`.`product` AS `product`,`p`.`code` AS `code`,`p`.`short` AS `short`,`p`.`description` AS `description`,`p`.`price` AS `price`,`p`.`date_registry` AS `date_registry`,`p`.`date_modify` AS `date_modify`,`p`.`published` AS `published`,min(`pi`.`url_image`) AS `url_image`,`pi`.`id` AS `images_id` from (`products` `p` left join `products_images` `pi` on(`p`.`id` = `pi`.`products_id`)) group by `p`.`id`,`p`.`product` */;
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

-- Dump completed on 2024-11-21 17:45:51

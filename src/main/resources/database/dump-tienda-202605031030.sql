/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: tienda
-- ------------------------------------------------------
-- Server version	12.1.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `edad_recomendada` int(11) NOT NULL,
  `descuento_base` decimal(5,2) NOT NULL DEFAULT 0.00,
  `fecha_creacion` date NOT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES
(1,'Acción','Videojuegos de acción y aventura',16,5.00,'2026-03-23',1),
(2,'Deportes','Videojuegos deportivos',7,10.00,'2026-03-23',1),
(3,'RPG','Juegos de rol y mundo abierto',18,7.50,'2026-03-23',1),
(4,'Accion','Videojuegos de combate, aventura y ritmo rapido.',16,5.00,'2026-01-01',1),
(5,'Aventura','Juegos centrados en exploracion, historia y descubrimiento.',12,3.00,'2026-01-01',1),
(6,'Deportes','Videojuegos de futbol, baloncesto, motor y otras disciplinas.',3,2.50,'2026-01-01',1),
(7,'Rol','Juegos con progresion de personajes, misiones y toma de decisiones.',12,4.00,'2026-01-01',1),
(8,'Estrategia','Juegos de gestion, tactica y planificacion.',7,6.00,'2026-01-01',1),
(9,'Terror','Videojuegos de suspense, supervivencia y miedo.',18,8.00,'2026-01-01',1),
(11,'Puzzles','',3,1.00,'2026-05-02',0);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(30) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `pagado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_pedido` date NOT NULL,
  `cantidad_articulos` int(11) NOT NULL DEFAULT 1,
  `id_usuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_pedido`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `fk_pedido_usuario` (`id_usuario`),
  CONSTRAINT `fk_pedido_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES
(1,'PED001',59.99,1,'2026-03-23',1,2),
(2,'PED002',109.94,0,'2026-03-23',2,3),
(3,'PED-2026-0001',59.99,1,'2026-03-10',1,1),
(4,'PED-2026-0002',64.98,1,'2026-03-12',2,2),
(5,'PED-2026-0003',69.99,0,'2026-03-15',1,3),
(6,'PED-2026-0004',109.98,1,'2026-03-20',2,1),
(7,'PED-2026-0005',29.99,0,'2026-03-25',1,5),
(8,'PED-2026-0006',129.98,1,'2026-04-02',2,2),
(9,'PED-2026-0007',13.99,1,'2026-04-05',1,3),
(10,'PED-2026-0008',89.98,0,'2026-04-12',2,1);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(20) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `saldo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `fecha_registro` date NOT NULL,
  `rol` varchar(20) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(1,'Administrador','admin@tienda.com','admin123','600111111',100.00,'2026-03-23','admin',1),
(2,'Carlos Pérez','carlos@tienda.com','carlos123','600222222',50.50,'2026-03-23','cliente',1),
(3,'Lucía Martín','lucia@tienda.com','lucia123','600333333',25.75,'2026-03-23','cliente',1),
(4,'Juan Perez','juan.perez@email.com','1234','600111222',120.50,'2026-01-10','CLIENTE',1),
(5,'Laura Sanchez','laura.sanchez@email.com','1234','600333444',75.00,'2026-01-15','CLIENTE',1),
(6,'Carlos Martin','carlos.martin@email.com','1234','600555666',0.00,'2026-02-01','CLIENTE',1),
(7,'Ana Lopez','ana.lopez@email.com','1234','600777888',250.99,'2026-02-18','ADMIN',1),
(8,'Marta Diaz','marta.diaz@email.com','1234','600999000',35.75,'2026-03-05','CLIENTE',0);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videojuego`
--

DROP TABLE IF EXISTS `videojuego`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `videojuego` (
  `id_videojuego` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(120) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `destacado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_lanzamiento` date NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `id_categoria` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_videojuego`),
  KEY `fk_videojuego_categoria` (`id_categoria`),
  CONSTRAINT `fk_videojuego_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videojuego`
--

LOCK TABLES `videojuego` WRITE;
/*!40000 ALTER TABLE `videojuego` DISABLE KEYS */;
INSERT INTO `videojuego` VALUES
(2,'FIFA 25','Simulador de fútbol',69.99,'fifa25.jpg',0,'2025-09-20',15,2),
(3,'The Witcher 3','RPG de fantasía',39.95,'witcher3.jpg',1,'2015-05-19',8,3),
(4,'Elden Ring','RPG de mundo abierto con exploracion, combate y fantasia oscura.',59.99,'elden-ring.jpg',1,'2022-02-25',12,4),
(5,'The Legend of Zelda: Breath of the Wild','Aventura de mundo abierto centrada en exploracion y libertad.',49.99,'zelda-botw.jpg',1,'2017-03-03',8,11),
(6,'EA Sports FC 26','Simulador de futbol con modos online y competiciones.',69.99,'ea-sports-fc-26.jpg',1,'2025-09-26',20,2),
(7,'Hollow Knight','Aventura de accion en 2D con exploracion y dificultad progresiva.',14.99,'hollow-knight.jpg',0,'2017-02-24',15,5),
(8,'Resident Evil 4 Remake','Juego de terror y accion con mecanicas de supervivencia.',39.99,'resident-evil-4-remake.jpg',1,'2023-03-24',10,6),
(9,'Civilization VI','Juego de estrategia por turnos basado en gestion de civilizaciones.',29.99,'civilization-vi.jpg',0,'2016-10-21',6,5),
(10,'God of War Ragnarok','Aventura de accion con narrativa mitologica y combate intenso.',59.99,'god-of-war-ragnarok.jpg',1,'2022-11-09',9,1),
(11,'Mario Kart 8 Deluxe','Juego de carreras arcade para varios jugadores.',44.99,'mario-kart-8-deluxe.jpg',0,'2017-04-28',18,3),
(12,'Baldur\'s Gate 3','RPG narrativo con decisiones, combates tacticos y fantasia.',59.99,'baldurs-gate-3.jpg',1,'2023-08-03',7,4),
(13,'Stardew Valley','Juego de gestion de granja, relaciones sociales y exploracion.',13.99,'stardew-valley.jpg',0,'2016-02-26',25,5),
(14,'Spider-Man 2','Aventura de accion protagonizada por Spider-Man en mundo abierto.',69.99,'spider-man-2.jpg',1,'2023-10-20',11,1),
(15,'Outlast','Juego de terror en primera persona basado en huida y supervivencia.',19.99,'outlast.jpg',0,'2013-09-04',5,9),
(19,'Metal Slug','Juego de pantallas',10.00,'97e33607-318a-4d8c-8f97-ec9a9d87a19d.png',0,'1996-11-11',35,4),
(20,'Minecraft','Juego de cubos',13.00,'0d82d246-e6f5-4c47-aeae-3a8d8a84340e.png',0,'2010-11-11',46,5);
/*!40000 ALTER TABLE `videojuego` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tienda'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-03 10:30:48

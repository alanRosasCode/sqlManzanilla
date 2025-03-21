-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 21, 2025 at 05:11 PM
-- Server version: 8.0.41-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `manzanilla`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Destare_Suma_Polen` (IN `id_proveedor` INT)   BEGIN
   SELECT (SUM(kilo) -(SUM(sacos) * .200)) FROM `manzanilla` WHERE tipo = "polen" AND id_proveedor = id_proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Destare_Suma_Tallo` (IN `id_proveedor` INT)   BEGIN
   SELECT (SUM(kilo) -(SUM(sacos) * .200)) FROM `manzanilla` WHERE tipo = "tallo" AND id_proveedor = id_proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_datos_polen` (IN `id_proveedor` INT)   BEGIN
	 SELECT 
        manzanilla.kilo,
        manzanilla.tipo,
        proveedor.nombre
    FROM manzanilla
    LEFT JOIN proveedor ON manzanilla.id_proveedor = proveedor.id_proveedor 
    WHERE manzanilla.tipo = 'polen' 
    AND manzanilla.id_proveedor = proveedor_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_manzanilla_totals` (`proveedor_id` INT)   BEGIN
    SELECT 
        SUM(kilo) AS total_kilos, 
        SUM(sacos) AS total_sacos
    FROM manzanilla 
    WHERE id_proveedor = proveedor_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_polen_totals` (`proveedor_id` INT)   BEGIN
    SELECT 
        SUM(kilo) AS total_kilos, 
        SUM(sacos) AS total_sacos
    FROM manzanilla
    WHERE tipo = 'polen' 
    AND id_proveedor = proveedor_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tallo_totals` (`proveedor_id` INT)   BEGIN
    SELECT 
        SUM(kilo) AS total_kilos, 
        SUM(sacos) AS total_sacos
    FROM manzanilla
    WHERE tipo = 'tallo' 
    AND id_proveedor = proveedor_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SumaKiloNeto` (IN `id_proveedor` INT, IN `tipo` ENUM("polen","tallo"))   BEGIN
DECLARE total_kilos DOUBLE DEFAULT 0$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cuenta`
--

CREATE TABLE `cuenta` (
  `id_cuenta` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `inyeccion_capital` int NOT NULL,
  `monto_producto` int NOT NULL,
  `precio` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cuenta_bancaria`
--

CREATE TABLE `cuenta_bancaria` (
  `id_cuenta_bancaria` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `numero_cuenta` varchar(20) NOT NULL,
  `nombre_titular` varchar(100) NOT NULL,
  `clabe` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cuenta_bancaria`
--

INSERT INTO `cuenta_bancaria` (`id_cuenta_bancaria`, `id_proveedor`, `numero_cuenta`, `nombre_titular`, `clabe`) VALUES
(1, 1, '10434600257', 'ALAN ROSAS GARCIA', '137437104346002573');

-- --------------------------------------------------------

--
-- Table structure for table `deposito`
--

CREATE TABLE `deposito` (
  `id_deposit` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `cantidad_deposito` double(10,2) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kilos`
--

CREATE TABLE `kilos` (
  `id_kilo` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `tipo` enum('polen','tallo') NOT NULL,
  `kilo_neto` double(5,2) NOT NULL,
  `kilo_destare` double(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manzanilla`
--

CREATE TABLE `manzanilla` (
  `id_manzanilla` int NOT NULL,
  `tipo` enum('polen','tallo') NOT NULL,
  `kilo` double(10,2) NOT NULL,
  `sacos` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `manzanilla`
--

INSERT INTO `manzanilla` (`id_manzanilla`, `tipo`, `kilo`, `sacos`, `id_proveedor`, `fecha`) VALUES
(5, 'polen', 93.85, 5, 1, '2025-02-16 18:54:48'),
(6, 'polen', 100.70, 5, 1, '2025-02-16 19:05:06'),
(7, 'polen', 104.70, 5, 1, '2025-02-16 19:06:08'),
(8, 'polen', 105.85, 5, 1, '2025-02-16 19:06:08'),
(9, 'polen', 104.85, 5, 1, '2025-02-16 19:12:45'),
(10, 'polen', 98.85, 5, 1, '2025-02-16 19:12:45'),
(11, 'polen', 109.20, 5, 1, '2025-02-16 19:12:45'),
(12, 'polen', 102.95, 5, 1, '2025-02-16 19:12:45'),
(13, 'polen', 97.25, 5, 1, '2025-02-16 19:12:45'),
(14, 'polen', 97.00, 5, 1, '2025-02-16 19:12:45'),
(15, 'polen', 100.35, 5, 1, '2025-02-16 19:12:45'),
(16, 'tallo', 90.15, 5, 1, '2025-02-16 21:01:25'),
(17, 'tallo', 90.85, 5, 1, '2025-02-16 21:01:25'),
(18, 'tallo', 94.75, 5, 1, '2025-02-16 21:01:25'),
(19, 'tallo', 93.45, 5, 1, '2025-02-16 21:01:25'),
(20, 'tallo', 80.45, 5, 1, '2025-02-16 21:01:25'),
(21, 'tallo', 92.90, 5, 1, '2025-02-16 21:01:25'),
(22, 'tallo', 93.55, 5, 1, '2025-02-16 21:01:25'),
(23, 'tallo', 94.05, 5, 1, '2025-02-16 21:01:25'),
(24, 'tallo', 94.70, 5, 1, '2025-02-16 21:01:25'),
(25, 'tallo', 92.75, 5, 1, '2025-02-16 21:01:25'),
(26, 'tallo', 92.95, 5, 1, '2025-02-16 21:01:25'),
(27, 'tallo', 92.25, 5, 1, '2025-02-16 21:01:25'),
(28, 'tallo', 91.45, 5, 1, '2025-02-16 21:01:25'),
(29, 'tallo', 94.45, 5, 1, '2025-02-16 21:01:25'),
(30, 'tallo', 91.40, 5, 1, '2025-02-16 21:01:25'),
(31, 'tallo', 92.25, 5, 1, '2025-02-16 21:01:25'),
(32, 'tallo', 93.00, 5, 1, '2025-02-16 21:01:25'),
(33, 'tallo', 90.45, 5, 1, '2025-02-16 21:01:25'),
(34, 'tallo', 95.05, 5, 1, '2025-02-16 21:01:25'),
(35, 'tallo', 94.90, 5, 1, '2025-02-16 21:01:25'),
(36, 'tallo', 93.90, 5, 1, '2025-02-16 21:01:25'),
(37, 'tallo', 92.90, 5, 1, '2025-02-16 21:01:25'),
(38, 'tallo', 89.80, 5, 1, '2025-02-16 21:01:25'),
(39, 'tallo', 92.80, 5, 1, '2025-02-16 21:01:25'),
(40, 'tallo', 91.45, 5, 1, '2025-02-16 21:01:25'),
(41, 'tallo', 89.70, 5, 1, '2025-02-16 21:01:25'),
(42, 'tallo', 87.90, 5, 1, '2025-02-16 21:01:25'),
(43, 'tallo', 91.25, 5, 1, '2025-02-16 21:01:25'),
(44, 'tallo', 90.60, 5, 1, '2025-02-16 21:01:25'),
(45, 'tallo', 89.50, 5, 1, '2025-02-16 21:01:25'),
(46, 'tallo', 90.80, 5, 1, '2025-02-16 21:01:25'),
(47, 'tallo', 92.40, 5, 1, '2025-02-16 21:01:25'),
(48, 'tallo', 90.55, 5, 1, '2025-02-16 21:01:25'),
(49, 'tallo', 85.90, 5, 1, '2025-02-16 21:01:25'),
(50, 'tallo', 87.30, 5, 1, '2025-02-16 21:01:25'),
(51, 'tallo', 87.00, 5, 1, '2025-02-16 21:01:25'),
(52, 'tallo', 86.55, 5, 1, '2025-02-16 21:01:25'),
(53, 'tallo', 102.40, 5, 1, '2025-02-16 21:01:25');

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `numero_telefonico` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre`, `numero_telefonico`) VALUES
(1, 'Alan Rosas Garcia', '5561601948'),
(2, 'Brandon rosas garcia', '5512837781'),
(3, 'Ruben Rosas Rivera', '5574602801');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`id_cuenta`),
  ADD KEY `fk_cuenta_proveedor` (`id_proveedor`);

--
-- Indexes for table `cuenta_bancaria`
--
ALTER TABLE `cuenta_bancaria`
  ADD PRIMARY KEY (`id_cuenta_bancaria`),
  ADD KEY `fk_cuenta_bancaria_proveedor` (`id_proveedor`);

--
-- Indexes for table `deposito`
--
ALTER TABLE `deposito`
  ADD PRIMARY KEY (`id_deposit`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indexes for table `kilos`
--
ALTER TABLE `kilos`
  ADD PRIMARY KEY (`id_kilo`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indexes for table `manzanilla`
--
ALTER TABLE `manzanilla`
  ADD PRIMARY KEY (`id_manzanilla`),
  ADD KEY `fk_manzanilla_proveedor` (`id_proveedor`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cuenta`
--
ALTER TABLE `cuenta`
  MODIFY `id_cuenta` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cuenta_bancaria`
--
ALTER TABLE `cuenta_bancaria`
  MODIFY `id_cuenta_bancaria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deposito`
--
ALTER TABLE `deposito`
  MODIFY `id_deposit` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kilos`
--
ALTER TABLE `kilos`
  MODIFY `id_kilo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manzanilla`
--
ALTER TABLE `manzanilla`
  MODIFY `id_manzanilla` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cuenta`
--
ALTER TABLE `cuenta`
  ADD CONSTRAINT `fk_cuenta_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE;

--
-- Constraints for table `cuenta_bancaria`
--
ALTER TABLE `cuenta_bancaria`
  ADD CONSTRAINT `fk_cuenta_bancaria_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE;

--
-- Constraints for table `deposito`
--
ALTER TABLE `deposito`
  ADD CONSTRAINT `deposito_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kilos`
--
ALTER TABLE `kilos`
  ADD CONSTRAINT `kilos_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `manzanilla`
--
ALTER TABLE `manzanilla`
  ADD CONSTRAINT `fk_manzanilla_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

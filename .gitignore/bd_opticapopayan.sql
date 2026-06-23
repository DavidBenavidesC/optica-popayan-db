-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2025 at 02:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bd_opticapopayan`
--

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `cliente_id` int(11) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `numero_documento` varchar(50) DEFAULT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`cliente_id`, `tipo_documento`, `numero_documento`, `nombre`, `direccion`, `telefono`, `email`, `created_by`, `created_at`) VALUES
(1, 'CC', '1001001001', 'Carlos Martínez', 'Calle 10 #34-56, Popayán', '3100000001', 'c.martinez@correo.com', 4, '2025-10-25 19:56:12'),
(2, 'CC', '1001001002', 'María Rodríguez', 'Cra 5 #12-34', '3100000002', 'm.rodriguez@correo.com', 4, '2025-10-25 19:56:12'),
(3, 'CC', '1001001003', 'Juan Gómez', 'Calle 20 #45-67', '3100000003', 'j.gomez@correo.com', 4, '2025-10-25 19:56:12'),
(4, 'CC', '1001001004', 'Luisa Fernández', 'Cra 10 #22-11', '3100000004', 'l.fernandez@correo.com', 4, '2025-10-25 19:56:12'),
(5, 'CC', '1001001005', 'Andrés Pérez', 'Calle 7 #8-90', '3100000005', 'a.perez@correo.com', 4, '2025-10-25 19:56:12'),
(6, 'CC', '1001001006', 'Sofía García', 'Cra 3 #45-67', '3100000006', 's.garcia@correo.com', 4, '2025-10-25 19:56:12'),
(7, 'CC', '1001001007', 'Diego Torres', 'Calle 1 #2-03', '3100000007', 'd.torres@correo.com', 4, '2025-10-25 19:56:12'),
(8, 'CC', '1001001008', 'Natalia Ríos', 'Cra 8 #9-10', '3100000008', 'n.rios@correo.com', 4, '2025-10-25 19:56:12'),
(9, 'CC', '1001001009', 'Pedro Castillo', 'Calle 15 #23-45', '3100000009', 'p.castillo@correo.com', 4, '2025-10-25 19:56:12'),
(10, 'CC', '1001001010', 'Camila López', 'Cra 12 #34-56', '3100000010', 'c.lopez@correo.com', 4, '2025-10-25 19:56:12'),
(11, 'CC', '1001001011', 'Rafael Quiñones', 'Calle 2 #33-21', '3100000011', 'r.quinones@correo.com', 4, '2025-10-25 19:56:12'),
(12, 'CC', '1001001012', 'Marta Álvarez', 'Cra 6 #16-80', '3100000012', 'm.alvarez@correo.com', 4, '2025-10-25 19:56:12'),
(13, 'TI', '1002963251', 'Valentina Otalvaro', 'Cra 3 D # 19 N 02', '3113155310', 'valen.otalvaro@correo.com', 4, '2025-10-26 09:52:29'),
(14, 'CE', '1098376253', 'John Smith', 'Hotel Dann Monasterio', '3209475839', 'smithster@eumail.com', 1, '2025-10-26 13:27:04');

-- --------------------------------------------------------

--
-- Table structure for table `consulta`
--

CREATE TABLE `consulta` (
  `consulta_id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `observaciones` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `precio` decimal(12,2) NOT NULL DEFAULT 30000.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consulta`
--

INSERT INTO `consulta` (`consulta_id`, `cliente_id`, `fecha`, `observaciones`, `created_by`, `precio`) VALUES
(1, 1, '2025-09-25 20:02:36', 'Revisión anual. Queja de fatiga ocular.', 1, 30000.00),
(2, 2, '2025-09-30 20:02:36', 'Molestia con visión a distancia.', 1, 30000.00),
(3, 3, '2025-10-05 20:02:36', 'Control post-adquisición de gafas.', 1, 30000.00),
(4, 4, '2025-10-07 20:02:36', 'Visión borrosa ocasional.', 1, 30000.00),
(5, 5, '2025-10-10 20:02:36', 'Chequeo infantil.', 1, 30000.00),
(6, 6, '2025-10-15 20:02:36', 'Revisión por trabajo en computador.', 1, 30000.00),
(7, 7, '2025-10-17 20:02:36', 'Cambio de receta solicitado.', 1, 30000.00),
(8, 8, '2025-10-20 20:02:36', 'Consulta por molestias en ojo derecho.', 1, 30000.00),
(9, 9, '2025-10-22 20:02:36', 'Revisión general.', 1, 30000.00),
(10, 10, '2025-10-24 20:02:36', 'Queja por deslumbramiento.', 1, 30000.00),
(11, 5, '2025-10-26 09:10:17', 'Consulta Anual', 1, 30000.00),
(12, 6, '2025-10-26 10:18:42', 'Ardor de Ojos, se ha recetado Dexametasona de uso comercial', 1, 30000.00),
(13, 14, '2025-10-26 13:29:49', 'Paciente con miopía leve. Se le receta formula médica y recomendación de uso de lentes permanentemente para evitar desgaste.', 1, 30000.00);

-- --------------------------------------------------------

--
-- Table structure for table `pedido`
--

CREATE TABLE `pedido` (
  `pedido_id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `receta_id` int(11) DEFAULT NULL,
  `proveedor_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT 1,
  `fecha_pedido` datetime DEFAULT current_timestamp(),
  `estado` varchar(50) NOT NULL DEFAULT 'SIN_SOLICITAR_A_LAB',
  `venta_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pedido`
--

INSERT INTO `pedido` (`pedido_id`, `cliente_id`, `receta_id`, `proveedor_id`, `producto_id`, `cantidad`, `fecha_pedido`, `estado`, `venta_id`, `created_by`) VALUES
(1, 1, 1, 1, 5, 5, '2025-09-27 20:13:31', 'SIN_SOLICITAR_A_LAB', 3, 2),
(2, 2, 2, 2, 11, 3, '2025-10-18 20:13:31', 'ENTREGADO_A_CLIENTE', NULL, 2),
(3, 3, 3, 3, 1, 2, '2025-10-03 20:13:31', 'SOLICITADO_A_LAB', NULL, 2),
(4, 4, 4, 4, 16, 2, '2025-10-16 20:13:31', 'RECIBIDO_EN_OPTICA', 6, 2),
(6, 14, 5, 4, 5, 1, '2025-10-26 13:44:10', 'SIN_SOLICITAR_A_LAB', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `producto_id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `tipo` enum('MARCO','LENTE','ACCESORIO','OTRO') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio_venta` decimal(12,2) NOT NULL DEFAULT 0.00,
  `stock` int(11) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`producto_id`, `nombre`, `tipo`, `descripcion`, `precio_venta`, `stock`, `created_by`, `created_at`) VALUES
(1, 'Marco RayBan RB-3016', 'MARCO', 'Marco clásico gato', 220000.00, 5, 4, '2025-10-25 19:59:46'),
(2, 'Marco Oakley OX-100', 'MARCO', 'Marco deportivo', 180000.00, 4, 4, '2025-10-25 19:59:46'),
(3, 'Marco Infinity IN-200', 'MARCO', 'Marco metal ligero', 150000.00, 5, 4, '2025-10-25 19:59:46'),
(4, 'Lente Monofocal CR-1.5', 'LENTE', 'Lente monofocal índice 1.5', 25000.00, 48, 4, '2025-10-25 19:59:46'),
(5, 'Lente Progresivo PR-1', 'LENTE', 'Lente progresivo estándar', 150000.00, 19, 4, '2025-10-25 19:59:46'),
(6, 'Lente Polarizado Solar P-01', 'LENTE', 'Polarizado para gafas de sol', 45000.00, 30, 4, '2025-10-25 19:59:46'),
(7, 'Estuche Universal', 'ACCESORIO', 'Estuche blando', 12000.00, 40, 4, '2025-10-25 19:59:46'),
(8, 'Gotas Limpieza 50ml', 'ACCESORIO', 'Líquido limpieza lentes', 8000.00, 59, 4, '2025-10-25 19:59:46'),
(9, 'Paño Microfibra', 'ACCESORIO', 'Paño limpieza microfibra', 5000.00, 76, 4, '2025-10-25 19:59:46'),
(10, 'Cordón Ajustable', 'ACCESORIO', 'Cordón para gafas', 10000.00, 25, 4, '2025-10-25 19:59:46'),
(11, 'Lente Fotocromático F-1', 'LENTE', 'Fotocromático', 60000.00, 14, 4, '2025-10-25 19:59:46'),
(12, 'Marco Niño N-01', 'MARCO', 'Marco tamaño infantil', 80000.00, 10, 4, '2025-10-25 19:59:46'),
(13, 'Marco Acetato A-01', 'MARCO', 'Acetato robusto', 110000.00, 7, 4, '2025-10-25 19:59:46'),
(14, 'Kit Ajuste Tornillos', 'ACCESORIO', 'Destornillador + tornillos', 9000.00, 49, 4, '2025-10-25 19:59:46'),
(15, 'Lente BlueBlock BB-1', 'LENTE', 'Anti-blue light', 35000.00, 25, 4, '2025-10-25 19:59:46'),
(16, 'Gafa Sol Modelo S-01', 'MARCO', 'Gafa sol marco plástico', 130000.00, 7, 4, '2025-10-25 19:59:46'),
(17, 'Paquete Protección 3und', 'ACCESORIO', 'Fundas y paños', 15000.00, 20, 4, '2025-10-25 19:59:46'),
(18, 'Montura Metal M-02', 'MARCO', 'Montura metal delgada', 125000.00, 9, 4, '2025-10-25 19:59:46'),
(19, 'Lente Transición T-1', 'LENTE', 'Transición día/noche', 55000.00, 12, 4, '2025-10-25 19:59:46'),
(20, 'Antirreflejo AR-1', 'ACCESORIO', 'Tratamiento antirreflejo', 30000.00, 20, 4, '2025-10-25 19:59:46'),
(21, 'Estuche Infantil', 'ACCESORIO', 'Estuche de Bob Esponja para niños', 10000.00, 5, 4, '2025-10-26 08:04:31');

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `proveedor_id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proveedor`
--

INSERT INTO `proveedor` (`proveedor_id`, `nombre`, `telefono`, `email`, `direccion`, `created_at`, `created_by`) VALUES
(1, 'Laboratorio Lentes Popayán', '3102000001', 'labpopayan@correo.com', 'Zona Industrial, Popayán', '2025-10-25 20:01:54', 3),
(2, 'Lentes y Asociados S.A.', '3102000002', 'lentesasoc@correo.com', 'Cra 2 #10-20, Popayán', '2025-10-25 20:01:54', 2),
(3, 'Soluciones Ópticas Ltda', '3102000003', 'soloptica@correo.com', 'Cl 5 #7-12, Popayán', '2025-10-25 20:01:54', 3),
(4, 'Proveeduría Visual S.A.S.', '3102000004', 'provevisual@correo.com', 'Av 3 #33-44, Popayán', '2025-10-25 20:01:54', 2),
(5, 'SmartLab Corp', '3206390583', 'smarlab.opticas.servicios@correo.com.co', 'Cra 9 # 6 - 50', '2025-10-26 10:46:28', 1);

-- --------------------------------------------------------

--
-- Table structure for table `receta`
--

CREATE TABLE `receta` (
  `receta_id` int(11) NOT NULL,
  `consulta_id` int(11) NOT NULL,
  `esfera_od` varchar(20) DEFAULT NULL,
  `esfera_oi` varchar(20) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `cilindro_od` decimal(5,2) DEFAULT NULL,
  `eje_od` int(11) DEFAULT NULL,
  `add_od` decimal(5,2) DEFAULT NULL,
  `cilindro_oi` decimal(5,2) DEFAULT NULL,
  `eje_oi` int(11) DEFAULT NULL,
  `add_oi` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receta`
--

INSERT INTO `receta` (`receta_id`, `consulta_id`, `esfera_od`, `esfera_oi`, `observaciones`, `created_by`, `fecha`, `cilindro_od`, `eje_od`, `add_od`, `cilindro_oi`, `eje_oi`, `add_oi`) VALUES
(1, 1, '-1.25', '-1.50', 'Paciente con ligera presbicia', 1, '2025-01-10 00:00:00', -0.50, 120, 1.00, -0.75, 90, 1.00),
(2, 2, '-2.00', '-2.25', 'Astigmatismo bilateral', 1, '2025-01-15 00:00:00', -1.00, 100, 1.50, -1.25, 80, 1.50),
(3, 3, '0.00', '0.00', 'Visión estable, sin fórmula óptica', 1, '2025-01-20 00:00:00', 0.00, NULL, NULL, 0.00, NULL, NULL),
(4, 4, '-3.25', '-3.00', 'Miopía avanzada, seguimiento necesario', 1, '2025-01-28 00:00:00', -1.50, 70, NULL, -1.25, 75, NULL),
(5, 13, '0.5', '1.0', 'Miopía leve', 1, '2025-10-26 13:29:49', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `usuario_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `rol` enum('ADMIN','OPTOMETRA','ASISTENTE','VENDEDOR') NOT NULL DEFAULT 'ASISTENTE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`usuario_id`, `username`, `password_hash`, `nombre`, `telefono`, `email`, `created_at`, `rol`) VALUES
(1, 'ebenavides', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'Eduardo Benavides', '3000000001', 'ebenavides@correo.com', '2025-10-25 19:54:57', 'OPTOMETRA'),
(2, 'alopez', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'Aura López', '3000000002', 'alopez@correo.com', '2025-10-25 19:54:57', 'ASISTENTE'),
(3, 'lsilva', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'Lina Silva', '3000000003', 'lsilva@correo.com', '2025-10-25 19:54:57', 'ADMIN'),
(4, 'dbenavides', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'David Benavides', '3000000004', 'dbenavides@correo.com', '2025-10-25 19:54:57', 'ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `venta`
--

CREATE TABLE `venta` (
  `venta_id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(12,2) DEFAULT 0.00,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venta`
--

INSERT INTO `venta` (`venta_id`, `cliente_id`, `fecha`, `total`, `created_by`) VALUES
(1, 1, '2025-09-25 20:05:19', 30000.00, 2),
(2, 2, '2025-09-30 20:05:19', 30000.00, 2),
(3, 3, '2025-10-05 20:05:19', 270000.00, 2),
(4, 4, '2025-10-07 20:05:19', 150000.00, 2),
(5, 5, '2025-10-10 20:05:19', 30000.00, 2),
(6, 6, '2025-10-15 20:05:19', 130000.00, 2),
(7, 7, '2025-10-17 20:05:19', 215000.00, 2),
(8, 8, '2025-10-20 20:05:19', 30000.00, 2),
(9, 9, '2025-10-22 20:05:19', 58000.00, 2),
(10, 10, '2025-10-24 20:05:19', 30000.00, 2),
(11, 7, '2025-10-26 10:44:03', 29000.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `venta_detalle`
--

CREATE TABLE `venta_detalle` (
  `venta_detalle_id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `consulta_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT 1,
  `precio_unitario` decimal(12,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venta_detalle`
--

INSERT INTO `venta_detalle` (`venta_detalle_id`, `venta_id`, `producto_id`, `consulta_id`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 1, NULL, 1, 1, 30000.00, 30000.00),
(2, 2, NULL, 2, 1, 30000.00, 30000.00),
(3, 3, NULL, 3, 1, 30000.00, 30000.00),
(4, 3, 1, NULL, 1, 240000.00, 240000.00),
(5, 4, 5, NULL, 1, 150000.00, 150000.00),
(6, 5, NULL, 5, 1, 30000.00, 30000.00),
(7, 6, 16, NULL, 1, 130000.00, 130000.00),
(8, 7, NULL, 7, 1, 30000.00, 30000.00),
(9, 7, 3, NULL, 1, 150000.00, 150000.00),
(10, 7, 11, NULL, 1, 35000.00, 35000.00),
(11, 8, NULL, 8, 1, 30000.00, 30000.00),
(12, 9, 4, NULL, 2, 25000.00, 50000.00),
(13, 9, 8, NULL, 1, 8000.00, 8000.00),
(14, 10, NULL, 10, 1, 30000.00, 30000.00),
(15, 11, 9, NULL, 4, 5000.00, 20000.00),
(16, 11, 14, NULL, 1, 9000.00, 9000.00);

--
-- Triggers `venta_detalle`
--
DELIMITER $$
CREATE TRIGGER `trg_devolver_stock` AFTER DELETE ON `venta_detalle` FOR EACH ROW BEGIN
    IF OLD.producto_id IS NOT NULL THEN
        UPDATE producto
        SET stock = stock + OLD.cantidad
        WHERE producto_id = OLD.producto_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_restar_stock` AFTER INSERT ON `venta_detalle` FOR EACH ROW BEGIN
    IF NEW.producto_id IS NOT NULL THEN
        UPDATE producto
        SET stock = stock - NEW.cantidad
        WHERE producto_id = NEW.producto_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_validar_detalle` BEFORE INSERT ON `venta_detalle` FOR EACH ROW BEGIN
    IF NEW.producto_id IS NULL AND NEW.consulta_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El detalle debe referenciar producto o consulta';
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_id`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD KEY `fk_cliente_usuario` (`created_by`);

--
-- Indexes for table `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`consulta_id`),
  ADD KEY `fk_consulta_cliente` (`cliente_id`),
  ADD KEY `fk_consulta_usuario` (`created_by`);

--
-- Indexes for table `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`pedido_id`),
  ADD KEY `fk_pedido_proveedor` (`proveedor_id`),
  ADD KEY `fk_pedido_producto` (`producto_id`),
  ADD KEY `fk_pedido_venta` (`venta_id`),
  ADD KEY `fk_pedido_usuario` (`created_by`),
  ADD KEY `fk_pedido_cliente` (`cliente_id`),
  ADD KEY `fk_pedido_receta` (`receta_id`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`producto_id`),
  ADD KEY `fk_producto_usuario` (`created_by`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`proveedor_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `receta`
--
ALTER TABLE `receta`
  ADD PRIMARY KEY (`receta_id`),
  ADD UNIQUE KEY `consulta_id` (`consulta_id`),
  ADD KEY `fk_receta_usuario` (`created_by`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`venta_id`),
  ADD KEY `fk_venta_cliente` (`cliente_id`),
  ADD KEY `fk_venta_usuario` (`created_by`);

--
-- Indexes for table `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD PRIMARY KEY (`venta_detalle_id`),
  ADD KEY `fk_vd_venta` (`venta_id`),
  ADD KEY `fk_vd_producto` (`producto_id`),
  ADD KEY `fk_vd_consulta` (`consulta_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `consulta`
--
ALTER TABLE `consulta`
  MODIFY `consulta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `pedido`
--
ALTER TABLE `pedido`
  MODIFY `pedido_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `producto_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `proveedor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `receta`
--
ALTER TABLE `receta`
  MODIFY `receta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `venta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `venta_detalle`
--
ALTER TABLE `venta_detalle`
  MODIFY `venta_detalle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_usuario` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`) ON DELETE SET NULL;

--
-- Constraints for table `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `fk_consulta_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`),
  ADD CONSTRAINT `fk_consulta_usuario` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`) ON DELETE SET NULL;

--
-- Constraints for table `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`),
  ADD CONSTRAINT `fk_pedido_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`producto_id`),
  ADD CONSTRAINT `fk_pedido_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`proveedor_id`),
  ADD CONSTRAINT `fk_pedido_receta` FOREIGN KEY (`receta_id`) REFERENCES `receta` (`receta_id`),
  ADD CONSTRAINT `fk_pedido_usuario` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pedido_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`venta_id`) ON DELETE SET NULL;

--
-- Constraints for table `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_usuario` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`) ON DELETE SET NULL;

--
-- Constraints for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`);

--
-- Constraints for table `receta`
--
ALTER TABLE `receta`
  ADD CONSTRAINT `fk_receta_consulta` FOREIGN KEY (`consulta_id`) REFERENCES `consulta` (`consulta_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_receta_usuario` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`) ON DELETE SET NULL;

--
-- Constraints for table `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`created_by`) REFERENCES `usuario` (`usuario_id`) ON DELETE SET NULL;

--
-- Constraints for table `venta_detalle`
--
ALTER TABLE `venta_detalle`
  ADD CONSTRAINT `fk_vd_consulta` FOREIGN KEY (`consulta_id`) REFERENCES `consulta` (`consulta_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_vd_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`producto_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_vd_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`venta_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-03-2019 a las 21:12:52
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `jboss_test`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `itemName` varchar(50) NOT NULL,
  `value` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `items`
--

INSERT INTO `items` (`id`, `itemName`, `value`) VALUES
(16, 'Xbox 360', '1250000'),
(17, 'Play station 4', '570000'),
(18, 'Nintendo Switch', '820000'),
(19, 'Mando Xbox 360', '180000'),
(20, 'Mando PlayStation', '190000'),
(21, 'Nintendo 3DS', '395000'),
(22, 'Combo tv 60 + PlayStation 4 pro', '3800000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orderitems`
--

CREATE TABLE `orderitems` (
  `id` int(11) NOT NULL,
  `idOrder` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `orderitems`
--

INSERT INTO `orderitems` (`id`, `idOrder`, `idItem`, `quantity`) VALUES
(27, 239, 16, 2),
(28, 239, 17, 1),
(29, 240, 18, 1),
(30, 241, 19, 2),
(31, 242, 20, 2),
(32, 243, 19, 1),
(33, 243, 21, 1),
(34, 244, 19, 1),
(35, 244, 21, 1),
(36, 245, 16, 1),
(37, 246, 16, 1),
(38, 246, 21, 1),
(39, 246, 22, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `country` varchar(10) NOT NULL,
  `total` varchar(10) NOT NULL,
  `accepted` varchar(10) NOT NULL,
  `itemsQuantity` int(10) NOT NULL,
  `comments` varchar(50) NOT NULL,
  `processed` int(2) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `name`, `country`, `total`, `accepted`, `itemsQuantity`, `comments`, `processed`) VALUES
(239, 'Sergio Gutierrez', 'CO', '1820000', 'Accepted', 3, 'Valor no ajustado', 0),
(240, 'Diego Gutierrez', 'CO', '820000', 'Rejected', 1, 'Valor no ajustado', 0),
(241, 'Andrea Sanchez', 'US', '1800', 'Rejected', 2, 'Valor ajustado: 1800', 0),
(242, 'Jack Nelson', 'UK', '8000', 'Rejected', 2, 'Valor ajustado: 8000', 0),
(243, 'Andres Rivera', 'CO', '485000', 'Rejected', 2, 'Valor no ajustado', 0),
(244, 'Gloria Sanchez', 'UK', '1758', 'Rejected', 2, 'Valor no ajustado', 0),
(245, 'Sergio Gutierrez', 'CO', '458712', 'Rejected', 1, 'Valor ajustado: 458712', 0),
(246, 'Jenny Barbosa', 'CO', '4500000', 'Accepted', 3, 'Valor no ajustado', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idOrder` (`idOrder`),
  ADD KEY `idItem` (`idItem`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`idItem`) REFERENCES `items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`idOrder`) REFERENCES `orders` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

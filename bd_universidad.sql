-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-12-2022 a las 05:46:03
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_universidad`
--
CREATE DATABASE IF NOT EXISTS `bd_universidad` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bd_universidad`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresar_notas` (IN `codigo_matricula` INTEGER, `codigo_curso` INTEGER, `grupo` VARCHAR(1), `estado` VARCHAR(1), `c1` INTEGER, `c2` INTEGER, `c3` INTEGER, `e1` INTEGER, `e2` INTEGER, `e3` INTEGER)   BEGIN
	INSERT INTO matricula_curso (`codigo_mtr`, `codigo_curso`, `grupo`, `ausente`) VALUES (codigo_matricula, codigo_curso, grupo, estado);
	UPDATE matricula_curso m_c SET m_c.C1=c1 , m_c.C2=c2, m_c.C3=c3 , m_c.E1=e1, m_c.E2=e2 , m_c.E3=e3  
    WHERE m_c.codigo_mtr=codigo_matricula and m_c.codigo_curso=codigo_curso;
    
    UPDATE matricula_curso m_c SET m_c.nota_final = nota_final(codigo_matricula,codigo_curso) 
	WHERE m_c.codigo_mtr=codigo_matricula and m_c.codigo_curso=codigo_curso;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_notas` (IN `cod_profesor` INTEGER, `grupo` VARCHAR(2), `cod_curso` INTEGER, `fecha` DATE)   BEGIN
	SELECT p.codigo ,CONCAT(p.primer_nombre , ' ', p.primer_apellido , ' ' , p.segundo_apellido) 'Nombres' , m_c.C1 , m_c.C2 , m_c.C3 , m_c.E1 , m_c.E2 , m_c.E3 , 
    m_c.nota_final , m_c.grupo, m_c.ausente FROM persona p 
    INNER JOIN estudiante est ON est.codigo_estu = p.codigo
    INNER JOIN estudiante_matricula e_mtr ON e_mtr.codigo_estu = est.codigo_estu
    INNER JOIN matricula mtr ON mtr.codigo_mtr = e_mtr.codigo_matricula
    INNER JOIN matricula_curso m_c ON m_c.codigo_mtr = mtr.codigo_mtr
    WHERE ABS( DATEDIFF(fecha,mtr.fecha_matricula) ) < 50 AND m_c.grupo = grupo;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `nota_final` (`codigo_matricula` INT, `cod_curso` INT) RETURNS FLOAT DETERMINISTIC BEGIN
	DECLARE pc1 FLOAT;
    DECLARE pc2 FLOAT;
    DECLARE pc3 FLOAT;
    DECLARE pe1 FLOAT;
    DECLARE pe2 FLOAT;
    DECLARE pe3 FLOAT;
    
    DECLARE c1 FLOAT;
    DECLARE c2 FLOAT;
    DECLARE c3 FLOAT;
    DECLARE e1 FLOAT;
    DECLARE e2 FLOAT;
    DECLARE e3 FLOAT;
    
	DECLARE nota_final FLOAT;

    set pc1 = (SELECT curso.PC1 FROM curso WHERE curso.codigo_curso=cod_curso);
    set pc2 = (SELECT curso.PC2 FROM curso WHERE curso.codigo_curso=cod_curso);
    set pc3 = (SELECT curso.PC3 FROM curso WHERE curso.codigo_curso=cod_curso);
    set pe1 = (SELECT curso.PE1 FROM curso WHERE curso.codigo_curso=cod_curso);
    set pe2 = (SELECT curso.PE2 FROM curso WHERE curso.codigo_curso=cod_curso);
    set pe3 = (SELECT curso.PE3 FROM curso WHERE curso.codigo_curso=cod_curso);
    
    
    
    set c1 = (SELECT m_c.C1 FROM matricula_curso m_c WHERE m_c.codigo_mtr=codigo_matricula AND m_c.codigo_curso = cod_curso);
    set c2 = (SELECT m_c.C2 FROM matricula_curso m_c WHERE m_c.codigo_mtr=codigo_matricula AND m_c.codigo_curso = cod_curso);
    set c3 = (SELECT m_c.C3 FROM matricula_curso m_c WHERE m_c.codigo_mtr=codigo_matricula AND m_c.codigo_curso = cod_curso);
    set e1 = (SELECT m_c.E1 FROM matricula_curso m_c WHERE m_c.codigo_mtr=codigo_matricula AND m_c.codigo_curso = cod_curso);
    set e2 = (SELECT m_c.E2 FROM matricula_curso m_c WHERE m_c.codigo_mtr=codigo_matricula AND m_c.codigo_curso = cod_curso);
    set e3 = (SELECT m_c.E3 FROM matricula_curso m_c WHERE m_c.codigo_mtr=codigo_matricula AND m_c.codigo_curso = cod_curso);
    
    SET nota_final = ROUND((c1*pc1 + c2*pc2 + c3*pc3 + e1*pe1 +  e2*pe2 + e3*pe3)/100 ,0);
    RETURN nota_final;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administracion`
--

CREATE TABLE `administracion` (
  `codigo_personal` int(11) NOT NULL,
  `cargo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `administracion`
--

INSERT INTO `administracion` (`codigo_personal`, `cargo`) VALUES
(70086861, 'Limpieza'),
(70906320, 'Limpieza'),
(72183063, 'Portero'),
(72189703, 'Limpieza'),
(72500380, 'Mantenimiento'),
(72825356, 'Mantenimiento'),
(73620015, 'Secretaria'),
(73952118, 'Mantenimiento'),
(74641837, 'Secretaria'),
(75456915, 'Limpieza'),
(75503317, 'Limpieza'),
(75558931, 'Limpieza'),
(76462285, 'Limpieza'),
(76556379, 'Asistente'),
(77494739, 'Secretaria'),
(78389577, 'Limpieza'),
(78859852, 'Limpieza'),
(78869829, 'Limpieza'),
(79192829, 'Mantenimiento'),
(79356988, 'Limpieza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `becario`
--

CREATE TABLE `becario` (
  `codigo_estu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `becario`
--

INSERT INTO `becario` (`codigo_estu`) VALUES
(48105236),
(56480512),
(65482352),
(66451287),
(70979676),
(71860523),
(72153488),
(74304954),
(74434256),
(76381469),
(76724829),
(76841532),
(77947004),
(78153990),
(79293044),
(95486638),
(96236651),
(98112345),
(98452715),
(98732341);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `codigo_curso` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `creditos` int(11) DEFAULT NULL,
  `PE1` float DEFAULT NULL,
  `PE2` float DEFAULT NULL,
  `PE3` float DEFAULT NULL,
  `PC1` float DEFAULT NULL,
  `PC2` float DEFAULT NULL,
  `PC3` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`codigo_curso`, `nombre`, `creditos`, `PE1`, `PE2`, `PE3`, `PC1`, `PC2`, `PC3`) VALUES
(1701101, 'RAZONAMIENTO LOGICO MATEMATICO', 4, 22, 22, 28, 8, 8, 12),
(1701102, 'METODOLOGIA DEL TRABAJO INTELECTUAL', 2, 15, 15, 20, 15, 15, 20),
(1701104, 'ARTE COMPUTACIONAL', 3, 15, 15, 20, 15, 15, 20),
(1701105, 'INGLES TECNICO PROFESIONAL I', 2, 10, 10, 20, 20, 20, 20),
(1701106, 'FUNDAMENTOS DE COMPUTACION', 4, 15, 15, 20, 15, 15, 20),
(1701107, 'ESTRUCTURAS DISCRETAS I', 4, 15, 15, 20, 15, 15, 20),
(1701114, 'LIDERAZGO Y ORATORIA', 2, 10, 10, 20, 20, 20, 20),
(1701208, 'ESTRUCTURAS DISCRETAS II', 4, 15, 15, 20, 15, 15, 20),
(1701209, 'CIENCIA DE LA COMPUTACION I', 4, 15, 15, 20, 15, 15, 20),
(1701210, 'CALCULO EN UNA VARIABLE', 4, 24, 24, 32, 6, 6, 8),
(1701212, 'INGLES TECNICO PROFESIONAL II', 2, 10, 10, 15, 20, 20, 25),
(1701215, 'COMUNICACION INTEGRAL', 2, 10, 10, 15, 20, 20, 25),
(1701216, 'REALIDAD NACIONAL', 2, 10, 10, 15, 20, 20, 25),
(1702117, 'ARQUITECTURA DE COMPUTADORES', 3, 15, 15, 20, 15, 15, 20),
(1702118, 'CIENCIAS DE LA COMPUTACION II', 4, 15, 15, 20, 15, 15, 20),
(1702119, 'DESARROLLO BASADO EN PLATAFORMAS', 3, 10, 10, 20, 20, 20, 20),
(1702120, 'TRABAJO INTERDISCIPLINAR I', 3, 10, 10, 30, 10, 10, 30),
(1702121, 'CALCULO EN VARIAS VARIABLES', 4, 24, 24, 32, 6, 6, 8),
(1702122, 'INGLES TECNICO PROFESIONAL III', 2, 10, 10, 20, 20, 20, 20),
(1702123, 'CIUDADANIA E INTERCULTURALIDAD', 2, 10, 10, 20, 20, 20, 20),
(1702224, 'ALGORITMOS Y ESTRUCTURAS DE DATOS', 4, 15, 15, 20, 15, 15, 20),
(1702225, 'TEORIA DE LA COMPUTACION', 3, 15, 15, 20, 15, 15, 20),
(1702226, 'BASE DE DATOS I', 3, 10, 10, 20, 20, 20, 20),
(1702227, 'ALGEBRA LINEAL NUMERICA', 3, 15, 15, 20, 15, 15, 20),
(1702228, 'ESTADISTICA Y PROBABILIDADES', 3, 22, 22, 32, 8, 8, 8),
(1702229, 'ECOLOGIA Y CONSERVACION AMBIENTAL', 2, 10, 10, 20, 20, 20, 20),
(1703130, 'BASE DE DATOS II', 3, 15, 15, 20, 15, 15, 20),
(1703131, 'ANALISIS Y DISENO DE ALGORITMOS', 4, 15, 15, 20, 15, 15, 20),
(1703132, 'INGENIERIA DE SOFTWARE I', 4, 15, 15, 20, 15, 15, 20),
(1703133, 'COMPILADORES', 3, 15, 15, 20, 15, 15, 20),
(1703134, 'ANALISIS EXPLORATORIO DE DATOS ESPACIALES', 3, 10, 10, 20, 20, 20, 20),
(1703135, 'ECUACIONES DIFERENCIALES', 4, 24, 24, 32, 6, 6, 8),
(1703236, 'PROGRAMACION COMPETITIVA', 4, 15, 15, 20, 15, 15, 20),
(1703237, 'INGENIERIA DE SOFTWARE II', 4, 15, 15, 20, 15, 15, 20),
(1703238, 'ESTRUCTURAS DE DATOS AVANZADOS', 4, 10, 10, 20, 20, 20, 20),
(1703239, 'SISTEMAS OPERATIVOS', 3, 15, 15, 20, 15, 15, 20),
(1703240, 'TRABAJO INTERDISCIPLINAR II', 3, 10, 10, 30, 10, 10, 30),
(1703241, 'MATEMATICA APLICADA A LA COMPUTACION', 3, 15, 15, 20, 15, 15, 20),
(1704142, 'INVESTIGACION EN CIENCIAS DE LA COMPUTACION', 2, 10, 10, 20, 20, 20, 20),
(1704143, 'DESARROLLO DE SOFTWARE EMPRESARIAL', 2, 10, 10, 20, 20, 20, 20),
(1704144, 'REDES Y COMUNICACION', 2, 10, 10, 20, 20, 20, 20),
(1704145, 'INGENIERIA DE SOFTWARE III', 4, 15, 15, 20, 15, 15, 20),
(1704146, 'COMPUTACION GRAFICA', 4, 15, 15, 20, 15, 15, 20),
(1704147, 'INTELIGENCIA ARTIFICIAL', 4, 15, 15, 20, 15, 15, 20),
(1704248, 'INTERACCION HUMANO COMPUTADOR', 3, 10, 10, 20, 20, 20, 20),
(1704249, 'PROYECTO DE FINAL DE CARRERA I', 4, 15, 15, 20, 15, 15, 20),
(1704250, 'COMPUTACION PARALELA Y DISTRIBUIDA', 3, 15, 15, 20, 15, 15, 20),
(1704251, 'SEGURIDAD EN COMPUTACION', 3, 10, 10, 20, 20, 20, 20),
(1704252, 'FORMACION DE EMPRESAS DE BASE TECNOLOGICA I', 2, 10, 10, 30, 10, 10, 30),
(1704253, 'RELACIONES HUMANAS', 2, 10, 10, 20, 20, 20, 20),
(1704254, 'FISICA COMPUTACIONAL ', 3, 15, 15, 20, 15, 15, 20),
(1704255, 'TOPICOS EN INGENIERIA DE SOFTWARE E', 3, 15, 15, 20, 15, 15, 20),
(1705156, 'PROYECTO DE FINAL DE CARRERA II', 4, 15, 15, 20, 15, 15, 20),
(1705157, 'BIG DATA', 3, 15, 15, 20, 15, 15, 20),
(1705158, 'ETICA GENERAL Y PROFESIONAL', 2, 10, 10, 20, 20, 20, 20),
(1705159, 'FORMACION DE EMPRESAS DE BASE TECNOLOGICA II', 2, 10, 10, 30, 10, 10, 30),
(1705160, 'INGLES TECNICO PROFESIONAL IV', 2, 10, 10, 20, 20, 20, 20),
(1705161, 'TOPICOS EN CIENCIA DE DATOS E', 3, 15, 15, 20, 15, 15, 20),
(1705162, 'TOPICOS EN INTELIGENCIA ARTIFICIAL', 3, 24, 24, 32, 6, 6, 8),
(1705163, 'TOPICOS EN COMPUTACION GRAFICA', 3, 10, 10, 30, 10, 10, 30),
(1705164, 'BIOINFORMATICA', 3, 15, 15, 20, 15, 15, 20),
(1705265, 'CLOUD COMPUTING', 3, 15, 15, 20, 15, 15, 20),
(1705266, 'PROYECTO DE FINAL DE CARRERA III', 4, 15, 15, 20, 15, 15, 20),
(1705267, 'TRABAJO INTERDISCIPLINAR III', 3, 10, 10, 30, 10, 10, 30),
(1705268, 'INTERNET DE LAS COSAS', 3, 15, 15, 20, 15, 15, 20),
(1705269, 'ROBOTICA', 3, 15, 15, 20, 15, 15, 20),
(1705270, 'TOPICOS EN CIBERSEGURIDAD', 3, 10, 10, 30, 10, 10, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `codigo_depa` int(11) NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `aforo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`codigo_depa`, `ubicacion`, `nombre`, `aforo`) VALUES
(1000, '1 piso', 'Benedicto', 58),
(1001, '3 piso', 'Benigno', 49),
(1002, '3 piso', 'Benito', 51),
(1003, '2 piso', 'Benjamín', 42),
(1004, '1 piso', 'Bernabé', 49),
(1005, '2 piso', 'Bernarda', 39),
(1006, '3 piso', 'Bernardo', 59),
(1007, '4 piso', 'Blanca', 55),
(1008, '1 piso', 'Blas', 47),
(1009, '4 piso', 'Bonifacio', 33),
(1010, '2 piso', 'Borja', 47),
(1011, '1 piso', 'Bruno', 49),
(1012, '4 piso', 'Calixto', 54),
(1013, '2 piso', 'Camilo', 38),
(1014, '1 piso', 'Cándida', 30),
(1015, '4 piso', 'Carina', 41),
(1016, '4 piso', 'Carlos', 32),
(1017, '3 piso', 'Carmelo', 53),
(1018, '3 piso', 'Carmen', 54),
(1019, '4 piso', 'Carolina', 43),
(1020, '1 piso', 'Casiano', 60),
(1021, '3 piso', 'Casimiro', 49),
(1022, '1 piso', 'Casio', 52),
(1023, '2 piso', 'Catalina', 60),
(1024, '1 piso', 'Cayetano', 45),
(1025, '1 piso', 'Cayo', 32),
(1026, '3 piso', 'Cecilia', 44),
(1027, '2 piso', 'Ceferino', 50),
(1028, '5 piso', 'Celia', 49),
(1029, '1 piso', 'Celina', 36),
(1030, '3 piso', 'Celso', 43),
(1031, '2 piso', 'César', 48),
(1032, '5 piso', 'Cesáreo', 40),
(1033, '4 piso', 'Cipriano', 37),
(1034, '5 piso', 'Cirilo', 31),
(1035, '5 piso', 'Cirino', 30),
(1036, '1 piso', 'Ciro', 58),
(1037, '2 piso', 'Clara', 48),
(1038, '3 piso', 'Claudia', 48),
(1039, '2 piso', 'Claudio', 31);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `codigo_estu` int(11) NOT NULL,
  `fecha_nac` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`codigo_estu`, `fecha_nac`) VALUES
(13548669, '2002-09-22'),
(35489768, '2002-09-26'),
(38112345, '2002-09-15'),
(38712349, '2002-10-07'),
(38782349, '2002-09-21'),
(48105236, '2002-10-13'),
(56480512, '2002-10-12'),
(61541897, '2002-10-20'),
(63155203, '2002-09-24'),
(64958826, '2002-10-09'),
(65482352, '2002-10-15'),
(65548456, '2002-09-11'),
(65548477, '2002-09-23'),
(66451287, '2002-10-11'),
(66457812, '2002-09-25'),
(66514853, '2002-10-05'),
(66541893, '2002-10-01'),
(68452315, '2002-10-06'),
(70219223, '2003-03-18'),
(70414462, '2000-02-27'),
(70979676, '1997-11-14'),
(71091947, '1997-08-09'),
(71113233, '2002-07-15'),
(71277642, '2004-06-01'),
(71736358, '1999-11-09'),
(71860523, '1995-12-24'),
(71899225, '1995-04-27'),
(71953434, '1997-08-28'),
(72153488, '2003-09-21'),
(72191607, '2003-10-15'),
(72275629, '1997-01-03'),
(72534757, '1998-11-21'),
(72640567, '1999-01-01'),
(72883406, '1996-11-23'),
(72973309, '2005-01-22'),
(72979311, '2000-11-05'),
(73043546, '2000-01-15'),
(73348181, '2000-12-14'),
(73585244, '2006-06-15'),
(73768171, '2002-10-04'),
(74304954, '1998-02-27'),
(74434256, '1996-01-24'),
(74589859, '1998-06-01'),
(74825994, '1998-11-28'),
(75238682, '2001-01-20'),
(76316791, '2005-06-07'),
(76333780, '2001-05-03'),
(76381469, '1999-02-04'),
(76724829, '2006-04-20'),
(76814598, '2002-09-20'),
(76841532, '2002-10-10'),
(76977921, '1999-05-22'),
(77052403, '1998-08-16'),
(77236880, '1999-11-25'),
(77375380, '2003-12-02'),
(77584095, '2002-10-03'),
(77584695, '2002-09-30'),
(77796783, '2004-01-24'),
(77947004, '2004-10-19'),
(77960545, '2003-07-04'),
(78119579, '2005-01-07'),
(78153990, '2000-03-11'),
(78172043, '2000-03-13'),
(78233416, '2002-09-13'),
(78374418, '2003-02-05'),
(78419312, '2003-02-22'),
(78785279, '1996-07-01'),
(79196466, '1997-03-04'),
(79293044, '2003-11-11'),
(79306078, '1996-05-24'),
(79309864, '2004-05-19'),
(79885368, '1997-12-19'),
(84512307, '2002-09-14'),
(84771203, '2002-09-29'),
(90026346, '2002-09-27'),
(91786346, '2002-10-08'),
(94881526, '2002-09-12'),
(95486638, '2002-10-14'),
(95916646, '2002-10-02'),
(96236651, '2002-10-18'),
(98112345, '2002-10-19'),
(98412345, '2002-09-16'),
(98413345, '2002-09-19'),
(98452315, '2002-09-17'),
(98452345, '2002-09-18'),
(98452375, '2002-09-28'),
(98452715, '2002-10-16'),
(98732341, '2002-10-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_matricula`
--

CREATE TABLE `estudiante_matricula` (
  `codigo_estu` int(11) NOT NULL,
  `codigo_matricula` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estudiante_matricula`
--

INSERT INTO `estudiante_matricula` (`codigo_estu`, `codigo_matricula`) VALUES
(13548669, 70000079),
(35489768, 70000053),
(38112345, 70000057),
(38712349, 70000081),
(38782349, 70000018),
(48105236, 70000074),
(56480512, 70000028),
(61541897, 70000067),
(63155203, 70000049),
(64958826, 70000029),
(65482352, 70000013),
(65548456, 70000034),
(65548477, 70000000),
(66451287, 70000014),
(66457812, 70000085),
(66514853, 70000036),
(66541893, 70000060),
(68452315, 70000053),
(70219223, 70000063),
(70414462, 70000016),
(70979676, 70000069),
(71091947, 70000080),
(71113233, 70000010),
(71277642, 70000041),
(71736358, 70000023),
(71860523, 70000013),
(71899225, 70000025),
(71953434, 70000049),
(72153488, 70000052),
(72191607, 70000063),
(72275629, 70000057),
(72534757, 70000029),
(72640567, 70000005),
(72883406, 70000083),
(72973309, 70000031),
(72979311, 70000019),
(73043546, 70000052),
(73348181, 70000013),
(73585244, 70000007),
(73768171, 70000003),
(74304954, 70000037),
(74434256, 70000072),
(74589859, 70000070),
(74825994, 70000028),
(75238682, 70000025),
(76316791, 70000068),
(76333780, 70000035),
(76381469, 70000049),
(76724829, 70000046),
(76814598, 70000056),
(76841532, 70000011),
(76977921, 70000044),
(77052403, 70000053),
(77236880, 70000087),
(77375380, 70000022),
(77584095, 70000051),
(77584695, 70000037),
(77796783, 70000051),
(77947004, 70000001),
(77960545, 70000016),
(78119579, 70000034),
(78153990, 70000004),
(78172043, 70000058),
(78233416, 70000061),
(78374418, 70000024),
(78419312, 70000043),
(78785279, 70000010),
(79196466, 70000023),
(79293044, 70000084),
(79306078, 70000082),
(79309864, 70000085),
(79885368, 70000002),
(84512307, 70000035),
(84771203, 70000044),
(90026346, 70000073),
(91786346, 70000030),
(94881526, 70000038),
(95486638, 70000052),
(95916646, 70000087),
(96236651, 70000015),
(98112345, 70000081),
(98412345, 70000010),
(98413345, 70000045),
(98452315, 70000042),
(98452345, 70000082),
(98452375, 70000074),
(98452715, 70000068),
(98732341, 70000076);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `codigo_obj` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `objeto` varchar(100) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `cod_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`codigo_obj`, `cantidad`, `objeto`, `descripcion`, `cod_departamento`) VALUES
(4000, 19, 'CPU', 'Motor de la PC', 1027),
(4001, 37, 'Cañon', 'Reproductor de imagen', 1001),
(4002, 42, 'Sillas', 'Para sentarse', 1007),
(4003, 15, 'Mesas', 'Para escribir', 1020),
(4004, 20, 'Cortinas', 'Para taparse', 1009),
(4005, 46, 'Plumones', 'Para escribir en pizarra', 1025),
(4006, 45, 'Monitor', 'Para ver la PC', 1024),
(4007, 33, 'Teclado', 'Para escribir en la PC', 1001),
(4008, 34, 'Mouse', 'Para navegar en la PC', 1001),
(4009, 30, 'Cables Ethernet', 'Llevar el internet a las PC\'s', 1005),
(4010, 43, 'Router', 'Señal wifi', 1029),
(4011, 26, 'Paneles Solares', 'Energia de emergencia', 1027),
(4012, 20, 'Puertas', 'Para aislar zonas', 1013),
(4013, 45, 'Pizarras', 'Donde se escribe', 1023),
(4014, 33, 'Mota', 'Para borrar', 1018),
(4015, 30, 'Adaptador', 'Para conectar a la corriente', 1028),
(4016, 22, 'Kit robotica', 'Para IA', 1021),
(4017, 12, 'VR oculus', 'Para entrar a Meta', 1008),
(4018, 40, 'Scanner 3D', 'Mapeo de mallas', 1021),
(4019, 29, 'Impresoras', 'Para imprimir logos, diseños,etc', 1017),
(4020, 41, 'Microondas', 'Calentar comida', 1034);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `laboratorio`
--

CREATE TABLE `laboratorio` (
  `codigo_depa_lab` int(11) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `laboratorio`
--

INSERT INTO `laboratorio` (`codigo_depa_lab`, `tipo`) VALUES
(1020, 'Computo'),
(1021, 'Robotica'),
(1022, 'Fisica'),
(1023, 'Quimica'),
(1024, 'Robotica'),
(1025, 'Fisica'),
(1026, 'Quimica'),
(1027, 'Robotica'),
(1028, 'Robotica'),
(1029, 'Computo'),
(1030, 'Computo'),
(1031, 'Robotica'),
(1032, 'Computo'),
(1033, 'Fisica'),
(1034, 'Oratoria'),
(1035, 'Computo'),
(1036, 'Quimica'),
(1037, 'Computo'),
(1038, 'Robotica'),
(1039, 'Quimica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `codigo_mtr` int(11) NOT NULL,
  `nro_matricula` int(11) DEFAULT NULL,
  `fecha_matricula` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `matricula`
--

INSERT INTO `matricula` (`codigo_mtr`, `nro_matricula`, `fecha_matricula`) VALUES
(70000000, 2, '2023-03-25'),
(70000001, 4, '2021-03-10'),
(70000002, 1, '2021-07-03'),
(70000003, 3, '2022-07-11'),
(70000004, 1, '2021-09-17'),
(70000005, 4, '2021-02-18'),
(70000006, 4, '2021-10-11'),
(70000007, 4, '2021-09-06'),
(70000008, 1, '2023-05-04'),
(70000009, 1, '2022-09-07'),
(70000010, 4, '2022-03-18'),
(70000011, 2, '2022-08-09'),
(70000012, 1, '2023-05-13'),
(70000013, 3, '2021-02-17'),
(70000014, 1, '2022-03-19'),
(70000015, 1, '2022-06-06'),
(70000016, 4, '2023-05-09'),
(70000017, 1, '2021-06-16'),
(70000018, 4, '2022-11-15'),
(70000019, 2, '2022-06-15'),
(70000020, 2, '2021-12-08'),
(70000021, 4, '2021-01-19'),
(70000022, 1, '2022-01-01'),
(70000023, 1, '2023-08-08'),
(70000024, 4, '2022-12-28'),
(70000025, 3, '2021-10-22'),
(70000026, 3, '2022-01-08'),
(70000027, 1, '2022-04-24'),
(70000028, 3, '2021-07-27'),
(70000029, 3, '2022-04-25'),
(70000030, 4, '2021-06-28'),
(70000031, 3, '2023-02-19'),
(70000032, 2, '2023-05-21'),
(70000033, 2, '2023-02-10'),
(70000034, 1, '2022-01-22'),
(70000035, 3, '2021-08-21'),
(70000036, 2, '2021-05-09'),
(70000037, 3, '2022-05-01'),
(70000038, 1, '2021-06-24'),
(70000039, 2, '2022-01-16'),
(70000040, 3, '2022-04-12'),
(70000041, 4, '2023-03-08'),
(70000042, 4, '2022-11-04'),
(70000043, 4, '2021-10-22'),
(70000044, 4, '2022-12-05'),
(70000045, 4, '2023-05-20'),
(70000046, 4, '2023-09-13'),
(70000047, 1, '2021-11-17'),
(70000048, 1, '2022-06-16'),
(70000049, 1, '2023-11-19'),
(70000050, 1, '2022-05-24'),
(70000051, 4, '2022-07-02'),
(70000052, 4, '2021-08-11'),
(70000053, 3, '2023-05-03'),
(70000054, 3, '2022-02-16'),
(70000055, 2, '2021-08-11'),
(70000056, 1, '2023-08-27'),
(70000057, 4, '2022-06-13'),
(70000058, 3, '2022-07-01'),
(70000059, 2, '2023-03-05'),
(70000060, 2, '2021-09-04'),
(70000061, 1, '2022-05-18'),
(70000062, 3, '2022-10-02'),
(70000063, 3, '2022-09-22'),
(70000064, 1, '2023-03-22'),
(70000065, 1, '2021-06-05'),
(70000066, 3, '2023-03-26'),
(70000067, 4, '2023-01-13'),
(70000068, 2, '2023-10-08'),
(70000069, 3, '2021-05-02'),
(70000070, 2, '2022-04-25'),
(70000071, 3, '2021-05-25'),
(70000072, 4, '2021-01-15'),
(70000073, 3, '2021-06-04'),
(70000074, 4, '2022-05-17'),
(70000075, 4, '2021-09-08'),
(70000076, 3, '2021-02-18'),
(70000077, 3, '2023-08-24'),
(70000078, 3, '2021-08-05'),
(70000079, 4, '2022-07-15'),
(70000080, 3, '2022-10-20'),
(70000081, 1, '2022-11-06'),
(70000082, 1, '2022-07-10'),
(70000083, 1, '2021-09-18'),
(70000084, 4, '2022-03-17'),
(70000085, 1, '2021-01-19'),
(70000086, 3, '2023-11-22'),
(70000087, 4, '2023-04-12'),
(70000088, 3, '2021-06-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula_curso`
--

CREATE TABLE `matricula_curso` (
  `codigo_mtr` int(11) NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  `grupo` varchar(1) DEFAULT NULL,
  `ausente` varchar(2) DEFAULT NULL,
  `C1` float DEFAULT NULL,
  `C2` float DEFAULT NULL,
  `C3` float DEFAULT NULL,
  `E1` float DEFAULT NULL,
  `E2` float DEFAULT NULL,
  `E3` float DEFAULT NULL,
  `nota_final` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `matricula_curso`
--

INSERT INTO `matricula_curso` (`codigo_mtr`, `codigo_curso`, `grupo`, `ausente`, `C1`, `C2`, `C3`, `E1`, `E2`, `E3`, `nota_final`) VALUES
(70000000, 1702121, 'A', 'N', 8, 8, 8, 13, 14, 20, 14),
(70000001, 1701101, 'B', 'N', 14, 18, 18, 18, 9, 16, 16),
(70000002, 1701102, 'B', 'N', 5, 7, 10, 19, 20, 13, 12),
(70000003, 1701104, 'B', 'N', 19, 19, 5, 14, 14, 11, 14),
(70000004, 1701105, 'D', 'N', 12, 11, 7, 18, 20, 20, 15),
(70000005, 1701106, 'D', 'N', 9, 13, 15, 15, 6, 6, 11),
(70000006, 1701107, 'C', 'N', 7, 8, 7, 11, 19, 20, 12),
(70000007, 1701114, 'D', 'N', 16, 7, 11, 19, 19, 9, 14),
(70000008, 1701208, 'E', 'N', 7, 20, 16, 13, 5, 13, 12),
(70000009, 1701209, 'C', 'N', 13, 18, 16, 14, 6, 13, 13),
(70000010, 1701210, 'A', 'N', 7, 10, 8, 20, 13, 7, 11),
(70000011, 1701212, 'B', 'N', 15, 20, 16, 5, 16, 8, 13),
(70000012, 1701215, 'A', 'N', 9, 19, 16, 13, 11, 19, 15),
(70000013, 1701216, 'A', 'N', 20, 20, 17, 19, 15, 9, 17),
(70000014, 1702117, 'C', 'N', 8, 18, 7, 11, 8, 20, 12),
(70000015, 1702118, 'C', 'N', 11, 10, 12, 7, 18, 18, 13),
(70000016, 1702119, 'A', 'N', 11, 16, 17, 18, 12, 5, 13),
(70000017, 1702120, 'B', 'N', 14, 15, 5, 9, 13, 5, 10),
(70000018, 1702121, 'A', 'N', 15, 8, 14, 17, 14, 7, 13),
(70000019, 1702122, 'E', 'N', 8, 8, 17, 12, 15, 14, 12),
(70000020, 1702123, 'C', 'N', 5, 13, 18, 18, 14, 5, 12),
(70000021, 1702224, 'B', 'N', 10, 18, 18, 5, 11, 11, 12),
(70000022, 1702225, 'D', 'N', 5, 19, 5, 19, 14, 17, 13),
(70000023, 1702226, 'D', 'N', 9, 14, 5, 20, 5, 10, 11),
(70000024, 1702227, 'A', 'N', 17, 11, 18, 18, 16, 7, 15),
(70000025, 1702228, 'C', 'N', 15, 16, 14, 19, 17, 12, 16),
(70000026, 1702229, 'D', 'N', 20, 18, 16, 8, 7, 18, 15),
(70000027, 1703130, 'D', 'N', 16, 16, 10, 9, 9, 20, 13),
(70000028, 1703131, 'E', 'N', 8, 6, 5, 8, 16, 6, 8),
(70000029, 1703132, 'B', 'N', 8, 20, 18, 6, 16, 9, 13),
(70000030, 1703133, 'D', 'N', 10, 13, 12, 9, 19, 6, 12),
(70000031, 1703134, 'A', 'N', 12, 8, 14, 6, 11, 16, 11),
(70000032, 1703135, 'B', 'N', 8, 6, 13, 11, 15, 13, 11),
(70000033, 1703236, 'A', 'N', 7, 15, 17, 12, 16, 8, 13),
(70000034, 1703237, 'E', 'N', 17, 17, 5, 19, 9, 19, 14),
(70000035, 1703238, 'E', 'N', 20, 7, 13, 16, 16, 19, 15),
(70000036, 1703239, 'B', 'N', 6, 18, 16, 6, 9, 11, 11),
(70000037, 1703240, 'D', 'N', 18, 6, 6, 10, 19, 15, 12),
(70000038, 1703241, 'E', 'N', 13, 18, 9, 6, 13, 13, 12),
(70000039, 1704142, 'C', 'N', 6, 14, 5, 12, 13, 6, 9),
(70000040, 1704143, 'D', 'N', 17, 19, 9, 7, 12, 16, 13),
(70000041, 1704144, 'C', 'N', 5, 16, 19, 5, 13, 13, 12),
(70000042, 1704145, 'C', 'N', 12, 10, 6, 15, 11, 19, 12),
(70000043, 1704146, 'E', 'N', 17, 9, 9, 11, 5, 12, 11),
(70000044, 1704147, 'C', 'N', 19, 6, 18, 5, 6, 7, 10),
(70000045, 1704248, 'E', 'N', 18, 10, 9, 15, 17, 15, 14),
(70000046, 1704249, 'B', 'N', 19, 10, 19, 11, 7, 18, 14),
(70000047, 1704250, 'E', 'N', 13, 5, 6, 16, 17, 19, 13),
(70000048, 1704251, 'C', 'N', 10, 11, 18, 18, 20, 18, 16),
(70000049, 1704252, 'B', 'N', 10, 10, 20, 8, 16, 8, 12),
(70000050, 1704253, 'A', 'N', 10, 16, 7, 13, 7, 15, 11),
(70000051, 1704254, 'A', 'N', 7, 20, 9, 11, 15, 17, 13),
(70000052, 1704255, 'B', 'N', 14, 10, 18, 7, 9, 16, 12),
(70000053, 1705156, 'D', 'N', 5, 12, 12, 20, 6, 9, 11),
(70000054, 1705157, 'A', 'N', 20, 5, 18, 16, 16, 18, 16),
(70000055, 1705158, 'B', 'N', 15, 12, 11, 12, 18, 6, 12),
(70000056, 1705159, 'B', 'N', 19, 13, 7, 20, 7, 5, 12),
(70000057, 1705160, 'A', 'N', 10, 11, 6, 19, 11, 11, 11),
(70000058, 1705161, 'B', 'N', 19, 9, 8, 10, 18, 15, 13),
(70000059, 1705162, 'D', 'N', 15, 10, 18, 11, 8, 13, 13),
(70000060, 1705163, 'B', 'N', 19, 12, 5, 18, 19, 20, 16),
(70000061, 1705164, 'A', 'N', 17, 9, 13, 12, 20, 17, 15),
(70000062, 1705265, 'C', 'N', 7, 10, 9, 15, 13, 17, 12),
(70000063, 1705266, 'C', 'N', 12, 11, 18, 13, 8, 9, 12),
(70000064, 1705267, 'D', 'N', 11, 16, 5, 7, 8, 9, 9),
(70000065, 1705268, 'B', 'N', 13, 16, 13, 11, 8, 19, 13),
(70000066, 1705269, 'C', 'N', 19, 13, 19, 9, 5, 8, 12),
(70000067, 1705270, 'E', 'N', 5, 20, 19, 19, 5, 20, 15),
(70000068, 1703237, 'C', 'N', 10, 6, 17, 6, 18, 20, 13),
(70000069, 1703238, 'E', 'N', 8, 16, 20, 6, 14, 14, 13),
(70000070, 1703239, 'A', 'N', 7, 19, 9, 5, 10, 19, 12),
(70000071, 1703237, 'B', 'N', 19, 8, 16, 7, 9, 18, 13),
(70000072, 1703238, 'D', 'N', 5, 16, 11, 20, 6, 14, 12),
(70000073, 1703239, 'A', 'N', 19, 17, 17, 11, 6, 13, 14),
(70000074, 1703237, 'C', 'N', 9, 15, 15, 18, 14, 5, 13),
(70000075, 1703238, 'C', 'N', 20, 16, 7, 19, 13, 13, 15),
(70000076, 1703239, 'A', 'N', 12, 14, 8, 14, 20, 12, 13),
(70000077, 1705160, 'B', 'N', 11, 10, 18, 6, 12, 8, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `no_becario`
--

CREATE TABLE `no_becario` (
  `codigo_estu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `no_becario`
--

INSERT INTO `no_becario` (`codigo_estu`) VALUES
(13548669),
(35489768),
(38112345),
(38712349),
(38782349),
(63155203),
(64958826),
(65548456),
(65548477),
(66457812),
(66514853),
(66541893),
(68452315),
(70219223),
(70414462),
(71091947),
(71113233),
(71277642),
(71736358),
(71899225),
(71953434),
(72191607),
(72275629),
(72534757),
(72640567),
(72883406),
(72973309),
(72979311),
(73043546),
(73348181),
(73585244),
(73768171),
(74589859),
(74825994),
(75238682),
(76316791),
(76333780),
(76814598),
(76977921),
(77052403),
(77236880),
(77375380),
(77584095),
(77584695),
(77796783),
(77960545),
(78119579),
(78172043),
(78233416),
(78374418),
(78419312),
(78785279),
(79196466),
(79306078),
(79309864),
(79885368),
(84512307),
(84771203),
(90026346),
(91786346),
(94881526),
(95916646),
(98412345),
(98413345),
(98452315),
(98452345),
(98452375);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `codigo` int(11) NOT NULL,
  `primer_apellido` varchar(100) DEFAULT NULL,
  `segundo_apellido` varchar(100) DEFAULT NULL,
  `primer_nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`codigo`, `primer_apellido`, `segundo_apellido`, `primer_nombre`, `direccion`, `sexo`, `password`) VALUES
(13548669, 'Quispe', 'Rojas', 'Javier Wilber', 'Calle Moral 402', 'm', 'quispe135'),
(35489768, 'Zamalloa', 'Molina', 'Sebastián Agenor', 'Av El Alto 635', 'm', 'zamalloa354'),
(38112345, 'Escarza', 'Pacori', 'Alexander Raúl', 'Av. Parra 1003', 'm', 'escarza381'),
(38712349, 'López', 'Condori', 'Andrea Del Rosario', 'Av. Parra 180', 'f', 'lópez387'),
(38782349, 'Condori', 'Casquino', 'Ebert Luis', 'Av. Parra 190', 'm', 'condori387'),
(48105236, 'Nizama', 'Céspedes', 'Juan Carlos Antonio', 'Av. Asuncion 662', 'm', 'nizama481'),
(56480512, 'Quilca', 'Huamani', 'Bryan Anthony', 'Calle Peral 1104', 'm', 'quilca564'),
(61541897, 'Lazo', 'Paxi', 'Natalie Marleny', 'Av. Independencia 301', 'f', 'lazo615'),
(63155203, 'Gutiérrez', 'Zevallos', 'Jaime José', 'Calle Los Rosales 526', 'm', 'gutiérrez631'),
(64958826, 'Lupo', 'Condori', 'Avelino', 'Av. Independencia 632', 'm', 'lupo649'),
(65482352, 'Mayorga', 'Villena', 'Jharold Alonso', 'Calle Cruz Verde 804', 'm', 'mayorga654'),
(65548456, 'Sucasaca', 'Chire', 'Edward Henry', 'Calle Moral 362', 'm', 'sucasaca655'),
(65548477, 'Martínez', 'Choque', 'Aldo Raúl', 'Calle El Progreso 368', 'm', 'martínez655'),
(66451287, 'Hualpa', 'López', 'José Mauricio', 'Av Las Marianas 657', 'm', 'hualpa664'),
(66457812, 'Olazábal', 'Chávez', 'Neill Elverth', 'Calle El Progreso 1090', 'm', 'olazábal664'),
(66514853, 'Maldonado', 'Parejo', 'Roy Abel', 'Av. Asuncion 405', 'm', 'maldonado665'),
(66541893, 'Yavar', 'Guillen', 'Roberto Gustavo', 'Av. El Alto 363', 'm', 'yavar665'),
(68452315, 'Ccama', 'Marrón', 'Gustavo Alonso', 'Calle Los Rosales 200', 'm', 'ccama684'),
(70086861, 'BAUTISTA', 'Suni', 'Franco', 'Av. BAUTISTA 102 Apt.', 'F', 'bautista700'),
(70202416, 'AMARU', 'Arqque', 'Beaton', 'Av. ANCALLA 193 Apt.', 'F', 'amaru702'),
(70219223, 'DELGADO', 'Toledo', 'Gonzalo', 'Av. DELGADO 136 Apt.', 'F', 'delgado702'),
(70414462, 'CHIPANA', 'Calapuja', 'Anyela', 'Av. CHISI 27 Apt.', 'M', 'chipana704'),
(70906320, 'CAYO', 'Larico', 'Junior', 'Av. CCACYA 118 Apt.', 'F', 'cayo709'),
(70979676, 'CERVANTES', 'Condori', 'Milagros', 'Av. CHACCA 132 Apt.', 'M', 'cervantes709'),
(71091947, 'CHIPA', 'Naventa', 'Anyi', 'Av. CHIPANA 153 Apt.', 'M', 'chipa710'),
(71113233, 'CONDOR', 'Oscanoa', 'Manuel', 'Av. CONDORI 28 Apt.', 'F', 'condor711'),
(71277642, 'CHANCAHUIRE', 'Velasquez', 'Ines', 'Av. CHARCCAHUANA 31 Apt.', 'M', 'chancahuire712'),
(71736358, 'CRUZ', 'Cornejo', 'Yanina', 'Av. CRUZ 42 Apt.', 'M', 'cruz717'),
(71860523, 'CCASA', 'Mamani', 'Adrian', 'Av. CCOSCCO 103 Apt.', 'F', 'ccasa718'),
(71899225, 'ESCALANTE', 'Alarcon', 'Dolores', 'Av.  140 Apt.', 'M', 'escalante718'),
(71953434, 'CUTI', 'Bustamante', 'Nayda', 'Av. CUTISACA 102 Apt.', 'M', 'cuti719'),
(72060523, 'ANCCO', 'Mamani', 'Alejandra', 'Av. ANCCO 34 Apt.', 'M', 'ancco720'),
(72153488, 'CCALLO', 'Huamani', 'Maricielo', 'Av. CCANSAYA 172 Apt.', 'M', 'ccallo721'),
(72183063, 'BENITO', 'Coila', 'Dayana', 'Av. BRAVO 95 Apt.', 'M', 'benito721'),
(72189703, 'BRAVO', 'Torvisco', 'Sara', 'Av. BRICEÑO 24 Apt.', 'M', 'bravo721'),
(72191607, 'EGUILUZ', 'Anco', 'Nicoll', 'Av. ESCALANTE 130 Apt.', 'M', 'eguiluz721'),
(72275629, 'CONDOR', 'Alcca', 'Meliza', 'Av. CONDOR 90 Apt.', 'M', 'condor722'),
(72454793, 'AQUIMA', 'Yauri', 'Lisbeth', 'Av. ARAPA 48 Apt.', 'M', 'aquima724'),
(72500380, 'CALA', 'Huaman', 'Soledad', 'Av. CALLATA 59 Apt.', 'M', 'cala725'),
(72534757, 'CHALCO', 'Huaracha', 'Brigitt', 'Av. CHANCAHUIRE 81 Apt.', 'M', 'chalco725'),
(72640567, 'ESCALANTE', 'Laqui', 'Fabiola', 'Av. ESCALANTE 196 Apt.', 'M', 'escalante726'),
(72750192, 'AYCHASI', 'Lazo', 'Madeleine', 'Av. AYMA 55 Apt.', 'M', 'aychasi727'),
(72825356, 'CAUNA', 'Condori', 'Luis', 'Av. CAYLLAHUA 195 Apt.', 'F', 'cauna728'),
(72883406, 'CHISI', 'Suni', 'Alberto', 'Av. CHOQUEHUANCA 55 Apt.', 'F', 'chisi728'),
(72973309, 'CONDORI', 'Barrios', 'Karina', 'Av. CONDORI 64 Apt.', 'M', 'condori729'),
(72979311, 'DELGADO', 'Guillen', 'Li', 'Av. DELGADO 114 Apt.', 'M', 'delgado729'),
(73010010, 'ACHAHUI', 'Vilca', 'Maricela', 'Av. Leonardo, Apto 21', 'M', 'achahui730'),
(73043546, 'CHOQUEHUANCA', 'Mamani', 'Ronal', 'Av. CHULLUNQUIA 134 Apt.', 'F', 'choquehuanca730'),
(73348181, 'DE LA CRUZ', 'Vilca', 'Andrea', 'Av. DEL CARPIO 129 Apt.', 'M', 'de la cruz733'),
(73513384, 'AYMA', 'Cutipa', 'Emanuel', 'Av. BARRETO 21 Apt.', 'F', 'ayma735'),
(73585244, 'CHULLUNQUIA', 'Chancayauri', 'Yanely', 'Av. CHUNCA 14 Apt.', 'M', 'chullunquia735'),
(73620015, 'CALLATA', 'Chambi', 'Jornet', 'Av. CALSINA 176 Apt.', 'F', 'callata736'),
(73654425, 'ARAPA', 'Quispe', 'Edith', 'Av. ARCE 36 Apt.', 'M', 'arapa736'),
(73768171, 'Roque', 'Sosa', 'Owen Haziel', 'Calle Arequipa 401', 'm', 'roque737'),
(73939626, 'ARCE', 'Vargas', 'Tali', 'Av. ARESTEGUI 58 Apt.', 'M', 'arce739'),
(73952118, 'CAYLLAHUA', 'Gutierrez', 'Yampier', 'Av. CAYO 172 Apt.', 'F', 'cayllahua739'),
(74175880, 'ALVARADO', 'Gutierrez', 'Yelmar', 'Av. ALVAREZ 176 Apt.', 'F', 'alvarado741'),
(74304954, 'CCACYA', 'Suri', 'Clinton', 'Av. CCALLO 177 Apt.', 'F', 'ccacya743'),
(74434256, 'CCOSCCO', 'Castañeda', 'Cristian', 'Av. CENTENO 121 Apt.', 'F', 'ccoscco744'),
(74589859, 'CHINO', 'Perez', 'Alexandra', 'Av. CHIPA 159 Apt.', 'M', 'chino745'),
(74641837, 'CASTRO', 'Cusi', 'Nicole xiomara', 'Av. CAUNA 124 Apt.', 'M', 'castro746'),
(74825994, 'DEL CASTILLO', 'Ovalle', 'Yadira', 'Av. DELGADO 15 Apt.', 'M', 'del castillo748'),
(75238682, 'CRUZ', 'Chura', 'Alexander', 'Av. CUTI 29 Apt.', 'F', 'cruz752'),
(75456915, 'BEDREGAL', 'Añamuro', 'Evelyn', 'Av. BEJARANO 66 Apt.', 'M', 'bedregal754'),
(75503317, 'BEJARANO', 'Villamar', 'Franshesca', 'Av. BENITO 19 Apt.', 'M', 'bejarano755'),
(75558931, 'CAPIA', 'Gonza', 'Esmeralda', 'Av. CASQUINA 70 Apt.', 'M', 'capia755'),
(75890837, 'ANCCO', 'Valdivia', 'Maricruz', 'Av. APAZA 65 Apt.', 'M', 'ancco758'),
(75955896, 'AGUILAR', 'Cuela', 'Elizabeth', 'Vereda Saul, Piso 60', 'M', 'aguilar759'),
(76166388, 'ACHINQUIPA', 'Jauja', 'Elvis', 'Carretera Angela, Hab. 1', 'F', 'achinquipa761'),
(76276765, 'BATALLANOS', 'Caceres', 'Alison', 'Av. BAUTISTA 149 Apt.', 'M', 'batallanos762'),
(76316791, 'CHALCO', 'Trelles', 'Daleska', 'Av. CHALCO 52 Apt.', 'M', 'chalco763'),
(76333780, 'CORNEJO', 'Coaguila', 'Leonardo', 'Av. CRUZ 149 Apt.', 'F', 'cornejo763'),
(76381469, 'CENTENO', 'Maldonado', 'Maria fe', 'Av. CERVANTES 132 Apt.', 'M', 'centeno763'),
(76404035, 'ARTEAGA', 'Gaitan', 'Mercedes', 'Av. AYCHASI 151 Apt.', 'M', 'arteaga764'),
(76462285, 'CAMARGO', 'Salas', 'Yenny', 'Av. CAÑAPATAÑA 57 Apt.', 'M', 'camargo764'),
(76556379, 'CASQUINA', 'Gonzales', 'Jessica', 'Av. CASTAÑEDA 84 Apt.', 'M', 'casquina765'),
(76724829, 'CHAHUARA', 'Huamani', 'Daniela', 'Av. CHALCO 188 Apt.', 'M', 'chahuara767'),
(76814598, 'Huamán', 'Coaquira', 'Luciana Julissa', 'Av Las Marianas 452', 'f', 'huamán768'),
(76841532, 'Maldonado', 'Casilla', 'Braulio Nayap', 'Calle Cruz Verde 965-A', 'm', 'maldonado768'),
(76977921, 'CONDORI', 'Mendoza', 'Sthefany', 'Av. CONDORI 102 Apt.', 'M', 'condori769'),
(77052403, 'DELGADO', 'Valencia', 'Samuel', 'Av. EGUILUZ 117 Apt.', 'F', 'delgado770'),
(77236880, 'CRUZ', 'Llamoca', 'Gladys', 'Av. CRUZ 99 Apt.', 'M', 'cruz772'),
(77281276, 'ANCALLA', 'Castro', 'Cristian', 'Av. ANCCO 11 Apt.', 'F', 'ancalla772'),
(77375380, 'CONDORI', 'Morales', 'Yomara', 'Av. CONDORI 77 Apt.', 'M', 'condori773'),
(77494739, 'CAHUANA', 'Mamani', 'Haydee', 'Av. CALA 120 Apt.', 'M', 'cahuana774'),
(77584095, 'Montoya', 'Choque', 'Leonardo', 'Calle El Progreso 539', 'm', 'montoya775'),
(77584695, 'Davis', 'Coropuna', 'León Felipe', 'Av El Alto 539', 'm', 'davis775'),
(77796783, 'DEL CARPIO', 'Pinto', 'Daniel', 'Av. DEL CASTILLO 30 Apt.', 'F', 'del carpio777'),
(77918846, 'ARESTEGUI', 'Mamani', 'Anshelic', 'Av. ARTEAGA 73 Apt.', 'F', 'arestegui779'),
(77947004, 'CCANSAYA', 'Fernandez', 'Emerson', 'Av. CCASA 15 Apt.', 'F', 'ccansaya779'),
(77960545, 'CHAVEZ', 'Chambi', 'Julia', 'Av. CHINO 13 Apt.', 'M', 'chavez779'),
(78119579, 'CHARCCAHUANA', 'Savina', 'Elizabet', 'Av. CHAVEZ 199 Apt.', 'M', 'charccahuana781'),
(78153990, 'CHACCA', 'Llaique', 'Miguel', 'Av. CHAHUARA 89 Apt.', 'F', 'chacca781'),
(78172043, 'CONDORI', 'Aguilar', 'Milagros', 'Av. CORNEJO 186 Apt.', 'M', 'condori781'),
(78233416, 'Apaza', 'Quispe', 'Angel Abraham', 'Calle Toledo 512', 'm', 'apaza782'),
(78374418, 'COJOMA', 'Osorio', 'Concepcion', 'Av. CONCHA 149 Apt.', 'M', 'cojoma783'),
(78389577, 'BAUTISTA', 'Pfoccori', 'Grober', 'Av. BEDREGAL 94 Apt.', 'F', 'bautista783'),
(78419312, 'CUTISACA', 'Lope', 'Delia', 'Av. DE LA CRUZ 175 Apt.', 'M', 'cutisaca784'),
(78587322, 'ALVAREZ', 'Amaro', 'Ibeth', 'Av. AMARU 58 Apt.', 'M', 'alvarez785'),
(78785279, 'CHINO', 'Cuno', 'Rodrigo', 'Av. CHINO 76 Apt.', 'F', 'chino787'),
(78859852, 'CASTAÑEDA', 'Choccata', 'Gabriel', 'Av. CASTRO 181 Apt.', 'F', 'castañeda788'),
(78869829, 'CAÑAPATAÑA', 'Potosi', 'Manuel', 'Av. CAPIA 197 Apt.', 'F', 'cañapataña788'),
(79128835, 'ARAPA', 'Mamani', 'Erikson', 'Av. ARAPA 106 Apt.', 'F', 'arapa791'),
(79163434, 'BARRETO', 'Noa', 'Shirley', 'Av. BATALLANOS 119 Apt.', 'M', 'barreto791'),
(79192829, 'CALSINA', 'Morales', 'Williams', 'Av. CAMARGO 7 Apt.', 'F', 'calsina791'),
(79196466, 'CHAVEZ', 'Tito', 'Estell', 'Av. CHAVEZ 116 Apt.', 'M', 'chavez791'),
(79293044, 'CENTENO', 'Huillcacuri', 'Stefany', 'Av. CENTENO 80 Apt.', 'M', 'centeno792'),
(79306078, 'CONCHA', 'Urday', 'Nicold', 'Av. CONDOR 53 Apt.', 'M', 'concha793'),
(79309864, 'CHAVEZ', 'Choque', 'Alondra', 'Av. CHAVEZ 185 Apt.', 'M', 'chavez793'),
(79356988, 'BRICEÑO', 'Uscca', 'Del rosario', 'Av. CAHUANA 173 Apt.', 'M', 'briceño793'),
(79486845, 'APAZA', 'Apaza', 'Bruno', 'Av. AQUIMA 77 Apt.', 'F', 'apaza794'),
(79885368, 'CHUNCA', 'Quispe', 'Beberly', 'Av. COJOMA 197 Apt.', 'M', 'chunca798'),
(84512307, 'Taya', 'Yana', 'Samuel Omar', 'Calle Peral 1503', 'm', 'taya845'),
(84771203, 'Mogollón', 'Cáceres', 'Sergio Daniel', 'Av. El Alto 586', 'm', 'mogollón847'),
(90026346, 'Parizaca', 'Mozo', 'Paul Antony', 'Av. El Sol 41', 'm', 'parizaca900'),
(91786346, 'Mena', 'Quispe', 'Sergio Sebastián Santos', 'Av. Venezuela 941', 'm', 'mena917'),
(92321021, 'Jaeger', 'Ganso', 'Eren', 'Av. Maria 325', 'm', 'jaeger923'),
(94881526, 'Castillo', 'Sancho', 'Sergio Ahmed', 'Calle Peral 102', 'm', 'castillo948'),
(95486638, 'Zhong', 'Callasi', 'Linghai Joaquín', 'Av El Alto 639', 'm', 'zhong954'),
(95916646, 'Mariños', 'Hilario', 'Princce Yorwin', 'Av. Venezuela 841', 'm', 'mariños959'),
(96236651, 'Pardavé', 'Espinoza', 'Christian', 'Calle Toledo 1024', 'm', 'pardavé962'),
(96320122, 'Ackerman', 'Turing', 'Mikasa', 'Av. Maria 230', 'f', 'ackerman963'),
(98112345, 'Cacsire', 'Sánchez', 'Jhosep Angel', 'Av. Parra 1004', 'm', 'cacsire981'),
(98412345, 'Gonzales', 'Condori', 'Alejandro Javier', 'Calle Los Rosales 300', 'm', 'gonzales984'),
(98413345, 'Ruiz', 'Mamani', 'Eduardo Germán', 'Calle Los Rosales 406', 'm', 'ruiz984'),
(98452315, 'Apaza', 'Apaza', 'Nelzon Jorge', 'Av. El Sol 480', 'm', 'apaza984'),
(98452345, 'Carazas', 'Quispe', 'Alessander Jesus', 'Calle Los Rosales 400', 'm', 'carazas984'),
(98452375, 'Cerpa', 'García', 'Jean Franco', 'Av. Asuncion 105', 'm', 'cerpa984'),
(98452715, 'Cayllahua', 'Gutierrez', 'Diego Yampier', 'Av. El Sol 481', 'm', 'cayllahua984'),
(98732341, 'Benavente', 'Aguirre', 'Paolo Daniel', 'Av. Independencia 1080', 'm', 'benavente987');

--
-- Disparadores `persona`
--
DELIMITER $$
CREATE TRIGGER `crear_correo` AFTER INSERT ON `persona` FOR EACH ROW BEGIN
	INSERT persona_correo VALUES (NEW.codigo , concat(LCASE(LEFT(NEW.primer_nombre,1)) , LCASE(NEW.primer_apellido) , "@unsa.edu.pe"));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `codigo_personal` int(11) NOT NULL,
  `sueldo` float DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_final` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`codigo_personal`, `sueldo`, `fecha_inicio`, `fecha_final`) VALUES
(70086861, 1222, '2017-05-26', '2025-12-13'),
(70202416, 1571, '2017-04-09', '2025-01-07'),
(70906320, 1219, '2017-04-02', '2021-09-11'),
(72060523, 1771, '2020-08-09', '2024-03-07'),
(72183063, 1287, '2019-09-16', '2022-07-18'),
(72189703, 1327, '2019-02-08', '2025-02-01'),
(72454793, 1944, '2019-06-27', '2023-12-12'),
(72500380, 1930, '2020-09-13', '2023-05-04'),
(72750192, 4019, '2017-04-25', '2021-04-21'),
(72825356, 1875, '2019-07-13', '2022-02-09'),
(73010010, 1298, '2017-03-14', '2025-04-21'),
(73513384, 1661, '2018-07-08', '2021-12-05'),
(73620015, 1534, '2020-09-14', '2023-10-26'),
(73654425, 4552, '2018-01-06', '2023-05-13'),
(73939626, 2277, '2019-12-06', '2022-09-06'),
(73952118, 1911, '2019-07-18', '2025-07-02'),
(74175880, 4161, '2018-12-07', '2024-11-13'),
(74641837, 1823, '2017-12-28', '2020-07-28'),
(75456915, 1615, '2018-12-24', '2025-06-10'),
(75503317, 1985, '2020-01-05', '2024-09-08'),
(75558931, 1244, '2019-08-15', '2020-12-11'),
(75890837, 4060, '2019-12-07', '2021-12-22'),
(75955896, 1822, '2018-05-23', '2021-02-09'),
(76166388, 3308, '2020-04-20', '2024-02-28'),
(76276765, 2504, '2016-01-21', '2021-08-08'),
(76404035, 3781, '2019-08-17', '2024-03-04'),
(76462285, 1697, '2018-10-02', '2025-03-18'),
(76556379, 2198, '2019-09-14', '2020-07-12'),
(77281276, 1579, '2019-10-28', '2020-08-28'),
(77494739, 1467, '2016-08-04', '2024-08-13'),
(77918846, 4917, '2020-08-25', '2023-04-21'),
(78389577, 1408, '2020-09-02', '2022-02-18'),
(78587322, 2232, '2018-02-05', '2023-03-01'),
(78859852, 1932, '2016-03-22', '2022-10-07'),
(78869829, 1299, '2018-06-23', '2025-06-22'),
(79128835, 3732, '2018-08-20', '2022-04-25'),
(79163434, 3520, '2019-04-11', '2020-07-17'),
(79192829, 2180, '2020-02-25', '2023-01-14'),
(79356988, 1334, '2020-11-15', '2025-04-17'),
(79486845, 2577, '2020-02-02', '2025-09-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona_correo`
--

CREATE TABLE `persona_correo` (
  `codigo_persona` int(11) NOT NULL,
  `correo` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona_correo`
--

INSERT INTO `persona_correo` (`codigo_persona`, `correo`) VALUES
(13548669, 'jquispe@unsa.edu.pe'),
(35489768, 'szamalloa@unsa.edu.pe'),
(38112345, 'aescarza@unsa.edu.pe'),
(38712349, 'alópez@unsa.edu.pe'),
(38782349, 'econdori@unsa.edu.pe'),
(48105236, 'jnizama@unsa.edu.pe'),
(56480512, 'bquilca@unsa.edu.pe'),
(61541897, 'nlazo@unsa.edu.pe'),
(63155203, 'jgutiérrez@unsa.edu.pe'),
(64958826, 'alupo@unsa.edu.pe'),
(65482352, 'jmayorga@unsa.edu.pe'),
(65548456, 'esucasaca@unsa.edu.pe'),
(65548477, 'amartínez@unsa.edu.pe'),
(66451287, 'jhualpa@unsa.edu.pe'),
(66457812, 'nolazábal@unsa.edu.pe'),
(66514853, 'rmaldonado@unsa.edu.pe'),
(66541893, 'ryavar@unsa.edu.pe'),
(68452315, 'gccama@unsa.edu.pe'),
(70086861, 'fbautista@unsa.edu.pe'),
(70202416, 'bamaru@unsa.edu.pe'),
(70219223, 'gdelgado@unsa.edu.pe'),
(70414462, 'achipana@unsa.edu.pe'),
(70906320, 'jcayo@unsa.edu.pe'),
(70979676, 'mcervantes@unsa.edu.pe'),
(71091947, 'achipa@unsa.edu.pe'),
(71113233, 'mcondor@unsa.edu.pe'),
(71277642, 'ichancahuire@unsa.edu.pe'),
(71736358, 'ycruz@unsa.edu.pe'),
(71860523, 'accasa@unsa.edu.pe'),
(71899225, 'descalante@unsa.edu.pe'),
(71953434, 'ncuti@unsa.edu.pe'),
(72060523, 'aancco@unsa.edu.pe'),
(72153488, 'mccallo@unsa.edu.pe'),
(72183063, 'dbenito@unsa.edu.pe'),
(72189703, 'sbravo@unsa.edu.pe'),
(72191607, 'neguiluz@unsa.edu.pe'),
(72275629, 'mcondor@unsa.edu.pe'),
(72454793, 'laquima@unsa.edu.pe'),
(72500380, 'scala@unsa.edu.pe'),
(72534757, 'bchalco@unsa.edu.pe'),
(72640567, 'fescalante@unsa.edu.pe'),
(72750192, 'maychasi@unsa.edu.pe'),
(72825356, 'lcauna@unsa.edu.pe'),
(72883406, 'achisi@unsa.edu.pe'),
(72973309, 'kcondori@unsa.edu.pe'),
(72979311, 'ldelgado@unsa.edu.pe'),
(73010010, 'machahui@unsa.edu.pe'),
(73043546, 'rchoquehuanca@unsa.edu.pe'),
(73348181, 'ade la cruz@unsa.edu.pe'),
(73513384, 'eayma@unsa.edu.pe'),
(73585244, 'ychullunquia@unsa.edu.pe'),
(73620015, 'jcallata@unsa.edu.pe'),
(73654425, 'earapa@unsa.edu.pe'),
(73768171, 'oroque@unsa.edu.pe'),
(73939626, 'tarce@unsa.edu.pe'),
(73952118, 'ycayllahua@unsa.edu.pe'),
(74175880, 'yalvarado@unsa.edu.pe'),
(74304954, 'cccacya@unsa.edu.pe'),
(74434256, 'cccoscco@unsa.edu.pe'),
(74589859, 'achino@unsa.edu.pe'),
(74641837, 'ncastro@unsa.edu.pe'),
(74825994, 'ydel castillo@unsa.edu.pe'),
(75238682, 'acruz@unsa.edu.pe'),
(75456915, 'ebedregal@unsa.edu.pe'),
(75503317, 'fbejarano@unsa.edu.pe'),
(75558931, 'ecapia@unsa.edu.pe'),
(75890837, 'mancco@unsa.edu.pe'),
(75955896, 'eaguilar@unsa.edu.pe'),
(76166388, 'eachinquipa@unsa.edu.pe'),
(76276765, 'abatallanos@unsa.edu.pe'),
(76316791, 'dchalco@unsa.edu.pe'),
(76333780, 'lcornejo@unsa.edu.pe'),
(76381469, 'mcenteno@unsa.edu.pe'),
(76404035, 'marteaga@unsa.edu.pe'),
(76462285, 'ycamargo@unsa.edu.pe'),
(76556379, 'jcasquina@unsa.edu.pe'),
(76724829, 'dchahuara@unsa.edu.pe'),
(76814598, 'lhuamán@unsa.edu.pe'),
(76841532, 'bmaldonado@unsa.edu.pe'),
(76977921, 'scondori@unsa.edu.pe'),
(77052403, 'sdelgado@unsa.edu.pe'),
(77236880, 'gcruz@unsa.edu.pe'),
(77281276, 'cancalla@unsa.edu.pe'),
(77375380, 'ycondori@unsa.edu.pe'),
(77494739, 'hcahuana@unsa.edu.pe'),
(77584095, 'lmontoya@unsa.edu.pe'),
(77584695, 'ldavis@unsa.edu.pe'),
(77796783, 'ddel carpio@unsa.edu.pe'),
(77918846, 'aarestegui@unsa.edu.pe'),
(77947004, 'eccansaya@unsa.edu.pe'),
(77960545, 'jchavez@unsa.edu.pe'),
(78119579, 'echarccahuana@unsa.edu.pe'),
(78153990, 'mchacca@unsa.edu.pe'),
(78172043, 'mcondori@unsa.edu.pe'),
(78233416, 'aapaza@unsa.edu.pe'),
(78374418, 'ccojoma@unsa.edu.pe'),
(78389577, 'gbautista@unsa.edu.pe'),
(78419312, 'dcutisaca@unsa.edu.pe'),
(78587322, 'ialvarez@unsa.edu.pe'),
(78785279, 'rchino@unsa.edu.pe'),
(78859852, 'gcastañeda@unsa.edu.pe'),
(78869829, 'mcañapataña@unsa.edu.pe'),
(79128835, 'earapa@unsa.edu.pe'),
(79163434, 'sbarreto@unsa.edu.pe'),
(79192829, 'wcalsina@unsa.edu.pe'),
(79196466, 'echavez@unsa.edu.pe'),
(79293044, 'scenteno@unsa.edu.pe'),
(79306078, 'nconcha@unsa.edu.pe'),
(79309864, 'achavez@unsa.edu.pe'),
(79356988, 'dbriceño@unsa.edu.pe'),
(79486845, 'bapaza@unsa.edu.pe'),
(79885368, 'bchunca@unsa.edu.pe'),
(84512307, 'staya@unsa.edu.pe'),
(84771203, 'smogollón@unsa.edu.pe'),
(90026346, 'pparizaca@unsa.edu.pe'),
(91786346, 'smena@unsa.edu.pe'),
(94881526, 'scastillo@unsa.edu.pe'),
(95486638, 'lzhong@unsa.edu.pe'),
(95916646, 'pmariños@unsa.edu.pe'),
(96236651, 'cpardavé@unsa.edu.pe'),
(96320122, 'mackerman@unsa.edu.pe'),
(98112345, 'jcacsire@unsa.edu.pe'),
(98412345, 'agonzales@unsa.edu.pe'),
(98413345, 'eruiz@unsa.edu.pe'),
(98452315, 'napaza@unsa.edu.pe'),
(98452345, 'acarazas@unsa.edu.pe'),
(98452375, 'jcerpa@unsa.edu.pe'),
(98452715, 'dcayllahua@unsa.edu.pe'),
(98732341, 'pbenavente@unsa.edu.pe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona_depa`
--

CREATE TABLE `persona_depa` (
  `codigo_depa` int(11) NOT NULL,
  `codigo_persona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona_depa`
--

INSERT INTO `persona_depa` (`codigo_depa`, `codigo_persona`) VALUES
(1000, 72973309),
(1000, 76556379),
(1000, 76814598),
(1000, 77960545),
(1001, 72500380),
(1001, 73952118),
(1001, 96236651),
(1002, 70219223),
(1002, 74589859),
(1002, 76333780),
(1002, 79486845),
(1002, 92321021),
(1003, 76276765),
(1004, 72750192),
(1004, 73513384),
(1004, 77375380),
(1005, 71277642),
(1005, 72979311),
(1005, 75456915),
(1005, 79309864),
(1005, 98412345),
(1006, 72534757),
(1006, 76404035),
(1006, 77281276),
(1006, 77947004),
(1007, 72191607),
(1007, 79306078),
(1007, 95916646),
(1008, 63155203),
(1008, 72189703),
(1008, 78119579),
(1008, 79163434),
(1008, 98413345),
(1008, 98452345),
(1009, 65548477),
(1009, 66457812),
(1009, 72825356),
(1010, 65482352),
(1010, 70202416),
(1010, 72183063),
(1010, 73654425),
(1010, 75955896),
(1010, 78869829),
(1011, 66514853),
(1011, 73043546),
(1011, 75503317),
(1011, 79293044),
(1012, 48105236),
(1012, 70414462),
(1012, 73939626),
(1012, 75238682),
(1012, 98452375),
(1013, 68452315),
(1013, 74825994),
(1013, 90026346),
(1013, 96320122),
(1014, 71860523),
(1014, 74304954),
(1014, 76316791),
(1014, 77584695),
(1015, 64958826),
(1016, 73768171),
(1016, 78389577),
(1016, 98732341),
(1017, 35489768),
(1017, 72454793),
(1017, 76724829),
(1017, 78172043),
(1019, 65548456),
(1019, 73585244),
(1019, 78419312),
(1019, 78587322),
(1020, 71899225),
(1020, 73620015),
(1021, 66451287),
(1021, 66541893),
(1021, 72883406),
(1021, 95486638),
(1022, 38782349),
(1022, 84771203),
(1023, 73010010),
(1024, 72640567),
(1024, 76381469),
(1024, 78785279),
(1024, 78859852),
(1025, 72060523),
(1025, 98112345),
(1026, 71113233),
(1026, 74175880),
(1026, 79128835),
(1026, 79192829),
(1026, 79196466),
(1026, 79356988),
(1026, 91786346),
(1027, 61541897),
(1027, 71736358),
(1027, 78153990),
(1028, 76462285),
(1028, 77052403),
(1029, 70906320),
(1029, 71091947),
(1029, 74434256),
(1030, 73348181),
(1031, 76166388),
(1031, 78374418),
(1032, 38112345),
(1032, 72153488),
(1032, 72275629),
(1032, 76841532),
(1032, 77236880),
(1033, 70979676),
(1033, 77796783),
(1033, 79885368),
(1034, 77584095),
(1035, 13548669),
(1035, 74641837),
(1035, 75890837),
(1035, 76977921),
(1035, 77918846),
(1035, 78233416),
(1036, 75558931),
(1037, 56480512),
(1037, 70086861),
(1037, 71953434),
(1037, 98452315),
(1037, 98452715),
(1039, 38712349),
(1039, 77494739),
(1039, 84512307),
(1039, 94881526);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona_telefono`
--

CREATE TABLE `persona_telefono` (
  `codigo_persona` int(11) NOT NULL,
  `telefono` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona_telefono`
--

INSERT INTO `persona_telefono` (`codigo_persona`, `telefono`) VALUES
(13548669, 999492545),
(35489768, 994623554),
(38112345, 992904179),
(38712349, 992687072),
(38782349, 942302318),
(48105236, 976775261),
(56480512, 938103535),
(61541897, 912232849),
(63155203, 939827278),
(64958826, 985622746),
(65482352, 912274362),
(65548456, 928799976),
(65548477, 964398746),
(66451287, 904965269),
(66457812, 923329396),
(66514853, 904079157),
(66541893, 963514680),
(68452315, 924198703),
(70086861, 979098713),
(70202416, 900345814),
(70219223, 937276310),
(70414462, 925713408),
(70906320, 971452041),
(70979676, 985211460),
(71091947, 969553358),
(71113233, 958959095),
(71277642, 927884110),
(71736358, 925314075),
(71860523, 981582065),
(71899225, 997932628),
(71953434, 985253562),
(72060523, 919267908),
(72153488, 911954151),
(72183063, 930504902),
(72189703, 914682391),
(72191607, 973415818),
(72275629, 965333746),
(72454793, 907788110),
(72500380, 954064271),
(72534757, 955274877),
(72640567, 913743227),
(72750192, 989654839),
(72825356, 985196545),
(72883406, 969038644),
(72973309, 978887829),
(72979311, 958555595),
(73010010, 926242049),
(73043546, 985097181),
(73348181, 971742754),
(73513384, 937941526),
(73585244, 997043369),
(73620015, 921258525),
(73654425, 916505477),
(73768171, 943884272),
(73939626, 954753492),
(73952118, 917202961),
(74175880, 940019782),
(74304954, 918894990),
(74434256, 990313270),
(74589859, 965674170),
(74641837, 964907021),
(74825994, 945479821),
(75238682, 922497493),
(75456915, 964008899),
(75503317, 904893975),
(75558931, 913629157),
(75890837, 925567778),
(75955896, 927829510),
(76166388, 924205591),
(76276765, 921223261),
(76316791, 979011882),
(76333780, 965071398),
(76381469, 989394800),
(76404035, 919246951),
(76462285, 933415466),
(76556379, 942989947),
(76724829, 911610511),
(76814598, 974741192),
(76841532, 945203744),
(76977921, 993389309),
(77052403, 950058788),
(77236880, 913579613),
(77281276, 944806832),
(77375380, 992037989),
(77494739, 923291111),
(77584095, 922443108),
(77584695, 967744048),
(77796783, 917083867),
(77918846, 953957546),
(77947004, 934775879),
(77960545, 996188816),
(78119579, 938253894),
(78153990, 954791554),
(78172043, 999041345),
(78233416, 929767203),
(78374418, 913721454),
(78389577, 948847061),
(78419312, 929256631),
(78587322, 928659567),
(78785279, 974746941),
(78859852, 905387312),
(78869829, 967569341),
(79128835, 949516176),
(79163434, 959544801),
(79192829, 964328997),
(79196466, 946550659),
(79293044, 925264059),
(79306078, 917302979),
(79309864, 916773928),
(79356988, 924913804),
(79486845, 923573783),
(79885368, 940878268),
(84512307, 906914583),
(84771203, 984527149),
(90026346, 955571218),
(91786346, 902413843),
(94881526, 921478660),
(95486638, 918876420),
(95916646, 996320800),
(96236651, 959972809),
(98112345, 936881684),
(98412345, 913540519),
(98413345, 921673164),
(98452315, 975254288),
(98452345, 901385677),
(98452375, 917780739),
(98452715, 962261485),
(98732341, 932556279);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prerrequisitos`
--

CREATE TABLE `prerrequisitos` (
  `codigo_curso` int(11) NOT NULL,
  `curso1` int(11) DEFAULT NULL,
  `curso2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `prerrequisitos`
--

INSERT INTO `prerrequisitos` (`codigo_curso`, `curso1`, `curso2`) VALUES
(1701101, 0, 0),
(1701102, 0, 0),
(1701104, 0, 0),
(1701105, 0, 0),
(1701106, 0, 0),
(1701107, 0, 0),
(1701114, 0, 0),
(1701208, 1701107, 1701106),
(1701209, 1701106, 0),
(1701210, 0, 0),
(1701212, 1701105, 0),
(1701215, 0, 0),
(1701216, 0, 0),
(1702117, 1701208, 0),
(1702118, 1701209, 0),
(1702119, 1701209, 0),
(1702120, 1701209, 0),
(1702121, 1701210, 0),
(1702122, 1701212, 0),
(1702123, 0, 0),
(1702224, 1702118, 0),
(1702225, 0, 0),
(1702226, 1701209, 1701208),
(1702227, 1701210, 0),
(1702228, 1702121, 0),
(1702229, 0, 0),
(1703130, 1702226, 0),
(1703131, 1702224, 0),
(1703132, 1702118, 1702226),
(1703133, 0, 0),
(1703134, 1702228, 1702224),
(1703135, 1702121, 1702227),
(1703236, 1703131, 0),
(1703237, 1703132, 0),
(1703238, 1703131, 0),
(1703239, 1702117, 0),
(1703240, 1702120, 0),
(1703241, 1703135, 0),
(1704142, 1703131, 0),
(1704143, 1703132, 0),
(1704144, 1703239, 0),
(1704145, 1703237, 0),
(1704146, 1703238, 1703241),
(1704147, 1702228, 0),
(1704248, 1704143, 0),
(1704249, 1704142, 1703238),
(1704250, 1703236, 1704144),
(1704251, 1704144, 0),
(1704252, 1704143, 0),
(1704253, 0, 0),
(1704254, 1703241, 0),
(1704255, 1704145, 0),
(1705156, 1704249, 0),
(1705157, 1703130, 1704250),
(1705158, 0, 0),
(1705159, 1704252, 0),
(1705160, 1702122, 0),
(1705161, 1703134, 0),
(1705162, 1704147, 0),
(1705163, 1704146, 0),
(1705164, 1703241, 0),
(1705265, 1705157, 0),
(1705266, 1705156, 0),
(1705267, 1703240, 0),
(1705268, 1704250, 0),
(1705269, 1705162, 0),
(1705270, 1704251, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `codigo_prof` int(11) NOT NULL,
  `grado_academico` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`codigo_prof`, `grado_academico`) VALUES
(70202416, 'Mg'),
(72060523, 'Dr'),
(72454793, 'Phd'),
(72750192, 'Mg'),
(73010010, 'Dr'),
(73513384, 'Lic'),
(73654425, 'Phd'),
(73939626, 'Lic'),
(74175880, 'Dr'),
(75890837, 'Lic'),
(75955896, 'Dr'),
(76166388, 'Mg'),
(76276765, 'Dr'),
(76404035, 'Mg'),
(77281276, 'Mg'),
(77918846, 'Lic'),
(78587322, 'Dr'),
(79128835, 'Dr'),
(79163434, 'Phd'),
(79486845, 'Lic');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_curso`
--

CREATE TABLE `profesor_curso` (
  `codigo_prof` int(11) NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `grupo` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `profesor_curso`
--

INSERT INTO `profesor_curso` (`codigo_prof`, `codigo_curso`, `fecha`, `grupo`) VALUES
(70202416, 1701101, '2023-04-04', 'E'),
(70202416, 1701105, '2022-10-23', 'D'),
(72060523, 1701104, '2021-05-01', 'E'),
(72060523, 1701106, '2021-04-02', 'A'),
(72454793, 1701102, '2022-09-02', 'C'),
(72454793, 1701105, '2023-11-25', 'A'),
(72454793, 1702121, '2023-03-10', 'A'),
(72750192, 1701101, '2021-02-19', 'B'),
(72750192, 1701105, '2021-06-13', 'C'),
(73010010, 1701106, '2021-06-26', 'B'),
(73513384, 1701106, '2023-08-15', 'D'),
(73654425, 1701209, '2022-02-24', 'A'),
(73939626, 1701210, '2022-09-01', 'C'),
(75890837, 1701208, '2022-05-21', 'E'),
(75955896, 1701210, '2023-07-06', 'A'),
(76166388, 1701212, '2021-06-20', 'A'),
(76276765, 1705266, '2022-11-21', 'A'),
(76404035, 1705265, '2022-05-07', 'A'),
(77281276, 1701210, '2022-02-09', 'B'),
(77918846, 1705267, '2021-08-13', 'D'),
(78587322, 1705269, '2021-01-13', 'D'),
(79128835, 1705157, '2023-10-14', 'E'),
(79163434, 1705270, '2022-10-08', 'C'),
(79486845, 1705268, '2023-10-05', 'B');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salon`
--

CREATE TABLE `salon` (
  `codigo_depa_salon` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `salon`
--

INSERT INTO `salon` (`codigo_depa_salon`) VALUES
(1000),
(1001),
(1002),
(1003),
(1004),
(1005),
(1006),
(1007),
(1008),
(1009),
(1010),
(1011),
(1012),
(1013),
(1014),
(1015),
(1016),
(1017),
(1018),
(1019);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_beca`
--

CREATE TABLE `tipo_beca` (
  `codigo_estu_becario` int(11) NOT NULL,
  `beca` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_beca`
--

INSERT INTO `tipo_beca` (`codigo_estu_becario`, `beca`) VALUES
(48105236, '\'Pronabec\''),
(56480512, '\'Beca 18\''),
(65482352, '\'Beca 18\''),
(66451287, '\'Pronabec\''),
(70979676, 'Beca 18'),
(71860523, 'Pronabec'),
(72153488, 'Beca 18'),
(74304954, 'Beca 18'),
(74434256, 'Beca 18'),
(76381469, 'Pronabec'),
(76724829, 'BIcentenario'),
(76841532, '\'Beca 18\''),
(77947004, 'Pronabec'),
(78153990, 'BIcentenario'),
(79293044, 'Pronabec'),
(95486638, '\'Bicentenario\''),
(96236651, '\'Beca 18\''),
(98112345, '\'Beca 18\''),
(98452715, '\'Bicentenario\''),
(98732341, '\'Pronabec\'');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administracion`
--
ALTER TABLE `administracion`
  ADD PRIMARY KEY (`codigo_personal`);

--
-- Indices de la tabla `becario`
--
ALTER TABLE `becario`
  ADD PRIMARY KEY (`codigo_estu`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`codigo_curso`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`codigo_depa`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`codigo_estu`);

--
-- Indices de la tabla `estudiante_matricula`
--
ALTER TABLE `estudiante_matricula`
  ADD PRIMARY KEY (`codigo_estu`,`codigo_matricula`),
  ADD KEY `codigo_matricula` (`codigo_matricula`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`codigo_obj`),
  ADD KEY `cod_departamento` (`cod_departamento`);

--
-- Indices de la tabla `laboratorio`
--
ALTER TABLE `laboratorio`
  ADD PRIMARY KEY (`codigo_depa_lab`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`codigo_mtr`);

--
-- Indices de la tabla `matricula_curso`
--
ALTER TABLE `matricula_curso`
  ADD PRIMARY KEY (`codigo_mtr`,`codigo_curso`),
  ADD KEY `codigo_curso` (`codigo_curso`);

--
-- Indices de la tabla `no_becario`
--
ALTER TABLE `no_becario`
  ADD PRIMARY KEY (`codigo_estu`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`codigo_personal`);

--
-- Indices de la tabla `persona_correo`
--
ALTER TABLE `persona_correo`
  ADD PRIMARY KEY (`codigo_persona`,`correo`);

--
-- Indices de la tabla `persona_depa`
--
ALTER TABLE `persona_depa`
  ADD PRIMARY KEY (`codigo_depa`,`codigo_persona`),
  ADD KEY `codigo_persona` (`codigo_persona`);

--
-- Indices de la tabla `persona_telefono`
--
ALTER TABLE `persona_telefono`
  ADD PRIMARY KEY (`codigo_persona`,`telefono`);

--
-- Indices de la tabla `prerrequisitos`
--
ALTER TABLE `prerrequisitos`
  ADD PRIMARY KEY (`codigo_curso`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`codigo_prof`);

--
-- Indices de la tabla `profesor_curso`
--
ALTER TABLE `profesor_curso`
  ADD PRIMARY KEY (`codigo_prof`,`codigo_curso`),
  ADD KEY `codigo_curso` (`codigo_curso`);

--
-- Indices de la tabla `salon`
--
ALTER TABLE `salon`
  ADD PRIMARY KEY (`codigo_depa_salon`);

--
-- Indices de la tabla `tipo_beca`
--
ALTER TABLE `tipo_beca`
  ADD PRIMARY KEY (`codigo_estu_becario`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administracion`
--
ALTER TABLE `administracion`
  ADD CONSTRAINT `administracion_ibfk_1` FOREIGN KEY (`codigo_personal`) REFERENCES `personal` (`codigo_personal`);

--
-- Filtros para la tabla `becario`
--
ALTER TABLE `becario`
  ADD CONSTRAINT `becario_ibfk_1` FOREIGN KEY (`codigo_estu`) REFERENCES `estudiante` (`codigo_estu`),
  ADD CONSTRAINT `becario_ibfk_2` FOREIGN KEY (`codigo_estu`) REFERENCES `estudiante` (`codigo_estu`);

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`codigo_estu`) REFERENCES `persona` (`codigo`);

--
-- Filtros para la tabla `estudiante_matricula`
--
ALTER TABLE `estudiante_matricula`
  ADD CONSTRAINT `estudiante_matricula_ibfk_1` FOREIGN KEY (`codigo_matricula`) REFERENCES `matricula` (`codigo_mtr`),
  ADD CONSTRAINT `estudiante_matricula_ibfk_2` FOREIGN KEY (`codigo_estu`) REFERENCES `estudiante` (`codigo_estu`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`cod_departamento`) REFERENCES `departamento` (`codigo_depa`);

--
-- Filtros para la tabla `laboratorio`
--
ALTER TABLE `laboratorio`
  ADD CONSTRAINT `laboratorio_ibfk_1` FOREIGN KEY (`codigo_depa_lab`) REFERENCES `departamento` (`codigo_depa`);

--
-- Filtros para la tabla `matricula_curso`
--
ALTER TABLE `matricula_curso`
  ADD CONSTRAINT `matricula_curso_ibfk_1` FOREIGN KEY (`codigo_mtr`) REFERENCES `matricula` (`codigo_mtr`),
  ADD CONSTRAINT `matricula_curso_ibfk_2` FOREIGN KEY (`codigo_curso`) REFERENCES `curso` (`codigo_curso`);

--
-- Filtros para la tabla `no_becario`
--
ALTER TABLE `no_becario`
  ADD CONSTRAINT `no_becario_ibfk_1` FOREIGN KEY (`codigo_estu`) REFERENCES `estudiante` (`codigo_estu`);

--
-- Filtros para la tabla `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`codigo_personal`) REFERENCES `persona` (`codigo`);

--
-- Filtros para la tabla `persona_correo`
--
ALTER TABLE `persona_correo`
  ADD CONSTRAINT `persona_correo_ibfk_1` FOREIGN KEY (`codigo_persona`) REFERENCES `persona` (`codigo`);

--
-- Filtros para la tabla `persona_depa`
--
ALTER TABLE `persona_depa`
  ADD CONSTRAINT `persona_depa_ibfk_1` FOREIGN KEY (`codigo_depa`) REFERENCES `departamento` (`codigo_depa`),
  ADD CONSTRAINT `persona_depa_ibfk_2` FOREIGN KEY (`codigo_persona`) REFERENCES `persona` (`codigo`);

--
-- Filtros para la tabla `persona_telefono`
--
ALTER TABLE `persona_telefono`
  ADD CONSTRAINT `persona_telefono_ibfk_1` FOREIGN KEY (`codigo_persona`) REFERENCES `persona` (`codigo`);

--
-- Filtros para la tabla `prerrequisitos`
--
ALTER TABLE `prerrequisitos`
  ADD CONSTRAINT `prerrequisitos_ibfk_1` FOREIGN KEY (`codigo_curso`) REFERENCES `curso` (`codigo_curso`);

--
-- Filtros para la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD CONSTRAINT `profesor_ibfk_1` FOREIGN KEY (`codigo_prof`) REFERENCES `personal` (`codigo_personal`);

--
-- Filtros para la tabla `profesor_curso`
--
ALTER TABLE `profesor_curso`
  ADD CONSTRAINT `profesor_curso_ibfk_1` FOREIGN KEY (`codigo_prof`) REFERENCES `profesor` (`codigo_prof`),
  ADD CONSTRAINT `profesor_curso_ibfk_2` FOREIGN KEY (`codigo_curso`) REFERENCES `curso` (`codigo_curso`);

--
-- Filtros para la tabla `salon`
--
ALTER TABLE `salon`
  ADD CONSTRAINT `salon_ibfk_1` FOREIGN KEY (`codigo_depa_salon`) REFERENCES `departamento` (`codigo_depa`);

--
-- Filtros para la tabla `tipo_beca`
--
ALTER TABLE `tipo_beca`
  ADD CONSTRAINT `tipo_beca_ibfk_1` FOREIGN KEY (`codigo_estu_becario`) REFERENCES `becario` (`codigo_estu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

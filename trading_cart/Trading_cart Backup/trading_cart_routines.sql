-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: trading_cart
-- ------------------------------------------------------
-- Server version	5.5.59

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
-- Dumping routines for database 'trading_cart'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_getUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUsuario`(
	IN _nick VARCHAR(50),
	IN _contrasenia VARCHAR(50)
)
BEGIN
	DECLARE usuarioExistente VARCHAR(50) DEFAULT NULL;

	SELECT idUsuario, nombreUsuario, apellidoPaterno, apellidoMaterno, sexo, correo,
		nickUsuario, imagenPerfil, perfilExt, imagenPortada, portadaExt
	FROM usuario
	WHERE nickUsuario LIKE _nick AND
		contrasenia LIKE _contrasenia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_setDireccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_setDireccion`(
	IN _idUsuario INT,
	IN _calle VARCHAR(64),
	IN _colonia VARCHAR(64),
	IN _ciudad VARCHAR(64),
	IN _estado VARCHAR(64),
	IN _pais VARCHAR(64),
	IN _noInt VARCHAR(64),
	IN _noExt VARCHAR(64),
	IN _codigoPostal MEDIUMINT
)
BEGIN
	DECLARE direccionExistente INT DEFAULT NULL;

	SELECT idDireccion INTO direccionExistente
	FROM direccion
	WHERE idUsuario = _idUsuario;

	IF (direccionExistente IS NULL)
	THEN
		INSERT INTO direccion
		VALUES(
			DEFAULT,
			_idUsuario,
			_calle,
			_colonia,
			_noInt,
			_noExt,
			_ciudad,
			_estado,
			_pais,
			_codigoPostal,
			0
			);
	ELSEIF (direccion IS NOT NULL)
	THEN
		UPDATE direccion
		SET 
			calle = _calle,
			colonia = _colonia,
			interior = _noInt,
			exterior = _noExt,
			ciudad = _ciudad,
			estado = _estado,
			pais = _pais,
			zipCode = _codigoPostal
		WHERE ipDireccion = direccionExistente;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_setUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_setUsuario`(
	IN _nombreUsuario VARCHAR(50),
	IN _apellidoPaterno VARCHAR(50),
	IN _apellidoMaterno VARCHAR(50),
    IN _fecha DATE,
	IN _sexo CHAR(1),
	IN _correo VARCHAR(50),
    IN _telefono VARCHAR(24),
	IN _nick VARCHAR(50),
	IN _contrasenia VARCHAR(50),
	IN _imagenPerfil MEDIUMBLOB,
    IN _perfilExt VARCHAR(8),
	IN _imagenPortada MEDIUMBLOB,
    IN _portadaExt VARCHAR(8)
)
BEGIN
	DECLARE usuarioRepetido VARCHAR(50) DEFAULT NULL;

	SELECT nickUsuario
	INTO usuarioRepetido
	FROM usuario
	WHERE nickUsuario = _nick;

	IF (usuarioRepetido IS NULL OR usuarioRepetido LIKE '')
	THEN
		INSERT INTO usuario()
		VALUES (
				DEFAULT,
				_nombreUsuario,
				_apellidoPaterno,
				_apellidoMaterno,
				_sexo,
                _fecha,
				_correo,
                _telefono,
				_nick,
				_contrasenia,
				_imagenPerfil,
                _perfilExt,
				_imagenPortada,
                _portadaExt
			);
            #SELECT 'HolaMundo';
	ELSE
		SELECT 'Usuario Repetido';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-19  1:22:18

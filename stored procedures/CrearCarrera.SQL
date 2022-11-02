DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearCarrera`(name VARCHAR(500))
BEGIN
DECLARE conteo INTEGER;
IF name REGEXP '^[A-zÀ-ú ]+$' THEN
	SELECT count(*) into conteo FROM carrera WHERE nombre = name;
	IF (conteo = 0) THEN
		INSERT INTO `proyecto2`.`carrera` (`nombre`) VALUES (name);
	ELSE
		SELECT 'ERROR: ya existe una carrera con el nombre ingresado';
	END IF;	
ELSE
		SELECT 'ERROR: una carrera puede componerse de sólo letras';
	END IF;
END$$
DELIMITER ;

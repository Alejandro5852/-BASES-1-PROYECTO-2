CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarDocente`(nombres varchar(500), apellidos varchar(500), fechaNacimiento DATETIME,correo varchar(500), telefono DECIMAL(15,0),  direccion BLOB, dpi BIGINT,registroSIIF DECIMAL(15,0))
BEGIN

DECLARE conteo_1 INTEGER;

IF correo REGEXP '^[^@]+@[^@]+\.[^@]{2,}$' THEN
	IF nombres REGEXP '^[A-zÀ-ú ]+$' THEN
		IF apellidos REGEXP '^[A-zÀ-ú ]+$' THEN
			SELECT count(*) into conteo_1 FROM docente WHERE docente.registroSIIF = registroSIIF or docente.correo = correo or docente.dpi = dpi;
			IF (conteo_1 = 0) THEN
				INSERT INTO `proyecto2`.`docente` (`registroSIIF`, `nombres`, `apellidos`, `fechaNacimiento`, `correo`, `telefono`, `direccion`, `dpi`) VALUES (registroSIIF, nombres, apellidos, fechaNacimiento, correo, telefono, direccion, dpi);				
			ELSE
				SELECT 'ERROR: ya existe información registrada (registroSIIF, correo, dpi)';			
            END IF;	
		ELSE
			SELECT 'ERROR: formato de apellidos inválido';
		END IF;
	ELSE
		SELECT 'ERROR: formato de nombres inválido';
	END IF;
ELSE
		SELECT 'ERROR: formato de correo inválido';
	END IF;
END
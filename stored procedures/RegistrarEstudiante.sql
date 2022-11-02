CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarEstudiante`(carnet varchar(45), nombres varchar(500), apellidos varchar(500), fechaNacimiento DATETIME, correo varchar(500), telefono decimal(10,0), direccion BLOB, dpi bigint, carrera_id INT)
BEGIN

DECLARE conteo INTEGER;
DECLARE conteo_1 INTEGER;

IF correo REGEXP '^[^@]+@[^@]+\.[^@]{2,}$' THEN
	IF nombres REGEXP '^[A-zÀ-ú ]+$' THEN
		IF apellidos REGEXP '^[A-zÀ-ú ]+$' THEN
			SELECT count(*) into conteo FROM carrera WHERE id = carrera_id;
			IF (conteo = 0) THEN
				SELECT 'ERROR: no existe una carrera registrada con el id proporcionado';
			ELSE
				SELECT count(*) into conteo_1 FROM estudiante WHERE estudiante.carnet = carnet or estudiante.correo = correo or estudiante.dpi = dpi;
				IF (conteo_1 = 0) THEN
					INSERT INTO `proyecto2`.`estudiante` (`carnet`, `nombres`, `apellidos`, `fechaNacimiento`, `correo`, `telefono`, `direccion`, `dpi`, `carrera_id`) VALUES (carnet, nombres, apellidos, fechaNacimiento, correo, telefono, direccion, dpi, carrera_id);
				ELSE
					SELECT 'ERROR: existe información previamente registrada (carne, dpi o correo)';
				END IF;	
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
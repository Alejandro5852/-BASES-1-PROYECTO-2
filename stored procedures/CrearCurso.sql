CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearCurso`(codigo varchar(45), nombre varchar(500), creditosN int, creditosO int, carrera_id int, esObligatorio int)
BEGIN
DECLARE conteo INTEGER;
DECLARE conteo_1 INTEGER;
	IF nombre REGEXP '^[0-9A-zÀ-ú ]+$' THEN
		IF creditosN >= 0 THEN
			IF creditosO >= 0 THEN
				SELECT count(*) into conteo FROM carrera WHERE carrera.id = carrera_id;
				IF (conteo = 0) THEN
					SELECT 'ERROR: el id de carrera proporcionado no está registrado';			
				ELSE 
					SELECT count(*) into conteo_1 FROM curso WHERE curso.nombre = nombre;
					IF (conteo_1 = 0) THEN
						INSERT INTO `proyecto2`.`curso` ( `codigo`, `nombre`, `creditosN`, `creditosO`, `esObligatorio`, `carrera_id`) VALUES ( codigo, nombre, creditosN, creditosO, esObligatorio, carrera_id);			
					ELSE
						SELECT 'ERROR: ya existe información registrada (nombre)';			
					END IF;
				END IF;	
			ELSE
				SELECT 'ERROR: formato de créditos necesarios inválido';
			END IF;
		ELSE
			SELECT 'ERROR: formato de créditos otorgables inválido';
		END IF;
    ELSE 
		SELECT 'ERROR: formato de nombre de curso inválido';
    END IF;
END
-- Tabla de inicio del robot
CREATE TABLE IF NOT EXISTS startup_audit(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    version VARCHAR(50) NOT NULL,
    date_process DATETIME DEFAULT NOW()
);

-- Tabla de acuses procesados
CREATE TABLE IF NOT EXISTS acuses(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rad VARCHAR(50) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    insercion DATETIME,
    recibido VARCHAR(50) NOT NULL,
    uid VARCHAR(500),
    saved INT(1),
    status VARCHAR(500)
);

/*
Author: Sebastian Montoya 
Create: 25/04/2023
Update: 25/05/2023
Description: Este proceso almacenado guarda la versión y inicio del robot. 
*/
DELIMITER //
DROP PROCEDURE IF EXISTS start_process//
CREATE PROCEDURE start_process(IN in_version VARCHAR(50))
BEGIN 
    DECLARE fecha_actual VARCHAR(20);
    SET fecha_actual = DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s');

    INSERT INTO startup_audit(version,date_process) VALUES(in_version,STR_TO_DATE(fecha_actual, '%d/%m/%Y %H:%i:%s'));
END//
DELIMITER ;

-- CALL start_process('1.0.0');

/*
Author: Sebastian Montoya 
Create: 08/05/2023
Update: 08/05/2023
Description: Guarda el acuse que ya fue subido en DocxFlow.
*/
DELIMITER //
DROP PROCEDURE IF EXISTS insertAcuseProcesado//
CREATE PROCEDURE insertAcuseProcesado(IN in_rad VARCHAR(50),IN in_subject VARCHAR(50),IN in_recibido VARCHAR(50), IN in_uid VARCHAR(500),in_status VARCHAR(500))
BEGIN 
    INSERT INTO acuses (
        rad,
        subject,
        insercion,
        recibido,
        uid,
        saved,
        status
    ) VALUES 
    (
        in_rad,
        in_subject,
        DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s'),
        in_recibido,
        in_uid,
        1,
        in_status
    );
END//
DELIMITER ;

-- CALL insertAcuseProcesado('CCI-01S23-1323','Conf: CCI-01S23-1323','08/05/2023','asdasda31231','Prueba');

/*
Author: Sebastian Montoya 
Create: 08/05/2023
Update: 08/05/2023
Description: Este procedimiento sirve para la memoria del robot en la que revisamos si 
*/
DELIMITER //
DROP PROCEDURE IF EXISTS consultAcuse//
CREATE PROCEDURE consultAcuse(IN in_acuse VARCHAR(50))
BEGIN 
    SELECT *
    FROM acuses
    WHERE rad = in_acuse;
END//
DELIMITER ;

-- CALL consultAcuse('CCI-01S23-1323');

/*
Author: Sebastian Montoya 
Create: 15/05/2023
Update: 15/05/2023
Description: Este procedimiento sirve para cuando sean las 11:30 pm en VUC saque de la tabla un
informe del dia de hoy y lo guarde en un excel para enviar via correo.
*/
DELIMITER //
DROP PROCEDURE IF EXISTS reporteDiario//
CREATE PROCEDURE reporteDiario()
BEGIN 
    SELECT 
    subject AS Email,
    rad AS Radicado,
    status AS Proceso,
    insercion AS Fecha,
    uid AS Lote
    FROM acuses
    WHERE insercion >= CURRENT_DATE();
END//
DELIMITER ;

-- CALL reporteDiario();
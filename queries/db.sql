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
    insercion DATETIME DEFAULT NOW()
    recibido DATETIME DEFAULT NOW(),
    uid VARCHAR(MAX),
    saved BIT(1) DEFAULT b'0',
    status VARCHAR(MAX)
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
"""
Para que podamos realizar transacciones primero debemos tener en mente que
query's vamos a usar, ya sea para insertar, actualizar o eliminar registros.
"""

/*Antes de correr nuestras query's debemos correr START TRANSACTION;,
esto le indica al sistema que apartir de ese momento todas las query's que se
ejecunten formarán parte de una transacción. */

START TRANSACTION;

/*Se definen y corren las query's de la transacción. */

SET @libro_id = 20, @usuario_id = 3;

UPDATE libros SET stock = stock -1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

/*Si todo salió bien, se confirma la transacción con COMMIT;.
Con COMMIT; se guardarán todos los cambios que se realizaron en la transacción. */

COMMIT;

/*Si ocurre un error al correr las query's, en lugar de COMMIT; 
se utiliza ROLLBACK para revertir los cambios. */

ROLLBACK;

/*Se pueden crear procedimientos que contengan transacciones.
En este caso, se agrega un manejador de excepciones para el manejo de errores.
Con "DECLARE EXIT HANDLER FOR SQLEXCEPTION", se le indica al sistema que debe hacer en caso de
que ocurra un error, en este caso se ejecutará un ROLLBACK.
Si no ocurre algún error, continua con la transacción y de ejecutará el COMMIT;.
*/

DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
    UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

    COMMIT;

END //

DELIMITER ;
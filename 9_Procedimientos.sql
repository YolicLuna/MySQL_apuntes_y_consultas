"""
Los procedimientos almacenados en MySQL son conjuntos de instrucciones que se ejecutan directamente
en el motor de la base de datos. Permiten encapsular lógica compleja. Los procedimientos almacenados no
arrojan ningun valor, a diferencia de las funciones que si lo hacen.
"""

/*Para crear un procedimiento almacenado, utilizamos la sentencia CREATE PROCEDURE.
En este caso, se crea un procedimiento para gestionar el préstamo de libros a usuarios.
Es decir, se insertará un registro en la tabla libros_usuarios y se actualizará el stock
de la tabla libros a menos 1 por cada nuevo registro. */

DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
    BEGIN
        INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
    END //

DELIMITER ;

/*Para listar los procedimientos almacenados en la base de datos actual, lo haremos de la siguiente manera. */

SELECT name FROM mysql.proc WHERE db = database() AND type = "PROCEDURE";

/*Para llamar o ejecutar un procedimiento almacenado, utilizamos la sentencia CALL.
En este caso se agregaron parametros dentro de () porque la sentencia CALL requiere que
se especifiquen los valores de los parámetros definidos en el procedimiento.
Entonces, solo se agregan parametros solo si el proceso dentro del procedimiento lo requiere. */

CALL prestamo(3, 20)

/*Para eliminar un procedimiento almacenado, utilizamos la sentencia DROP PROCEDURE.
En este caso, se eliminará el procedimiento prestamo. */

DROP PROCEDURE prestamo;

/*Para obtener valores después de ejecutar el procedimiento, utilizamos parámetros de salida (OUT).
En este caso, se modificará el procedimiento prestamo para incluir un parámetro de salida (OUT cantidad INT)
que devolverá la cantidad de libros disponibles después del préstamo.
Se agrega tambien la sentencia SET que asignará el valor de la cantidad de libros disponibles a
la variable de salida (OUT cantidad INT). */

DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
    BEGIN
        INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

        SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
    END //

DELIMITER ;

/*Se crea una funcion para obtener la cantidad de libros disponibles. */

SET @cantidad = -1;

/*Se llama o ejecuta el procedimiento agregando ahora la función como parámetro de salida. */

CALL prestamo(3, 20, @cantidad);

/*Se ejecuta un SELECT de la función para obtener la cantidad de libros disponibles.
"El resultado obtenido es producto de la sentencia "SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);"
que agregamos previamente en nuestro procedimiento, se asigno a la variable de salida (OUT cantidad INT) y con la funcion @cantidad
sepuede acceder a ese valor. */

SELECT @cantidad;

/*Se pueden condicionar los procedimientos almacenados.
En este caso, se condiciona la ejecución del prestamo de libros, si el stock es mayor a 0.
Lo que hicimos con respecto a la sentencia dentro de nuestro procedimiento fue;
cambiar la sentencia "SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);" que estaba al final y ahora al principio,
se añade la condicional IF cantidad > 0 THEN para verificar si hay stock disponible antes de realizar el préstamo,
si es mayor a 0 se ejecutara la logica que teniamos, INSERT INTO y UPDATE, si el stock es 0 se moatrara el mensaje de error
colocado en el ELSE y se cierra el IF. */

DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN

    SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);

    IF cantidad > 0 THEN

        INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

        SET cantidad = cantidad - 1;
        
    ELSE

        SELECT "No es posible realizar el prestamo" AS mensaje_error;

    END IF;

END //

DELIMITER ;

/*Con CASE se pueden crear casos que se cumplan dependiando de las condiciones.
Es decir, que el resultado podrá tener varios casos de resultado dependiendo de las condicines.
En este caso, agregamos CASE, dentro agregamos las condiciones con WHEN,
que es como si le dijeramos al sistema "Si esto pasa, haz esto o aquello",
se agrega ELSE para manejar un caso que no cumpla con ninguna condicion anterior, digamos que
lo que esta en ELSE se cumplira por defecto siempre que las otras condiciones no se cumplan,
y cerramos con END CASE. 

Se pueden agregar tantas condiciones como se desee. 

En las condiciones se puede hacer uso de operadores lógicos para combinar multiples condiciones,
incluso el uso de clausulas como BETWEEN. */

DELIMITER //

CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN

    SET @cantidad = (SELECT COUNT(*) FROM libros_usuarios
                    WHERE libros_usuarios.usuario_id = usuario_id);
    
    CASE
        WHEN @cantidad > 20 THEN
            SELECT "Lector Voraz" AS mensaje;
        WHEN @cantidad > 10 AND @cantidad < 20 THEN
            SELECT "Lector Frecuente" AS mensaje;
        WHEN @cantidad BETWEEN 5 AND 9 THEN
            SELECT "Lector Ocasional" AS mensaje;
        ELSE
            SELECT "Nuevo lector" AS mensaje;
    END CASE;

END  //

DELIMITER ;

/*Con WHILE podemos hacer ciclos/bucles para que una consulta se repita varias o tantas veces como querramos.
La primera diferencia entre el siguiente procedimiento y los anteriores es que a este no le agregamos
parametros tal cual se ve en CREATE PROCEDURE libros_azar(), despues el agrega el WHILE, dento de este
se define cuantas veces se repetira la consulta, en este caso 5 veces, se agrega el DO que le indica al sistema
"Haz esto", despues e agrega la consulta que se desea realizar, esn este caso se realizará las 5 veces
y para terminar se cierra el WHILE.

Ojo, si en la variable SET @iteracion se agrega un numero mayor o igual al numero de veces que indicamos
dentro de WHILE, el ciclo nunca se ejecutará. En este caso el ciclo se ejecutará 5 veces porque nuestra variable comienza en 0,
si comenzamos en 3, el ciclo solo se ejecutará 2 veces. */

DELIMITER //

CREATE PROCEDURE libros_azar()
BEGIN
    SET @iteracion = 0;

    WHILE @iteracion < 5 DO

        SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
        SET @iteracion = @iteracion + 1;
    
    END WHILE;

END//

DELIMITER ;

/*Tmbien se pueden crear ciclos utilizando REPEAT.
La diferencia es que con REPEAT, la condicion de cuantas veces se ejecuta el ciclo se
se evalua con UNTIL al final de cada iteracion, lo que garantiza que el bloque de codigo dentro de REPEAT
se ejecute al menos una vez. En este caso, con "UNTIL @iteracion >= 5" le estamos
diciendo al sistema que el ciclo debe continuar hasta que la variable @iteracion sea mayor o igual a 5. */

DELIMITER //

CREATE PROCEDURE libros_azar()
BEGIN
    SET @iteracion = 0;

    REPEAT

        SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
        SET @iteracion = @iteracion + 1;

        UNTIL @iteracion >= 5
    END REPEAT;

END//

DELIMITER ;
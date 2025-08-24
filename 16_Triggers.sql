/*
Un trigger, también conocido como disparador (Por su traducción al español) es un conjunto de sentencias
SQL las cuales se ejecutan de forma automática cuando ocurre algún evento que modifique a una tabla.
Pero no me refierón a una modificación de estructura, no, me refiero a una modificación en cuando a los
datos almacenados, es decir, cuando se ejecute una sentencia INSERT, UPDATE o DELETE.

A diferencia de una función o un store procedure, un trigger no puede existir sin una tabla asociada.

Lo interesante aquí es que podemos programar los triggers de tal manera que se ejecuten antes o después,
de dichas sentencias; Dando como resultado seis combinaciones de eventos.

BEFORE INSERT Acciones a realizar antes de insertar uno más o registros en una tabla.

AFTER INSERT Acciones a realizar después de insertar uno más o registros en una tabla.

BEFORE UPDATE Acciones a realizar antes de actualizar uno más o registros en una tabla.

AFTER UPDATE Acciones a realizar después de actualizar uno más o registros en una tabla.

BEFORE DELETE Acciones a realizar antes de eliminar uno más o registros en una tabla.

AFTER DELETE Acciones a realizar después de eliminar uno más o registros en una tabla.

A partir de la versión 5.7.2 de MySQL podemos tener la n cantidad de triggers asociados a una tabla.
Anteriormente estábamos limitados a tener un máximo de seis trigger por tabla (Uno por cada combinación evento).

Podemos ver esto como una relación uno a muchos, una tabla puede poseer muchos triggers y un trigger le
pertenece única y exclusivamente a una tabla.

Algo importante a mencionar es que la sentencia TRUNCATE no ejecutará un trigger.

Ventajas de Utilizar triggers

Con los triggers seremos capaces validar todos aquellos valores los cuales no pudieron ser validados mediante
un constraints, asegurando así la integreidad de los datos.
Los triggers nos permitirán ejecutar reglas de negocios.
Utilizando la combinación de eventos nosotros podemos realizar acciones sumamente complejas.
Los trigger nos permitirán llevar un control de los cambios realizados en una tabla. Para esto nos debemos
de apoyar de una segunda tabla (Comúnmente una tabla log).

Desventajas de Utilizar triggers
Los triggers al ejecutarse de forma automática puede dificultar llevar un control sobre qué sentencias
SQL fueron ejecutadas.
Los triggers incrementa la sobrecarga del servidor. Un mal uso de triggers puede tornarse en respuestas
lentas por parte del servidor. */

/*Lo siguiente es una manera de crear un TRIGGER.
Se hace uso de la clausula CREATE TRIGGER seguida del nombre del trigger, se recomienda que el nombre del trigger
este conformado por el tiempo "after_insert" y la acción que va a realizar "actualizacion_libros".
Despues se hace uso de la clausula AFTER que le indica al sistema que se debe ejecutar el trigger después de la acción especificada.
(Tambien se puede usar BEFORE, para indicar que se debe ejecutar el trigger antes de la acción especificada.)
INSERT que esta despues de AFTER, hace referencia a la accion que se va a realizar, en este caso, la inserción de un nuevo registro en la tabla libros.
Despues se hace uso de la clausula FOR EACH ROW, para indicar que el trigger se debe ejecutar para cada fila afectada por la acción.
Despues se agregan las consultas que se desean ejecutar cuando se active el trigger, en este caso, 
se desea actualizar la tabla de autores para incrementar la cantidad de libros del autor correspondiente.
La clausula NEW hace referencia a los nuevos valores que se están insertando en la tabla y solo se usa en triggers de tipo INSERT o UPDATE.
 */

DELIMITER //

CREATE TRIGGER after_insert_actualizacion_libros
AFTER INSERT ON libros
FOR EACH ROW
BEGIN
    UPDATE autores SET cantidad_libros = cantidad_libros + 1
    WHERE autor_id = NEW.autor_id;
END;
//

DELIMITER ;

/*Antes comenzar a correr query's debemos correr el trigger para que se active. 

Al correr la siguiente query, se activará el trigger y se actualizará la tabla autores.
Esto ocurrira cada vez que se inserte un nuevo valor en la tabla libros. */

INSERT INTO libros (titulo, autor_id) VALUES ('Nuevo Libro', 1);

/*EL siguiente trigger tambien modificara la tabla autores, solo que en esta ocacion, en lugar de incrementar
la cantidad de libros, se decrementara.
En este caso se cambia el nombre del trigger, se cambia la clausula AFTER por la clausula DELETE, en cantida_libros
pasa de +1 a -1 y por ultimo se cambia la clausula NEW por OLD. */

DELIMITER //

CREATE TRIGGER after_delete_actualizacion_libros
AFTER DELETE ON libros
FOR EACH ROW
BEGIN
    UPDATE autores SET cantidad_libros = cantidad_libros - 1
    WHERE autor_id = OLD.autor_id;
END;
//

DELIMITER ;

/*Despues de correr el trigger para activarlo, se corre la query para eliminar un registro y con ello
el trigger se ejecuta. */

DELETE FROM libros WHERE libro_id = 1;

/*El siguente trigger se activara en caso de una actualización.
En este caso se cambio la clausula AFTER por la clausula UPDATE.
Lo que hara el tirgger es actualizar la cantidad de libros del autor correspondiente.
Primero con IF se evaluará si el autor_id ha cambiado.
Si el autor ha cambiado a mayor entonces se incrementa la cantidad de libros del nuevo autor y
se decrementa la cantidad de libros del autor anterior. */

DELIMITER //

CREATE TRIGGER after_update_actualizacion_libros
AFTER UPDATE ON libros
FOR EACH ROW
BEGIN
    IF(NEW.autor_id != OLD.autor_id) THEN

        UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
        UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;

    END IF;
END;
//

DELIMITER ;

/*Despues de correr el trigger para activarlo, se corre la query para actualizar un registro y con ello
el trigger se ejecuta. */

UPDATE libros SET autor_id = 2 WHERE libro_id = 2;

/*La siguiente consulta listará los trigger existentes en la base de datos en la que se esta trabajando. */

SHOW TRIGGERS/G

/*La siguiente consulta eliminará un trigger existente en la base de datos. */

DROP TRIGGER IF EXISTS nombre_de_la_tabla.nombre_del_trigger;
"""
Las vistas en MySQL son consultas almacenadas que se pueden utilizar como tablas virtuales.
Permiten simplificar consultas complejas y mejorar la seguridad al restringir el acceso a ciertos datos,
sobre todo a información sensible, privada y confidencial.
"""

/*En el siguiente ejemplo se crea una vista que muestra los prestamos de los usuarios,
ese resultado se obtiene de la query que comienza en SELECT y termina en GROUP BY.
Dicha consulta esta almacenada en la vista prestamos_usuarios_vw.
Si corremos esta consulta solo nos arrojara "OK" y al listar todas nuestras tablas con SHOW TABLES;
podremos visualizar nuestra vista junto a las demas tablas.

Se recomienda que el nombre de nuestras vistas siempre tenga vw al final, esto como buena práctica,
ya que esto hara que podamos distinguirlas fácilmente de las tablas normales. */

CREATE VIEW prestamos_usuarios_vw AS
SELECT
    usuarios.usuario_id,
    usuarios.nombre,
    usuarios.email,
    usuarios.username,
    COUNT(usuarios.usuario_id) AS total_prestamos

FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
GROUP BY usuarios.usuario_id;

/*Para consultar la información dentro de la vista prestamos_usuarios_vw, basta con realizar una consulta
tratando a la vista como una tabla normal.
Entonces, siempre que querramos hacer uso de los datos que arroja la query que esta almacenada en nuestra vista,
solo tenemos que hacer uso de ella como si fuera tabla normal.
Con esto evitamos tener que repetir la misma consulta compleja una y otra vez. */

SELECT * FROM prestamos_usuarios_vw;

/*Para eliminar una vista debemos usar la query DROP VIEW seguida del nombre de la vista a eliminar. */

DROP VIEW prestamos_usuarios_vw;

/*Para modificar una vista existente, utilizamos la sentencia CREATE OR REPLACE VIEW.
Esta sentencia crea o modifica una vista existente.
En este caso, se actualiza la query almacenada en la vista, que ahora incluye un filtro por fecha. */

CREATE OR REPLACE VIEW prestamos_usuarios_vw AS
SELECT
    usuarios.usuario_id,
    usuarios.nombre,
    usuarios.email,
    usuarios.username,
    COUNT(usuarios.usuario_id) AS total_prestamos

FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
            AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY usuarios.usuario_id;
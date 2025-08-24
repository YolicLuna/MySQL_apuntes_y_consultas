""" Los Joins se utilizan para trabajar con dos tablas o en algunos casos, mas de dos tablas.
Combinan columnas de tablas diferentes.
"""

# INNER JOIN
/*Los INNER JOIN se utilizan combinan solo las filas que cumplen con una
condición de relación entre las tablas.
La condicion en el caso de esta consulta es autor_id que podría estar relacionando
las tablas, en una como PRIMARY KEY y en la otra como FOREIGN KEY.

Las partes escritas como 'libros.titulo' son por que en ellas se especifica
el nombre de la tabla y el nombre de la columna de donde se obtienen los datos.

En el caso de esta consulta, obtendremos como resultado, una tabla combinada que 
contiene los titulos de los libros, el nombre y apellido de los autores (concatenados en una columna llamada nombre_completo)
y la fecha de publicación de los libros. El titulo y la fecha salen de la tabla libros
y el nombre completo de los autores sale de la tabla autores. */
SELECT
    libros.titulo,
    CONCAT(autores.nombre, ' ', autores.apellido) AS nombre_completo,
    libros.fecha_publicacion
FROM libros
INNER JOIN autores ON libros.autor_id = autores.autor_id;

# LEFT JOIN
/*Los LEFT JOIN se utilizan para combinar todas las filas de la tabla izquierda (A)
con las filas coincidentes de la tabla derecha (B). 
Si no hay coincidencias, los resultados de la tabla derecha serán NULL. 

En el caso de esta consulta, obtendremos como resultado una lista de todos los
autores y los libros que han leído, si es que han leído uno.
La tabla izquierda (A) es la tabla usuarios y la tabla derecha (B) es la tabla libros_usuarios. */

SELECT CONCAT(autores.nombre, ' ', autores.apellido),
    libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuarios_id = libros_usuarios.usuarios_id;

# RIGHT JOIN
/*Los RIGHT JOIN se utilizan para combinar todas las filas de la tabla derecha (B)
con las filas coincidentes de la tabla izquierda (A).
Si no hay coincidencias, los resultados de la tabla izquierda serán NULL.

En el caso de esta consulta, obtendremos como resultado una lista de todos los
libros y los autores que los han escrito, si es que han escrito uno. */

SELECT CONCAT(autores.nombre, ' ', autores.apellido),
    libros_usuarios.libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuarios_id = libros_usuarios.usuarios_id;


# CROSS JOIN
/*Lo CROSS JOIN se utiliza para combinar todas las filas de dos tablas, generando un producto cartesiano.
En este caso, obtendremos la combinación de todos los nombres (de la tabla usuarios)
y su correspondiente libro (de la tabla libros). */

SELECT usuarios.nombre, libros.titulo From usuarios CROSS JOIN libros;

/*Los CROSS JOIN tambien se pueden utilizar para insertar datos en una tabla intermedia entre dos tablas.
En este caso, se insertarán en una tabla todas las combinaciones de libros y nombre de usuarios obtenidas del CROSS JOIN. */

INSERT INTO libros_usuarios (libro_id, usuario_id)
SELECT libro_id, usuario_id FROM usuarios
CROSS JOIN libros;
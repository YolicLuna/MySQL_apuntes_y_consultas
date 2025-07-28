"""NOTA: Las query's pueden o no llevar la clusula IF EXISTS. 
Recordemos que IF EXISTS se utiliza para que las query's se ejecuten solo si la base de datos o tabla existen.|
Pero su uso sirve para evitar errores. """

/*La clusula ALTER TABLE sirve para modificar la estructura de una tabla.
La clausula ADD hace referencia a la adición de una nueva columna.
En este caso, se agregara la columna ventas a la tabla libros. */
ALTER TABLE IF EXISTS libros ADD ventas INT UNSIGNED NOT NULL;

/*Por ejemplo: aqui se esta agregando la columna email de tipo VARCHAR(50).*/
ALTER TABLE usuarios ADD email VARCHAR(50);

/*La clusula DROP COLUMN hace referencia a la eliminación de una columna. */
ALTER TABLE IF EXISTS libros DROP COLUMN IF EXISTS ventas;

/*Con la clusula RENAME TO se puede cambiar el nombre de una tabla.
En este caso, usuarios se renombra como users. */
ALTER TABLE usuarios RENAME TO users;

/*La clusula MODIFY sirve para modificar el tipo de dato de una columna.
En este caso, la columna telefono ahora sera VARCHAR(50). */
ALTER TABLE usuarios MODIFY telefono VARCHAR(50);

/*En esta query se esta agregando una nueva columna id de tipo INT UNSIGNED NOT NULL AUTO_INCREMENT 
y se establece como clave primaria. */
ALTER TABLE usuarios ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (id);

/*En esta query se esta agregando una clave foranea que hace referencia a la tabla grupos. */
ALTER TABLE usuarios ADD FOREIGN KEY(grupo_id) REFERENCES grupos(grupo_id);

/* En esta query se esta eliminando la clave foranea grupo_id. */
ALTER TABLE usuarios DROP FOREIGN KEY grupo_id;

/*En esta query se elimina la clave primaria.
No se agrega el nombre de la columna ya que no es necesario porque solo puede existir
una llave primaria en cada tabla. Por lo tanto, al ejecutar la query, por default se elimina
la llave primaria existente en esa tabla.
NOTA: no se pueden eliminar llaves primarias sin antes eliminar las llaves foraneas 
con las cuales estan relacionadas. */
ALTER TABLE usuarios DROP PRIMARY KEY;

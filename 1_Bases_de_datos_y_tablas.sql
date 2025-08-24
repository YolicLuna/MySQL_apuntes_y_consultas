
/*Query para crear base de datos si no existe. */
CREATE DATABASE IF NOT EXISTS libreria;

/*Query que muestra las bases de datos. */
SHOW DATABASES;

/*Query para eliminar base de datos si existe.
Se debe tener cuidado con la clausula DROP DATABASE ya que elimina toda la base de datos y su contenido, 
sin la posibilidad de recuperación. */
DROP DATABASE IF EXISTS libreria;

/*Query para usar la base de datos seleccionada. */
USE libreria;

--Creación de tablas.

/*CREATE TABLE es la clausula para crear una tabla, seguida del nombre de la tabla.
IF NOT EXISTS es la clausula que se utiliza para que se cree la tabla solo si no existe previamente.
Despues se agregan () y dentro se definen las columnas con sus tipos de datos.
INT es para enteros, VARCHAR() es para cadenas de texto de longitud variable y CHAR() es para cadenas de texto mas cortas.
En ambas, VARCHAR y CHAR se especifica dentro de () la cantidad de caracteres que se pueden almacenar.
En el caso de DATE, es para almacenar fechas con el formato 'YYYY-MM-DD'.
 */
CREATE TABLE IF NOT EXISTS autores (
    autor_id INT,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    genero CHAR(1),
    fecha_nacimiento DATE,
    pais_origen VARCHAR(40)
);

/*Query para mostrar las tablas de la base de datos que se selecciono en USE. */
SHOW TABLES;

/*Query para mostrar la base de datos en la que se esta trabajando. */
SELECT DATABASE();

/*Query para eliminar una tabla si existe.
Recuerda, al igual que DROP DATABASE, esto eliminará toda la tabla
y su contenido sin posibilidad de recuperación.*/
DROP TABLE IF EXISTS usuarios;


/*Query para mostrar las columnas de una tabla. */
SHOW COLUMNS FROM autores;

/*DESC hace lo mismo que SHOW COLUMNS, pero es como una abreviatura. */
DESC autores;

/*Query para crear una tabla con la misma estructura que otra tabla existente.
Con las mismas columnas, mismos nombres en columnas y mismo tipo de datos. */
CREATE TABLE usuarios LIKE autores;

/*Query para insertar datos en una tabla.
Dentro de () que están después de la clausula INSERT INTO se especifican las columnas en las que se insertarán los datos.
Y en dentro de () despues de la clausula VALUES se especifican los valores a insertar.
Es decir, se debe colocar la misma cantidad de columnas y valores.
IMPORTANTE, deben llevar el mismo orden y deben coincidir con las columnas y tipo de dato de la tabla en la que se agregarán los datos.
Se puede seleccionar menos columnas de las existentes, pero los valores a insertar deben seguir el mismo orden.
Las columnas no seleccionadas recibirán el valor NULL por defecto. */
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
VALUES (1, 'Gabriel', 'Garcia Marquez', 'M', '1927-03-06', 'Colombia');

/*Query para consultar todos los datos de una tabla. */
SELECT * FROM autores;

/*Query para ingresar multiples registros en una tabla. */
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen)
VALUES (2, 'J.K.', 'Rowling', 'F', '1965-07-31', 'Reino Unido'),
       (3, 'Haruki', 'Murakami', 'M', '1949-01-12', 'Japón'),
       (4, 'Isabel', 'Allende', 'F', '1942-08-02', 'Chile'),
       (5, 'George', 'Orwell', 'M', '1903-06-25', 'Reino Unido');    

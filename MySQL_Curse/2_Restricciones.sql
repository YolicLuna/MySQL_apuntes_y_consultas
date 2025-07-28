"""NOTA: Las query's pueden o no llevar la clausula IF EXISTS. 
Recordemos que IF EXISTS se utiliza para que las query's se ejecuten solo si la base de datos o tabla existen.
Pero su uso sirve para evitar errores. """


/*Al agregar la clausuala NOT NULL en una columna evitamos que se inserten valores nulos en esa columna.
Y si al ingresar datos en la tabla y no se proporciona un valor a esa columna se producirá un error. */
CREATE TABLE IF NOT EXISTS autores (
    nombre VARCHAR(25) NOT NULL
);

/*Al agregar la clausula UNIQUE en una columna evitamos que se inserten valores duplicados en esa columna.
Si se intenta insertar un valor ya existente en esa columna se producirá un error. */
CREATE TABLE IF NOT EXISTS autores (
    seudonimo VARCHAR(50) UNIQUE
);

/*DATETIME es la clusula que sirve para almacenar fechas y horas.
DEFAULT sirve para establecer un valor por defecto, es decir, si al insertar datos no se agrega un valor
a esa columna, se utilizará el valor por defecto (puede ser para cualquier tipo de dato).
la clausula current_time sirve para obtener la fecha y hora actual del momento en que se realizó el registro,
que es lo que en este caso se agregara por default. */
CREATE TABLE IF NOT EXISTS autores (
    fecha_creacion DATETIME DEFAULT current_time
);

/*now() realiza la misma funcion que current_time. */
CREATE TABLE IF NOT EXISTS autores (
    fecha_creacion DATETIME DEFAULT now()
);

/*UNSIGNED es la clusula que se utiliza para es para evitar que se almacenen numeros negativos en una columna.*/
CREATE TABLE IF NOT EXISTS autores (
    autor_id INT UNSIGNED
);

/*La clausula ENUM se utiliza para restringir los valores que se pueden almacenar en una columna.
En este caso, solo se permiten los valores 'M' y 'F'. */
CREATE TABLE IF NOT EXISTS autores (
    genero ENUM('M', 'F')
);

/*La clausula PRIMARY KEY se utiliza para definir una columna como clave primaria, 
lo que significa que los valores en esta columna serán únicos y no nulos.
Solo se puede agregar una PRIMARY KEY por tabla. 

La clausula AUTO_INCREMENT se utiliza para generar un valor único que se genera automáticamente para cada fila nueva. 
Los valores son enteros positivos que se incrementan automáticamente de uno en uno.
No es necesario que AUTO_INCREMENT se utilice en una columna que ya es PRIMARY KEY. */
CREATE TABLE IF NOT EXISTS autores (
    autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
);

/*Como podemos ver. la tabla libros cuenta con una columna autor_id, al igual que la tabla autores.
Esto es porque debajo se establece con la clausula FOREIGN KEY para que la columna autor_id en la tabla libros será una llave foranea,
misma que hará referencia a la tabla autores utilizando la clausula REFERENCES. 
Pueden existir una o varias llaves foraneas en la misma tabla, pero antes de crear una tabla con llave foranea,
se debe crear la tabla que tendra la llave primaria a la que se hará referencia, de lo contrario no se podrá crear la tabla. 
Si se intentan agregar datos en la columna con llave foranea pero esos datos no existen en la tabla a la que se hace referencia,
entonces se producirá un error. */
CREATE TABLE libros (
    libro_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    fecha_publicacion DATE,
    genero ENUM('Fiction', 'Non-Fiction', 'Science', 'History') NOT NULL,
    autor_id INT UNSIGNED,
    FOREIGN KEY (autor_id) REFERENCES autores(autor_id)
);

/*Si queremos que en una tabla no existan combinaciones de valores de varias columnas en la misma fila,
debemos utilizar la formula CONSTRAINT unique_combinacion UNIQUE y entre () los nombres de las columnas que tendran
combinaciones únicas. */
CREATE TABLE IF NOT EXISTS usuarios (
    CONSTRAINT unique_combinacion UNIQUE (nombre, apellido, matricula)
);
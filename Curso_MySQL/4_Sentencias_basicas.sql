
/*Esta query sirve para obtener todos los registros de una tabla.
La funcion de la clausula SELECT es seleccionar datos de una base de datos.
El * indica que queremos seleccionar todas las columnas (Puedes colocar el nombre de la columna en lugar de *).
La funcion de la clausula FROM es indicar la tabla de la cual queremos obtener los registros, para ello
se agrega el nombre de la tabla seguido de la clausula FROM. */
SELECT * FROM empleados;

/*Se pueden seleccionar una o varias columnas separadas por comas.
En este caso, solo se obtendran datos de las columnas nombre y apellido. */
SELECT nombre, apellido FROM empleados;

/*La clausula WHERE se utiliza para filtrar los datos que se quieren obtener.
En este caso, obtendremos todos los registros (SELECT *) de la tabla empleados (FROM empleados)
donde los datos en la columna nombre sean iguales a Juan (WHERE nombre = 'Juan').
'Juan' se escribe ente comillas porque es un dato de tipo texto (string), en el caso numerico no se colocan comillas.
NOTA: Si no se especifica la clausula WHERE, se obtendran todos los registros de la tabla, como si solo
ejecutaramos la query sin el WHERE. */
SELECT * FROM empleados WHERE nombre = 'Juan';

/*En este caso, se utiliza el signo > para filtrar los empleados con un salario mayor a 10000.*/
SELECT * FROM empleados WHERE salario > 10000;
"""
Se pueden utilizar otros operadores de comparacion como <, =, <=, >=, <>.
El signo < para comparar datos que sean menores a un valor especifico.
El signo > para comparar datos que sean mayores a un valor especifico.
El signo <= para comparar datos que sean menores o iguales a un valor especifico.
El signo >= para comparar datos que sean mayores o iguales a un valor especifico.
El signo = para comparar datos que sean iguales a un valor especifico.
El signo <> o != para comparar datos que sean diferentes a un valor especifico.
"""

/*La clausla (Operador logico) AND sirve para combinar condiciones.
En cualquier caso, ambas condiciones deben cumplirse para que se obtengan resultados,
es decir, si una condicion falla, no se obtendran resultados.
En este caso, solo se obtendran datos de los la tabla empleados que conmplan con las condiciones especificadas,
salario menor o igual a 10000 y que tengan el nombre Juan. 
Se pueden agregar la cantidad de condiciones que deseemos, recordando siempre que para obtener resultados, 
todas esas condiciones deben cumplirse. */
SELECT * FROM empleados WHERE salario <= 10000 AND nombre = 'Juan';

/* La clausla (Operador logico) OR sirve para combinar condiciones. 
En cualquier caso, solo una de las condiciones debe cumplirse para obtener resultados.
Es decir, los datos que obtengamos proveendras de filas que cumplan con una o ambas condiciones.
En este caso, solo se obtendran datos de la tabla empleados que cumplan con al menos una de las condiciones especificadas,
salario menor o igual a 10000 o que tengan el nombre Juan.
Si en una de las filas de la tabla se cumple con una de las condiciones, tambien se observara en el resultado.
Se pueden agregar la cantidad de condiciones que deseemos, recordando siempre que para obtener resultados,
basta con que una de esas condiciones se cumpla. */
SELECT * FROM empleados WHERE salario <= 10000 OR nombre = 'Juan';

/*En una misma query se pueden combinar los operadores logicos AND y OR, colocando entre parentesis las sentencias de condiciones.
En este caso, se obtendran datos de la tabla empleados que cumplan con las condiciones especificadas:
salario menor o igual a 10000 y nombre igual a Juan, o salario mayor a 10000 y nombre igual a Pedro.
Obtendremos datos siempre que ambas condiciones de una de las sentencias se cumpla.
En este caso, la unica manera de no obtener datos es que las condiciones de ambas sentencias fallen. */
SELECT * FROM empleados WHERE (salario <= 10000 AND nombre = 'Juan') OR (salario > 10000 AND nombre = 'Pedro');

/*La clausula IS NULL se utiliza para obtener los datos de las filas donde una columna contenga NULL. */
SELECT * FROM empleados WHERE apellido IS NULL;
/*La clausula IS NOT NULL se utiliza para obtener los datos de las filas donde una columna no contenga NULL. */
SELECT * FROM empleados WHERE apellido IS NOT NULL;
"""
Nota: Si intentamos algo como apellido = NULL, no obtendremos resultados, ya que NULL no es un valor de ningun tipo.
"""

/*La clausula BETWEEN se utiliza para filtrar los datos que se encuentran dentro de un rango especifico.
En este caso, obtendremos todos los registros de la tabla empleados donde la fecha de ingreso
se encuentre entre el 1 de enero de 2020 y el 31 de diciembre de 2020. 
El operador logico AND debe ser utilizado ya que establece la condición de los rangos entre los que se obtendran los datos. */
SELECT * FROM empleados WHERE fecha_ingreso BETWEEN '2020-01-01' AND '2020-12-31';
"""
Nota: No solo se puede trabajar con fechas, tambien con enteros, decimales o flotantes.
Con textos no se puede trabajar, ya que no se pueden establecer rangos con ellos.
"""


/*La clusula IN se utiliza para obtener datos apartir de una lista de valores especificos, valores que se agregan
dentro de paréntesis despues de IN. 
En este caso, obtendremos todos los registros de la tabla empleados donde el nombre sea Juan, Pedro o Maria. 
Esto mismo se podría hacer utilizando varias condiciones OR, pero no es nada recomendable. */
SELECT * FROM empleados WHERE nombre IN ('Juan', 'Pedro', 'Maria');

/*La clausula DISTINCT se utiliza para obtener datos unicos.
Es decir, si en una columna existen datos duplicados, estos se evitaran y solo obtendremos los datos
unicos. */
SELECT DISTINCT nombre FROM empleados;

/*La clusula AS se utiliza para renombrar columnas o tablas en una consulta.
Esto puede ser útil para hacer que los resultados sean más legibles o para evitar ambigüedades.
En este caso, obtendremos todos los registros de la tabla empleados, renombraremos la columna nombre como empleado_nombre
y la tabla empleados como employees. */
SELECT nombre AS empleado_nombre FROM empleados AS employees;

/*Las clusulas UPDATE y SET se utilizan para modificar los datos existentes en una tabla.
En este caso, estamos actualizando la columna salarios de la tabla empleados y estableciendo su valor en 12000.
Asi, todos los registros en la columna salarios serán de 12000. */
UPDATE empleados SET salarios = 12000;

/*En este caso, se agrega la clausula WHERE para especificar qué registros se deben actualizar.
Esto es útil para no afectar a todos los registros de la tabla.
Como en este caso, que solo se actualizará el registro del salario de Juan. */
UPDATE empleados SET salarios = 12000 WHERE nombre = 'Juan';

/*Se pueden actualizar múltiples columnas al mismo tiempo. separando con comas las columnas con sus cambios.
En este caso, se actualizará el salario y puesto de Juan. */
UPDATE empleados SET salarios = 12000, puesto = 'Vendedor' WHERE nombre = 'Juan';

"""
NOTA: Es importante saber si en una columna diferente a ID existen valores duplicados, si es así,
al actualizar datos se deberia utilizar la clusula WHERE con el valor del ID.
Ejemplo: Si en la consulta anterior existen dos empleados con el nombre Juan, al ejecutar la query, se cambiaran
los registros para ambos empleados. Si en lugar de usar el nombre Juan, se usa el ID del empleado en especifico,
los cambios solo se aplicarán al empleado con ese ID.
Ejemplo: UPDATE empleados SET salarios = 12000 WHERE id = 1;
"""

/*La clausula DELETE sirve para eliminar registros de una tabla.
En este caso, se eliminaran todas las ventas ralizadas por el empleado Juan.
Si quisieramos eliminar una sola venta, lo ideal sería usar "WHERE id = 1" o el numero de id de la venta, 
en lugar de "WHERE empleado = 'Juan'" */
DELETE FROM ventas WHERE empleado = 'Juan';

"""
NOTA: Si la query anterior de ejecutara sin la clusula WHERE, se eliminarian todos los registros de la tabla.
Y al igual que UPDATE, es importante saber si en una columna diferente a ID existen valores duplicados,
si es así, al eliminar datos se deberia utilizar la clusula WHERE con el valor del ID.
Ejemplo: Si en la consulta anterior existen dos empleados con el nombre Juan, al ejecutar la query, se eliminaran
los registros para ambos empleados. Si en lugar de usar el nombre Juan, se usa el ID del empleado en especifico,
los cambios solo se aplicarán al empleado con ese ID.
Ejemplo: DELETE FROM ventas WHERE id = 1;
"""

"""
Si intentamos eliminar registros utilizando una columna que esta especificada como llave primaria (Normalmente ID),
no se podrá realizar, ya que primero deberann eliminarse los registros de las llaves foraneas que hagan referencia a esa llave.
"""

/*El proceso para la eliminacion de datos en columnas llaves primarias y foraneas es el siguiente. */
/*1. Primero se eliminan los registros de la tabla que tiene la llave foranea, es decir, la tabla que hace referencia a la llave primaria. */
DELETE FROM ventas WHERE id_empleado = 1;

/*2. Luego se eliminan los registros de la tabla que tiene la llave primaria, es decir, la tabla a la que hace referencia la llave foranea. */
DELETE FROM empleados WHERE id_empleado = 1;


/*Existe una manera en cadena para eliminar esos registros.
Colocando la clausula ON DELETE CASCADE en la llave foranea, se eliminan automaticamente los registros
cuando se eliminan registros en la llave primaria de la tabla referenciada.
En este caso, si se elimina un empleado de la tabla empleados utilizando su ID como condicion (DELETE FROM empleados WHERE id_empleado = 1;), 
las ventas en la tabla ventas asociadas al ID de ese empleado se eliminaran automaticamente. */
CREATE TABLE IF NOT EXISTS ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50),
    cantidad INT,
    precio DECIMAL(10, 2),
    nombre_empleado VARCHAR(50),
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado) ON DELETE CASCADE
);

/*Esta es otra manera de eliminación en cascada.
Si al crear la tabla no se agrega ON DELETE CASCADE, se puede agregar posteriormente con la clusula ALTER TABLE,
seguido de ADD, seguido de FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado) y terminando con ON DELETE CASCADE.
Asi la tabla sera modificada y se podrá hacer la eliminacion en cascada. */
ALTER TABLE ventas ADD FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado) ON DELETE CASCADE;

/*La clausula TRUNCATE se utiliza para eliminar todos los registros de una tabla de manera rápida y eficiente.
A diferencia de DELETE, TRUNCATE no registra la eliminación de cada fila individualmente, lo que lo hace más rápido.
Sin embargo, no se puede utilizar TRUNCATE si la tabla tiene llaves foraneas que hacen referencia a ella. 
La otra diferencia con DELETE es que DELETE conserva los metadatos de la tabla y TRUNCATE no lo hace.
Ejemplo: Si tenemos 100 registros con el id AUTO_INCREMENT y usamos DELETE al volver a agregar registros,
el conteo en id comenzara en donde se quedo, que seria 101.
Pero con TRUNCATE, el conteo se reiniciara a 1.
Ya que TRUNCATE resetea toda la tabla y sus metadatos. */
TRUNCATE TABLE empleados;
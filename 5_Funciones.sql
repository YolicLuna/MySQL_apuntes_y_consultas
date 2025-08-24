""" FUNCIONES PARA MANIPULAR CADENAS DE TEXTO. """

/*La funcion CONCAT() sirve para conectar cadenas de texto de diferentes columnas (pueden ser 2 o más) pertenecientes
a la misma tabla.
EN este caso, se unira el nombre y apellido de los empleados, colocando un espacio entre ellos.
La clausula AS permite asignar un alias a la columna resultante, esa columna solo existira en el resultado de la consulta y
no puede ser usado fuera de ella, o sea, en otras consultas. */
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM empleados;


/*La funcion LENGTH() sirve para obtener la cantidad de caracteres de una cadena de tecxto.
En este caso, se obtendran solo los nombres de empleados que tengan mas de 5 caracteres. */
SELECT * FROM empleados WHERE LENGTH(nombre) > 5;

/*La funcion UPPER() sirve para obtener cadenas de texto en mayusculas,
es decir, aun que el texto contenga minusculas, UPPER convertira todo en mayusculas. */
SELECT UPPER(nombre) FROM empleados;

/*La funcion LOWER() sirve para obtener cadenas de texto en minusculas,
es decir, aun que el texto contenga mayusculas, LOWER convertira todo en minusculas. */
SELECT LOWER(apellido) FROM empleados;

/*Con la funcion TRIM() se pueden eliminar los espacios en blanco al inicio y al final de una cadena de texto. */
SELECT TRIM(nombre) FROM empleados;

/*La funcion LEFT() sirve para obtener una subcadena de una cadena de texto, comenzando desde la izquierda.
En ambas query's se obtendrán los 3 primeros caracteres de los nombres de los empleados. */
SELECT LEFT(nombre, 3) AS nombre_corto FROM empleados;
SELECT * FROM empleados WHERE LEFT(nombre, 3);

/*La funcion RIGHT() sirve para obtener una subcadena de una cadena de texto, comenzando desde la derecha.
Funciona igual que LEFT(), pero en este caso se obtendrá la subcadena desde la derecha. 
En este caso, obtendremos los 3 últimos caracteres de los nombres de los empleados. */
SELECT RIGHT(nombre, 3) AS nombre_corto FROM empleados;
SELECT * FROM empleados WHERE RIGHT(nombre, 3);



""" FUNCIONES PARA MANIPULAR NUMEROS. """

/*La funcion RAND() sirve para generar un número aleatorio entre 0 y 1, o sea un float. */
SELECT RAND();

/*Si queremos generar un número aleatorio entero positivo entre 0 y 100 podemos multiplicar el resultado de RAND() por 100
y luego redondearlo con la funcion ROUND(). */
SELECT ROUND(RAND() * 100);

/*La funcion TRUNCATE() sirve para truncar un número a una cantidad de decimales especificada.
En este caso, se truncará el salario de los empleados a 2 decimales, es decir, si el salario contiene 8 decimales,
con TRUNCATE solo se obtendra el salario con los decimales especificados, en este caso, 2. */
SELECT TRUNCATE(salario, 2) FROM empleados;




""" FUNCIONES PARA MANIPULAR FECHAS. """

/*La funcion NOW() sirve para obtener la fecha y hora actual del sistema en el que se encuentra la base de datos. */
SELECT NOW();

/*La funcion CURDATE() sirve para obtener solo la fecha actual del sistema en el que se encuentra la base de datos. */
SELECT CURDATE();

/*Con la siguiente query, podemos extraer información que fue almacenada en la fecha actual.
En este caso, obtendremos las ventas generadas en la fecha actual. */
SELECT * FROM ventas WHERE DATE(fecha_de_venta) = CURDATE();

/*La funcion CURTIME() sirve para obtener solo la hora actual del sistema en el que se encuentra la base de datos. */
SELECT CURTIME();

/*Se puede crear una variable en la que se almacene la fecha y hora actual. */
SET @now = NOW();

/*Las variables se pueden crear de dos maneras diferentes.
EN este caso, se crea una variable llamada @now que almacena la fecha y hora actual. */
CREATE VARIABLE @now NOW();
SET @now = NOW();

/*Despues, con esa variable se puede extraer informacion de la fecha y hora actual.
No es necesario colocar todas las funciones, solo las necesarias */

SELECT SECOND(@now), 
       MINUTE(@now), 
       HOUR(@now),
       DAY(@now),
       MONTH(@now),
       YEAR(@now);

/*Podemos extraer el dia de la semana, del mes o del año. */
SELECT DAYOFWEEK(@now), 
       DAYOFMONTH(@now), 
       DAYOFYEAR(@now);

/*Se puede convertir nuestra variable que es de timestamp a formato DATE. */
SELECT DATE(@now);

/*Con la funcion INTERVAL se puede sumar o restar tiempo a una fecha.
En este caso, se sumarán 30 días a la fecha y hora actual.
Pero pueden ser segundos, minutos, semanas y años.
Si queremos restar solo se debe cambiar el simbolo + por el -. */
SELECT @now + INTERVAL 30 DAY;



""" FUNCIONES SOBRE CONDICIONES. """

/*La funcion IF() permite evaluar una condición y devolver un valor u otro según el resultado de esa evaluación.
Las condiciones pueden ser de cualquier tipo, numericas, de texto, booleanas, etc.
En este caso, se evaluará si el salario es mayor a 15000. Si es así, se devolverá 'Alto', de lo contrario, se devolverá 'Bajo'. */
SELECT IF(salario > 15000, 'Alto', 'Bajo') FROM empleados;

/*La funcion IFNULL() permite evaluar si un valor es NULL y devolver un valor/mensaje alternativo en caso de que el valor original si sea NULL.
En este caso, si el nombre es NULL, se devolverá 'Sin nombre'. */
SELECT IFNULL(nombre, 'Sin nombre') FROM empleados;


/*Para crear una funcion necesitamos utilizar la palabra clave CREATE FUNCTION, seguida del nombre de la funcion y los parametros que recibira.
En este caso, crearemos una funcion que calcule el salario anual de un empleado a partir de su salario mensual. 
DELIMITER hace que el separador de instrucciones cambie temporalmente, permitiendo el uso de ; dentro de la funcion sin que se interprete como el final de la misma. 
Si no se aplica DELIMITER antes de crear la funcion, se producira un error al tener dos ; en la misma intruccioón. 
Recuerda siempre ejecutar DELIMITER ; al terminar de crear la funcion. */

DELIMITER //

CREATE FUNCTION calcular_salario_anual(salario_mensual DECIMAL(10,2)) -- EN esta parte se añade la logica de la funcion.
RETURNS DECIMAL(10,2) -- Esta parte indica el tipo de dato que la funcion retornara.
BEGIN -- En esta parte se define el cuerpo de la funcion.
      -- La logica de la funcion se escribe aqui.
    RETURN salario_mensual * 12; -- Esta parte indica el resultado que la funcion retornara.
END// -- Esta parte indica el final de la funcion y se usa el delimitador definido anteriormente.

DELIMITER ;


/*Esta query muestra como se llamaria o usaria una funcion, en este caso, la que se creo anteriormente. 
En este caso obtendremos el salario anual de cada empleado, ya que la funcion multiplica el salario mensual por 12. */
SELECT calcular_salario_anual(salario) FROM empleados;


/*La siguiente query sirve para listar las funciones existentes en nuestra base de datos. */
SELECT name FROM mysql.proc WHERE db = database() AND type = 'FUNCTION';

/*La siguiente query sirve para eliminar una funcion de nuestra base de datos.
En este caso, se eliminara la funcion que se creo anteriormente. */
DROP FUNCTION IF EXISTS calcular_salario_anual;

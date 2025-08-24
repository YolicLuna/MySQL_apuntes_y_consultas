/*La clusula LIKE sirve para buscar coincidencias en una columna de texto, 
es decir, buscar datos que coincidan con la cadena de texto que se agrega entre ''.
En este caso se buscara el texto "Noche" en la columna titulo de la tabla Canciones.
Podriamos usar % para que las busquedas sean parciales,
si el % se coloca antes de la palabra '%Noche' se buscara la palabra Noche al final de 
la cadena de texto de la columna titulo. Si el % se coloca al final de la palabra'Noche%' 
se buscara la palabra Noche al principio de la cadena de texto y si el % se coloca
en ambos lados, al principio y final de la cadena '%Noche%', se buscara la palabra Noche
en cualquier parte de la cadena de texto. */

SELECT * FROM Canciones WHERE titulo LIKE "Noche";

/*Si en lugar de colocar un string se coloca un patrón con _, la busqueda será mas precisa,
ya que solo buscara titulos con la misma cantida de caracteres que los ___,
es decir, 3 ___ serian tres caracteres.
Si se coloca una letra en algun lugar del patron __e__ obtendremos titulos con la letra e
en la posicion que se encuentre. */

SELECT * FROM Canciones WHERE titulo LIKE "_____";


/*La clausula ORDER BY se utiliza para ordenar los resultados de una consulta y al funal se utiliza
DESC para ordenar de forma descendente y ASC para ordenar de forma ascendente. */

SELECT * FROM Canciones ORDER BY cancion_id DESC;

/*La clausula LIMIT se utiliza para limitar el número de resultados que se obtienen,
en este caso se limita a 10 resultados. */

SELECT * FROM Canciones LIMIT 10;

/*Si se agregan 2 numeros enteros despues de LIMIT, el primer número indica desde que fila o registro 
comenzara a mostrar resultados y el segundo número indica el número de resultados a mostrar. */

SELECT * FROM Canciones LIMIT 5, 10;

/*La clausula COUNT() se utiliza para contar el número de filas que cumplen con una condición.
En este caso se contaran las canciones que tienen 50 reproducciones. */

SELECT COUNT(*) FROM Canciones WHERE reproducciones == 50;

/*La clausula SUM() se utiliza para sumar el valor de una columna en todas las filas que cumplen con
una condición. */

SELECT SUM(reproducciones) FROM Canciones;

/*La clausula MAX() se utiliza para obtener el valor maximo de una columna.
La clausula MIN() se utiliza para obtener el valor minimo de una columna.
Y la clausula AVG() se utiliza para obtener el valor promedio de una columna. */

SELECT MAX(reproducciones) FROM Canciones;
SELECT MIN(reproducciones) FROM Canciones;
SELECT AVG(reproducciones) FROM Canciones;

/*La clausula GROUP BY se utiliza para agrupar filas que tienen valores iguales en la columna
especificada.
En este caso se agruparan se agruparan los autores y se sumara las ventas de totales que genero
cada uno con sus respectivas canciones. */

SELECT autor_id, SUM(ventas) FROM Canciones GROUP BY autor_id;

/*La clausula HAVING se utiliza para filtrar los resultados de una consulta que utiliza 
GROUP BY.
En este caso se filtraran los autores que tengan más de 1000 ventas en total.
Es decir, primero se sumaran las ventas, se agruparan por autor y luego se aplicara el filtro/condicion. */

SELECT autor_id, SUM(ventas) FROM Canciones GROUP BY autor_id HAVING SUM(ventas) > 1000;

/*La clausula UNION se utuliza para combinar los resultados de dos o más consultas en una misma columna.
Es importante saber que la cantidad de columnas asignadas en AS deben ser las mismas en ambas
consultas, si alguna de las consultas tiene menos columnas, las columnas faltantes se sustitullen
por "". */

SELECT CONCAT(cancion, ' ', album) AS cancion_autor, "" FROM Canciones
UNION
SELECT CONCAT(nombre_autor, ' ', apellido_autor) AS cancion_autor, disquera FROM Autores;

/*La siguiente consulta es un ejemplo de subconsultas, las cuales permiten realizar consultas dentro de otras consultas.
Estas subconsultas pueden ser utilizadas en diferentes partes de una consulta, como en la cláusula WHERE, HAVING o incluso en la lista de selección.
Estas subconsultas siempre deben ir dentro de paréntesis.
Y la manera en que se ejecutan es de forma anidada, es decir, la subconsulta se ejecuta primero
y el resultado se utiliza en la consulta principal. 

En este ejmplo tenemos una consulta con dos subconsultas anidadas.
Primero se ejecutan la subconsulta que comienza con SELECT AVG, el resultado de esa subconsulta se utiliza
para ejecutar la subconsulta que comienza con SELECT autor_id y el resultado de esta se utiliza para
ejecutar la consulta principal que comienza con SELECT CONCAT. */

SELECT CONCAT(nombre_autor, ' ', apellido_autor)
FROM Autores
WHERE autor_id IN (
    SELECT autor_id FROM Canciones GROUP BY autor_id
    HAVING SUM(ventas) > (SELECT AVG(ventas) FROM Canciones)
);

/*La siguiente consulta utiliza la función IF para validar registros.
En este caso, el resultado nos dara 'Disponible' en caso de que existna una o mas canciones
con el titulo Arcana, de lo contrario el resultado sera 'No disponible'. */

SELECT IF (
    EXISTS(SELECT cancion_id FROM Canciones WHERE titulo = "Arcana"),
    'Disponible',
    'No disponible'
) AS Resultado;
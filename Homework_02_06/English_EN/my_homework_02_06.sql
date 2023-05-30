
use henry_module_2;
/*
1. Ejecute el archivo "`registros_henry.sql`" para insertar registros dentro de la base de datos 
creada en la clase anterior, corregir los errores que impidan la instrucción.
*/


/*
2. No se sabe con certeza el lanzamiento de las cohortes N° 1245 y N° 1246, 
se solicita que las elimine de la tabla.
*/

SELECT 
    *
FROM
    cohorte;

DELETE FROM cohorte 
WHERE
    IdCohorte = 1245 OR IdCohorte = 1246;

# 3  
/*
Se ha decidido retrasar el comienzo de la cohorte N°1243, por lo que la nueva fecha de inicio será el 16/05. 
Se le solicita modificar la fecha de inicio de esos alumnos.
*/

UPDATE cohorte 
SET 
    fecha_Inicio = '2020-05-16'
WHERE
    IdCohorte = 1243;	

select * from cohorte
where IdCohorte = 1243;
# 4
/*
a. El alumno N° 165 solicito el cambio de su Apellido por “Ramirez”.
*/
# Como quiero ver las columnas solamente, hago esto
SELECT 
    *
FROM
    alumnos
LIMIT 1;

UPDATE alumnos 
SET 
    apellido = 'Ramirez'
WHERE
    IdAlumno = 165;

SELECT 
    *
FROM
    alumnos
WHERE
    IdAlumno = 165;

/*
b. El área de Learning le solicita un listado de alumnos de la Cohorte N°1243 que incluya la fecha de ingreso.
*/
select * from cohorte;

select * from alumnos
limit 1;

SELECT 
    CONCAT(a.nombre, ' ', a.apellido) AS Full_Name,
    a.Fecha_Ingreso
FROM
    alumnos a
        JOIN
    cohorte c ON a.IdCohorte = c.IdCohorte
WHERE
    c.IdCohorte = 1243
ORDER BY Full_Name ASC;

/*
c. Como parte de un programa de actualización, el área de People le solicita un listado de los instructores 
que dictan la carrera de Full Stack Developer.
*/
select * from carrera;

select * from instructores
limit 1;

select * from cohorte;

SELECT 
    CONCAT(ins.nombre, ' ', ins.apellido) AS Full_Name
FROM
    cohorte coh
        JOIN
    carrera carr ON coh.IdCarrera = carr.IdCarrera
        JOIN
    instructores ins ON ins.IdInstructor = coh.IdInstructor
WHERE
    carr.Nombre = 'Full Stack Developer'
ORDER BY Full_Name ASC;

/*
d. Se desea saber que alumnos formaron parte de la cohorte N° 1235. Elabore un listado.
*/
SELECT 
    CONCAT(alu.nombre, ' ', alu.apellido) AS Full_Name
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
WHERE
    alu.IdCohorte = 1235
ORDER BY Full_Name ASC;

/*
e. Del listado anterior se desea saber quienes ingresaron en el año 2019.
*/

SELECT 
    CONCAT(alu.nombre, ' ', alu.apellido) AS Full_Name
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
WHERE
    alu.IdCohorte = 1235
        AND YEAR(alu.Fecha_Ingreso) = 2019
ORDER BY Full_Name ASC;

# 5
/*
a. ¿Que campos permiten que se puedan acceder al nombre de la carrera?

*/

select nombre from carrera
where nombre = "Data Science"						# En donde el campo nombre sea igual a "Data Science"
-- where nombre like "%Science%"  					# Cualquier nombre que contenga "Science" en su nombre
-- where nombre not like "Full Stack%"				# En donde el campo nombre no contenga al principio "Full Stack"
-- where nombre not like "Full Stack Developer"		# Todos los nombres que no sean "Full Stack Developer"
-- where nombre != "Full Stack Developer"			# Todos los nombres que no sean "Full Stack Developer"
-- where IdCarrera = 2								# Por el Id
order by nombre;



/*
b. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', 
utilizando LIKE y NOT LIKE?, ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 

*/

select * from carrera;

select * from cohorte limit 2;

select * from alumnos limit 1;

# utilizando LIKE 
SELECT 
    alu.nombre AS Nombre,
    alu.apellido AS Apellido,
    carr.nombre AS Carrera
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
        JOIN
    carrera carr ON carr.IdCarrera = coh.IdCarrera
WHERE
    carr.nombre LIKE 'Full Stack Developer';
    
# utilizando NOT LIKE 
SELECT 
    alu.nombre AS Nombre,
    alu.apellido AS Apellido,
    carr.nombre AS Carrera
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
        JOIN
    carrera carr ON carr.IdCarrera = coh.IdCarrera
WHERE
    carr.nombre NOT LIKE 'Data Science';
-- where carr.nombre not like "Data Science" and carr.nombre not like "Data Engineer" and carr.nombre not like "Data Analytics" ...;

	/*
	Claramente la mejor manera es con LIKE ya que filtramos especificamente la carrera que queremos, en cambio
	con un NOT LIKE deberiamos especificar todas las carreras que no nos interesan 
    (en este caso es una pero podrian ser muchas mas), lo que puede provocar que haya varias carreras que no nos interesen
	*/

/*
d. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', 
utilizando " = " y " != "? ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 

*/

# utilizando = 
SELECT 
    alu.nombre AS Nombre,
    alu.apellido AS Apellido,
    carr.nombre AS Carrera
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
        JOIN
    carrera carr ON carr.IdCarrera = coh.IdCarrera
WHERE
    carr.nombre = 'Full Stack Developer';

# utilizando != 
SELECT 
    alu.nombre AS Nombre,
    alu.apellido AS Apellido,
    carr.nombre AS Carrera
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
        JOIN
    carrera carr ON carr.IdCarrera = coh.IdCarrera
WHERE
    carr.nombre != 'Data Science';

/*
f. ¿Como emplearía el filtrado utilizando el campo idCarrera?
*/

SELECT 
    alu.nombre AS Nombre,
    alu.apellido AS Apellido,
    carr.nombre AS Carrera
FROM
    alumnos alu
        JOIN
    cohorte coh ON alu.IdCohorte = coh.IdCohorte
        JOIN
    carrera carr ON carr.IdCarrera = coh.IdCarrera
WHERE
    carr.IdCarrera = 1;


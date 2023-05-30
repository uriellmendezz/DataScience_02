use henry_module_2;

# 1
/*
¿Cuantas carreas tiene Henry?
*/

select count(*) as "Cantidad de carreras que tiene Henry" from carrera ; # 2 carreras

# 2
/*
¿Cuantos alumnos hay en total?
*/
select distinct count(*) as "Total de alumnos" from alumnos; # 180 alumnos en total

# 3
/*
¿Cuantos alumnos tiene cada cohorte?
*/
# Como en la tabla "cohorte" tenemos todos los valores de la columna "CantidadAlumnos" vacia,
# debo usar la tabla "alumnos" y agrupar por IdCohorte

select 
	IdCohorte as Cohorte,
	count(IdCohorte) as Cantidad_Alumnos
from 
	alumnos
group by IdCohorte;

# Inserto los valores que me dieron la consulta en la tabla "cohorte"
update cohorte
inner join (
select 
IdCohorte as Cohorte,
count(IdCohorte) as Cantidad_Alumnos
from alumnos
group by IdCohorte
) as subquery
on cohorte.IdCohorte = subquery.Cohorte
set cohorte.CantidadAlumnos = subquery.Cantidad_Alumnos;

select * from cohorte;

# 4
/*
Confecciona un listado de los alumnos ordenado por los 
últimos alumnos que ingresaron, con nombre y apellido en un solo campo.
*/
select * from alumnos;

select
fecha_Ingreso as Fecha_Ingreso,
concat(nombre," ",apellido) as Full_Name
from alumnos
order by Fecha_Ingreso desc;

# 5
/*
¿Cual es el nombre del primer alumno que ingreso a Henry? # Beverly	Gardner
*/
select 
nombre, 
apellido
from alumnos
order by fecha_Ingreso asc
limit 1;

# 6
/*
¿En que fecha ingreso? # 2019-12-04
*/
select 
nombre, 
apellido,
fecha_Ingreso
from alumnos
order by fecha_Ingreso asc
limit 1;

# 7
/*
¿Cual es el nombre del ultimo alumno que ingreso a Henry? # Jason	Harmon
*/
select 
nombre, 
apellido,
fecha_Ingreso
from alumnos
order by fecha_Ingreso desc
limit 1;

# 8
/*
La función YEAR le permite extraer el año de un campo date, 
utilice esta función y especifique cuantos alumnos ingresaron a Henry por año.
*/
select 
year(fecha_Ingreso) as Año,
count(*) as Total
from alumnos
group by Año
order by Año;

# 9
/*
¿Cuantos alumnos ingresaron por semana a henry?, (indique también el año)
*/
select
year(fecha_Ingreso) as Año,
weekofyear(fecha_Ingreso) as Semana,
count(*) as Total
from alumnos
group by Año, Semana
order by Año, Semana;

# 10
/*
¿En que años ingresaron más de 20 alumnos? # 2020,2021,2022
*/
select
year(fecha_Ingreso) as Año,
count(*) as Total
from alumnos
group by Año
having Total >= 20;

# 11
/*
Investigue las funciones TIMESTAMPDIFF() y CURDATE(). 
¿Podría utilizarlas para saber cual es la edad de los instructores?. 
*/

select * from instructores;

# TIMESTAMPDIFF() ---> Para sacar la diferencia de tiempo entre dos fechas
# CURDATE() ---> Retorna la fecha actual

select
timestampdiff(year,fecha_Nacimiento,curdate()) as Edad,
nombre,
apellido
from instructores;

# 12
/*
Cálcula:

La edad de cada alumno.
La edad promedio de los alumnos de henry.
La edad promedio de los alumnos de cada cohorte.
*/
select * from alumnos limit 1;

# La edad de cada alumno.
select 
concat(nombre," ",apellido) as Alumno,
timestampdiff(year,fecha_nacimiento,curdate()) as Edad
from alumnos
order by Edad asc;

# La edad promedio de los alumnos de henry # 32
select
round(avg(subquery.Edad)) as "Promedio de edad"
from
(
select 
IdAlumno,
timestampdiff(year,fecha_nacimiento,curdate()) as Edad
from alumnos
) as subquery;

# La edad promedio de los alumnos de cada cohorte.
select
subquery.IdCohorte as Cohorte,
round(avg(subquery.Edad)) as Promedio_Edad
from
(
select 
alu.IdAlumno,
coh.IdCohorte,
timestampdiff(year,alu.fecha_nacimiento,curdate()) as Edad
from alumnos alu
join cohorte coh on alu.IdCohorte = coh.IdCohorte
) as subquery
group by Cohorte;
	

# 13
/*
Elabora un listado de los alumnos que superan la edad promedio de Henry.
*/

select
nombre,
apellido,
timestampdiff(year,fecha_nacimiento,curdate()) as edad
from alumnos
where timestampdiff(year,fecha_nacimiento,curdate()) > 
(
select
round(avg(sq.edades)) as Promedio_Edad
from
(select
timestampdiff(year,fecha_nacimiento,curdate()) as edades
from alumnos)as sq
);
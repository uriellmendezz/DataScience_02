use henry_module_2;

# 1
/*
How many careers does Henry have?
*/

select count(*) as "Amount of Henry careers" from carrera ; # 2 carreras

# 2
/*
How many students are there in total?
*/
select distinct count(*) as "Total of students" from alumnos; # 180 students in total

# 3
/*
How any students does each cohort have?
*/

# As in the table "cohorte" we have all the values from the column "CantidadAlumnos" empty,
# I must use the table "alumnos" and group by IdCohorte

select 
	IdCohorte as Cohorte,
	count(IdCohorte) as Cantidad_Alumnos
from 
	alumnos
group by IdCohorte;

# I inserted the values that I got from the query into the table "cohorte"
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
Make a list of students ordered by
last students who entered, with first and last name in a single field.
*/
select * from alumnos;

select
fecha_Ingreso as Fecha_Ingreso,
concat(nombre," ",apellido) as Full_Name
from alumnos
order by Fecha_Ingreso desc;

# 5
/*
What's the name of the first student to enter Henry? #Beverly Gardner
*/
select 
nombre, 
apellido
from alumnos
order by fecha_Ingreso asc
limit 1;

# 6
/*
On what date did he enter? #2019-12-04
*/
select 
nombre, 
apellido,
fecha_Ingreso
from alumnos
order by fecha_Ingreso asc
limit 1;

# 7
/* What is the name of the last student that entered Henry? # Jason Harmon */
select 
nombre, 
apellido,
fecha_Ingreso
from alumnos
order by fecha_Ingreso desc
limit 1;

# 8
/*
The YEAR function allows you to extract the year from a date field,
use this function and specify how many students entered Henry per year.
*/
select 
year(fecha_Ingreso) as Año,
count(*) as Total
from alumnos
group by Año
order by Año;

# 9
/*
How many students entered Henry per week? (also indicate the year)
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
In which years did more than 20 students enter? #2020,2021,2022
*/
select
year(fecha_Ingreso) as Año,
count(*) as Total
from alumnos
group by Año
having Total >= 20;

# 11
/*
Investigate the TIMESTAMPDIFF() and CURDATE() functions.
Could you use them to find out the age of the instructors?
*/

select * from instructores;

# TIMESTAMPDIFF() ---> To get the time difference between two dates
# CURDATE() ---> return the current date

select
timestampdiff(year,fecha_Nacimiento,curdate()) as Edad,
nombre,
apellido
from instructores;

# 12
/*
Calculate:

The age of each student.
The average age of Henry's students.
The average age of students in each cohort.
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
Make a list of students who are older than Henry's average age.
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
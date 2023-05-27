## Homework
#### Instalación MySQL y Wokrbench
MySQL Server: Download
MySQL Installer: Download
Workbench: Download
MySQL: Documentation

#### Crear un modelo relacional basado en el modelo de negocios de Henry:

- Identificar las relaciones.
- Identifcar primery key´s y foreing key´s.
- Definir los tipos de datos.
- La entidades a modelar junto sus atributos son:

Carrea: ID, Nombre.<br><br>
Cohorte: ID, Código, Carrera, Fecha de Inicio, Fecha de Finalización, Instructor.<br><br>
Instructores: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Incorporación.<br><br>
Alumnos: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Ingreso, Cohorte.<br><br>
Crear en MySQL las tablas y relaciones del modelo definido.
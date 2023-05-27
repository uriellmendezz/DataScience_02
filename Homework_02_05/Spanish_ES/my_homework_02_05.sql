CREATE DATABASE Henry_Module_2;
USE Henry_Module_2;

CREATE TABLE IF NOT EXISTS Carrera (
    IdCarrera INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(40) NOT NULL,
    PRIMARY KEY (IdCarrera)
);

CREATE TABLE IF NOT EXISTS Instructores (
    IdInstructor INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(40),
    Apellido VARCHAR(40),
    Cedula_Identidad VARCHAR(40),
    Fecha_Nacimiento DATE,
    Fecha_Incorporacion DATE,
    PRIMARY KEY (IdInstructor)
);

CREATE TABLE IF NOT EXISTS Cohorte (
    IdCohorte INT NOT NULL AUTO_INCREMENT,
    Codigo VARCHAR(20),
    Carrera VARCHAR(40),
    Fecha_Inicio DATE,
    Fecha_Finalización DATE,
    CantidadAlumnos INT,
    IdInstructor INT,
    PRIMARY KEY (IdCohorte),
    FOREIGN KEY (IdInstructor) REFERENCES Instructores (IdInstructor)
);

CREATE TABLE IF NOT EXISTS Alumnos (
    IdAlumno INT NOT NULL AUTO_INCREMENT,
    Cedula_identidad VARCHAR(30),
    Nombre VARCHAR(40),
    Apellido VARCHAR(40),
    Fecha_Nacimiento DATE,
    Fecha_Ingreso DATE,
    IdCohorte INT,
    PRIMARY KEY (IdAlumno),
    FOREIGN KEY (IdCohorte) REFERENCES Cohorte (IdCohorte)
);


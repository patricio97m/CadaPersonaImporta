CREATE SCHEMA cada_persona_importal;
USE cada_persona_importal;

CREATE TABLE Persona (
  CUIL INT PRIMARY KEY,
  NumeroPaciente INT,
  Nombre VARCHAR(50),
  Apellido VARCHAR(50),
  FechaNacimiento DATE,
  Genero VARCHAR(10)
);

CREATE TABLE Antecedente (
  CUIL INT,
  Antecedente VARCHAR(50),
  Descripcion VARCHAR(100),
  PRIMARY KEY (CUIL, Antecedente),
  FOREIGN KEY (CUIL) REFERENCES Persona(CUIL)
);

CREATE TABLE Tratamiento (
  Codigo INT PRIMARY KEY,
  FechaOcurrencia DATE,
  LugarAplicacion VARCHAR(100),
  EfectoEsperado VARCHAR(100),
  Modo INT,
  Contraindicaciones VARCHAR(200),
  Riesgo VARCHAR(100),
  Beneficio VARCHAR(100),
  EdadMinima INT
);

CREATE TABLE Diagnostico (
  Codigo INT PRIMARY KEY,
  Descripcion VARCHAR(100),
  CodigoTrat INT,
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE EfectoAdverso (
  Codigo INT PRIMARY KEY,
  Nombre VARCHAR(50),
  FechaOcurrencia DATE
);

CREATE TABLE GravedadEfecto (
  CodigoEfecto INT PRIMARY KEY,
  ID INT,
  Descripcion VARCHAR(100),
  FOREIGN KEY (CodigoEfecto) REFERENCES EfectoAdverso(Codigo)
);

CREATE TABLE Modo (
  CodigoTrat INT PRIMARY KEY,
  ID INT,
  Descripcion VARCHAR(100),
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE TratamientoDiag (
  Codigo INT PRIMARY KEY,
  Confirmacion VARCHAR(50),
  FOREIGN KEY (Codigo) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE TratamientoFar (
  Codigo INT PRIMARY KEY,
  FOREIGN KEY (Codigo) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE TratamientoQui (
  Codigo INT PRIMARY KEY,
  Exito VARCHAR(50),
  FOREIGN KEY (Codigo) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE CompuestoFarmaco (
  Codigo INT PRIMARY KEY,
  Fabricante VARCHAR(100),
  Partida VARCHAR(50),
  Lote VARCHAR(50),
  FechaVencimiento DATE,
  Vacuna VARCHAR(50)
);

CREATE TABLE Composicion (
  CodigoTrat INT,
  CodigoComp INT,
  Codigo INT,
  Farmaco VARCHAR(100),
  Cantidad INT,
  PRIMARY KEY (CodigoTrat, CodigoComp),
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo),
  FOREIGN KEY (CodigoComp) REFERENCES CompuestoFarmaco(Codigo)
);

CREATE TABLE Profesional (
  MatriculaNac INT PRIMARY KEY,
  MatriculaProv INT,
  Nombre VARCHAR(50),
  Apellido VARCHAR(50),
  Especialidades VARCHAR(100),
  Celular VARCHAR(20),
  Email VARCHAR(50),
  DireccionPostal VARCHAR(100)
);

CREATE TABLE TratamientoMadre (
  CUILMadre INT,
  CUILHijo INT,
  PRIMARY KEY (CUILMadre, CUILHijo),
  FOREIGN KEY (CUILMadre) REFERENCES Persona(CUIL),
  FOREIGN KEY (CUILHijo) REFERENCES Persona(CUIL)
);

CREATE TABLE ConsultaA (
  CUIL INT,
  MatriculaNac INT,
  PRIMARY KEY (CUIL, MatriculaNac),
  FOREIGN KEY (CUIL) REFERENCES Persona(CUIL),
  FOREIGN KEY (MatriculaNac) REFERENCES Profesional(MatriculaNac)
);

CREATE TABLE Experimenta (
  CUIL INT,
  CodigoEf INT,
  PRIMARY KEY (CUIL, CodigoEf),
  FOREIGN KEY (CUIL) REFERENCES Persona(CUIL),
  FOREIGN KEY (CodigoEf) REFERENCES EfectoAdverso(Codigo)
);

CREATE TABLE EsRequeridoPor (
  Antecedente INT,
  CodigoTrat INT,
  CUIL INT,
  PRIMARY KEY (Antecedente, CodigoTrat, CUIL),
  FOREIGN KEY (Antecedente) REFERENCES Antecedente(CUIL),
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo),
  FOREIGN KEY (CUIL) REFERENCES Persona(CUIL)
);

CREATE TABLE EsCausadoPor (
  CodigoEf INT,
  CodigoTrat INT,
  PRIMARY KEY (CodigoEf, CodigoTrat),
  FOREIGN KEY (CodigoEf) REFERENCES EfectoAdverso(Codigo),
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE Indica (
  MatriculaNac INT,
  CodigoTrat INT,
  PRIMARY KEY (MatriculaNac, CodigoTrat),
  FOREIGN KEY (MatriculaNac) REFERENCES Profesional(MatriculaNac),
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo)
);

CREATE TABLE Utiliza (
  CodigoComp INT,
  CodigoTrat INT,
  PRIMARY KEY (CodigoComp, CodigoTrat),
  FOREIGN KEY (CodigoComp) REFERENCES CompuestoFarmaco(Codigo),
  FOREIGN KEY (CodigoTrat) REFERENCES Tratamiento(Codigo)
);


-- INSERT en tabla Persona
INSERT INTO Persona (CUIL, NumeroPaciente, Nombre, Apellido, FechaNacimiento, Genero)
VALUES (12345678, 1, 'Juan', 'Pérez', '1990-05-15', 'Masculino'),
       (87654321, 2, 'María', 'Gómez', '1985-09-20', 'Femenino');

-- INSERT en tabla Antecedente
INSERT INTO Antecedente (CUIL, Antecedente, Descripcion)
VALUES (12345678, 'Hipertensión', 'Antecedente de hipertensión arterial'),
       (12345678, 'Diabetes', 'Antecedente de diabetes tipo 2'),
       (87654321, 'Asma', 'Antecedente de asma'),
       (87654321, 'Alergia a los mariscos', 'Antecedente de alergia a los mariscos');

-- INSERT en tabla Tratamiento
INSERT INTO Tratamiento (Codigo, FechaOcurrencia, LugarAplicacion, EfectoEsperado, Modo, Contraindicaciones, Riesgo, Beneficio, EdadMinima)
VALUES (1, '2022-03-15', 'Hospital Central', 'Reducción de la inflamación', 1, 'Embarazo, alergia a los componentes', 'Bajo', 'Alivio del dolor', 18),
       (2, '2022-06-20', 'Clínica del Sur', 'Prevención de infecciones', 2, 'Ninguna', 'Bajo', 'Refuerzo del sistema inmunológico', 12);

-- INSERT en tabla Diagnostico
INSERT INTO Diagnostico (Codigo, Descripcion, CodigoTrat)
VALUES (1, 'Artritis reumatoide', 1),
       (2, 'Resfriado común', 2);

-- INSERT en tabla EfectoAdverso
INSERT INTO EfectoAdverso (Codigo, Nombre, FechaOcurrencia)
VALUES 	(1, 'Náuseas', '2020-02-02'),
		(2, 'Dolor de cabeza', '2022-12-12'),
		(3, 'Mareos', '2021-06-15'),
		(4, 'Insomnio', '2022-03-10'),
		(5, 'Diarrea', '2023-01-25'),
		(6, 'Erupción cutánea', '2022-09-05'),
		(7, 'Pérdida de apetito', '2021-11-20'),
		(8, 'Fatiga', '2023-03-08'),
		(9, 'Dolor muscular', '2022-07-12'),
		(10, 'Visión borrosa', '2021-09-30'),
        (11, 'Fiebre', '2020-04-04');
       

-- INSERT en tabla GravedadEfecto
INSERT INTO GravedadEfecto (CodigoEfecto, ID, Descripcion)
VALUES (1, 1, 'Leve'),
       (2, 2, 'Moderado');

-- INSERT en tabla Modo
INSERT INTO Modo (CodigoTrat, ID, Descripcion)
VALUES (1, 1, 'Inyección intramuscular'),
       (2, 1, 'Tomar comprimidos');

-- INSERT en tabla TratamientoDiag
INSERT INTO TratamientoDiag (Codigo, Confirmacion)
VALUES (1, 'Confirmado'),
       (2, 'Sospecha');

-- INSERT en tabla TratamientoFar
INSERT INTO TratamientoFar (Codigo)
VALUES (1),
       (2);

-- INSERT en tabla TratamientoQui
INSERT INTO TratamientoQui (Codigo, Exito)
VALUES (1, 'Éxito parcial'),
       (2, 'Éxito total');

-- INSERT en tabla CompuestoFarmaco
INSERT INTO CompuestoFarmaco (Codigo, Fabricante, Partida, Lote, FechaVencimiento, Vacuna)
VALUES (1, 'Farmacorp', 'ABC123', 'L12345', '2024-12-31', 'COVID-19'),
       (2, 'PharmaX', 'DEF456', 'M98765', '2023-09-30', NULL);

-- INSERT en tabla Composicion
INSERT INTO Composicion (CodigoTrat, CodigoComp, Codigo, Farmaco, Cantidad)
VALUES (1, 1, 1, 'Antiinflamatorio', 50),
       (1, 2, 1, 'Antipirético', 25),
       (2, 1, 2, 'Antibiótico', 100);

-- INSERT en tabla Profesional
INSERT INTO Profesional (MatriculaNac, MatriculaProv, Nombre, Apellido, Especialidades, Celular, Email, DireccionPostal)
VALUES (12345, 98765, 'Dr. Roberto', 'González', 'Cardiología, Medicina Interna', '555-123456', 'roberto.gonzalez@example.com', 'Calle Principal 123'),
       (54321, 56789, 'Dra. Ana', 'López', 'Pediatría, Alergología', '555-987654', 'ana.lopez@example.com', 'Avenida Central 456');

-- INSERT en tabla TratamientoMadre
INSERT INTO TratamientoMadre (CUILMadre, CUILHijo)
VALUES (12345678, 87654321),
       (87654321, 12345678);

-- INSERT en tabla ConsultaA
INSERT INTO ConsultaA (CUIL, MatriculaNac)
VALUES (12345678, 12345),
       (87654321, 54321);

-- INSERT en tabla Experimenta
INSERT INTO Experimenta (CUIL, CodigoEf)
VALUES (12345678, 1),
       (87654321, 2);

-- INSERT en tabla EsRequeridoPor
INSERT INTO EsRequeridoPor (Antecedente, CodigoTrat, CUIL)
VALUES (12345678, 1, 12345678),
       (87654321, 2, 87654321);

-- INSERT en tabla EsCausadoPor
INSERT INTO EsCausadoPor (CodigoEf, CodigoTrat)
VALUES (1, 1),
       (2, 2),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 1),
       (6, 1),
       (7, 1),
       (8, 1),
       (9, 1),
       (10, 1),
       (11, 1);

-- INSERT en tabla Indica
INSERT INTO Indica (MatriculaNac, CodigoTrat)
VALUES (12345, 1),
       (54321, 2);

-- INSERT en tabla Utiliza
INSERT INTO Utiliza (CodigoComp, CodigoTrat)
VALUES (1, 1),
       (2, 2);

-- Consultas 

-- i. Top 10 de tratamientos con más de 10 efectos adversos:

SELECT T.Codigo, T.FechaOcurrencia, COUNT(E.Codigo) AS NumeroEfectos
FROM Tratamiento T
JOIN EsCausadoPor EC ON T.Codigo = EC.CodigoTrat
JOIN EfectoAdverso E ON EC.CodigoEf = E.Codigo
GROUP BY T.Codigo, T.FechaOcurrencia
HAVING COUNT(E.Codigo) > 10
ORDER BY NumeroEfectos DESC
LIMIT 10;

-- ii. Cantidad de personas con algún tratamiento diagnóstico que no haya confirmado el diagnóstico:

SELECT COUNT(DISTINCT P.CUIL) AS CantidadPersonas
FROM Persona P
JOIN TratamientoDiag TD ON P.CUIL = TD.Codigo
WHERE TD.Confirmacion LIKE 'No confirmado';

-- iii. ¿Cuántas personas ha habido que hayan tenido la mayor cantidad de efectos adversos de algún tratamiento de vacunación?

SELECT COUNT(DISTINCT P.CUIL) AS CantidadPersonas
FROM Persona P
JOIN Experimenta E ON P.CUIL = E.CUIL
JOIN Tratamiento T ON E.CodigoEf = T.Codigo
JOIN TratamientoFar TF ON T.Codigo = TF.Codigo
JOIN CompuestoFarmaco CF ON TF.Codigo = CF.Codigo
WHERE CF.Vacuna = 'Vacuna'
GROUP BY P.CUIL
HAVING COUNT(E.CodigoEf) = (
    SELECT MAX(NumEfectos) AS MaxEfectos
    FROM (
        SELECT COUNT(CodigoEf) AS NumEfectos
        FROM Experimenta
        GROUP BY CUIL
    ) AS EfectosPorPersona
);

-- iv. ¿Cuántas muertes ocurrieron relacionadas con vacunas, agrupando por vacuna, durante los años 2021 al 2023?

SELECT CF.Vacuna, COUNT(E.Codigo) AS CantidadMuertes
FROM EfectoAdverso E
JOIN GravedadEfecto GE ON E.Codigo = GE.CodigoEfecto
JOIN CompuestoFarmaco CF ON E.Codigo = CF.Codigo
WHERE GE.Descripcion = 'Letal' AND CF.Vacuna IS NOT NULL AND YEAR(E.FechaOcurrencia) BETWEEN 2021 AND 2023
GROUP BY CF.Vacuna;

-- v. 
SELECT COUNT(*) AS TotalMuertesRecienNacidos
FROM Tratamiento T
JOIN TratamientoMadre TM ON T.CUIL = TM.CUILMadre
JOIN Persona P ON TM.CUILMadre = P.CUIL
JOIN EfectoAdverso EA ON T.Codigo = EA.Codigo
WHERE EA.Nombre = 'Muerte' AND P.Genero = 'Femenino' AND P.FechaNacimiento >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


-- vi. Formulen una consulta que permita a un profesional médico descartar un tratamiento en niños por ser el riesgo mayor al beneficio. ¿Qué otra información guardarían para realizar esta comparación? Incluirla en el modelo completo.

SELECT T.Codigo, T.FechaOcurrencia, T.Riesgo, T.Beneficio
FROM Tratamiento T
WHERE T.EdadMinima <= 18 AND T.Riesgo > T.Beneficio;

-- vii. Mostrar todos los tratamientos de bajo riesgo practicados a personas con al menos 2 (dos) patologías preexistentes y que sean adultos mayores.

SELECT DISTINCT T.Codigo, T.FechaOcurrencia, T.Riesgo, T.Beneficio, T.EdadMinima
FROM Tratamiento T
INNER JOIN EsRequeridoPor ER ON T.Codigo = ER.CodigoTrat
INNER JOIN Antecedente A ON ER.Antecedente = A.CUIL
INNER JOIN Persona P ON A.CUIL = P.CUIL
WHERE T.Riesgo = 'Bajo'
  AND P.Genero = 'Masculino' -- Se puede cambiar a femenino también
  AND YEAR(CURRENT_DATE) - YEAR(P.FechaNacimiento) >= 60 
GROUP BY T.Codigo, T.FechaOcurrencia, T.LugarAplicacion, T.EfectoEsperado, T.Modo, T.Contraindicaciones, T.Riesgo, T.Beneficio, T.EdadMinima
HAVING COUNT(DISTINCT ER.Antecedente) >= 2;

-- viii. Formular una consulta que Uds. Le harían a la app para saber si realizarse un tratamiento.
-- Esta consulta te dará como resultado los tratamientos de bajo riesgo que podrías considerar realizar
-- según tu edad y si tienes alguna patología preexistente requerida por el tratamiento en la base de datos.    
SELECT T.Codigo, T.FechaOcurrencia, T.LugarAplicacion, T.EfectoEsperado, T.Riesgo, T.Beneficio
FROM Tratamiento T
WHERE T.Riesgo = 'Bajo' -- Filtrar por tratamientos de bajo riesgo
  AND T.EdadMinima >= 26 -- En este campo iría tu edad
  AND (
    SELECT COUNT(*) -- Verificar si tienes alguna patología preexistente requerida por el tratamiento
    FROM EsRequeridoPor ER JOIN Antecedente A ON ER.Antecedente = A.CUIL
    WHERE ER.CodigoTrat = T.Codigo
      AND ER.CUIL = '19999115' -- Acá iría tu cuil
  ) >= 1;    

-- viii. 

SELECT T.Codigo, T.Descripcion, T.Riesgo, T.Beneficio
FROM Tratamiento T
WHERE T.EdadMinima > 0 -- Restringir a tratamientos para niños
    AND T.Riesgo > T.Beneficio; -- Verificar si el riesgo es mayor al beneficio


-- ix. Destacar aquellos tratamientos letales, por causar efectos severos, por rango etario, 
-- considerando 0 años, 1-5 años, 6-12 años, 13-17 años, 18 a 25 años, 26-40 años, 41-50 años, 51-70 años, 71-90 años, 91 o más años.
SELECT T.Codigo, T.FechaOcurrencia, T.Riesgo, T.Beneficio, P.FechaNacimiento,
       CASE
		WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) THEN '0 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) THEN '1-5 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 12 YEAR) THEN '6-12 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 17 YEAR) THEN '13-17 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 25 YEAR) THEN '18-25 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 40 YEAR) THEN '26-40 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 50 YEAR) THEN '41-50 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 70 YEAR) THEN '51-70 años'
        WHEN P.FechaNacimiento <= DATE_SUB(CURDATE(), INTERVAL 90 YEAR) THEN '71-90 años'
        ELSE '91 o más años'
       END AS RangoEtario
FROM Tratamiento T
JOIN Diagnostico D ON T.Codigo = D.CodigoTrat
JOIN Persona P ON D.Codigo = P.CUIL
JOIN EsCausadoPor ECP ON T.Codigo = ECP.CodigoTrat
JOIN GravedadEfecto GE ON ECP.CodigoEf = GE.CodigoEfecto
WHERE GE.Descripcion = 'Severo' -- Filtrar por efectos severos
  AND T.Riesgo = 'Letal' -- Filtrar por tratamientos letales
ORDER BY RangoEtario;

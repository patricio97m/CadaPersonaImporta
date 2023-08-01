# Trabajo práctico final de BD1 "Cada persona importa"

## Enunciado y Requisitos
“Cada Persona Importa” es una organización sin fines de lucro que busca registrar los
problemas de salud asociados a eventos locales, nacionales, mundiales y que como consecuencia de
decisiones tomadas por organismos gubernamentales han sido ocasionados a distintas poblaciones.
Las estadísticas son importantes en la toma de decisiones, pero en este caso, cada persona importa.
Por ello, esta organización quiere alzar la voz por todos aquellos que ya no están, por sus familias y
por los que quedan con su salud deteriorada, para ayudar a empoderar a todas las personas que
entienden que son responsables por las decisiones sobre su salud y de quienes están a su cargo

----------------------------------------------------------------------------------------------------------------------------------------

### De acuerdo a esta definicion, es necesario registrar:

- Cada persona con sus datos personales, y se lo identifica con una combinación entre su CUIL y un
número de paciente, que es un número de hash de 64 bits único que permitirá la anonimización de
los pacientes. 
- De cada "**persona**", todos los "**antecedentes**" como condiciones preexistentes, tales como diabetes,
cataratas, obesidad, cáncer, etc. Se debe permitir utilizar una codificación universal de diagnósticos
como la ICD 5 o posterior.
- Cada "**efecto adverso**" producido, indicando fecha de ocurrencia, eventos previos con sus fechas de
ocurrencia, como una bitácora o una línea de tiempo.
- Cada "**evento**" puede ser la administración de un "**tratamiento**" (diagnóstico, prescriptivo, curativo), que
a su vez puede ser invasivo o superficial.
- Cada tratamiento es o bien una "**práctica diagnóstica**" o "**quirúrgica**", o la administración de un
"**compuesto farmacológico**" (medicamentos, vacunas, sueros, adyuvantes) que es natural o artificial.
Se conoce el lugar del cuerpo principal de aplicación, efecto esperado principal y el conjunto de
contraindicaciones supuestas o comprobadas, así como también el centro de salud donde se realiza
y el profesional realizador.
- Los tratamientos se identifican con un código de nomenclador. Para el caso de las prácticas
diagnósticas se sabe además si se confirmó el diagnóstico presuntivo. Para las quirúrgicas se desea
saber si fue exitoso o no.
- Para los compuestos farmacológicos se desea saber la composición (fármaco y cantidad), fabricante,
partida y número de lote, con fecha de vencimiento. Se identifican con códigos de barras sean
artificiales o naturales.
- Un efecto adverso puede ser leve, moderado, grave o severo o muerte. Tiene un código y un
nombre.
- Se sabe que un tratamiento puede tener muchos efectos adversos y a su vez un efecto adverso
ocurrir con muchos tratamientos.
Cada tratamiento puede ser indicado por un profesional, en caso de que no se conozca o haya sido
sin indicación médica, se registran como “Profesional NN” y “Sin Profesional indicador”
respectivamente. Obviamente un profesional puede indicar muchos tratamientos, sean parte de su
especialidad o no.
- De los profesionales se desea conocer su nombre y apellido, especialidades, matrícula nacional y
provincial, sus datos de contacto como celular, email y dirección postal. No olvidar que un
profesional de la salud también es una persona.
El corazón de esta app es registrar para cada persona, todos los efectos adversos de cada
tratamiento recibido y los eventos ocurridos previos y posteriores, para poder realizar cálculos de
correlación que ayuden a conducir una investigación sobre las prácticas médicas vigentes y
obligatorias. Asimismo, detecten oportunidades de investigación acerca de los fundamentos
biológicos que permitan explicar la ocurrencia de ciertas patologías y cómo colaborar con la salud de
las personas.

#### El Modelo deberá permitir además resolver las siguientes cuestiones:
- Detectar qué efectos adversos se producen luego de un mismo tratamiento y en qué
cantidad o porcentaje.
- Conocer la frecuencia de ciertos eventos asociados a los tratamientos.
- Calcular la correlación de ciertos efectos adversos con distintos tratamientos.
- Conocer en qué medida la prescripción de los tratamientos empeora o mejora la
salud de las personas.
- Detectar qué antecedentes de salud de las personas deberían ser tenidos en cuenta
antes de aplicar un tratamiento.


----------------------------------------------------------------------------------------------------------------------------------------

## Diagrama entidad relación

![WhatsApp Image 2023-07-04 at 8 40 59 AM](https://github.com/patricio97m/CadaPersonaImporta/assets/112729627/c130e378-d3d8-4243-b9ae-df300a203e89)

## Modelo relacional detallado

**Persona**(CUIL, NumeroPaciente, Nombre, Apellido, FechaNacimiento, Genero) <br>
>	La entidad "Persona" almacena los datos personales y de identificación de cada persona, incluyendo el CUIL y el número de paciente. 

**Antecedente**(CUIL, Antecedente, Descripción) [FK: persona]
>	Los antecedentes médicos de cada persona se registran en la entidad "Antecedente"

**Diagnostico**(Codigo, Descripción, CodigoTrat) [FK: Tratamiento]
>	Los diagnósticos utilizan la codificación ICD y se almacenan en la entidad "Diagnostico".

**EfectoAdverso**(Codigo, Nombre)
>	Los efectos adversos se representan en la entidad "EfectoAdverso"

**GravedadEfecto** (CodigoEfecto, ID, Descripcion) [FK:EfectoAdverso]
>	Es una subentidad de EfectoAdverso donde se guardan los registros de que tipo de gravedad es el efecto

**Tratamiento** (Codigo, FechaOcurrencia, LugarAplicacion, EfectoEsperado, Modo, Contraindicaciones, Riesgo, Beneficio, EdadMinima)
>	Esta entidad contiene información sobre la fecha de ocurrencia, el lugar de aplicación y el efecto esperado del tratamiento.

**Modo** (CodigoTrat, ID, Descripcion) [FK: Tratamiento]
>	Esta es una subentidad de Tratamiento donde se almacena información de que si el tratamiento es invasivo o superficial.

**TratamientoDiag**(Codigo, Confirmacion) [FK:tratamiento] <br>
**TratamientoFar**(Codigo) [FK: tratamiento] 

**TratamientoQui**(Codigo, Exito) [FK: tratamiento]
>	Existen tres tipos de tratamientos: "TratamientoDiag" , "TratamientoFar" o "TratamientoQui". Cada uno de estos subtipos tiene atributos adicionales relevantes para su tipo de tratamiento específico.

**CompuestoFarmaco**(Codigo, Fabricante, Partida, Lote, FechaVencimiento, Vacuna)
>	La entidad "CompuestoFarmaco" almacena información sobre los compuestos farmacológicos, incluyendo su composición, fabricante, partida, lote y fecha de vencimiento. <br>

**Composicion** (CodigoTrat, CodigoComp, Codigo, Fármaco, Cantidad) [FK: Tratamiento, CompuestoFarmaco]
>	Esta subentidad subentidad de CompuestoFarmaco contiene información específica sobre los fármacos que contiene y sus proporciones de cantidad de estos

**Profesional**(Matricula Nac, MatriculaProv, Nombre, Apellido, ...)
>	La entidad "Profesional" registra los datos personales y de contacto de los profesionales de la salud, incluyendo su nombre, apellido, matrícula nacional y provincial.

#### Relaciones  
**TratamientoMadre** ( CUILMadre, CUILHijo) [FK: Persona, Persona] <br>
**ConsultaA** ( CUIL, MatriculaNac) [FK: Persona, Profesional]  <br>
**Experimenta** (CUIL,CodigoEf)  [FK: Persona, EfectoAdverso] <br>
**EsRequeridoPor** (CodigoAnt, CodigoTrat, CUIL) [FK: Antecedente, Tratamiento, Persona] <br>
**EsCausadoPor** (CodigoEf, CodigoTrat) [FK: EfectoAdverso, Tratamiento] <br>
**Indica** (MatriculaNac, CodigoTrat) [FK: Profesional, Tratamiento] <br>
**Utiliza** (CodigoComp, CodigoTrat) [FK: CompuestoFarmaco, Tratamiento] <br>

### Lista de claves foráneas
Antecedente.CUIL -> Persona.CUIL <br>
Diagnostico.CodigoTrat -> Tratamiento.Codigo <br>
GravedadEfecto.CodigoEfecto -> EfectoAdverso.Codigo <br>
Modo.CodigoTrat -> Tratamiento.Codigo <br>
TratamientoDiag.Codigo -> Tratamiento.Codigo <br>
TratamientoFar.Codigo -> Tratamiento.Codigo <br>
TratamientoQui.Codigo -> Tratamiento.Codigo <br>
Composicion.CodigoTrat -> Tratamiento.Codigo <br>
Composicion.CodigoComp -> CompuestoFarmaco.Codigo <br>
TratamientoMadre.CUILMadre + CUILHijo -> Persona.CUIL + CUIL <br>
ConsultaA.CUIL -> Persona.CUIL <br>
ConsultaA.MatriculaNac -> Profesional.MatriculaNac <br>
Experimenta.CUIL -> Persona.CUIL <br>
Experimenta.CodigoEf -> EfectoAdverso.Codigo <br>
EsRequeridoPor.CodigoAnt -> Antecedente.Codigo <br>
EsRequeridoPor.CodigoTrat -> Tratamiento.Codigo <br>
EsRequeridoPor. CUIL -> Persona.CUIL <br>
EsCausadoPor.CodigoEf -> EfectoAdverso.Codigo <br>
EsCausadoPor.CodigoTrat -> Tratamiento.Codigo <br> 
Indica.MatriculaNac -> Profesional.MatriculaNac <br> 
Indica.CodigoTrat -> Tratamiento.Codigo <br>
Utiliza.CodigoComp -> CompuestoFarmaco.Codigo <br>
Utiliza.CodigoTrat -> Tratamiento.Codigo <br>

----------------------------------------------------------------------------------------------------------------------------------------

## Consultas formuladas en SQL:

**1.** Top 10 de tratamientos con más de 10 efectos adversos.
```sql
SELECT T.Codigo, T.FechaOcurrencia, COUNT(E.Codigo) AS NumeroEfectos
FROM Tratamiento T
JOIN EsCausadoPor EC ON T.Codigo = EC.CodigoTrat
JOIN EfectoAdverso E ON EC.CodigoEf = E.Codigo
GROUP BY T.Codigo, T.FechaOcurrencia
HAVING COUNT(E.Codigo) > 10
ORDER BY NumeroEfectos DESC
LIMIT 10;
```
**2.** Cantidad de personas con algún tratamiento diagnóstico que no haya confirmado el diagnóstico.
```sql
SELECT COUNT(DISTINCT P.CUIL) AS CantidadPersonas
FROM Persona P
JOIN TratamientoDiag TD ON P.CUIL = TD.Codigo
WHERE TD.Confirmacion LIKE 'No confirmado';
```

**3.** ¿Cuántas personas ha habido que hayan tenido la mayor cantidad de efectos adversos de algún tratamiento de vacunación?
```sql
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
```

**4.** ¿Cuántas muertes ocurrieron relacionadas con vacunas, agrupando por vacuna, durante los años 2021 al 2023?
```sql
SELECT CF.Vacuna, COUNT(E.Codigo) AS CantidadMuertes
FROM EfectoAdverso E
JOIN GravedadEfecto GE ON E.Codigo = GE.CodigoEfecto
JOIN CompuestoFarmaco CF ON E.Codigo = CF.Codigo
WHERE GE.Descripcion = 'Letal' AND CF.Vacuna IS NOT NULL AND YEAR(E.FechaOcurrencia) BETWEEN 2021 AND 2023
GROUP BY CF.Vacuna;
```

**5.**¿Cuántas muertes de recién nacidos se pueden relacionar a medicamentos administrados a la madre? Si el modelo realizado no permite contestar esta pregunta, modificarlo para poder hacerlo.
```sql
SELECT COUNT(*) AS TotalMuertesRecienNacidos
FROM Tratamiento T
JOIN TratamientoMadre TM ON T.CUIL = TM.CUILMadre
JOIN Persona P ON TM.CUILMadre = P.CUIL
JOIN EfectoAdverso EA ON T.Codigo = EA.Codigo
WHERE EA.Nombre = 'Muerte' AND P.Genero = 'Femenino' AND P.FechaNacimiento >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
```

**6.** Formulen una consulta que permita a un profesional médico descartar un tratamiento en niños por ser el riesgo mayor al beneficio. ¿Qué otra información guardarían para realizar esta comparación? Incluirla en el modelo completo.
```sql
SELECT T.Codigo, T.FechaOcurrencia, T.Riesgo, T.Beneficio
FROM Tratamiento T
WHERE T.EdadMinima <= 18 AND T.Riesgo > T.Beneficio;
```

**7.** Mostrar todos los tratamientos de bajo riesgo practicados a personas con al menos 2 (dos) patologías preexistentes y que sean adultos mayores.
```sql
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
```

**8.** Formular una consulta que Uds. Le harían a la app para saber si realizarse un tratamiento.
```sql
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
```

**9.** Destacar aquellos tratamientos letales, por causar efectos severos, por rango etario, considerando 0 años, 1-5 años, 6-12 años, 13-17 años, 18 a 25 años, 26-40 años, 41-50 años, 51-70 años, 71-90 años, 91 o más años.
```sql
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
```

----------------------------------------------------------------------------------------------------------------------------------------

> En el archivo "Cada_Persona_Importa_Script.sql" se encuentra en detalle la creación de todas las tablas y los inserts en formato SQL. 

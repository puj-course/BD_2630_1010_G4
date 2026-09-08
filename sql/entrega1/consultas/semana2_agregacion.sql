--Consulta 1
SELECT * 
FROM (
    SELECT s.pais, SUM(pa.goles_marcados) as GOLES_TOTALES
    FROM seleccion s
    JOIN participacion_partido pa
    ON s.id_seleccion = pa.id_seleccion
    GROUP BY s.pais, s.id_seleccion --Evita que dos selecciones con mismo nombre mezclaran suma de goles totales
    --Entonces es mejor filtrar por id tambien y no solo por nombre
    ORDER BY SUM(pa.goles_marcados) DESC)
WHERE ROWNUM <= 5;

--Consulta 3
SELECT s.pais, SUM(pa.goles_marcados) AS GOLES_FAVOR,
SUM(ap.goles_marcados) AS GOLES_CONTRA, 
SUM(pa.goles_marcados) - SUM(ap.goles_marcados) 
    AS DIFERENCIA_GOL
FROM seleccion s
JOIN participacion_partido pa
    ON s.id_seleccion = pa.id_seleccion
JOIN participacion_partido ap 
    ON pa.id_partido = ap.id_partido
AND pa.id_seleccion <> ap.id_seleccion --Que no sean las mismas, para que se haga la comparación 
GROUP BY
    s.id_seleccion,
    s.pais
ORDER BY
    DIFERENCIA_GOL DESC;

--Consulta 4
SELECT p.fase, COUNT(p.id_partido) as NUM_PARTIDOS
FROM partido p
GROUP BY p.fase; 

--Consulta 5
SELECT p.id_edicion, e.nombre AS ESTADIO, COUNT(p.id_partido)as N_PARTIDOS
FROM estadio e
JOIN partido p
ON e.id_estadio = p.id_estadio
GROUP BY 
    p.id_edicion,
    p.id_estadio,
    e.nombre
HAVING COUNT(p.id_partido) = (
    SELECT MAX(COUNT(p2.id_partido)) --La mayor cantidad de partidos
    FROM partido p2
    WHERE p2.id_edicion = p.id_edicion --Donde sea la misma edicion 
    GROUP BY p2.id_estadio) --Por cada estadio
ORDER BY p.id_edicion,
         N_PARTIDOS DESC;


--Consulta 9
SELECT 
    e.nombre AS ESTADIO, 
    p.id_partido, 
    p.fase, 
    SUM(pa.goles_marcados) AS GOLES_TOTALES
FROM estadio e
JOIN partido p 
    ON e.id_estadio = p.id_estadio
JOIN participacion_partido pa 
    ON p.id_partido = pa.id_partido
GROUP BY 
    e.id_estadio, 
    e.nombre, 
    p.id_partido, 
    p.fase
HAVING (e.id_estadio, SUM(pa.goles_marcados)) IN (
    --Encuentra el marcador más alto (MAX) para cada estadio
    SELECT id_estadio, MAX(goles_por_partido)
    FROM (
        --Sumar los goles de cada partido y saber en qué estadio se jugó
        SELECT p2.id_estadio, p2.id_partido, SUM(pa2.goles_marcados) AS goles_por_partido
        FROM partido p2
        JOIN participacion_partido pa2 
            ON p2.id_partido = pa2.id_partido
        GROUP BY p2.id_estadio, p2.id_partido
    )
    GROUP BY id_estadio --Agrupar por estadio para extraer solo el número más alto
);


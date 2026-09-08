--Consulta 2
SELECT e.nombre as ESTADIO, e.ciudad, e.capacidad, 
COUNT(p.id_partido) AS PARTIDOS_JUGADOS, 
ROUND(
    (SUM(p.asistencia_registrada) /
    (COUNT(p.id_partido)*e.capacidad)) *100,2) AS OCUPACION_PCT
FROM estadio e
JOIN partido p
    ON e.id_estadio = p.id_estadio
GROUP BY 
    e.id_estadio,
    e.nombre,
    e.ciudad,
    e.capacidad
ORDER BY OCUPACION_PCT DESC;

--Consulta 6
SELECT pa.id_partido, p.id_edicion, p.fase, SUM(pa.goles_marcados) as GOLES_TOTALES, CASE
    WHEN SUM(pa.goles_marcados) = 0 THEN 'SIN GOLES'
    WHEN SUM(pa.goles_marcados) >= 6 THEN 'MARCADOR ALTO'
END AS PATRON
FROM partido p
JOIN participacion_partido pa
    ON p.id_partido = pa.id_partido
GROUP BY 
    pa.id_partido,
    p.id_edicion,
    p.fase
HAVING 
    SUM(pa.goles_marcados) = 0
    OR SUM(pa.goles_marcados) >= 7
ORDER BY 
    GOLES_TOTALES
DESC;

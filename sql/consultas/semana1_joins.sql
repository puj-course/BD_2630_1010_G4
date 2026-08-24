-- Consulta 2: Calcular el porcentaje de ocupación estimado de cada estadio.
SELECT 
    e.nombre AS estadio,
    e.capacidad,
    SUM(p.asistencia_registrada) AS asistencia_total,
    ROUND((SUM(p.asistencia_registrada) / e.capacidad) * 100, 2) AS porcentaje_ocupacion
FROM ESTADIO e
JOIN PARTIDO p
    ON e.id_estadio = p.id_estadio
GROUP BY 
    e.id_estadio,
    e.nombre,
    e.capacidad
ORDER BY porcentaje_ocupacion DESC;


-- Consulta 6: Identificar partidos con marcadores atípicos y partidos sin goles (0-0).
SELECT 
    p.id_partido,
    p.fecha_hora,
    p.fase,
    e.nombre AS estadio,
    SUM(pp.goles_marcados) AS goles_totales,
    CASE
        WHEN SUM(pp.goles_marcados) = 0 THEN 'Partido sin goles (0-0)'
        WHEN SUM(pp.goles_marcados) >= 7 THEN 'Marcador inusualmente alto'
    END AS patron_atipico
FROM PARTIDO p
JOIN ESTADIO e
    ON p.id_estadio = e.id_estadio
JOIN PARTICIPACION_PARTIDO pp
    ON p.id_partido = pp.id_partido
GROUP BY 
    p.id_partido,
    p.fecha_hora,
    p.fase,
    e.nombre
HAVING 
    SUM(pp.goles_marcados) = 0
    OR SUM(pp.goles_marcados) >= 7
ORDER BY goles_totales DESC;
-- Consulta 2: Calcular el porcentaje de ocupación estimado de cada estadio.
SELECT
    e.nombre AS estadio,
    e.ciudad,
    e.capacidad,
    COUNT(p.id_partido) AS partidos_jugados,
    ROUND(
        (SUM(p.asistencia_registrada) /
        (COUNT(p.id_partido) * e.capacidad)) * 100,
        2
    ) AS ocupacion_pct
FROM ESTADIO e
JOIN PARTIDO p
    ON e.id_estadio = p.id_estadio
GROUP BY
    e.id_estadio,
    e.nombre,
    e.ciudad,
    e.capacidad
ORDER BY ocupacion_pct DESC;


-- Consulta 6: Identificar partidos con marcadores atípicos y partidos sin goles (0-0).
SELECT
    p.id_partido,
    p.id_edicion,
    p.fase,
    SUM(pp.goles_marcados) AS goles_totales,
    CASE
        WHEN SUM(pp.goles_marcados) = 0 THEN 'SIN GOLES'
        WHEN SUM(pp.goles_marcados) >= 7 THEN 'MARCADOR ALTO'
    END AS patron
FROM PARTIDO p
JOIN PARTICIPACION_PARTIDO pp
    ON p.id_partido = pp.id_partido
GROUP BY
    p.id_partido,
    p.id_edicion,
    p.fase
HAVING
    SUM(pp.goles_marcados) = 0
    OR SUM(pp.goles_marcados) >= 7
ORDER BY
    goles_totales DESC;

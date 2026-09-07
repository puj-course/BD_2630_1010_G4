--Cosulta 7: Mostrar las selecciones que no han perdido ningún partido.
SELECT s.pais
FROM SELECCION s
WHERE NOT EXISTS (
    SELECT 1
    FROM PARTICIPACION_PARTIDO pp
    JOIN PARTICIPACION_PARTIDO rival
        ON pp.id_partido = rival.id_partido
        AND pp.id_seleccion <> rival.id_seleccion
    WHERE pp.id_seleccion = s.id_seleccion
      AND pp.goles_marcados < rival.goles_marcados
);

--Consulta 8: Mostrar los estadios cuya ocupación está por encima del promedio general.
SELECT
    e.nombre AS estadio,
    e.ciudad,
    ROUND(
        (SUM(p.asistencia_registrada) /
        (COUNT(p.id_partido) * e.capacidad)) * 100,
        2
    ) AS ocupacion_pct
FROM ESTADIO e
JOIN PARTIDO p
    ON e.id_estadio = p.id_estadio
GROUP BY e.id_estadio, e.nombre, e.ciudad, e.capacidad
HAVING
    (SUM(p.asistencia_registrada) /
    (COUNT(p.id_partido) * e.capacidad)) * 100
    >
    (
        SELECT AVG(ocupacion)
        FROM (
            SELECT
                (SUM(p2.asistencia_registrada) /
                (COUNT(p2.id_partido) * e2.capacidad)) * 100 AS ocupacion
            FROM ESTADIO e2
            JOIN PARTIDO p2
                ON e2.id_estadio = p2.id_estadio
            GROUP BY e2.id_estadio, e2.capacidad
        )
    )
ORDER BY ocupacion_pct DESC;

-- Consulta 10: Mostrar las selecciones que jugaron todos sus partidos como local
-- o que no jugaron ningún partido como local.
SELECT
    s.pais,
    SUM(CASE WHEN pp.condicion = 'LOCAL' THEN 1 ELSE 0 END) AS partidos_local,
    SUM(CASE WHEN pp.condicion = 'VISITANTE' THEN 1 ELSE 0 END) AS partidos_visitante,
    COUNT(pp.id_partido) AS total_partidos
FROM SELECCION s
JOIN PARTICIPACION_PARTIDO pp
    ON s.id_seleccion = pp.id_seleccion
GROUP BY s.id_seleccion, s.pais
HAVING
    SUM(CASE WHEN pp.condicion = 'LOCAL' THEN 1 ELSE 0 END) = 0
    OR
    SUM(CASE WHEN pp.condicion = 'LOCAL' THEN 1 ELSE 0 END) = COUNT(pp.id_partido)
ORDER BY s.pais;

-- Consulta 11: Mostrar las selecciones cuya diferencia de gol está
-- estrictamente por encima del promedio general.
SELECT
    pais,
    diferencia_gol,
    RANK() OVER (ORDER BY diferencia_gol DESC) AS ranking
FROM (
    SELECT
        s.id_seleccion,
        s.pais,
        SUM(pp.goles_marcados) - SUM(rival.goles_marcados) AS diferencia_gol
    FROM SELECCION s
    JOIN PARTICIPACION_PARTIDO pp
        ON s.id_seleccion = pp.id_seleccion
    JOIN PARTICIPACION_PARTIDO rival
        ON pp.id_partido = rival.id_partido
        AND pp.id_seleccion <> rival.id_seleccion
    GROUP BY s.id_seleccion, s.pais
)
WHERE diferencia_gol > (
    SELECT AVG(diferencia_gol)
    FROM (
        SELECT
            s2.id_seleccion,
            SUM(pp2.goles_marcados) - SUM(rival2.goles_marcados) AS diferencia_gol
        FROM SELECCION s2
        JOIN PARTICIPACION_PARTIDO pp2
            ON s2.id_seleccion = pp2.id_seleccion
        JOIN PARTICIPACION_PARTIDO rival2
            ON pp2.id_partido = rival2.id_partido
            AND pp2.id_seleccion <> rival2.id_seleccion
        GROUP BY s2.id_seleccion
    )
)
ORDER BY ranking;
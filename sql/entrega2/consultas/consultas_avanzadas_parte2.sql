/*
    Consutlas avanzadas pt2. (desde la 3ra consulta de la parte 1, hasta la 8va)
*/
-- 4. Ranking de jugadores con más tarjetas por edición

WITH disciplina AS (
    SELECT
        e.id_edicion,
        e.anio,
        j.id_jugador,
        j.nombre AS jugador,
        SUM(est.tarjetas_amarillas) AS tarjetas_amarillas,
        SUM(est.tarjetas_rojas) AS tarjetas_rojas,
        SUM(est.tarjetas_amarillas + est.tarjetas_rojas) AS total_tarjetas
    FROM estadistica_jugador_partido est
    JOIN jugador j
        ON j.id_jugador = est.id_jugador
    JOIN partido p
        ON p.id_partido = est.id_partido
    JOIN edicion_mundial e
        ON e.id_edicion = p.id_edicion
    GROUP BY
        e.id_edicion,
        e.anio,
        j.id_jugador,
        j.nombre
),
ranking AS (
    SELECT
        disciplina.*,
        DENSE_RANK() OVER (
            PARTITION BY id_edicion
            ORDER BY total_tarjetas DESC
        ) AS posicion
    FROM disciplina
)
SELECT
    anio,
    posicion,
    jugador,
    tarjetas_amarillas,
    tarjetas_rojas,
    total_tarjetas
FROM ranking
WHERE posicion <= 5
ORDER BY anio, posicion, jugador;

-- 5. Carga de trabajo de los árbitros por edición

SELECT
    e.anio,
    a.id_arbitro,
    a.nombre AS arbitro,
    COUNT(DISTINCT p.id_partido) AS partidos_asignados,
    SUM(
        CASE
            WHEN aa.rol = 'CENTRAL' THEN 1
            ELSE 0
        END
    ) AS asignaciones_central,
    SUM(
        CASE
            WHEN aa.rol = 'VAR' THEN 1
            ELSE 0
        END
    ) AS asignaciones_var
FROM asignacion_arbitral aa
JOIN arbitro a
    ON a.id_arbitro = aa.id_arbitro
JOIN partido p
    ON p.id_partido = aa.id_partido
JOIN edicion_mundial e
    ON e.id_edicion = p.id_edicion
GROUP BY
    e.anio,
    a.id_arbitro,
    a.nombre
HAVING COUNT(DISTINCT p.id_partido) >= 2
ORDER BY
    e.anio,
    partidos_asignados DESC;

-- 6. Cantidad de convocados y capitanes por seleccion

SELECT
    e.anio,
    s.pais AS seleccion,
    COUNT(cj.id_jugador) AS jugadores_convocados,
    SUM(
        CASE
            WHEN cj.es_capitan = 'SI' THEN 1
            ELSE 0
        END
    ) AS cantidad_capitanes
FROM seleccion s
JOIN edicion_mundial e
    ON e.id_edicion = s.id_edicion
LEFT JOIN convocatoria_jugador cj
    ON cj.id_seleccion = s.id_seleccion
GROUP BY
    e.anio,
    s.id_seleccion,
    s.pais
HAVING COUNT(cj.id_jugador) > 0
ORDER BY
    e.anio,
    jugadores_convocados DESC,
    s.pais;

-- 7. Analisis de incidencias por tipo y edicion

SELECT
    e.anio,
    i.tipo,
    COUNT(i.id_incidencia) AS cantidad_incidencias,
    ROUND(AVG(i.minuto), 2) AS minuto_promedio,
    MIN(i.minuto) AS primer_minuto,
    MAX(i.minuto) AS ultimo_minuto
FROM incidencia i
JOIN partido p
    ON p.id_partido = i.id_partido
JOIN edicion_mundial e
    ON e.id_edicion = p.id_edicion
GROUP BY
    e.anio,
    i.tipo
HAVING COUNT(i.id_incidencia) >= 2
ORDER BY
    e.anio,
    cantidad_incidencias DESC;

-- 8. Partidos con muchos goles o grandes diferencias

WITH marcador AS (
    SELECT
        p.id_partido,
        e.anio,
        f.nombre AS fase,
        MAX(
            CASE
                WHEN pp.condicion = 'LOCAL'
                THEN s.pais
            END
        ) AS seleccion_local,
        MAX(
            CASE
                WHEN pp.condicion = 'LOCAL'
                THEN pp.goles_marcados
            END
        ) AS goles_local,
        MAX(
            CASE
                WHEN pp.condicion = 'VISITANTE'
                THEN s.pais
            END
        ) AS seleccion_visitante,
        MAX(
            CASE
                WHEN pp.condicion = 'VISITANTE'
                THEN pp.goles_marcados
            END
        ) AS goles_visitante
    FROM partido p
    JOIN edicion_mundial e
        ON e.id_edicion = p.id_edicion
    JOIN fase f
        ON f.id_fase = p.id_fase
    JOIN participacion_partido pp
        ON pp.id_partido = p.id_partido
    JOIN seleccion s
        ON s.id_seleccion = pp.id_seleccion
    GROUP BY
        p.id_partido,
        e.anio,
        f.nombre
)
SELECT
    anio,
    id_partido,
    fase,
    seleccion_local,
    goles_local,
    seleccion_visitante,
    goles_visitante,
    goles_local + goles_visitante AS goles_totales,
    ABS(goles_local - goles_visitante) AS diferencia_goles
FROM marcador
WHERE goles_local IS NOT NULL
  AND goles_visitante IS NOT NULL
  AND (
      goles_local + goles_visitante >= 5
      OR ABS(goles_local - goles_visitante) >= 3
  )
ORDER BY
    anio,
    goles_totales DESC,
    diferencia_goles DESC;

-- Consulta 1: Mostrar las 5 selecciones con más goles marcados en la edición modelada.

SELECT
    s.pais,
    SUM(pp.goles_marcados) AS goles_totales
FROM SELECCION s
JOIN PARTICIPACION_PARTIDO pp
    ON s.id_seleccion = pp.id_seleccion
JOIN PARTIDO p
    ON pp.id_partido = p.id_partido
GROUP BY
    s.id_seleccion,
    s.pais
ORDER BY
    goles_totales DESC;
	
	
-- Consulta 3: Mostrar las selecciones con su diferencia de gol a lo largo de sus partidos.

SELECT
    s.pais,
    SUM(pp.goles_marcados) AS goles_favor,
    SUM(op.goles_marcados) AS goles_contra,
    SUM(pp.goles_marcados) - SUM(op.goles_marcados) AS diferencia_gol
FROM SELECCION s
JOIN PARTICIPACION_PARTIDO pp
    ON s.id_seleccion = pp.id_seleccion
JOIN PARTICIPACION_PARTIDO op
    ON pp.id_partido = op.id_partido
    AND pp.id_seleccion <> op.id_seleccion
GROUP BY
    s.id_seleccion,
    s.pais
ORDER BY
    diferencia_gol DESC;
	
-- Consulta 4: Contar la cantidad de partidos jugados en cada fase del torneo.

SELECT
    fase,
    COUNT(id_partido) AS num_partidos
FROM PARTIDO
GROUP BY
    fase
ORDER BY
    num_partidos DESC;
	
-- Consulta 5: Indicar, para cada edición, el o los estadios que albergaron la mayor cantidad de partidos.

SELECT
    p.id_edicion,
    e.nombre AS estadio,
    COUNT(p.id_partido) AS n_partidos
FROM PARTIDO p
JOIN ESTADIO e
    ON p.id_estadio = e.id_estadio
GROUP BY
    p.id_edicion,
    e.id_estadio,
    e.nombre
HAVING COUNT(p.id_partido) = (
    SELECT MAX(COUNT(p2.id_partido))
    FROM PARTIDO p2
    WHERE p2.id_edicion = p.id_edicion
    GROUP BY p2.id_estadio
)
ORDER BY
    p.id_edicion,
    n_partidos DESC;
	
-- Consulta 9: Mostrar, para cada estadio, el partido con el mayor marcador combinado jugado en él.

SELECT
    e.nombre AS estadio,
    p.id_partido,
    p.fase,
    SUM(pp.goles_marcados) AS goles_totales
FROM ESTADIO e
JOIN PARTIDO p
    ON e.id_estadio = p.id_estadio
JOIN PARTICIPACION_PARTIDO pp
    ON p.id_partido = pp.id_partido
GROUP BY
    e.id_estadio,
    e.nombre,
    p.id_partido,
    p.fase
HAVING SUM(pp.goles_marcados) = (
    SELECT MAX(SUM(pp2.goles_marcados))
    FROM PARTIDO p2
    JOIN PARTICIPACION_PARTIDO pp2
        ON p2.id_partido = pp2.id_partido
    WHERE p2.id_estadio = p.id_estadio
    GROUP BY p2.id_partido
)
ORDER BY
    e.nombre;
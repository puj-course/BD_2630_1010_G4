/*
    Consutlas avanzadas pt2.
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
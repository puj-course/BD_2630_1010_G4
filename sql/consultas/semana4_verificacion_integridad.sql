-- Consulta 14: Identificar participaciones duplicadas de una selección en un mismo partido.

SELECT
    id_partido,
    id_seleccion,
    COUNT(*) AS cantidad_participaciones
FROM PARTICIPACION_PARTIDO
GROUP BY
    id_partido,
    id_seleccion
HAVING COUNT(*) > 1;
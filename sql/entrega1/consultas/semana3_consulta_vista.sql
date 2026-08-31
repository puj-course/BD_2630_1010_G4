-- consulta 15: determinar que seleccion lidera cada grupo simulado
-- se utiliza la vista v_goles_selecion creada previamente

SELECT
    s.grupo,
    v.pais,
    v.total_goles
FROM v_goles_selecion v
JOIN SELECCION s
    ON v.pais = s.pais
WHERE v.total_goles = (
    SELECT MAX(v2.total_goles)
    FROM v_goles_selecion v2
    JOIN SELECCION s2
        ON v2.pais = s2.pais
    WHERE s2.grupo = s.grupo
)
ORDER BY
    s.grupo;

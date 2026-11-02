-- 1. Calcular la diferencia de goles total de una selección

CREATE OR REPLACE FUNCTION fn_diferencia_gol_seleccion(p_id_seleccion IN NUMBER) 
RETURN NUMBER IS
    v_goles_favor NUMBER := 0;
    v_goles_contra NUMBER := 0;
    v_dif_total NUMBER := 0;
BEGIN
    -- Sumar goles a favor de la selección en todas sus participaciones
    SELECT NVL(SUM(goles_marcados), 0)
    INTO v_goles_favor
    FROM participacion_partido
    WHERE id_seleccion = p_id_seleccion;

    -- Sumar goles en contra (los goles marcados por los rivales en los mismos partidos)
    SELECT NVL(SUM(rival.goles_marcados), 0)
    INTO v_goles_contra
    FROM participacion_partido pp
    JOIN participacion_partido rival 
      ON rival.id_partido = pp.id_partido 
     AND rival.id_seleccion <> pp.id_seleccion
    WHERE pp.id_seleccion = p_id_seleccion;

    v_dif_total := v_goles_favor - v_goles_contra;
    
    RETURN v_dif_total;
EXCEPTION
    WHEN OTHERS THEN
        
        RETURN 0;
END fn_diferencia_gol_seleccion;
/


-- 2. Validar cupo de convocatoria
-- Retorna SI si la selección aún tiene cupo disponible, o NO si ya llenó 
-- el límite máximo 

CREATE OR REPLACE FUNCTION fn_validar_cupo_convocatoria(
    p_id_seleccion IN NUMBER, 
    p_limite_maximo IN NUMBER DEFAULT 26
) RETURN VARCHAR2 IS
    v_total_convocados NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_total_convocados
    FROM convocatoria_jugador
    WHERE id_seleccion = p_id_seleccion;

    IF v_total_convocados < p_limite_maximo THEN
        RETURN 'SI'; -- Aún hay cupo
    ELSE
        RETURN 'NO'; -- Cupo lleno o excedido
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'NO';
END fn_validar_cupo_convocatoria;
/


-- 3. Función para validar dorsal único en selección
-- Retorna VALIDO si el dorsal no está repetido en esa selección, 
-- u OCUPADO si ya pertenece a otro jugador.

CREATE OR REPLACE FUNCTION fn_verificar_dorsal_disponible(
    p_id_seleccion IN NUMBER,
    p_dorsal IN NUMBER,
    p_id_jugador IN NUMBER DEFAULT NULL
) RETURN VARCHAR2 IS
    v_existe NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_existe
    FROM convocatoria_jugador
    WHERE id_seleccion = p_id_seleccion
      AND dorsal = p_dorsal
      -- Por si se trata de una actualización del mismo jugador
      AND (p_id_jugador IS NULL OR id_jugador <> p_id_jugador);

    IF v_existe = 0 THEN
        RETURN 'VALIDO';
    ELSE
        RETURN 'OCUPADO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'OCUPADO';
END fn_verificar_dorsal_disponible;
/
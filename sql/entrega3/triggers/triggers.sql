
-- ============================================================
-- ENTREGA 3 - SEMANA 1
-- TRIGGERS OBLIGATORIOS
-- BASE DE DATOS MUNDIAL FIFA
-- ORACLE 19C
-- ============================================================


-- ============================================================
-- 1. TRIGGER DE AUDITORIA
-- Registra inserciones, modificaciones y eliminaciones
-- en las tablas PARTIDO y ESTADISTICA_JUGADOR_PARTIDO.
-- ============================================================

CREATE TABLE auditoria_bd (
    id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tabla_afectada VARCHAR2(50) NOT NULL,
    operacion VARCHAR2(20) NOT NULL,
    id_registro NUMBER NOT NULL,
    usuario_bd VARCHAR2(100),
    fecha_operacion TIMESTAMP DEFAULT SYSTIMESTAMP,
    detalle VARCHAR2(1000)
);


-- Auditoria de partidos

CREATE OR REPLACE TRIGGER trg_auditoria_partido
AFTER INSERT OR UPDATE OR DELETE ON partido
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO auditoria_bd (
            tabla_afectada, operacion, id_registro,
            usuario_bd, detalle
        ) VALUES (
            'PARTIDO', 'INSERT', :NEW.id_partido,
            USER, 'Se registro un nuevo partido.'
        );

    ELSIF UPDATING THEN
        INSERT INTO auditoria_bd (
            tabla_afectada, operacion, id_registro,
            usuario_bd, detalle
        ) VALUES (
            'PARTIDO', 'UPDATE', :NEW.id_partido,
            USER, 'Se modifico un partido.'
        );

    ELSIF DELETING THEN
        INSERT INTO auditoria_bd (
            tabla_afectada, operacion, id_registro,
            usuario_bd, detalle
        ) VALUES (
            'PARTIDO', 'DELETE', :OLD.id_partido,
            USER, 'Se elimino un partido.'
        );
    END IF;
END;
/


-- Auditoria de estadisticas de jugadores

CREATE OR REPLACE TRIGGER trg_auditoria_estadisticas
AFTER INSERT OR UPDATE OR DELETE ON estadistica_jugador_partido
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO auditoria_bd (
            tabla_afectada, operacion, id_registro,
            usuario_bd, detalle
        ) VALUES (
            'ESTADISTICA_JUGADOR_PARTIDO',
            'INSERT',
            :NEW.id_estadistica,
            USER,
            'Se registro una estadistica de jugador.'
        );

    ELSIF UPDATING THEN
        INSERT INTO auditoria_bd (
            tabla_afectada, operacion, id_registro,
            usuario_bd, detalle
        ) VALUES (
            'ESTADISTICA_JUGADOR_PARTIDO',
            'UPDATE',
            :NEW.id_estadistica,
            USER,
            'Se modifico una estadistica de jugador.'
        );

    ELSIF DELETING THEN
        INSERT INTO auditoria_bd (
            tabla_afectada, operacion, id_registro,
            usuario_bd, detalle
        ) VALUES (
            'ESTADISTICA_JUGADOR_PARTIDO',
            'DELETE',
            :OLD.id_estadistica,
            USER,
            'Se elimino una estadistica de jugador.'
        );
    END IF;
END;
/


-- ============================================================
-- 2. TRIGGER DE VALIDACION DE RANGOS
-- Impide registrar goles o asistencias negativas.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_validacion_rangos
BEFORE INSERT OR UPDATE ON estadistica_jugador_partido
FOR EACH ROW
BEGIN
    IF :NEW.goles < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Error: los goles no pueden ser negativos.'
        );
    END IF;

    IF :NEW.asistencias < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Error: las asistencias no pueden ser negativas.'
        );
    END IF;
END;
/


-- ============================================================
-- 3. TRIGGER ANTI-DUPLICIDAD
-- Evita que una seleccion aparezca mas de una vez
-- en el mismo partido.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_anti_duplicidad
FOR INSERT OR UPDATE ON participacion_partido
COMPOUND TRIGGER

    TYPE t_partidos IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    TYPE t_selecciones IS TABLE OF NUMBER INDEX BY PLS_INTEGER;

    v_partidos t_partidos;
    v_selecciones t_selecciones;
    v_contador PLS_INTEGER := 0;
    v_cantidad NUMBER;

    AFTER EACH ROW IS
    BEGIN
        v_contador := v_contador + 1;
        v_partidos(v_contador) := :NEW.id_partido;
        v_selecciones(v_contador) := :NEW.id_seleccion;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..v_contador LOOP
            SELECT COUNT(*)
            INTO v_cantidad
            FROM participacion_partido
            WHERE id_partido = v_partidos(i)
              AND id_seleccion = v_selecciones(i);

            IF v_cantidad > 1 THEN
                RAISE_APPLICATION_ERROR(
                    -20003,
                    'Error: una seleccion no puede participar dos veces en el mismo partido.'
                );
            END IF;
        END LOOP;
    END AFTER STATEMENT;

END trg_anti_duplicidad;
/


-- ============================================================
-- 4. TRIGGER DE CONSISTENCIA
-- Verifica que la suma de goles individuales de una seleccion
-- no supere los goles registrados en el marcador oficial.
--
-- Se permite una suma menor porque las estadisticas pueden
-- cargarse progresivamente.
-- ============================================================

CREATE OR REPLACE TRIGGER trg_consistencia_goles
FOR INSERT OR UPDATE OR DELETE ON estadistica_jugador_partido
COMPOUND TRIGGER

    TYPE t_partidos IS TABLE OF NUMBER INDEX BY PLS_INTEGER;

    v_partidos t_partidos;
    v_contador PLS_INTEGER := 0;
    v_excesos NUMBER;

    AFTER EACH ROW IS
    BEGIN
        IF INSERTING OR UPDATING THEN
            v_contador := v_contador + 1;
            v_partidos(v_contador) := :NEW.id_partido;
        END IF;

        IF DELETING OR UPDATING THEN
            v_contador := v_contador + 1;
            v_partidos(v_contador) := :OLD.id_partido;
        END IF;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..v_contador LOOP

            SELECT COUNT(*)
            INTO v_excesos
            FROM participacion_partido pp
            WHERE pp.id_partido = v_partidos(i)
              AND NVL((
                  SELECT SUM(est.goles)
                  FROM estadistica_jugador_partido est
                  JOIN convocatoria_jugador cj
                    ON cj.id_jugador = est.id_jugador
                  WHERE est.id_partido = pp.id_partido
                    AND cj.id_seleccion = pp.id_seleccion
              ), 0) > pp.goles_marcados;

            IF v_excesos > 0 THEN
                RAISE_APPLICATION_ERROR(
                    -20004,
                    'Error: los goles individuales superan el marcador oficial.'
                );
            END IF;

        END LOOP;
    END AFTER STATEMENT;

END trg_consistencia_goles;
/

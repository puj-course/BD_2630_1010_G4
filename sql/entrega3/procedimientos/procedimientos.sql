
-- ============================================================
-- ENTREGA 3 - PROCEDIMIENTOS ALMACENADOS
-- Proyecto Base de Datos FIFA
-- ============================================================


-- ============================================================
-- TABLAS AUXILIARES
-- ============================================================

-- Guarda la tabla de posiciones calculada por grupo.

CREATE TABLE tabla_posiciones (
    id_edicion          NUMBER(10) NOT NULL,
    id_grupo            NUMBER(10) NOT NULL,
    id_seleccion        NUMBER(10) NOT NULL,
    partidos_jugados    NUMBER(3) DEFAULT 0 NOT NULL,
    partidos_ganados    NUMBER(3) DEFAULT 0 NOT NULL,
    partidos_empatados  NUMBER(3) DEFAULT 0 NOT NULL,
    partidos_perdidos   NUMBER(3) DEFAULT 0 NOT NULL,
    goles_favor         NUMBER(4) DEFAULT 0 NOT NULL,
    goles_contra        NUMBER(4) DEFAULT 0 NOT NULL,
    diferencia_gol      NUMBER(4) DEFAULT 0 NOT NULL,
    puntos              NUMBER(4) DEFAULT 0 NOT NULL,

    CONSTRAINT pk_tabla_posiciones
        PRIMARY KEY (id_edicion, id_grupo, id_seleccion),

    CONSTRAINT fk_posiciones_edicion
        FOREIGN KEY (id_edicion)
        REFERENCES edicion_mundial(id_edicion),

    CONSTRAINT fk_posiciones_grupo
        FOREIGN KEY (id_grupo)
        REFERENCES grupo(id_grupo),

    CONSTRAINT fk_posiciones_seleccion
        FOREIGN KEY (id_seleccion)
        REFERENCES seleccion(id_seleccion)
);


-- Guarda las selecciones que avanzan de una fase a otra.

CREATE TABLE avance_fase (
    id_fase_origen      NUMBER(10) NOT NULL,
    id_fase_destino     NUMBER(10) NOT NULL,
    id_seleccion        NUMBER(10) NOT NULL,
    id_grupo            NUMBER(10) NOT NULL,
    puesto_grupo        NUMBER(3) NOT NULL,

    CONSTRAINT pk_avance_fase
        PRIMARY KEY (id_fase_origen, id_seleccion),

    CONSTRAINT fk_avance_fase_origen
        FOREIGN KEY (id_fase_origen)
        REFERENCES fase(id_fase),

    CONSTRAINT fk_avance_fase_destino
        FOREIGN KEY (id_fase_destino)
        REFERENCES fase(id_fase),

    CONSTRAINT fk_avance_seleccion
        FOREIGN KEY (id_seleccion)
        REFERENCES seleccion(id_seleccion),

    CONSTRAINT fk_avance_grupo
        FOREIGN KEY (id_grupo)
        REFERENCES grupo(id_grupo)
);


-- ============================================================
-- PROCEDIMIENTO 1:
-- CARGA MASIVA CONTROLADA DE RESULTADOS
-- ============================================================

CREATE OR REPLACE PROCEDURE cargar_resultados_masivos (
    p_ids_partidos       IN SYS.ODCINUMBERLIST,
    p_goles_locales      IN SYS.ODCINUMBERLIST,
    p_goles_visitantes   IN SYS.ODCINUMBERLIST
)
AS
    v_cantidad_locales       NUMBER;
    v_cantidad_visitantes    NUMBER;
    v_partido_existe         NUMBER;
BEGIN

    -- Validar que las listas hayan sido enviadas.

    IF p_ids_partidos IS NULL
       OR p_goles_locales IS NULL
       OR p_goles_visitantes IS NULL THEN

        RAISE_APPLICATION_ERROR(
            -20001,
            'Las listas de resultados no pueden estar vacias.'
        );

    END IF;


    -- Validar que las tres listas tengan la misma cantidad de datos.

    IF p_ids_partidos.COUNT = 0
       OR p_ids_partidos.COUNT <> p_goles_locales.COUNT
       OR p_ids_partidos.COUNT <> p_goles_visitantes.COUNT THEN

        RAISE_APPLICATION_ERROR(
            -20002,
            'Las listas deben tener la misma cantidad de elementos.'
        );

    END IF;


    -- Recorrer todos los partidos recibidos.

    FOR i IN 1 .. p_ids_partidos.COUNT LOOP

        -- Validar que los goles no sean negativos.

        IF p_goles_locales(i) < 0
           OR p_goles_visitantes(i) < 0 THEN

            RAISE_APPLICATION_ERROR(
                -20003,
                'Los goles no pueden ser negativos.'
            );

        END IF;


        -- Comprobar que el partido exista.

        SELECT COUNT(*)
        INTO v_partido_existe
        FROM partido
        WHERE id_partido = p_ids_partidos(i);

        IF v_partido_existe <> 1 THEN

            RAISE_APPLICATION_ERROR(
                -20004,
                'El partido indicado no existe.'
            );

        END IF;


        -- Comprobar que tenga exactamente una participacion local.

        SELECT COUNT(*)
        INTO v_cantidad_locales
        FROM participacion_partido
        WHERE id_partido = p_ids_partidos(i)
          AND condicion = 'LOCAL';

        -- Comprobar que tenga exactamente una participacion visitante.

        SELECT COUNT(*)
        INTO v_cantidad_visitantes
        FROM participacion_partido
        WHERE id_partido = p_ids_partidos(i)
          AND condicion = 'VISITANTE';


        IF v_cantidad_locales <> 1
           OR v_cantidad_visitantes <> 1 THEN

            RAISE_APPLICATION_ERROR(
                -20005,
                'Cada partido debe tener una seleccion local y una visitante.'
            );

        END IF;


        -- Actualizar los goles de la seleccion local.

        UPDATE participacion_partido
        SET goles_marcados = p_goles_locales(i)
        WHERE id_partido = p_ids_partidos(i)
          AND condicion = 'LOCAL';


        -- Actualizar los goles de la seleccion visitante.

        UPDATE participacion_partido
        SET goles_marcados = p_goles_visitantes(i)
        WHERE id_partido = p_ids_partidos(i)
          AND condicion = 'VISITANTE';

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(
        'Resultados de los partidos registrados correctamente.'
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;

END cargar_resultados_masivos;
/


-- ============================================================
-- PROCEDIMIENTO 2:
-- ACTUALIZACION DE LA TABLA DE POSICIONES POR GRUPO
-- ============================================================

CREATE OR REPLACE PROCEDURE actualizar_posiciones_grupo (
    p_id_edicion IN NUMBER
)
AS
    v_selecciones NUMBER;
BEGIN

    -- Verificar que existan selecciones con grupo asignado.

    SELECT COUNT(*)
    INTO v_selecciones
    FROM seleccion
    WHERE id_edicion = p_id_edicion
      AND id_grupo IS NOT NULL;


    IF v_selecciones = 0 THEN

        RAISE_APPLICATION_ERROR(
            -20010,
            'No existen selecciones con grupo asignado para esta edicion.'
        );

    END IF;


    -- Eliminar las posiciones anteriores de la edicion.

    DELETE FROM tabla_posiciones
    WHERE id_edicion = p_id_edicion;


    -- Calcular las nuevas posiciones a partir de los resultados.

    INSERT INTO tabla_posiciones (
        id_edicion,
        id_grupo,
        id_seleccion,
        partidos_jugados,
        partidos_ganados,
        partidos_empatados,
        partidos_perdidos,
        goles_favor,
        goles_contra,
        diferencia_gol,
        puntos
    )
    SELECT
        datos.id_edicion,
        datos.id_grupo,
        datos.id_seleccion,

        COUNT(*) AS partidos_jugados,

        SUM(
            CASE
                WHEN datos.goles_seleccion > datos.goles_rival
                THEN 1
                ELSE 0
            END
        ) AS partidos_ganados,

        SUM(
            CASE
                WHEN datos.goles_seleccion = datos.goles_rival
                THEN 1
                ELSE 0
            END
        ) AS partidos_empatados,

        SUM(
            CASE
                WHEN datos.goles_seleccion < datos.goles_rival
                THEN 1
                ELSE 0
            END
        ) AS partidos_perdidos,

        SUM(datos.goles_seleccion) AS goles_favor,

        SUM(datos.goles_rival) AS goles_contra,

        SUM(datos.goles_seleccion)
        - SUM(datos.goles_rival) AS diferencia_gol,

        SUM(
            CASE
                WHEN datos.goles_seleccion > datos.goles_rival
                THEN 3
                WHEN datos.goles_seleccion = datos.goles_rival
                THEN 1
                ELSE 0
            END
        ) AS puntos

    FROM (
        SELECT
            s.id_edicion,
            s.id_grupo,
            s.id_seleccion,
            pp.goles_marcados AS goles_seleccion,
            rival.goles_marcados AS goles_rival

        FROM seleccion s

        JOIN participacion_partido pp
            ON pp.id_seleccion = s.id_seleccion

        JOIN partido p
            ON p.id_partido = pp.id_partido

        JOIN participacion_partido rival
            ON rival.id_partido = pp.id_partido
           AND rival.id_seleccion <> pp.id_seleccion

        WHERE s.id_edicion = p_id_edicion
          AND s.id_grupo IS NOT NULL
          AND p.id_edicion = p_id_edicion

    ) datos

    GROUP BY
        datos.id_edicion,
        datos.id_grupo,
        datos.id_seleccion;


    DBMS_OUTPUT.PUT_LINE(
        'Tabla de posiciones actualizada correctamente.'
    );

END actualizar_posiciones_grupo;
/


-- ============================================================
-- PROCEDIMIENTO 3:
-- CIERRE DE FASE Y AVANCE DE SELECCIONES CLASIFICADAS
-- ============================================================

CREATE OR REPLACE PROCEDURE cerrar_fase (
    p_id_edicion       IN NUMBER,
    p_id_fase_origen   IN NUMBER,
    p_id_fase_destino  IN NUMBER,
    p_cupos_por_grupo  IN NUMBER DEFAULT 2
)
AS
    v_fase_origen NUMBER;
    v_fase_destino NUMBER;
    v_posiciones NUMBER;
BEGIN

    -- Validar la cantidad de clasificados por grupo.

    IF p_cupos_por_grupo <= 0 THEN

        RAISE_APPLICATION_ERROR(
            -20020,
            'La cantidad de clasificados debe ser mayor que cero.'
        );

    END IF;


    -- Verificar que la fase de origen pertenezca a la edicion.

    SELECT COUNT(*)
    INTO v_fase_origen
    FROM fase
    WHERE id_fase = p_id_fase_origen
      AND id_edicion = p_id_edicion;


    -- Verificar que la fase de destino pertenezca a la edicion.

    SELECT COUNT(*)
    INTO v_fase_destino
    FROM fase
    WHERE id_fase = p_id_fase_destino
      AND id_edicion = p_id_edicion;


    IF v_fase_origen <> 1 OR v_fase_destino <> 1 THEN

        RAISE_APPLICATION_ERROR(
            -20021,
            'Las fases indicadas no pertenecen a la edicion seleccionada.'
        );

    END IF;


    IF p_id_fase_origen = p_id_fase_destino THEN

        RAISE_APPLICATION_ERROR(
            -20022,
            'La fase de origen y destino no pueden ser iguales.'
        );

    END IF;


    -- Actualizar las posiciones antes de determinar los clasificados.

    actualizar_posiciones_grupo(p_id_edicion);


    -- Verificar que existan posiciones calculadas.

    SELECT COUNT(*)
    INTO v_posiciones
    FROM tabla_posiciones
    WHERE id_edicion = p_id_edicion;


    IF v_posiciones = 0 THEN

        RAISE_APPLICATION_ERROR(
            -20023,
            'No existen posiciones para determinar los clasificados.'
        );

    END IF;


    -- Eliminar clasificaciones anteriores de esta fase.

    DELETE FROM avance_fase
    WHERE id_fase_origen = p_id_fase_origen;


    -- Clasificar las mejores selecciones de cada grupo.
    -- Criterios: puntos, diferencia de gol y goles a favor.

    INSERT INTO avance_fase (
        id_fase_origen,
        id_fase_destino,
        id_seleccion,
        id_grupo,
        puesto_grupo
    )
    SELECT
        p_id_fase_origen,
        p_id_fase_destino,
        clasificados.id_seleccion,
        clasificados.id_grupo,
        clasificados.puesto_grupo

    FROM (
        SELECT
            tp.id_seleccion,
            tp.id_grupo,

            ROW_NUMBER() OVER (
                PARTITION BY tp.id_grupo
                ORDER BY
                    tp.puntos DESC,
                    tp.diferencia_gol DESC,
                    tp.goles_favor DESC,
                    tp.id_seleccion ASC
            ) AS puesto_grupo

        FROM tabla_posiciones tp

        WHERE tp.id_edicion = p_id_edicion

    ) clasificados

    WHERE clasificados.puesto_grupo <= p_cupos_por_grupo;


    DBMS_OUTPUT.PUT_LINE(
        'Fase cerrada. Las selecciones clasificadas fueron registradas.'
    );

END cerrar_fase;
/

--DROPs para eliminar las tablas
-- DROP TABLE PARTICIPACION_PARTIDO CASCADE CONSTRAINTS;
-- DROP TABLE PARTIDO CASCADE CONSTRAINTS;
-- DROP TABLE ESTADIO CASCADE CONSTRAINTS;
-- DROP TABLE SELECCION CASCADE CONSTRAINTS;
-- DROP TABLE EDICION_MUNDIAL CASCADE CONSTRAINTS;




--edicion

INSERT INTO EDICION_MUNDIAL (id_edicion, anio, pais_sede, lema, fecha_inicio, fecha_fin)
VALUES (1, 2026, 'Canadá, México, Estados Unidos', 'We Are 26', DATE '2026-06-11', DATE '2026-07-19');

-- EAstadios
INSERT INTO ESTADIO (id_estadio, id_edicion, nombre, ciudad, capacidad)
VALUES (1, 1, 'Estadio Azteca', 'Ciudad de México', 87523);


INSERT INTO ESTADIO (id_estadio, id_edicion, nombre, ciudad, capacidad)
VALUES (2, 1, 'MetLife Stadium', 'East Rutherford', 82500);

--  selecciones
INSERT INTO SELECCION (id_seleccion, id_edicion, pais, confederacion, grupo)
VALUES (1, 1, 'México', 'CONCACAF', 'A');

INSERT INTO SELECCION (id_seleccion, id_edicion, pais, confederacion, grupo)
VALUES (2, 1, 'Colombia', 'CONMEBOL', 'A');

INSERT INTO SELECCION (id_seleccion, id_edicion, pais, confederacion, grupo)
VALUES (3, 1, 'España', 'UEFA', 'B');

INSERT INTO SELECCION (id_seleccion, id_edicion, pais, confederacion, grupo)
VALUES (4, 1, 'Argentina', 'CONMEBOL', 'B');

--  Partidos
INSERT INTO PARTIDO (id_partido, id_edicion, id_estadio, fecha_hora, fase, asistencia_registrada)
VALUES (1, 1, 1, TO_DATE('2026-06-11 15:00', 'YYYY-MM-DD HH24:MI'), 'FASE_DE_GRUPOS', 85000);

INSERT INTO PARTIDO (id_partido, id_edicion, id_estadio, fecha_hora, fase, asistencia_registrada)
VALUES (2, 1, 2, TO_DATE('2026-06-12 18:00', 'YYYY-MM-DD HH24:MI'), 'FASE_DE_GRUPOS', 80000);

-- 5. partido 1
INSERT INTO PARTICIPACION_PARTIDO (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
VALUES (1, 1, 1, 'LOCAL', 2);

INSERT INTO PARTICIPACION_PARTIDO (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
VALUES (2, 1, 2, 'VISITANTE', 1);

-- partido 2
INSERT INTO PARTICIPACION_PARTIDO (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
VALUES (3, 2, 3, 'LOCAL', 0);

INSERT INTO PARTICIPACION_PARTIDO (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
VALUES (4, 2, 4, 'VISITANTE', 3);

-- cambios
COMMIT;

--probar que existen las tablas
SELECT object_name, object_type, created
FROM user_objects
WHERE object_type = 'TABLE'
ORDER BY created DESC;


--Vista 1
--esta es la primera vista para ver locales 
CREATE OR REPLACE VIEW v_partidos_local AS
SELECT 
    p.id_partido,
    p.fecha_hora,
    p.fase,
    s.pais AS equipo_local,
    pp.goles_marcados AS goles_local
FROM PARTIDO p
JOIN PARTICIPACION_PARTIDO pp 
    ON p.id_partido = pp.id_partido
JOIN SELECCION s 
    ON pp.id_seleccion = s.id_seleccion
WHERE pp.condicion = 'LOCAL';

--esta es la segunda vista para ver partidos visitantes 
CREATE OR REPLACE VIEW v_partidos_visitante AS
SELECT 
    p.id_partido,
    s.pais AS equipo_visitante,
    pp.goles_marcados AS goles_visitante
FROM PARTIDO p
JOIN PARTICIPACION_PARTIDO pp 
    ON p.id_partido = pp.id_partido
JOIN SELECCION s 
    ON pp.id_seleccion = s.id_seleccion
WHERE pp.condicion = 'VISITANTE';

--Esta vista permite ver el partido tanto visitante como local
CREATE OR REPLACE VIEW v_partido_completo AS
SELECT 
    l.id_partido,
    l.fecha_hora,
    l.fase,
    l.equipo_local,
    l.goles_local,
    v.goles_visitante,
    v.equipo_visitante
FROM v_partidos_local l
JOIN v_partidos_visitante v 
    ON l.id_partido = v.id_partido;
    
SELECT * FROM v_partido_completo;

SELECT * from v_partidos_local;

SELECT * FROM v_partidos_visitante;
--

COMMIT;

SELECT table_name 
FROM user_tables 
ORDER BY table_name;
-- vista 4 sobre rendimiento de una slecion en total y promedio de goles
CREATE OR REPLACE VIEW v_goles_selecion AS
SELECT 
    s.pais,
    COUNT(pp.id_partido) AS partidos_jugados,
    SUM(pp.goles_marcados) AS total_goles,
    ROUND(AVG(pp.goles_marcados), 2) AS promedio_goles
FROM SELECCION s
JOIN PARTICIPACION_PARTIDO pp 
    ON s.id_seleccion = pp.id_seleccion
GROUP BY s.pais;
-- VER GOLES POR DESCENDINTE
SELECT pais, total_goles, promedio_goles
FROM v_goles_selecion
ORDER BY total_goles DESC;
-- eN ESTE CASO ESPAÑA TIENE 0 NO ES ERROR
-- vista 5
CREATE OR REPLACE VIEW v_ocupacion_estadios AS
SELECT 
    e.nombre AS estadio,
    e.ciudad,
    e.capacidad,
    COUNT(p.id_partido) AS partidos_albergados,
    SUM(p.asistencia_registrada) AS asistencia_total,
    ROUND(AVG((p.asistencia_registrada / e.capacidad) * 100), 1) AS porcentaje_ocupados
FROM ESTADIO e
JOIN PARTIDO p 
    ON e.id_estadio = p.id_estadio
GROUP BY e.nombre, e.ciudad, e.capacidad;

--
SELECT estadio, ciudad, capacidad, partidos_albergados, asistencia_total, porcentaje_ocupados
FROM v_ocupacion_estadios
ORDER BY porcentaje_ocupados DESC;

SELECT estadio, ciudad, capacidad, partidos_albergados, porcentaje_ocupados
FROM v_ocupacion_estadios
ORDER BY porcentaje_ocupados DESC;

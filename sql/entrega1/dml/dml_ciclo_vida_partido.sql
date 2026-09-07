INSERT INTO PARTIDO (
  id_partido, 
  id_edicion, 
  id_estadio, 
  fecha_hora, 
  fase, 
  asistencia_registrada
) VALUES (
  4,
  1,
  2,
  TO_DATE('25/08/2026 08:30 PM', 'DD/MM/YYYY HH:MI PM'),
  'FASE_DE_GRUPOS',
  80000
);

INSERT INTO PARTICIPACION_PARTIDO (
  id_participacion,
  id_partido,
  id_seleccion,
  condicion,
  goles_marcados
) VALUES (
  5,
  4,
  2,
  'LOCAL',
  0
);

INSERT INTO PARTICIPACION_PARTIDO (
  id_participacion, 
  id_partido, 
  id_seleccion,
  condicion,
  goles_marcados
) VALUES (
  6,
  4,
  4,
  'VISITANTE',
  0
);

UPDATE PARTICIPACION_PARTIDO 
SET goles_marcados = 2
WHERE id_partido = 4 AND id_seleccion = 2;

UPDATE PARTICIPACION_PARTIDO 
SET goles_marcados = 1
WHERE id_partido = 4 AND id_seleccion = 4;


-- ============================================================
-- OPERACIONES INVALIDAS - SEMANA 3
-- ============================================================

-- 1. Operación inválida: asistencia negativa.
-- Debe fallar porque la restricción ck_partido_asistencia
-- establece que la asistencia registrada debe ser mayor o igual a 0.

INSERT INTO PARTIDO (
  id_partido,
  id_edicion,
  id_estadio,
  fecha_hora,
  fase,
  asistencia_registrada
) VALUES (
  5,
  1,
  2,
  TO_DATE('26/08/2026 08:30 PM', 'DD/MM/YYYY HH:MI PM'),
  'FASE_DE_GRUPOS',
  -100
);


-- 2. Operación inválida: condición diferente de LOCAL/VISITANTE.
-- Debe fallar porque la restricción ck_participacion_condicion
-- solamente permite los valores LOCAL y VISITANTE.

INSERT INTO PARTICIPACION_PARTIDO (
  id_participacion,
  id_partido,
  id_seleccion,
  condicion,
  goles_marcados
) VALUES (
  7,
  4,
  1,
  'ARBITRO',
  0
);


-- 3. Operación inválida: cantidad de goles negativa.
-- Debe fallar porque la restricción ck_participacion_goles
-- establece que los goles marcados deben ser mayores o iguales a 0.

INSERT INTO PARTICIPACION_PARTIDO (
  id_participacion,
  id_partido,
  id_seleccion,
  condicion,
  goles_marcados
) VALUES (
  8,
  4,
  1,
  'LOCAL',
  -2
);

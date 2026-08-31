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
)VALUES (
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
  )VALUES (
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

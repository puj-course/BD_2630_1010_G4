select column_name, nullable
from user_tab_columns
where table_name = 'EDICION_MUNDIAL';


//1Insertamos una seleccion 
insert into edicion_mundial (id_edicion, anio, lema, fecha_inicio, fecha_fin)
values (1, 2022, 'Now is All', date '2022-11-20', date '2022-12-18');


//2 Insetamos Federaciones
insert into federacion (id_federacion, nombre, sigla, confederacion)
values (1, 'Asociación del Fútbol Argentino', 'AFA', 'CONMEBOL');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (2, 'Federación Francesa de Fútbol', 'FFF', 'UEFA');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (3, 'Federación Croata de Fútbol', 'HNS', 'UEFA');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (4, 'Federación Real Marroquí de Fútbol', 'FRMF', 'CAF');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (5, 'The Football Association', 'FA', 'UEFA');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (6, 'Real Asociación Neerlandesa de Fútbol', 'KNVB', 'UEFA');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (7, 'Confederación Brasileña de Fútbol', 'CBF', 'CONMEBOL');

insert into federacion (id_federacion, nombre, sigla, confederacion)
values (8, 'Federación Portuguesa de Fútbol', 'FPF', 'UEFA');

//3 Insertamos una sede catar
insert into sede (id_sede, id_edicion, pais)
values (1, 1, 'Catar');

//4 Insertamos ahora una ciudade de bueno catar Lusaik
insert into ciudad (id_ciudad, id_sede, nombre)
values (1, 1, 'Lusail');

insert into ciudad (id_ciudad, id_sede, nombre)
values (2, 1, 'Al Khor');

insert into ciudad (id_ciudad, id_sede, nombre)
values (3,1, 'Al Rayyan');

insert into ciudad(id_ciudad, id_sede, nombre)
values (4,1,'Doha');
--5 Insertamos unos estadios vallidos  
//Nota tome valores redondeados reales de capacidad maxima no general
insert into estadio (id_estadio, id_ciudad, id_edicion, nombre, capacidad)
values (1, 1, 1, 'Lusail Stadium', 88000);

insert into estadio(id_estadio, id_ciudad, id_edicion, nombre, capacidad)
values (2,2,1, 'Al Bayt Stadium', 88000);

insert into estadio (id_estadio, id_ciudad, id_edicion, nombre, capacidad)
values (3,3,1,' Education City Stadium', 40000);

insert into estadio (id_estadio,id_ciudad, id_edicion, nombre, capacidad)
values (4,4,1, 'Al Thumama Stadium', 44000)
;

insert into estadio (id_estadio, id_ciudad, id_edicion, nombre, capacidad)
values (5,4,1,'Khalifa International Stadium', 45000);
-- 6Fase
/*
//aqui todas son de la edicion 1 pero fase es cada 1 para un total de 4
insert into fase (id_fase, id_edicion, nombre, tipo)
values (1, 1, 'Cuartos de final', 'ELIMINATORIA');

insert into fase (id_fase, id_edicion, nombre, tipo)
values (2,1, 'Semifinales', 'ELIMINATORIA');

insert into fase (id_fase, id_edicion, nombre, tipo) 
values (4,1, 'Final', ' ELIMINATORIA');

insert into fase (id_fase, id_edicion, nombre, tipo)
values (3, 1, 'Tercer puesto', 'ELIMINATORIA');
*/
//tubo algun error

insert into fase (id_fase, id_edicion, nombre, tipo)
values (1, 1, 'Cuartos de final', 'ELIMINATORIA');
insert into fase (id_fase, id_edicion, nombre, tipo)
values (2, 1, 'Semifinales', 'ELIMINATORIA');
insert into fase (id_fase, id_edicion, nombre, tipo)
values (3, 1, 'Tercer puesto', 'ELIMINATORIA');
insert into fase (id_fase, id_edicion, nombre, tipo)
values (4, 1, 'Final', 'ELIMINATORIA');

// 7. SELECCION (Todas son id edicion 1 y federacion aumenta dependiendo de la logica o bueno que federeaciones habia 
//si era francia sera federacion de francia 
insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (1, 1, 1, null, 'Argentina');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (2, 1, 2, null, 'Francia');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (3, 1, 3, null, 'Croacia');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (4, 1, 4, null, 'Marruecos');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (5, 1, 5, null, 'Inglaterra');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (6, 1, 6, null, 'Países Bajos');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (7, 1, 7, null, 'Brasil');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais)
values (8, 1, 8, null, 'Portugal');
//  8 Insertamos en jugador validos que nacimiento no nulo 
-- Dorsal es numero de camisa 

//USANDO MOCKARO PARA ALEATORIEDAD
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (1, 'Rosemary Regardsoe', date '1995-10-12');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (2, 'Idelle Sigward', date '1998-02-06');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (3, 'Jeremias Yuryatin', date '2001-10-01');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (4, 'Kalinda Pascho', date '1997-02-24');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (5, 'Linette Rosenbusch', date '2000-05-14');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (6, 'Griselda Konzel', date '1994-11-16');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (7, 'Wolf Bartels-Ellis', date '1999-03-23');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (8, 'Doyle Jarrett', date '2003-09-10');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (9, 'Conrade Demongeot', date '1996-01-27');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (10, 'Yoshiko Baldetti', date '2002-09-01');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (11, 'Ketti Stockey', date '1993-10-26');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (12, 'Zed Henaughan', date '2004-01-10');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (13, 'Arther Flieg', date '1998-06-02');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (14, 'Aristotle Burnside', date '1991-05-16');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (15, 'Teddie Sentance', date '1995-11-26');
insert into jugador (id_jugador, nombre, fecha_nacimiento) values (16, 'Raff Colaco', date '2000-02-17');

-- 9. CONVOCATORIA_JUGADOR (un capitan por seleccion)
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (1, 1, 1, 10, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (2, 2, 1, 9, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (3, 3, 2, 10, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (4, 4, 2, 1, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (5, 5, 3, 10, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (6, 6, 3, 20, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (7, 7, 4, 19, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (8, 8, 4, 6, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (9, 9, 5, 9, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (10, 10, 5, 22, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (11, 11, 6, 4, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (12, 12, 6, 8, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (13, 13, 7, 10, 'NO');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (14, 14, 7, 3, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (15, 15, 8, 7, 'SI');
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (16, 16, 8, 8, 'NO');
--Nota personal es buena restriccion poner que un capi por grupo 


select 'edicion_mundial' as tabla, count(*) as filas from edicion_mundial
union all select 'ciudad', count(*) from ciudad
union all select 'estadio', count(*) from estadio
union all select 'fase', count(*) from fase
union all select 'seleccion', count(*) from seleccion;
//- 10. PARTIDO (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
-- Cuartos de final (fase 1) son 4 partifos
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (1, 1, 1, 3, to_date('2022-12-09 18:00', 'YYYY-MM-DD HH24:MI'), 39500);   -- Croacia - Brasil
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (2, 1, 1, 1, to_date('2022-12-09 22:00', 'YYYY-MM-DD HH24:MI'), 87000);   -- Paises Bajos - Argentina
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (3, 1, 1, 4, to_date('2022-12-10 18:00', 'YYYY-MM-DD HH24:MI'), 43500);   -- Marruecos - Portugal
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (4, 1, 1, 2, to_date('2022-12-10 22:00', 'YYYY-MM-DD HH24:MI'), 67000);   -- Inglaterra - Francia
 
-- Semifinales (fase 2)son 2 partidos
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (5, 1, 2, 1, to_date('2022-12-13 22:00', 'YYYY-MM-DD HH24:MI'), 87800);   -- Argentina - Croacia
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (6, 1, 2, 2, to_date('2022-12-14 22:00', 'YYYY-MM-DD HH24:MI'), 67500);   -- Francia - Marruecos
 
-- Tercer puesto (fase 3) son 1 partido
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (7, 1, 3, 5, to_date('2022-12-17 18:00', 'YYYY-MM-DD HH24:MI'), 44000);   -- Croacia - Marruecos
 
-- Final (fase 4) son 1 partido
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (8, 1, 4, 1, to_date('2022-12-18 18:00', 'YYYY-MM-DD HH24:MI'), 87900);   -- Argentina - Francia
 
-- 11. PARTICIPACION_PARTIDO (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
-- Goles: tiempo reglamentario + prorroga (los penales no se cuentan).
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (1, 1, 3, 'LOCAL', 1);        -- Croacia
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (2, 1, 7, 'VISITANTE', 1);    -- Brasil
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (3, 2, 6, 'LOCAL', 2);        -- Paises Bajos
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (4, 2, 1, 'VISITANTE', 2);    -- Argentina
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (5, 3, 4, 'LOCAL', 1);        -- Marruecos
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (6, 3, 8, 'VISITANTE', 0);    -- Portugal
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (7, 4, 5, 'LOCAL', 1);        -- Inglaterra
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (8, 4, 2, 'VISITANTE', 2);    -- Francia
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (9, 5, 1, 'LOCAL', 3);        -- Argentina
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (10, 5, 3, 'VISITANTE', 0);   -- Croacia
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (11, 6, 2, 'LOCAL', 2);       -- Francia
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (12, 6, 4, 'VISITANTE', 0);   -- Marruecos
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (13, 7, 3, 'LOCAL', 2);       -- Croacia
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (14, 7, 4, 'VISITANTE', 1);   -- Marruecos
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (15, 8, 1, 'LOCAL', 3);       -- Argentina
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (16, 8, 2, 'VISITANTE', 3);   -- Francia
 
commit;
select 'partido' as tabla, count(*) as filas from partido
union all select 'participacion_partido', count(*) from participacion_partido;


-- 12. ARBITRO
/*insert into arbitro (id_arbitro, nombre, nacionalidad)
values (1, 'Nombre de Mockaroo', 'Argentina');
*/


insert into arbitro (id_arbitro, nombre, nacionalidad) values (1, 'Virgie Trembley', 'China');
insert into arbitro (id_arbitro, nombre, nacionalidad) values (2, 'Harp Matton', 'United States');
insert into arbitro (id_arbitro, nombre, nacionalidad) values (3, 'Claudian Ritelli', 'Portugal');
insert into arbitro (id_arbitro, nombre, nacionalidad) values (4, 'Ellsworth Frome', 'Brazil');
insert into arbitro (id_arbitro, nombre, nacionalidad) values (5, 'Penny Merriton', 'China');
insert into arbitro (id_arbitro, nombre, nacionalidad) values (6, 'Candice Dionisi', 'Philippines');

-- 13. ASIGNACION_ARBITRAL
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (1, 1, 1, 'CENTRAL');  -- Croacia - Brasil
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (2, 2, 2, 'CENTRAL');  -- Países Bajos - Argentina
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (3, 4, 3, 'CENTRAL');  -- Marruecos - Portugal
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (4, 3, 4, 'CENTRAL');  -- Inglaterra - Francia
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (5, 5, 5, 'CENTRAL');  -- Argentina - Croacia
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (6, 6, 6, 'CENTRAL');  -- Francia - Marruecos
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (7, 1, 7, 'CENTRAL');  -- Croacia - Marruecos
insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) values (8, 2, 8, 'CENTRAL');  -- Argentina - Francia
commit;

-- 14. ESTADISTICA_JUGADOR_PARTIDO
-- (id_estadistica, id_partido, id_jugador, goles, asistencias,

-- Cada partido tiene solo alguno de los jugadores insertados
-- Todos los goles del equipo se asignan a un solo jugador por partido 

-- Partido 1: Croacia 1-1 Brasil (120 min)
insert into estadistica_jugador_partido values (1, 1, 5, 1, 0, 0, 0, 3, 120);
insert into estadistica_jugador_partido values (2, 1, 6, 0, 1, 1, 0, 1, 120);
insert into estadistica_jugador_partido values (3, 1, 13, 1, 0, 0, 0, 4, 120);
insert into estadistica_jugador_partido values (4, 1, 14, 0, 0, 1, 0, 0, 120);
-- Partido 2: Paises Bajos 2-2 Argentina (120 min)
insert into estadistica_jugador_partido values (5, 2, 11, 0, 1, 1, 0, 1, 120);
insert into estadistica_jugador_partido values (6, 2, 12, 2, 0, 0, 0, 5, 120);
insert into estadistica_jugador_partido values (7, 2, 1, 2, 0, 0, 0, 4, 120);
insert into estadistica_jugador_partido values (8, 2, 2, 0, 1, 1, 0, 2, 120);
 
 
-- Partido 3: Marruecos 1-0 Portugal (90 min)
insert into estadistica_jugador_partido values (9, 3, 7, 1, 0, 0, 0, 3, 90);
insert into estadistica_jugador_partido values (10, 3, 8, 0, 0, 1, 0, 0, 90);
insert into estadistica_jugador_partido values (11, 3, 15, 0, 0, 0, 0, 4, 90);
insert into estadistica_jugador_partido values (12, 3, 16, 0, 0, 1, 0, 2, 90);

-- Partido 4: Inglaterra 1-2 Francia (90 min)
insert into estadistica_jugador_partido values (13, 4, 9, 1, 0, 0, 0, 3, 90);
insert into estadistica_jugador_partido values (14, 4, 10, 0, 1, 1, 0, 2, 90);
insert into estadistica_jugador_partido values (15, 4, 3, 2, 0, 0, 0, 4, 90);
insert into estadistica_jugador_partido values (16, 4, 4, 0, 1, 0, 0, 0, 90);
-- Partido 5: Argentina 3-0 Croacia (90 min)
insert into estadistica_jugador_partido values (17, 5, 1, 3, 0, 0, 0, 5, 90);
insert into estadistica_jugador_partido values (18, 5, 2, 0, 2, 0, 0, 2, 90);
insert into estadistica_jugador_partido values (19, 5, 5, 0, 0, 0, 0, 2, 90);
insert into estadistica_jugador_partido values (20, 5, 6, 0, 0, 1, 0, 1, 90);
 
-- Partido 6: Francia 2-0 Marruecos (90 min)
insert into estadistica_jugador_partido values (21, 6, 3, 2, 0, 0, 0, 4, 90);
insert into estadistica_jugador_partido values (22, 6, 4, 0, 1, 0, 0, 0, 90);
insert into estadistica_jugador_partido values (23, 6, 7, 0, 0, 1, 0, 2, 90);
insert into estadistica_jugador_partido values (24, 6, 8, 0, 0, 0, 0, 0, 90);
 
-- Partido 7: Croacia 2-1 Marruecos (90 min)
insert into estadistica_jugador_partido values (25, 7, 5, 2, 0, 0, 0, 4, 90);
insert into estadistica_jugador_partido values (26, 7, 6, 0, 1, 1, 0, 1, 90);
insert into estadistica_jugador_partido values (27, 7, 7, 1, 0, 0, 0, 3, 90);
insert into estadistica_jugador_partido values (28, 7, 8, 0, 0, 0, 0, 0, 90);
 
-- Partido 8: Argentina 3-3 Francia (120 min)
insert into estadistica_jugador_partido values (29, 8, 1, 3, 0, 0, 0, 6, 120);
insert into estadistica_jugador_partido values (30, 8, 2, 0, 1, 1, 0, 2, 120);
insert into estadistica_jugador_partido values (31, 8, 3, 3, 0, 0, 0, 7, 120);
insert into estadistica_jugador_partido values (32, 8, 4, 0, 1, 1, 0, 0, 120);
 
commit;


-- 15. INCIDENCIA hañadido como tarjeta amarilla o amonestacion de gol anulado
insert into incidencia (id_incidencia, id_partido, tipo, descripcion, minuto)
values (1, 8, 'TANDA DE PENALES', 'Argentina gana 4-2 en la tanda de penales', 120);

insert into incidencia (id_incidencia, id_partido, tipo, descripcion, minuto)
values (2, 3, 'TARJETA AMARILLA', 'Amonestación a Doyle Jarrett (Marruecos)', 34);

insert into incidencia (id_incidencia, id_partido, tipo, descripcion, minuto)
values (3, 6, 'GOL ANULADO', 'Gol anulado por fuera de juego', 61);


--Notas finales algunos modelos no correran la // como caracter para comentario validos.
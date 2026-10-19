# Pruebas de Integridad y Validación del Modelo

A continuación se presentan las pruebas de validación sobre el esquema en formato SQL plano. Cada caso incluye la operación ejecutada y el comportamiento esperado según las reglas y restricciones del modelo relacional.

---

## 1. Escenarios Exitosos


-- CP-EXITO-01: Registro de edición con fechas consistentes
-- Debe insertar correctamente al cumplir que fecha_fin sea posterior a fecha_inicio.
insert into edicion_mundial (id_edicion, anio, lema, fecha_inicio, fecha_fin)
values (1, 2026, 'We Are 26', date '2026-06-11', date '2026-07-19');
-- Resultado: 1 fila insertada.


-- CP-EXITO-02: Jerarquía territorial e infraestructura
-- Inserción en cascada lógica: sede, ciudad y estadio con capacidad positiva.
insert into sede (id_sede, id_edicion, pais) 
values (1, 1, 'Estados Unidos');

insert into ciudad (id_ciudad, id_sede, nombre) 
values (1, 1, 'Nueva York / Nueva Jersey');

insert into estadio (id_estadio, id_ciudad, id_edicion, nombre, capacidad) 
values (1, 1, 1, 'MetLife Stadium', 82500);
-- Resultado: 1 fila insertada en cada tabla.


-- CP-EXITO-03: Convocatoria con dorsal y capitanía válidos
-- Registro de federación, selección, jugador ficticio y su convocatoria formal.
insert into federacion (id_federacion, nombre, sigla, confederacion) 
values (1, 'Federación Colombiana de Fútbol', 'FCF', 'CONMEBOL');

insert into seleccion (id_seleccion, id_edicion, id_federacion, id_grupo, pais) 
values (1, 1, 1, null, 'Colombia');

insert into jugador (id_jugador, nombre, fecha_nacimiento) 
values (1, 'Carlos Valderrama Ficticio', date '1998-05-12');

insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan) 
values (1, 1, 1, 10, 'SI');
-- Resultado: 1 fila insertada. Dorsal entre 1 y 99 y valor de capitán permitido.


-- CP-EXITO-04: Asignación de árbitro a un partido
-- Vinculación de un árbitro con rol específico dentro de un partido programado.
insert into fase (id_fase, id_edicion, nombre, tipo) 
values (1, 1, 'Fase de Grupos', 'Grupos');

insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada) 
values (1, 1, 1, 1, date '2026-06-12', 75000);

insert into arbitro (id_arbitro, nombre, nacionalidad) 
values (1, 'Marc Brena', 'Francia');

insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol) 
values (1, 1, 1, 'CENTRAL');
-- Resultado: 1 fila insertada. Rol asignado unívocamente para ese encuentro.


-- CP-EXITO-05: Estadísticas individuales de partido
-- Registro de métricas individuales no negativas y tiempo jugado reglamentario.
insert into estadistica_jugador_partido (
    id_estadistica, id_partido, id_jugador, goles, asistencias, 
    tarjetas_amarillas, tarjetas_rojas, tiros, minutos_jugados
) values (1, 1, 1, 2, 1, 0, 0, 4, 90);
-- Resultado: 1 fila insertada. Valores dentro de los rangos numéricos válidos.
```
2. Escenarios Fallidos 
````
-- CP-FALLO-01: Fechas invertidas en edición mundial
-- Intento de registrar una fecha de finalización previa al inicio del torneo.
insert into edicion_mundial (id_edicion, anio, lema, fecha_inicio, fecha_fin)
values (2, 2030, 'Centenario', date '2030-07-20', date '2030-06-10');
-- Resultado esperado: Error ORA-02290 por violación de la restricción ck_edicion_fechas.


-- CP-FALLO-02: Capacidad de estadio no positiva
-- Intento de definir un aforo igual a 0.
insert into estadio (id_estadio, id_ciudad, id_edicion, nombre, capacidad)
values (2, 1, 1, 'Estadio Municipal Invalido', 0);
-- Resultado esperado: Error ORA-02290 por violación de ck_estadio_capacidad.


-- CP-FALLO-03: Convocatoria duplicada de un mismo jugador
-- Intento de registrar al mismo futbolista dos veces en la misma selección.
insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (2, 1, 1, 11, 'NO');
-- Resultado esperado: Error ORA-00001 por violación de la restricción única uq_convocatoria.


-- CP-FALLO-04: Dorsal fuera del rango reglamentario
-- Intento de asignar un número superior a 99 (por ejemplo, 105).
insert into jugador (id_jugador, nombre, fecha_nacimiento) 
values (2, 'Julian Gomez Ficticio', date '2001-02-15');

insert into convocatoria_jugador (id_convocatoria, id_jugador, id_seleccion, dorsal, es_capitan)
values (3, 2, 1, 105, 'NO');
-- Resultado esperado: Error ORA-02290 por violación de ck_convocatoria_dorsal.


-- CP-FALLO-05: Condición de partido inválida
-- Intento de registrar una condición distinta a 'LOCAL' o 'VISITANTE'.
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (1, 1, 1, 'NEUTRAL', 0);
-- Resultado esperado: Error ORA-02290 por violación de ck_participacion_condicion.


-- CP-FALLO-06: Selección duplicada en el mismo encuentro
-- Intento de asociar dos veces la misma selección en el mismo partido.
insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (1, 1, 1, 'LOCAL', 1);

insert into participacion_partido (id_participacion, id_partido, id_seleccion, condicion, goles_marcados)
values (2, 1, 1, 'VISITANTE', 0);
-- Resultado esperado: Error ORA-00001 por violación de la clave única uq_participacion.


-- CP-FALLO-07: Rol arbitral repetido en un partido
-- Intento de asignar dos árbitros con el rol de 'CENTRAL' en el mismo partido.
insert into arbitro (id_arbitro, nombre, nacionalidad) 
values (2, 'Daniele Rossi', 'Italia');

insert into asignacion_arbitral (id_asignacion, id_arbitro, id_partido, rol)
values (2, 2, 1, 'CENTRAL');
-- Resultado esperado: Error ORA-00001 por violación de uq_asignacion_rol.


-- CP-FALLO-08: Minutos jugados superiores al límite
-- Intento de registrar más de 120 minutos reglamentarios en una estadística individual.
insert into estadistica_jugador_partido (
    id_estadistica, id_partido, id_jugador, goles, asistencias, 
    tarjetas_amarillas, tarjetas_rojas, tiros, minutos_jugados
) values (2, 1, 1, 0, 0, 0, 0, 1, 135);
-- Resultado esperado: Error ORA-02290 por violación de ck_estadistica_minutos.


-- CP-FALLO-09: Clave foránea inexistente
-- Intento de vincular un partido a un estadio con ID no registrado en la base de datos.
insert into partido (id_partido, id_edicion, id_fase, id_estadio, fecha_hora, asistencia_registrada)
values (2, 1, 1, 9999, date '2026-06-15', 50000);
-- Resultado esperado: Error ORA-02291 por violación de fk_partido_estadio (llave padre no encontrada).

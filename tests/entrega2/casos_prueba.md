# Pruebas de Integridad y Validación del Modelo

A continuación se presentan las pruebas de validación sobre el esquema en formato SQL plano. Cada caso incluye la operación ejecutada y el comportamiento esperado según las reglas y restricciones del modelo relacional.

---

## 1. Escenarios Exitosos

```sql
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

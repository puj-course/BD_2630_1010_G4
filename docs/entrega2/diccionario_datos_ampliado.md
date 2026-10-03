# Diccionario de Datos — Modelo Lógico del Mundial

## 1. EDICION_MUNDIAL

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| EDICION_MUNDIAL | id_edicion | NUMBER(10) | Identificador único de la edición del Mundial. | PK, NOT NULL |
| EDICION_MUNDIAL | anio | NUMBER(4) | Año en el que se realiza la edición. | UNIQUE, NOT NULL |
| EDICION_MUNDIAL | lema | VARCHAR2(150) | Lema oficial asociado a la edición. | NULL permitido |
| EDICION_MUNDIAL | fecha_inicio | DATE | Fecha de inicio de la edición. | NOT NULL |
| EDICION_MUNDIAL | fecha_fin | DATE | Fecha de finalización de la edición. | NOT NULL |


## 2. SEDE

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| SEDE | id_sede | NUMBER(10) | Identificador único de la sede. | PK, NOT NULL |
| SEDE | id_edicion | NUMBER(10) | Identificador de la edición a la que pertenece la sede. | FK → EDICION_MUNDIAL, NOT NULL |
| SEDE | pais | VARCHAR2(100) | País que participa como sede de la edición. | NOT NULL, UNIQUE (id_edicion, pais) |


## 3. CIUDAD

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| CIUDAD | id_ciudad | NUMBER(10) | Identificador único de la ciudad. | PK, NOT NULL |
| CIUDAD | id_sede | NUMBER(10) | Identificador de la sede a la que pertenece la ciudad. | FK → SEDE, NOT NULL |
| CIUDAD | nombre | VARCHAR2(100) | Nombre de la ciudad donde se encuentran los estadios. | NOT NULL, UNIQUE (id_sede, nombre) |


## 4. ESTADIO

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| ESTADIO | id_estadio | NUMBER(10) | Identificador único del estadio. | PK, NOT NULL |
| ESTADIO | id_ciudad | NUMBER(10) | Identificador de la ciudad donde se encuentra el estadio. | FK → CIUDAD, NOT NULL |
| ESTADIO | nombre | VARCHAR2(100) | Nombre del estadio. | NOT NULL, UNIQUE (id_ciudad, nombre) |
| ESTADIO | capacidad | NUMBER(10) | Capacidad máxima de espectadores del estadio. | NOT NULL, CHECK (capacidad > 0) |


## 5. FASE

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| FASE | id_fase | NUMBER(10) | Identificador único de la fase. | PK, NOT NULL |
| FASE | id_edicion | NUMBER(10) | Identificador de la edición a la que pertenece la fase. | FK → EDICION_MUNDIAL, NOT NULL |
| FASE | nombre | VARCHAR2(50) | Nombre de la fase del torneo. | NOT NULL, UNIQUE (id_edicion, nombre) |
| FASE | tipo | VARCHAR2(30) | Tipo de fase, por ejemplo grupos o eliminación directa. | NOT NULL |


## 6. GRUPO

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| GRUPO | id_grupo | NUMBER(10) | Identificador único del grupo. | PK, NOT NULL |
| GRUPO | id_edicion | NUMBER(10) | Identificador de la edición a la que pertenece el grupo. | FK → EDICION_MUNDIAL, NOT NULL |
| GRUPO | nombre | VARCHAR2(30) | Nombre o identificador del grupo, por ejemplo Grupo A. | NOT NULL, UNIQUE (id_edicion, nombre) |


## 7. FEDERACION

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| FEDERACION | id_federacion | NUMBER(10) | Identificador único de la federación nacional. | PK, NOT NULL |
| FEDERACION | nombre | VARCHAR2(150) | Nombre de la federación nacional. | NOT NULL |
| FEDERACION | sigla | VARCHAR2(10) | Sigla utilizada para identificar la federación. | UNIQUE, NOT NULL |
| FEDERACION | confederacion | VARCHAR2(100) | Confederación continental a la que pertenece la federación. | NOT NULL |


## 8. SELECCION

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| SELECCION | id_seleccion | NUMBER(10) | Identificador único de la selección participante. | PK, NOT NULL |
| SELECCION | id_edicion | NUMBER(10) | Identificador de la edición en la que participa la selección. | FK → EDICION_MUNDIAL, NOT NULL |
| SELECCION | id_federacion | NUMBER(10) | Identificador de la federación a la que pertenece la selección. | FK → FEDERACION, NOT NULL |
| SELECCION | id_grupo | NUMBER(10) | Identificador del grupo al que pertenece la selección durante la fase de grupos. | FK → GRUPO, NULL permitido |
| SELECCION | pais | VARCHAR2(100) | Nombre del país representado por la selección. | NOT NULL, UNIQUE (id_edicion, pais) |


## 9. JUGADOR

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| JUGADOR | id_jugador | NUMBER(10) | Identificador único del jugador. | PK, NOT NULL |
| JUGADOR | nombre | VARCHAR2(150) | Nombre del jugador. | NOT NULL |
| JUGADOR | fecha_nacimiento | DATE | Fecha de nacimiento del jugador. | NOT NULL |


## 10. CONVOCATORIA_JUGADOR

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| CONVOCATORIA_JUGADOR | id_jugador | NUMBER(10) | Identificador del jugador convocado. | PK, FK → JUGADOR, NOT NULL |
| CONVOCATORIA_JUGADOR | id_seleccion | NUMBER(10) | Identificador de la selección que convoca al jugador. | PK, FK → SELECCION, NOT NULL |
| CONVOCATORIA_JUGADOR | dorsal | NUMBER(2) | Número de camiseta asignado al jugador durante la edición. | NOT NULL, CHECK (dorsal BETWEEN 1 AND 99) |
| CONVOCATORIA_JUGADOR | es_capitan | CHAR(1) | Indica si el jugador es el capitán de la selección. | NOT NULL, CHECK (es_capitan IN ('S','N')) |

**Clave primaria compuesta:**

`(id_jugador, id_seleccion)`


## 11. PARTIDO

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| PARTIDO | id_partido | NUMBER(10) | Identificador único del partido. | PK, NOT NULL |
| PARTIDO | id_edicion | NUMBER(10) | Identificador de la edición en la que se disputa el partido. | FK → EDICION_MUNDIAL, NOT NULL |
| PARTIDO | id_fase | NUMBER(10) | Identificador de la fase en la que se disputa el partido. | FK → FASE, NOT NULL |
| PARTIDO | id_estadio | NUMBER(10) | Identificador del estadio donde se disputa el partido. | FK → ESTADIO, NOT NULL |
| PARTIDO | fecha_hora | DATE | Fecha y hora programada para el partido. | NOT NULL |
| PARTIDO | asistencia_registrada | NUMBER(10) | Cantidad de espectadores registrados en el partido. | NOT NULL, CHECK (asistencia_registrada >= 0) |


## 12. PARTICIPACION_PARTIDO

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| PARTICIPACION_PARTIDO | id_partido | NUMBER(10) | Identificador del partido en el que participa la selección. | PK, FK → PARTIDO, NOT NULL |
| PARTICIPACION_PARTIDO | id_seleccion | NUMBER(10) | Identificador de la selección que participa en el partido. | PK, FK → SELECCION, NOT NULL |
| PARTICIPACION_PARTIDO | condicion | VARCHAR2(20) | Indica si la selección participa como local o visitante. | NOT NULL, CHECK (condicion IN ('LOCAL','VISITANTE')) |
| PARTICIPACION_PARTIDO | goles_marcados | NUMBER(3) | Cantidad de goles marcados por la selección en el partido. | NOT NULL, CHECK (goles_marcados >= 0) |

**Clave primaria compuesta:**

`(id_partido, id_seleccion)`


## 13. ARBITRO

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| ARBITRO | id_arbitro | NUMBER(10) | Identificador único del árbitro. | PK, NOT NULL |
| ARBITRO | nombre | VARCHAR2(150) | Nombre del árbitro. | NOT NULL |
| ARBITRO | nacionalidad | VARCHAR2(100) | Nacionalidad del árbitro. | NOT NULL |


## 14. ASIGNACION_ARBITRAL

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| ASIGNACION_ARBITRAL | id_partido | NUMBER(10) | Identificador del partido al que se asigna el árbitro. | PK, FK → PARTIDO, NOT NULL |
| ASIGNACION_ARBITRAL | id_arbitro | NUMBER(10) | Identificador del árbitro asignado al partido. | PK, FK → ARBITRO, NOT NULL |
| ASIGNACION_ARBITRAL | rol | VARCHAR2(20) | Función desempeñada por el árbitro durante el partido. | NOT NULL, UNIQUE (id_partido, rol) |

**Clave primaria compuesta:**

`(id_partido, id_arbitro)`

**Roles permitidos:**

- CENTRAL
- ASISTENTE 1
- ASISTENTE 2
- CUARTO
- VAR
- AVAR


## 15. ESTADISTICA_JUGADOR_PARTIDO

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| ESTADISTICA_JUGADOR_PARTIDO | id_estadistica | NUMBER(10) | Identificador único del registro estadístico. | PK, NOT NULL |
| ESTADISTICA_JUGADOR_PARTIDO | id_partido | NUMBER(10) | Identificador del partido en el que se registran las estadísticas. | FK → PARTIDO, NOT NULL |
| ESTADISTICA_JUGADOR_PARTIDO | id_jugador | NUMBER(10) | Identificador del jugador al que pertenecen las estadísticas. | FK → JUGADOR, NOT NULL |
| ESTADISTICA_JUGADOR_PARTIDO | goles | NUMBER(3) | Cantidad de goles marcados por el jugador en el partido. | NOT NULL, CHECK (goles >= 0) |
| ESTADISTICA_JUGADOR_PARTIDO | asistencias | NUMBER(3) | Cantidad de asistencias realizadas por el jugador. | NOT NULL, CHECK (asistencias >= 0) |
| ESTADISTICA_JUGADOR_PARTIDO | tarjetas_amarillas | NUMBER(2) | Cantidad de tarjetas amarillas recibidas por el jugador. | NOT NULL, CHECK (tarjetas_amarillas >= 0) |
| ESTADISTICA_JUGADOR_PARTIDO | tarjetas_rojas | NUMBER(2) | Cantidad de tarjetas rojas recibidas por el jugador. | NOT NULL, CHECK (tarjetas_rojas >= 0) |
| ESTADISTICA_JUGADOR_PARTIDO | tiros | NUMBER(3) | Cantidad de tiros realizados por el jugador. | NOT NULL, CHECK (tiros >= 0) |
| ESTADISTICA_JUGADOR_PARTIDO | minutos_jugados | NUMBER(3) | Cantidad de minutos jugados por el jugador en el partido. | NOT NULL, CHECK (minutos_jugados BETWEEN 0 AND 120) |

**Restricción UNIQUE:**

`(id_partido, id_jugador)`


## 16. INCIDENCIA

| Tabla | Atributo | Tipo | Descripción | Restricciones |
|---|---|---|---|---|
| INCIDENCIA | id_incidencia | NUMBER(10) | Identificador único de la incidencia. | PK, NOT NULL |
| INCIDENCIA | id_partido | NUMBER(10) | Identificador del partido en el que ocurre la incidencia. | FK → PARTIDO, NOT NULL |
| INCIDENCIA | tipo | VARCHAR2(50) | Tipo de incidencia ocurrida durante el partido. | NOT NULL |
| INCIDENCIA | descripcion | VARCHAR2(500) | Descripción detallada de la incidencia. | NOT NULL |
| INCIDENCIA | minuto | NUMBER(3) | Minuto aproximado del partido en el que ocurre la incidencia. | NULL permitido, CHECK (minuto >= 0) |


# Resumen de claves primarias

| Tabla | Clave primaria |
|---|---|
| EDICION_MUNDIAL | id_edicion |
| SEDE | id_sede |
| CIUDAD | id_ciudad |
| ESTADIO | id_estadio |
| FASE | id_fase |
| GRUPO | id_grupo |
| FEDERACION | id_federacion |
| SELECCION | id_seleccion |
| JUGADOR | id_jugador |
| CONVOCATORIA_JUGADOR | id_jugador + id_seleccion |
| PARTIDO | id_partido |
| PARTICIPACION_PARTIDO | id_partido + id_seleccion |
| ARBITRO | id_arbitro |
| ASIGNACION_ARBITRAL | id_partido + id_arbitro |
| ESTADISTICA_JUGADOR_PARTIDO | id_estadistica |
| INCIDENCIA | id_incidencia |


# Resumen de relaciones identificantes

Las siguientes tablas poseen claves primarias compuestas que incluyen las claves de las entidades relacionadas:

| Entidad dependiente | Entidades relacionadas | Clave primaria |
|---|---|---|
| CONVOCATORIA_JUGADOR | JUGADOR, SELECCION | id_jugador + id_seleccion |
| PARTICIPACION_PARTIDO | PARTIDO, SELECCION | id_partido + id_seleccion |
| ASIGNACION_ARBITRAL | PARTIDO, ARBITRO | id_partido + id_arbitro |


# Resumen de restricciones UNIQUE

| Tabla | Restricción UNIQUE |
|---|---|
| EDICION_MUNDIAL | anio |
| SEDE | id_edicion + pais |
| CIUDAD | id_sede + nombre |
| ESTADIO | id_ciudad + nombre |
| FASE | id_edicion + nombre |
| GRUPO | id_edicion + nombre |
| FEDERACION | sigla |
| SELECCION | id_edicion + pais |
| ASIGNACION_ARBITRAL | id_partido + rol |
| ESTADISTICA_JUGADOR_PARTIDO | id_partido + id_jugador |

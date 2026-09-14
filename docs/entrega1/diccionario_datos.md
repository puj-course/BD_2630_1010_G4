<<<<<<< HEAD
# Diccionario de Datos — Entrega 1

Presnetación detalla la estructura física y lógica sobre las cinco tablas implementadas el sistema para  la Copa Mundial de la FIFA.

---
## 1. Tabla: EDICION_MUNDIAL
Almacena la información general de cada edición de la Copa del Mundo.

| Columna | Tipo de Dato | Nulo | Restricción | Descripción |
|---|---|---|---|---|
| `id_edicion` | NUMBER | NO | PK | Identificador único de la edición del torneo. |
| `anio` | NUMBER(4) | NO | CHECK (`anio > 1900`) | Año de celebración del mundial. |
| `pais_sede` | VARCHAR2(100) | NO | - | País anfitrión de la edición. |
| `lema` | VARCHAR2(200) | SÍ | - | Lema o eslogan oficial del torneo. |
| `fecha_inicio` | DATE | NO | - | Fecha de inauguración del certamen. |
| `fecha_fin` | DATE | NO | CHECK (`fecha_fin >= fecha_inicio`) | Fecha de clausura del certamen. |

---

## 2. Tabla: ESTADIO
Registra las sedes e infraestructuras donde se disputan los partidos de una edición.
Aca hay que revisar las correspondencias y reglas, para asegurar la información.

| Columna | Tipo de Dato | Nulo | Restricción | Descripción |
|---|---|---|---|---|
| `id_estadio` | NUMBER | NO | PK | Identificador único del estadio. |
| `id_edicion` | NUMBER | NO | FK | Edición a la que pertenece el recinto (hacia `EDICION_MUNDIAL`). |
| `nombre` | VARCHAR2(100) | NO | - | Nombre oficial del estadio. |
| `ciudad` | VARCHAR2(100) | NO | - | Ciudad donde se ubica el estadio. |
| `capacidad` | NUMBER | NO | CHECK (`capacidad > 0`) | Capacidad total de espectadores autorizada. |

---

## 3. Tabla: SELECCION
Almacena las selecciones nacionales clasificadas que disputan el torneo, aqui se cordinan para los equipos.
| Columna | Tipo de Dato | Nulo | Restricción | Descripción |
|---|---|---|---|---|
| `id_seleccion` | NUMBER | NO | PK | Identificador único de la selección en el torneo. |
| `id_edicion` | NUMBER | NO | FK | Edición en la que participa (hacia `EDICION_MUNDIAL`). |
| `pais` | VARCHAR2(100) | NO | - | Nombre del país de la selección nacional. |
| `confederacion` | VARCHAR2(50) | NO | - | Confederación continental (ej. CONMEBOL, UEFA). |
| `grupo` | CHAR(1) | SÍ | - | Letra del grupo asignado para la fase inicial. |

---


## 4. Tabla: PARTIDO
Contiene la programación y cabecera operativa de los encuentros deportivos cordinando los datos de selecciones y estadios.

| Columna | Tipo de Dato | Nulo | Restricción | Descripción |
|---|---|---|---|---|
| `id_partido` | NUMBER | NO | PK | Identificador único del partido. |
| `id_edicion` | NUMBER | NO | FK | Edición del torneo a la que corresponde (hacia `EDICION_MUNDIAL`). |
| `id_estadio` | NUMBER | NO | FK | Recinto deportivo donde se disputa (hacia `ESTADIO`). |
| `fecha_hora` | TIMESTAMP / DATE | NO | - | Fecha y hora programada para el inicio del partido. |
| `fase` | VARCHAR2(50) | NO | - | Etapa del torneo (ej. Grupos, Octavos, Final). |
| `asistencia_registrada` | NUMBER | SÍ | CHECK (`asistencia_registrada >= 0`) | Concurrencia real de público en el recinto. |

---

## 5. Tabla: PARTICIPACION_PARTIDO
Tabla asociativa que modela la relación N:M entre `PARTIDO` y `SELECCION`, registrando cuando o donde se genera u partido y de cada equipo por encuentro.

| Columna | Tipo de Dato | Nulo | Restricción | Descripción |
|---|---|---|---|---|
| `id_participacion` | NUMBER | NO | PK | Identificador único del registro de participación. |
| `id_partido` | NUMBER | NO | FK | Partido disputado (hacia `PARTIDO`). |
| `id_seleccion` | NUMBER | NO | FK | Selección que disputa el juego (hacia `SELECCION`). |
| `condicion` | VARCHAR2(20) | NO | CHECK (`condicion IN ('Local', 'Visitante')`) | Rol del equipo dentro del partido. |
| `goles_marcados` | NUMBER | NO | CHECK (`goles_marcados >= 0`) | Cantidad total de goles anotados por la selección en el partido. |
=======
# Diccionario de Datos

## 1. EDICION_MUNDIAL

| Campo | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_edicion | NUMBER(10) | PRIMARY KEY | Identificador único de la edición del Mundial. |
| anio | NUMBER(4) | NOT NULL | Año en que se realiza la edición. |
| pais_sede | VARCHAR2(100) | NOT NULL | País o países sede de la edición. |
| lema | VARCHAR2(150) | | Lema de la edición del Mundial. |
| fecha_inicio | DATE | NOT NULL | Fecha de inicio de la edición. |
| fecha_fin | DATE | NOT NULL | Fecha de finalización de la edición. |

---

## 2. ESTADIO

| Campo | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_estadio | NUMBER(10) | PRIMARY KEY | Identificador único del estadio. |
| id_edicion | NUMBER(10) | NOT NULL, FOREIGN KEY | Identifica la edición del Mundial a la que pertenece el estadio. |
| nombre | VARCHAR2(100) | NOT NULL | Nombre del estadio. |
| ciudad | VARCHAR2(100) | NOT NULL | Ciudad donde se encuentra el estadio. |
| capacidad | NUMBER(10) | NOT NULL, CHECK > 0 | Capacidad máxima registrada del estadio. |

**Clave foránea:**
- `fk_estadio_edicion`: relaciona `ESTADIO.id_edicion` con `EDICION_MUNDIAL.id_edicion`.

**Restricción:**
- `ck_estadio_capacidad`: la capacidad debe ser mayor que 0.

---

## 3. SELECCION

| Campo | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_seleccion | NUMBER(10) | PRIMARY KEY | Identificador único de la selección. |
| id_edicion | NUMBER(10) | NOT NULL, FOREIGN KEY | Edición del Mundial en la que participa la selección. |
| pais | VARCHAR2(100) | NOT NULL | País representado por la selección. |
| confederacion | VARCHAR2(100) | NOT NULL | Confederación a la que pertenece la selección. |
| grupo | CHAR(1) | | Grupo asignado a la selección. |

**Clave foránea:**
- `fk_seleccion_edicion`: relaciona `SELECCION.id_edicion` con `EDICION_MUNDIAL.id_edicion`.

---

## 4. PARTIDO

| Campo | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_partido | NUMBER(10) | PRIMARY KEY | Identificador único del partido. |
| id_edicion | NUMBER(10) | NOT NULL, FOREIGN KEY | Edición del Mundial a la que pertenece el partido. |
| id_estadio | NUMBER(10) | NOT NULL, FOREIGN KEY | Estadio donde se juega el partido. |
| fecha_hora | DATE | NOT NULL | Fecha y hora programada para el partido. |
| fase | VARCHAR2(30) | NOT NULL | Fase del Mundial en la que se disputa el partido. |
| asistencia_registrada | NUMBER(10) | NOT NULL, CHECK >= 0 | Cantidad de asistentes registrada para el partido. |

**Claves foráneas:**
- `fk_partido_edicion`: relaciona `PARTIDO.id_edicion` con `EDICION_MUNDIAL.id_edicion`.
- `fk_partido_estadio`: relaciona `PARTIDO.id_estadio` con `ESTADIO.id_estadio`.

**Restricción:**
- `ck_partido_asistencia`: la asistencia debe ser mayor o igual a 0.

---

## 5. PARTICIPACION_PARTIDO

| Campo | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_participacion | NUMBER(10) | PRIMARY KEY | Identificador único de la participación. |
| id_partido | NUMBER(10) | NOT NULL, FOREIGN KEY | Partido en el que participa la selección. |
| id_seleccion | NUMBER(10) | NOT NULL, FOREIGN KEY | Selección que participa en el partido. |
| condicion | VARCHAR2(20) | NOT NULL, CHECK | Indica si la selección es LOCAL o VISITANTE. |
| goles_marcados | NUMBER(3) | NOT NULL, CHECK >= 0 | Cantidad de goles marcados por la selección en el partido. |

**Claves foráneas:**
- `fk_participacion_partido`: relaciona `PARTICIPACION_PARTIDO.id_partido` con `PARTIDO.id_partido` y utiliza `ON DELETE CASCADE`.
- `fk_participacion_seleccion`: relaciona `PARTICIPACION_PARTIDO.id_seleccion` con `SELECCION.id_seleccion`.

**Restricciones:**
- `uq_partido_seleccion`: evita registrar dos veces la misma selección en un mismo partido.
- `ck_participacion_condicion`: solamente permite los valores `LOCAL` o `VISITANTE`.
- `ck_participacion_goles`: los goles marcados deben ser mayores o iguales a 0.

---

# Relaciones principales

- Una edición del Mundial puede tener varios estadios.
- Una edición del Mundial puede tener varias selecciones.
- Una edición del Mundial puede tener varios partidos.
- Un estadio puede estar asociado a varios partidos.
- Un partido puede tener participaciones de selecciones.
- Una selección puede aparecer en varias participaciones de partidos.
- La relación entre partidos y selecciones se maneja mediante `PARTICIPACION_PARTIDO`.

# Vista creada

## V_GOL﻿ES_SELECCION

La vista `v_goles_seleccion` resume el rendimiento de cada selección a partir de sus participaciones en partidos.

Incluye:

| Campo | Descripción |
|---|---|
| pais | País de la selección. |
| partidos_jugados | Cantidad de partidos registrados para la selección. |
| total_goles | Total de goles marcados por la selección. |
| promedio_goles | Promedio de goles marcados por partido. |

La vista utiliza `JOIN`, `COUNT`, `SUM`, `AVG`, `ROUND` y `GROUP BY`.

Esta vista posteriormente es utilizada en la consulta que identifica la selección que lidera cada grupo según el total de goles.

# Datos registrados

La base de datos contiene inicialmente:

- 1 edición del Mundial.
- 2 estadios.
- 4 selecciones.
- 2 partidos iniciales.
- 4 participaciones de selecciones.

Posteriormente se registra el partido 4 y sus dos participaciones para demostrar el ciclo de vida del partido y la actualización de los goles.
>>>>>>> 8bff91988fd9e6b28ee6176de3ccf1be7097666c

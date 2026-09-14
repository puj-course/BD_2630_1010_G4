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

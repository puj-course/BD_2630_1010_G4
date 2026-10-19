# Diccionario de Datos — Sistema de Información del Mundial FIFA

El presente diccionario de datos describe detalladamente las 16 tablas del modelo lógico, sus atributos, tipos de datos, restricciones de integridad referencial y reglas de negocio asociadas.

---

## 1. Tabla `EDICION_MUNDIAL`
Almacena la información institucional correspondiente a cada edición de la Copa Mundial de la FIFA.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_edicion` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la edición. |
| `anio` | `INT` | No | `UNIQUE`, `CHECK (anio >= 1930)` | Año oficial de celebración de la edición. |
| `lema` | `VARCHAR(150)` | Sí | — | Lema o eslogan oficial de la edición. |
| `fecha_inicio` | `DATE` | No | — | Fecha oficial de inauguración del torneo. |
| `fecha_fin` | `DATE` | No | `CHECK (fecha_fin >= fecha_inicio)` | Fecha oficial de clausura del torneo. |

---

## 2. Tabla `SEDE`
Registra los países anfitriones autorizados para albergar una edición del torneo.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_sede` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la sede. |
| `id_edicion` | `INT` | No | FK (`EDICION_MUNDIAL.id_edicion`) | Edición del torneo a la que pertenece la sede. |
| `pais` | `VARCHAR(100)` | No | — | Nombre del país anfitrión. |

- **Restricción UNIQUE:** `(id_edicion, pais)`

---

## 3. Tabla `CIUDAD`
Almacena las ciudades donde se ubican los estadios sedes del torneo.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_ciudad` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la ciudad. |
| `id_sede` | `INT` | No | FK (`SEDE.id_sede`) | Identificador de la sede a la que pertenece la ciudad. |
| `nombre` | `VARCHAR(100)` | No | — | Nombre de la ciudad. |

- **Restricción UNIQUE:** `(id_sede, nombre)`

---

## 4. Tabla `ESTADIO`
Registra las instalaciones deportivas oficiales donde se disputan los partidos.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_estadio` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único del estadio. |
| `id_ciudad` | `INT` | No | FK (`CIUDAD.id_ciudad`) | Ciudad geográfica en la que está ubicado el estadio. |
| `nombre` | `VARCHAR(100)` | No | — | Nombre oficial del estadio. |
| `capacidad` | `INT` | No | `CHECK (capacidad > 0)` | Capacidad máxima de espectadores permitida. |

- **Restricción UNIQUE:** `(id_ciudad, nombre)`

---

## 5. Tabla `FASE`
Almacena la estructura de fases competitivas que componen la edición.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_fase` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la fase. |
| `id_edicion` | `INT` | No | FK (`EDICION_MUNDIAL.id_edicion`) | Edición a la cual corresponde la fase. |
| `nombre` | `VARCHAR(50)` | No | — | Nombre de la fase (e.g., Fase de Grupos, Final). |
| `tipo` | `VARCHAR(30)` | No | `CHECK (tipo IN ('GRUPOS', 'ELIMINATORIA'))` | Categorización del tipo de fase. |

- **Restricción UNIQUE:** `(id_edicion, nombre)`

---

## 6. Tabla `GRUPO`
Contiene la clasificación de los grupos pertenecientes a la fase inicial.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_grupo` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único del grupo. |
| `id_edicion` | `INT` | No | FK (`EDICION_MUNDIAL.id_edicion`) | Edición de la Copa Mundial a la que corresponde el grupo. |
| `nombre` | `VARCHAR(20)` | No | — | Denominación del grupo (e.g., Grupo A, Grupo B). |

- **Restricción UNIQUE:** `(id_edicion, nombre)`

---

## 7. Tabla `FEDERACION`
Registra la entidad directiva nacional del fútbol asociada a una confederación.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_federacion` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la federación. |
| `nombre` | `VARCHAR(100)` | No | — | Nombre completo de la federación nacional. |
| `sigla` | `VARCHAR(10)` | No | `UNIQUE` | Acrónimo oficial de la federación. |
| `confederacion` | `VARCHAR(20)` | No | `CHECK (confederacion IN ('CONMEBOL', 'UEFA', 'CONCACAF', 'CAF', 'AFC', 'OFC'))` | Confederación internacional a la que está filiada. |

---

## 8. Tabla `SELECCION`
Registra los equipos nacionales participantes por cada edición.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_seleccion` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la selección participante. |
| `id_edicion` | `INT` | No | FK (`EDICION_MUNDIAL.id_edicion`) | Edición del mundial en la cual participa la selección. |
| `id_federacion` | `INT` | No | FK (`FEDERACION.id_federacion`) | Federación responsable de la selección. |
| `id_grupo` | `INT` | Sí | FK (`GRUPO.id_grupo`) | Grupo asignado para la fase inicial (si aplica). |
| `pais` | `VARCHAR(100)` | No | — | Nombre del país al que representa el equipo. |

- **Restricción UNIQUE:** `(id_edicion, pais)`

---

## 9. Tabla `JUGADOR`
Almacena el catálogo de futbolistas habilitados para ser convocados.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_jugador` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único del jugador. |
| `nombre` | `VARCHAR(100)` | No | — | Nombre completo del jugador. |
| `fecha_nacimiento` | `DATE` | No | — | Fecha de nacimiento registrada. |

---

## 10. Tabla `CONVOCATORIA_JUGADOR`
Asocia a un jugador con una selección en una edición particular.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_convocatoria` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único del registro de convocatoria. |
| `id_jugador` | `INT` | No | FK (`JUGADOR.id_jugador`) | Identificador del jugador convocado. |
| `id_seleccion` | `INT` | No | FK (`SELECCION.id_seleccion`) | Selección a la cual es convocado. |
| `dorsal` | `INT` | No | `CHECK (dorsal BETWEEN 1 AND 99)` | Número de camiseta asignado en el torneo. |
| `es_capitan` | `BOOLEAN` | No | `DEFAULT FALSE` | Indica si ostenta la capitanía del equipo. |

- **Restricción UNIQUE:** `(id_seleccion, dorsal)`

---

## 11. Tabla `PARTIDO`
Representa el encuentro deportivo disputado en el marco del torneo.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_partido` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único del partido. |
| `id_edicion` | `INT` | No | FK (`EDICION_MUNDIAL.id_edicion`) | Edición en la que se efectúa el encuentro. |
| `id_fase` | `INT` | No | FK (`FASE.id_fase`) | Fase en la que se programa el partido. |
| `id_estadio` | `INT` | No | FK (`ESTADIO.id_estadio`) | Estadio designado como sede del partido. |
| `fecha_hora` | `DATETIME` | No | — | Programación oficial de fecha y hora. |
| `asistencia_registrada` | `INT` | Sí | `CHECK (asistencia_registrada >= 0)` | Número de espectadores presentes en el encuentro. |

---

## 12. Tabla `PARTICIPACION_PARTIDO`
Detalla el desempeño y condición de las dos selecciones en un partido.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_participacion` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador de la participación. |
| `id_partido` | `INT` | No | FK (`PARTIDO.id_partido`) | Identificador del encuentro disputado. |
| `id_seleccion` | `INT` | No | FK (`SELECCION.id_seleccion`) | Selección participante. |
| `condicion` | `VARCHAR(10)` | No | `CHECK (condicion IN ('LOCAL', 'VISITANTE'))` | Condición táctica asignada. |
| `goles_marcados` | `INT` | No | `DEFAULT 0, CHECK (goles_marcados >= 0)` | Cantidad de goles oficiales anotados. |

- **Restricción UNIQUE:** `(id_partido, id_seleccion)`

---

## 13. Tabla `ARBITRO`
Almacena el registro oficial de los jueces y colegiados designados.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_arbitro` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único del árbitro. |
| `nombre` | `VARCHAR(100)` | No | — | Nombre completo del juez o colegiado. |
| `nacionalidad` | `VARCHAR(100)` | No | — | País de procedencia/federación de origen. |

---

## 14. Tabla `ASIGNACION_ARBITRAL`
Asigna los roles de arbitraje a los jueces para cada partido.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_asignacion` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador del registro de asignación. |
| `id_partido` | `INT` | No | FK (`PARTIDO.id_partido`) | Partido designado. |
| `id_arbitro` | `INT` | No | FK (`ARBITRO.id_arbitro`) | Árbitro designado. |
| `rol` | `VARCHAR(30)` | No | `CHECK (rol IN ('CENTRAL', 'ASISTENTE_1', 'ASISTENTE_2', 'CUARTO_ARBITRO', 'VAR', 'AVAR'))` | Rol específico desempeñado en el encuentro. |

- **Restricción UNIQUE:** `(id_partido, rol)`

---

## 15. Tabla `ESTADISTICA_JUGADOR_PARTIDO`
Consolida los eventos individuales cuantitativos de cada jugador por partido.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_estadistica` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador del registro estadístico. |
| `id_partido` | `INT` | No | FK (`PARTIDO.id_partido`) | Partido correspondiente. |
| `id_jugador` | `INT` | No | FK (`JUGADOR.id_jugador`) | Jugador que registra el desempeño. |
| `goles` | `INT` | No | `DEFAULT 0, CHECK (goles >= 0)` | Goles anotados en el partido. |
| `asistencias` | `INT` | No | `DEFAULT 0, CHECK (asistencias >= 0)` | Asistencias efectivas realizadas. |
| `tarjetas_amarillas` | `INT` | No | `DEFAULT 0, CHECK (tarjetas_amarillas BETWEEN 0 AND 2)` | Tarjetas amarillas mostradas. |
| `tarjetas_rojas` | `INT` | No | `DEFAULT 0, CHECK (tarjetas_rojas BETWEEN 0 AND 1)` | Tarjetas rojas mostradas. |
| `tiros` | `INT` | No | `DEFAULT 0, CHECK (tiros >= 0)` | Remates totales ejecutados. |
| `minutos_jugados` | `INT` | No | `DEFAULT 0, CHECK (minutos_jugados BETWEEN 0 AND 130)` | Minutos en cancha disputados. |

- **Restricción UNIQUE:** `(id_partido, id_jugador)`

---

## 16. Tabla `INCIDENCIA`
Registra novedades y eventualidades ocurridas durante un encuentro.

| Atributo | Tipo de Dato | Nulo | Restricción / Clave | Descripción |
|---|---|---|---|---|
| `id_incidencia` | `INT` | No | PK, `AUTO_INCREMENT` | Identificador único de la incidencia. |
| `id_partido` | `INT` | No | FK (`PARTIDO.id_partido`) | Encuentro en el que se produjo la eventualidad. |
| `tipo` | `VARCHAR(50)` | No | — | Categoría de la incidencia (e.g., Clima, VAR, Invasión). |
| `descripcion` | `TEXT` | Sí | — | Detalle explicativo de la eventualidad. |
| `minuto` | `INT` | Sí | `CHECK (minuto >= 0)` | Minuto del encuentro en que aconteció el suceso. |
# Modelo Lógico — Base de Datos del Mundial

## 1. Introducción

El modelo lógico de la base de datos tiene como objetivo representar la estructura de información necesaria para gestionar diferentes ediciones de un torneo mundial de fútbol.

El modelo parte de las entidades principales relacionadas con:

- Organización del torneo.
- Países y ciudades sede.
- Estadios.
- Fases y grupos de competición.
- Federaciones y selecciones.
- Jugadores y convocatorias.
- Partidos y participación de las selecciones.
- Árbitros y asignaciones arbitrales.
- Estadísticas de jugadores.
- Incidencias ocurridas durante los partidos.

El diseño busca mantener la información organizada y evitar la duplicación innecesaria de datos, utilizando claves primarias, claves foráneas, restricciones `UNIQUE` y relaciones entre las entidades.

---

# 2. Estructura general del modelo

El modelo lógico está compuesto por **16 tablas**:

1. `EDICION_MUNDIAL`
2. `SEDE`
3. `CIUDAD`
4. `ESTADIO`
5. `FASE`
6. `GRUPO`
7. `FEDERACION`
8. `SELECCION`
9. `JUGADOR`
10. `CONVOCATORIA_JUGADOR`
11. `PARTIDO`
12. `PARTICIPACION_PARTIDO`
13. `ARBITRO`
14. `ASIGNACION_ARBITRAL`
15. `ESTADISTICA_JUGADOR_PARTIDO`
16. `INCIDENCIA`

---

# 3. Nuevas tablas incorporadas

El modelo inicial contaba con las entidades básicas para representar una edición, selecciones, estadios y partidos.

Para cumplir con los requerimientos del sistema se incorporaron nuevas entidades que permiten representar con mayor detalle la organización y el desarrollo del torneo.

## 3.1. SEDE

Representa los países que participan como sedes de una determinada edición del Mundial.

Una edición puede tener una o varias sedes.

**Clave primaria:**
- `id_sede`

**Clave foránea:**
- `id_edicion`

**Restricción UNIQUE:**
- `(id_edicion, pais)`

---

## 3.2. CIUDAD

Representa las ciudades pertenecientes a una sede y permite organizar los estadios de acuerdo con su ubicación.

**Clave primaria:**
- `id_ciudad`

**Clave foránea:**
- `id_sede`

**Restricción UNIQUE:**
- `(id_sede, nombre)`

---

## 3.3. FASE

Representa las diferentes fases de una edición del torneo.

Ejemplos:

- Fase de grupos
- Octavos de final
- Cuartos de final
- Semifinal
- Tercer puesto
- Final

**Clave primaria:**
- `id_fase`

**Clave foránea:**
- `id_edicion`

**Restricción UNIQUE:**
- `(id_edicion, nombre)`

---

## 3.4. GRUPO

Representa los grupos correspondientes a la fase de grupos de una edición.

Ejemplos:

- Grupo A
- Grupo B
- Grupo C
- Grupo D

**Clave primaria:**
- `id_grupo`

**Clave foránea:**
- `id_edicion`

**Restricción UNIQUE:**
- `(id_edicion, nombre)`

---

## 3.5. FEDERACION

Representa la federación nacional a la que pertenece una selección.

También permite asociar la federación con su respectiva confederación.

**Clave primaria:**
- `id_federacion`

**Restricción UNIQUE:**
- `sigla`

---

## 3.6. JUGADOR

Representa a los jugadores que pueden participar en diferentes ediciones del torneo.

La información del jugador se mantiene separada de su convocatoria, ya que un mismo jugador puede participar en diferentes ediciones.

**Clave primaria:**
- `id_jugador`

---

## 3.7. CONVOCATORIA_JUGADOR

Representa la convocatoria de un jugador para una selección en una determinada edición.

Esta tabla permite registrar información específica de la participación del jugador, como:

- Número de camiseta.
- Si es capitán.

La relación entre `JUGADOR` y `SELECCION` es de muchos a muchos, por lo que se utiliza esta tabla intermedia.

**Clave primaria propuesta:**
- `id_jugador`
- `id_seleccion`

**Restricción UNIQUE:**
- `(id_jugador, id_seleccion)`

---

## 3.8. ARBITRO

Representa los árbitros que pueden ser asignados a los diferentes partidos.

**Clave primaria:**
- `id_arbitro`

---

## 3.9. ASIGNACION_ARBITRAL

Representa la asignación de árbitros a los partidos y permite indicar el rol que desempeña cada árbitro.

Los roles contemplados incluyen:

- Central.
- Asistente 1.
- Asistente 2.
- Cuarto árbitro.
- VAR.
- AVAR.

La relación entre `ARBITRO` y `PARTIDO` es de muchos a muchos, por lo que se utiliza esta tabla intermedia.

**Clave primaria propuesta:**
- `id_partido`
- `id_arbitro`

**Restricción UNIQUE:**
- `(id_partido, rol)`

---

## 3.10. ESTADISTICA_JUGADOR_PARTIDO

Permite registrar las estadísticas individuales de un jugador durante un partido.

Entre los datos registrados se encuentran:

- Goles.
- Asistencias.
- Tarjetas amarillas.
- Tarjetas rojas.
- Tiros.
- Minutos jugados.

La relación entre `JUGADOR` y `PARTIDO` es de muchos a muchos, por lo que esta tabla funciona como entidad intermedia.

**Clave primaria:**
- `id_estadistica`

**Restricción UNIQUE:**
- `(id_partido, id_jugador)`

---

## 3.11. INCIDENCIA

Representa situaciones particulares ocurridas durante un partido.

Algunos ejemplos son:

- Condiciones climáticas.
- Invasión de campo.
- Suspensión temporal.
- Revisión prolongada del VAR.

**Clave primaria:**
- `id_incidencia`

**Clave foránea:**
- `id_partido`

---

# 4. Tablas principales del modelo

Además de las nuevas entidades, se mantienen las tablas principales del modelo inicial.

## 4.1. EDICION_MUNDIAL

Representa una edición específica del Mundial.

Contiene información general como:

- Identificador de la edición.
- Año.
- Lema.
- Fecha de inicio.
- Fecha de finalización.

**PK:** `id_edicion`

**UNIQUE:** `anio`

---

## 4.2. SELECCION

Representa una selección participante en una edición determinada.

Una selección está relacionada con:

- Una edición.
- Una federación.
- Opcionalmente, un grupo.

**PK:** `id_seleccion`

**FK:**
- `id_edicion`
- `id_federacion`
- `id_grupo`

**UNIQUE:**
- `(id_edicion, pais)`

---

## 4.3. ESTADIO

Representa los estadios utilizados durante el torneo.

Cada estadio pertenece a una ciudad.

**PK:** `id_estadio`

**FK:**
- `id_ciudad`

**UNIQUE:**
- `(id_ciudad, nombre)`

---

## 4.4. PARTIDO

Representa un partido disputado durante una edición del torneo.

Cada partido está asociado con:

- Una edición.
- Una fase.
- Un estadio.

También almacena la fecha y hora y la asistencia registrada.

**PK:** `id_partido`

**FK:**
- `id_edicion`
- `id_fase`
- `id_estadio`

---

## 4.5. PARTICIPACION_PARTIDO

Representa la participación de una selección en un partido.

Permite almacenar:

- Selección.
- Partido.
- Condición: local o visitante.
- Goles marcados.

Esta tabla permite representar la relación de muchos a muchos entre `PARTIDO` y `SELECCION`.

**PK propuesta:**
- `id_partido`
- `id_seleccion`

**UNIQUE:**
- `(id_partido, id_seleccion)`

---

# 5. Relaciones del modelo

Las principales relaciones entre las tablas son las siguientes:

| Tabla origen | Tabla destino | Cardinalidad |
|---|---|---|
| `EDICION_MUNDIAL` | `SEDE` | 1:N |
| `SEDE` | `CIUDAD` | 1:N |
| `CIUDAD` | `ESTADIO` | 1:N |
| `EDICION_MUNDIAL` | `FASE` | 1:N |
| `EDICION_MUNDIAL` | `GRUPO` | 1:N |
| `FEDERACION` | `SELECCION` | 1:N |
| `EDICION_MUNDIAL` | `SELECCION` | 1:N |
| `GRUPO` | `SELECCION` | 1:N |
| `EDICION_MUNDIAL` | `PARTIDO` | 1:N |
| `FASE` | `PARTIDO` | 1:N |
| `ESTADIO` | `PARTIDO` | 1:N |
| `PARTIDO` | `PARTICIPACION_PARTIDO` | 1:N |
| `SELECCION` | `PARTICIPACION_PARTIDO` | 1:N |
| `JUGADOR` | `CONVOCATORIA_JUGADOR` | 1:N |
| `SELECCION` | `CONVOCATORIA_JUGADOR` | 1:N |
| `PARTIDO` | `ASIGNACION_ARBITRAL` | 1:N |
| `ARBITRO` | `ASIGNACION_ARBITRAL` | 1:N |
| `PARTIDO` | `ESTADISTICA_JUGADOR_PARTIDO` | 1:N |
| `JUGADOR` | `ESTADISTICA_JUGADOR_PARTIDO` | 1:N |
| `PARTIDO` | `INCIDENCIA` | 1:N |

---

# 6. Relaciones muchos a muchos

Para evitar relaciones N:M directas, se utilizan entidades intermedias.

## 6.1. SELECCION — PARTIDO

Una selección puede jugar muchos partidos y un partido involucra varias selecciones.

Se resuelve mediante:

`PARTICIPACION_PARTIDO`

```text
SELECCION 1:N PARTICIPACION_PARTIDO N:1 PARTIDO
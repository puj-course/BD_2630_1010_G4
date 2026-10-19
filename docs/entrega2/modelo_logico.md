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

## 2. Estructura general del modelo

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

## 3. Nuevas tablas incorporadas

El modelo inicial contaba únicamente con las entidades básicas para representar una edición, selecciones, estadios y partidos. Para cumplir con los requerimientos integrales del sistema se incorporaron entidades adicionales que permiten detallar de manera exhaustiva la organización y el desarrollo operativo de la competición.

### 3.1. SEDE

Representa los países que participan como sedes de una determinada edición del Mundial. Una edición puede contar con una o múltiples sedes compartidas.

- **Clave primaria:** `id_sede`
- **Clave foránea:** `id_edicion`
- **Restricción UNIQUE:** `(id_edicion, pais)`

---

### 3.2. CIUDAD

Representa las ciudades pertenecientes a una sede y permite organizar los estadios de acuerdo con su ubicación geográfica exacta.

- **Clave primaria:** `id_ciudad`
- **Clave foránea:** `id_sede`
- **Restricción UNIQUE:** `(id_sede, nombre)`

---

### 3.3. FASE

Representa las diferentes etapas competitivas de una edición del torneo (por ejemplo: Fase de grupos, Octavos de final, Cuartos de final, Semifinal, Tercer puesto, Final).

- **Clave primaria:** `id_fase`
- **Clave foránea:** `id_edicion`
- **Restricción UNIQUE:** `(id_edicion, nombre)`

---

### 3.4. GRUPO

Representa los grupos pertenecientes a la fase inicial de una edición (por ejemplo: Grupo A, Grupo B, Grupo C, Grupo D).

- **Clave primaria:** `id_grupo`
- **Clave foránea:** `id_edicion`
- **Restricción UNIQUE:** `(id_edicion, nombre)`

---

### 3.5. FEDERACION

Representa la federación nacional a la que pertenece una selección y consolida la relación organizativa con su respectiva confederación continental.

- **Clave primaria:** `id_federacion`
- **Restricción UNIQUE:** `sigla`

---

### 3.6. JUGADOR

Representa a los futbolistas habilitados para competir. La información histórica del jugador se mantiene desacoplada de la convocatoria específica, permitiendo registrar su participación en múltiples ediciones a lo largo de su carrera.

- **Clave primaria:** `id_jugador`

---

### 3.7. CONVOCATORIA_JUGADOR

Representa el registro oficial de un jugador convocado por una selección para una edición específica del torneo. Permite gestionar datos propios del torneo como el número de camiseta asignado y el rol de capitán.

- **Clave primaria:** `id_convocatoria`
- **Claves foráneas:** `id_jugador`, `id_seleccion`
- **Restricción UNIQUE:** `(id_seleccion, dorsal)`

---

### 3.8. ARBITRO

Representa a los jueces y oficiales de juzgamiento habilitados por la FIFA para dirigir partidos en el torneo.

- **Clave primaria:** `id_arbitro`

---

### 3.9. ASIGNACION_ARBITRAL

Representa la designación oficial de los árbitros en cada encuentro e identifica el rol específico asignado en la ternas u oficiales de juzgamiento (Central, Asistente 1, Asistente 2, Cuarto árbitro, VAR, AVAR).

- **Clave primaria:** `id_asignacion`
- **Claves foráneas:** `id_partido`, `id_arbitro`
- **Restricción UNIQUE:** `(id_partido, rol)`

---

### 3.10. ESTADISTICA_JUGADOR_PARTIDO

Permite registrar las métricas individuales de rendimiento de un jugador durante un partido determinado (goles, asistencias, tarjetas amarillas, tarjetas rojas, tiros al arco y minutos disputados).

- **Clave primaria:** `id_estadistica`
- **Claves foráneas:** `id_partido`, `id_jugador`
- **Restricción UNIQUE:** `(id_partido, id_jugador)`

---

### 3.11. INCIDENCIA

Permite documentar eventos e incidencias extraordinarias reportadas en el transcurso de un encuentro (condiciones climáticas adversas, invasión de campo, suspensiones temporales, revisiones de VAR, entre otras).

- **Clave primaria:** `id_incidencia`
- **Clave foránea:** `id_partido`

---

## 4. Tablas principales del modelo

### 4.1. EDICION_MUNDIAL

Entidad principal que almacena los datos institucionales y temporales de una edición específica del torneo Mundial.

- **Clave primaria:** `id_edicion`
- **Restricción UNIQUE:** `anio`

---

### 4.2. SELECCION

Representa a cada equipo nacional participante dentro de una edición determinada. Garantiza la vinculación con su federación de origen y su asignación a un grupo durante la fase inicial.

- **Clave primaria:** `id_seleccion`
- **Claves foráneas:** `id_edicion`, `id_federacion`, `id_grupo`
- **Restricción UNIQUE:** `(id_edicion, pais)`

---

### 4.3. ESTADIO

Almacena la infraestructura física en la que se disputan los partidos, asociando cada recinto a su respectiva ciudad sede.

- **Clave primaria:** `id_estadio`
- **Clave foránea:** `id_ciudad`
- **Restricción UNIQUE:** `(id_ciudad, nombre)`

---

### 4.4. PARTIDO

Representa la unidad básica de competición deportiva. Vincula la edición, fase, estadio, fecha, hora y datos de asistencia del público.

- **Clave primaria:** `id_partido`
- **Claves foráneas:** `id_edicion`, `id_fase`, `id_estadio`

---

### 4.5. PARTICIPACION_PARTIDO

Representa la condición de competencia de cada selección en un partido determinado, registrando el rol táctico (local o visitante) y los goles acumulados al cierre del encuentro.

- **Clave primaria:** `id_participacion`
- **Claves foráneas:** `id_partido`, `id_seleccion`
- **Restricción UNIQUE:** `(id_partido, id_seleccion)`

---

## 5. Matriz de Relaciones del Modelo

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

## 6. Resolucion de Relaciones Muchos a Muchos

Para preservar la Tercera Forma Normal (3FN) y asegurar la integridad referencial, las relaciones muchos a muchos se implementan mediante tablas asociativas con llaves primarias subrogadas y restricciones `UNIQUE` compuestas:

### 6.1. SELECCION — PARTIDO
Resuelto mediante `PARTICIPACION_PARTIDO`.
`SELECCION (1:N) ➔ PARTICIPACION_PARTIDO (N:1) ➔ PARTIDO`

### 6.2. JUGADOR — SELECCION
Resuelto mediante `CONVOCATORIA_JUGADOR`.
`JUGADOR (1:N) ➔ CONVOCATORIA_JUGADOR (N:1) ➔ SELECCION`

### 6.3. ARBITRO — PARTIDO
Resuelto mediante `ASIGNACION_ARBITRAL`.
`ARBITRO (1:N) ➔ ASIGNACION_ARBITRAL (N:1) ➔ PARTIDO`

### 6.4. JUGADOR — PARTIDO
Resuelto mediante `ESTADISTICA_JUGADOR_PARTIDO`.
`JUGADOR (1:N) ➔ ESTADISTICA_JUGADOR_PARTIDO (N:1) ➔ PARTIDO`
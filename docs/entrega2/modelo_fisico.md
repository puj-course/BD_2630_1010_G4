# Modelo Fisico — Base de Datos del Mundial

## 1. Introduccion

el modelo fisico documenta como se implementa el modelo logico en Oracle incluyendo tipos de datos indices y otras estructuras para garantizar el rendimiento se mantiene la misma estructura de 16 tablas definida en el modelo logico

---

## 2. Estructura general del modelo fisico

el modelo fisico esta compuesto por **16 tablas**:

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

## 3. Tipos de datos por tabla

### 3.1. EDICION_MUNDIAL

| atributo | tipo | justificacion |
|---|---|---|
| id_edicion | NUMBER(10) | PK suficiente para el rango de ediciones |
| anio | NUMBER(4) | UNIQUE rango suficiente para años |
| lema | VARCHAR2(200) | texto variable para el lema del torneo |
| fecha_inicio | DATE | fecha de inicio del torneo |
| fecha_fin | DATE | fecha de finalizacion del torneo |

### 3.2. SEDE

| atributo | tipo | justificacion |
|---|---|---|
| id_sede | NUMBER(10) | PK |
| id_edicion | NUMBER(10) | FK a EDICION_MUNDIAL |
| pais | VARCHAR2(100) | UNIQUE (id_edicion, pais), nombre del pais sede |

### 3.3. CIUDAD

| atributo | tipo | justificacion |
|---|---|---|
| id_ciudad | NUMBER(10) | PK |
| id_sede | NUMBER(10) | FK a SEDE |
| nombre | VARCHAR2(100) | UNIQUE (id_sede, nombre), nombre de la ciudad  |

### 3.4. ESTADIO

| atributo | tipo | justificacion |
|---|---|---|
| id_estadio | NUMBER(10) | PK |
| id_ciudad | NUMBER(10) | FK a CIUDAD |
| nombre | VARCHAR2(150) | UNIQUE (id_ciudad, nombre) nombre del estadio |
| capacidad | NUMBER(10) | CHECK > 0 |

### 3.5. FASE

| atributo | tipo | justificacion |
|---|---|---|
| id_fase | NUMBER(10) | PK |
| id_edicion | NUMBER(10) | FK a EDICION_MUNDIAL |
| nombre | VARCHAR2(100) | UNIQUE (id_edicion, nombre), nombre de la fase |

### 3.6. GRUPO

| atributo | tipo | justificacion |
|---|---|---|
| id_grupo | NUMBER(10) | PK |
| id_edicion | NUMBER(10) | FK a EDICION_MUNDIAL |
| nombre | VARCHAR2(50) | UNIQUE (id_edicion, nombre), nombre del grupo |

### 3.7. FEDERACION

| atributo | tipo | justificacion |
|---|---|---|
| id_federacion | NUMBER(10) | PK |
| nombre | VARCHAR2(150) | nombre de la federacion |
| sigla | VARCHAR2(10) | sigla unica |
| confederacion | VARCHAR2(100) | confederacion a la que pertenece |

### 3.8. SELECCION

| atributo | tipo | justificacion |
|---|---|---|
| id_seleccion | NUMBER(10) | PK |
| id_edicion | NUMBER(10) | FK a EDICION_MUNDIAL |
| id_federacion | NUMBER(10) | FK a FEDERACION |
| id_grupo | NUMBER(10) | FK a GRUPO (nullable) |
| pais | VARCHAR2(100) | UNIQUE (id_edicion, pais) |

### 3.9. JUGADOR

| atributo | tipo | justificacion |
|---|---|---|
| id_jugador | NUMBER(10) | PK |
| nombre | VARCHAR2(150) | nombre completo |
| fecha_nacimiento | DATE | para calcular edad |

### 3.10. CONVOCATORIA_JUGADOR

| atributo | tipo | justificacion |
|---|---|---|
| id_jugador | NUMBER(10) | PK, FK a JUGADOR. |
| id_seleccion | NUMBER(10) | PK, FK a SELECCION |
| dorsal | NUMBER(2) | numero de camiseta. |
| es_capitan | VARCHAR2(2) | 'SI' o 'NO'. |

### 3.11. PARTIDO

| atributo | tipo | justificacion |
|---|---|---|
| id_partido | NUMBER(10) | PK |
| id_edicion | NUMBER(10) | FK a EDICION_MUNDIAL |
| id_fase | NUMBER(10) | FK a FASE |
| id_estadio | NUMBER(10) | FK a ESTADIO |
| fecha_hora | DATE | fecha y hora del partido |
| asistencia_registrada | NUMBER(10) | CHECK >= 0 |

### 3.12. PARTICIPACION_PARTIDO

| atributo | tipo | justificacion |
|---|---|---|
| id_partido | NUMBER(10) | PK, FK a PARTIDO |
| id_seleccion | NUMBER(10) | PK, FK a SELECCION |
| condicion | VARCHAR2(20) | CHECK in ('LOCAL', 'VISITANTE') |
| goles_marcados | NUMBER(3) | CHECK >= 0 |

### 3.13. ARBITRO

| atributo | tipo | justificacion |
|---|---|---|
| id_arbitro | NUMBER(10) | PK |
| nombre | VARCHAR2(150) | nombre completo |
| nacionalidad | VARCHAR2(100) | nacionalidad del arbitro |

### 3.14. ASIGNACION_ARBITRAL

| atributo | tipo | justificacion |
|---|---|---|
| id_partido | NUMBER(10) | PK, FK a PARTIDO |
| id_arbitro | NUMBER(10) | PK, FK a ARBITRO |
| rol | VARCHAR2(30) | UNIQUE (id_partido, rol), rol del arbitro  |

### 3.15. ESTADISTICA_JUGADOR_PARTIDO

| atributo | tipo | justificacion |
|---|---|---|
| id_estadistica | NUMBER(10) | PK |
| id_partido | NUMBER(10) | FK a PARTIDO |
| id_jugador | NUMBER(10) | FK a JUGADOR |
| goles | NUMBER(3) | CHECK >= 0 |
| asistencias | NUMBER(3) | CHECK >= 0 |
| tarjetas_amarillas | NUMBER(2) | CHECK >= 0 |
| tarjetas_rojas | NUMBER(2) | CHECK >= 0 |
| tiros | NUMBER(3) | CHECK >= 0 |
| minutos_jugados | NUMBER(3) | CHECK between 0 and 120 |

### 3.16. INCIDENCIA

| atributo | tipo | justificacion |
|---|---|---|
| id_incidencia | NUMBER(10) | PK |
| id_partido | NUMBER(10) | FK a PARTIDO |
| tipo | VARCHAR2(100) | tipo de incidencia |
| descripcion | VARCHAR2(500) | descripcion del evento |
| minuto | NUMBER(3) | CHECK >= 0 |

---

## 4. Indices Estrategicos

oracle no crea indices automaticamente en las FK, se crean para acelerar los JOIN y evitar bloqueos al actualizar la tabla padre

| Nombre del Indice | Tabla | Columna | Justificacion |
|---|---|---|---|
| idx_sede_edicion | SEDE | id_edicion | acelera JOIN con EDICION_MUNDIAL |
| idx_ciudad_sede | CIUDAD | id_sede | acelera JOIN con SEDE |
| idx_estadio_ciudad | ESTADIO | id_ciudad | acelera JOIN con CIUDAD |
| idx_fase_edicion | FASE | id_edicion | acelera JOIN con EDICION_MUNDIAL |
| idx_grupo_edicion | GRUPO | id_edicion | acelera JOIN con EDICION_MUNDIAL |
| idx_seleccion_edicion | SELECCION | id_edicion | acelera JOIN con EDICION_MUNDIAL |
| idx_seleccion_federacion | SELECCION | id_federacion | acelera JOIN con FEDERACION |
| idx_seleccion_grupo | SELECCION | id_grupo | acelera JOIN con GRUPO |
| idx_convocatoria_jugador | CONVOCATORIA_JUGADOR | id_jugador | acelera JOIN con JUGADOR |
| idx_convocatoria_seleccion | CONVOCATORIA_JUGADOR | id_seleccion | acelera JOIN con SELECCION |
| idx_partido_edicion | PARTIDO | id_edicion | acelera JOIN con EDICION_MUNDIAL |
| idx_partido_fase | PARTIDO | id_fase | acelera JOIN con FASE |
| idx_partido_estadio | PARTIDO | id_estadio | acelera JOIN con ESTADIO |
| idx_participacion_partido | PARTICIPACION_PARTIDO | id_partido | acelera JOIN con PARTIDO |
| idx_participacion_seleccion | PARTICIPACION_PARTIDO | id_seleccion | acelera JOIN con SELECCION |
| idx_asignacion_arbitro | ASIGNACION_ARBITRAL | id_arbitro | acelera JOIN con ARBITRO |
| idx_asignacion_partido | ASIGNACION_ARBITRAL | id_partido | acelera JOIN con PARTIDO |
| idx_estadistica_partido | ESTADISTICA_JUGADOR_PARTIDO | id_partido | acelera JOIN con PARTIDO |
| idx_estadistica_jugador | ESTADISTICA_JUGADOR_PARTIDO | id_jugador | acelera JOIN con JUGADOR |
| idx_incidencia_partido | INCIDENCIA | id_partido | acelera JOIN con PARTIDO |

---

## 5. Consideraciones de Rendimiento

- **PK:** oracle crea automaticamente un indice unico para cada PK
- **UNIQUE:** las restricciones UNIQUE tambien crean un indice unico automaticamente
- **FK:** los indices en FK evitan bloqueos de tabla y mejoran el rendimiento de los JOIN
- **Coste:** los indices aceleran SELECT pero ralentizan INSERT/UPDATE/DELETE por eso solo se crean los justificados

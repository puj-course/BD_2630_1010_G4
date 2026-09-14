# Evaluación Crítica del Modelo Inicial y Propuesta de Ampliación

## 1. Problemas Identificados en el Modelo Inicial

Tras contrastar el esquema relacional de 5 tablas con los flujos reales de una Copa Mundial de la FIFA, se identificaron las siguientes limitaciones estructurales:

1. **Redundancia y riesgo de desincronización entre Partido, Estadio y Edición:**  
   La tabla `PARTIDO` posee claves foráneas directas hacia `EDICION_MUNDIAL` (`id_edicion`) y hacia `ESTADIO` (`id_estadio`), mientras que `ESTADIO` ya está vinculado a `EDICION_MUNDIAL`. Esta doble vía genera una redundancia estructural que abre la puerta a inconsistencias graves: a nivel de motor, es posible registrar un partido asignado a una edición con un estadio perteneciente a otra edición distinta.

2. **Falta de detalle sobre los actores principales (Jugadores y Árbitros):**  
   El modelo actual es estrictamente institucional y de infraestructura (selecciones y estadios). Carece por completo de la representación de las personas que hacen posible el evento: no existen registros de la plantilla de jugadores convocados ni de la terna arbitral encargada de impartir justicia en cada juego.

3. **Inexistencia de desglose temporal y eventos del juego:**  
   El desarrollo deportivo se reduce a un único número estático (`goles_marcados` en `PARTICIPACION_PARTIDO`). El modelo no permite registrar el momento en que ocurren las anotaciones ni discriminar cómo transcurrió el encuentro (por ejemplo, primer tiempo frente a segundo tiempo o tiempos extra).

4. **Incapacidad del esquema para restringir la cardinalidad exacta de un partido:**  
   La tabla asociativa `PARTICIPACION_PARTIDO` resuelve técnicamente la relación N:M entre `PARTIDO` y `SELECCION`. Sin embargo, a nivel de esquema relacional no restringe la cantidad de participantes: la base de datos permite registrar 1, 3 o más selecciones en un mismo encuentro, dependiendo exclusivamente de que la aplicación cliente no cometa ese error.

5. **Riesgo de colisión de horarios en una misma sede:**  
   El modelo permite programar múltiples partidos en el mismo estadio con la misma fecha y hora, ya que no existe una regla de unicidad o exclusión que valide la disponibilidad física de la cancha.

---

## 2. Ajustes Propuestos y su Justificación

Para resolver estas deficiencias de cara a las siguientes fases del proyecto, se proponen los siguientes ajustes:

* **Incorporación de plantillas (`JUGADOR` y `CONVOCATORIA`):**  
  Permitirá registrar a los futbolistas y asociarlos a su respectiva selección para el torneo, sentando las bases para estadísticas individuales (como tablas de goleo reales).
* **Incorporación de colegiados (`ARBITRO` y `DESIGNACION_ARBITRAL`):**  
  Permitirá registrar a los jueces oficiales y vincularlos a los encuentros en los que participan con roles específicos (árbitro central, asistentes, cuarto árbitro).
* **Desglose de tiempos y registro de incidencias básicas (`TIEMPO_JUEGO` e `INCIDENCIA`):**  
  En lugar de registrar marcas de minutos complejas, se propone dividir el partido en sus segmentos reglamentarios (primer tiempo, segundo tiempo, tiempo extra) y asociar allí los eventos elementales (goles y tarjetas vinculados al jugador y al tiempo correspondiente).
* **Corrección de redundancia en `PARTIDO`:**  
  Evaluar la eliminación de `id_edicion` dentro de `PARTIDO`, derivando la edición directamente a través del `ESTADIO` asignado para evitar inconsistencias de calendario.
* **Control estricto de dos contendientes y horarios:**  
  Establecer mecanismos (mediante restricciones avanzadas o triggers en fases posteriores) que fuercen que cada partido tenga exactamente dos registros en `PARTICIPACION_PARTIDO` (local y visitante) y que impidan solapar horarios en un mismo recinto.

---

## 3. Boceto Conceptual del Modelo Ampliado

El diagrama visual de esta propuesta se encuentra disponible en:  
`docs/entrega1/boceto_modelo_ampliado.png`

### Estructura y Conexiones en Base al Modelo Actual

Las 5 entidades base se conservan y actúan como núcleo del sistema, conectándose con los nuevos componentes de la siguiente manera:

1. **Núcleo de Participantes:**
   * `SELECCION` (1) $\rightarrow$ (N) `JUGADOR`: Una selección registra su lista de futbolistas.
2. **Núcleo de Control y Arbitraje:**
   * `ARBITRO`: Entidad independiente que registra los jueces del torneo.
   * `PARTIDO` (1) $\rightarrow$ (N) `DESIGNACION_ARBITRAL` (N) $\leftarrow$ (1) `ARBITRO`: Tabla asociativa que permite asignar la terna arbitral a un partido específico con su respectivo rol.
3. **Núcleo de Desarrollo del Encuentro:**
   * `PARTIDO` (1) $\rightarrow$ (N) `TIEMPO_JUEGO`: Divide cada partido en sus lapsos oficiales (ej. Primer Tiempo, Segundo Tiempo).
   * `TIEMPO_JUEGO` (1) $\rightarrow$ (N) `INCIDENCIA`: Registra los sucesos ocurridos en cada tiempo.
   * `JUGADOR` (1) $\rightarrow$ (N) `INCIDENCIA`: Vincula al futbolista causante del evento (gol o tarjeta).
   * `PARTICIPACION_PARTIDO` (1) $\rightarrow$ (N) `INCIDENCIA`: Asocia el evento a la selección correspondiente en dicho encuentro.

### Listado Breve de Nuevas Entidades Anticipadas

* **`JUGADOR`**: Futbolistas registrados en el torneo.
* **`ARBITRO`**: Jueces deportivos oficiales disponibles para el certamen.
* **`DESIGNACION_ARBITRAL`**: Asignación de árbitros a un partido específico.
* **`TIEMPO_JUEGO`**: Segmentos oficiales de duración de cada encuentro (1T, 2T, TE).
* **`INCIDENCIA`**: Sucesos elementales del juego (goles y tarjetas) vinculados al tiempo y al jugador.

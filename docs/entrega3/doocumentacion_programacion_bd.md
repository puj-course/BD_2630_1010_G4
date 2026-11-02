# Documentación de Programacion en Base de Datos

este documento detalla el proposito, los parametros y el comportamiento esperado de las funciones, procedimientos almacenados y triggers implementados para la logica del negocio del Mundial


## 1. Funciones

las funciones fueron creadas para encapsular calculos recurrentes y validaciones logicas retornando un valor unico

| Nombre de la función | proposito | Parametros de entrada | Comportamiento / retorno |
| :--- | :--- | :--- | :--- |
| `fn_diferencia_gol_seleccion` | calcular la diferencia de gol total de una seleccion a lo largo del torneo | `p_id_seleccion` (NUMBER) | retorna un `NUMBER` con la diferencia (goles a favor - goles en contra) Si hay error retorna 0 |
| `fn_validar_cupo_convocatoria` | verificar si una seleccion tiene cupo disponible para convocar mas jugadores | `p_id_seleccion` (NUMBER) `p_limite_maximo` (NUMBER, por defecto 26) | retorna `'SI'` si hay cupo disponible o `'NO'` si ya se alcanzo el límite |
| `fn_verificar_dorsal_disponible` | verificar si un numero de camiseta está libre en una seleccion | `p_id_seleccion` (NUMBER) `p_dorsal` (NUMBER `p_id_jugador` (NUMBER opcional) | retorna `'VALIDO'` si el dorsal está libre o `'OCUPADO'` si otro jugador ya lo tiene |


## 2. Procedimientos Almacenados

los procedimientos se utilizan para ejecutar transacciones complejas de modificación de datos en bloque

| Nombre del procedimiento | Proposito | Parametros de entrada | Comportamiento esperado |
| :--- | :--- | :--- | :--- |
| `cargar_resultados_masivos` | insertar o actualizar los marcadores de multiples partidos simultaneamente | `p_ids_partidos`, `p_goles_locales`, `p_goles_visitantes` (Listas `SYS.ODCINUMBERLIST`) | valida que las listas tengan el mismo tamaño, que no haya goles negativos y que cada partido tenga un local y un visitante, si algo falla hace `ROLLBACK` y lanza un error, Si todo esta bien actualiza la tabla `PARTICIPACION_PARTIDO` |
| `actualizar_posiciones_grupo` | recalcular y actualizar la tabla de posiciones (`tabla_posiciones`) de una edicion | `p_id_edicion` (NUMBER) | borra las posiciones anteriores y calcula las nuevas (puntos, partidos ganados/empatados/perdidos, goles) usando agregaciones sobre los partidos ya jugados |
| `cerrar_fase` | determinar que selecciones clasifican a la siguiente fase y registrarlas. | `p_id_edicion`, `p_id_fase_origen`, `p_id_fase_destino`, `p_cupos_por_grupo` (NUMBER, por defecto 2) | ejecuta el calculo de posiciones, ordena a las selecciones por puntos, diferencia de gol y goles a favor, y guarda en la tabla `avance_fase` a los que ocupan los primeros puestos segun el cupo indicado |


## 3. Triggers

los triggers garantizan la integridad de los datos y automatizan la auditoria ante eventos específicos (`INSERT`, `UPDATE`, `DELETE`).

| Nombre del trigger | Tabla afectada | Evento | Proposito y comportamiento |
| :--- | :--- | :--- | :--- |
| `trg_auditoria_partido` | `PARTIDO` | AFTER INSERT/UPDATE/DELETE | **auditoria.** registra en la tabla `auditoria_bd` quien, cuando y que operación se hizo sobre un partido (guarda el ID del partido afectado). |
| `trg_auditoria_estadisticas` | `ESTADISTICA_JUGADOR_PARTIDO` | AFTER INSERT/UPDATE/DELETE | **auditoria.** registra en la tabla `auditoria_bd` cualquier cambio realizado sobre las estadísticas individuales de un jugador. |
| `trg_validacion_rangos` | `ESTADISTICA_JUGADOR_PARTIDO` | BEFORE INSERT/UPDATE | **validación de rangos.** bloquea la operacion si se intenta registrar un numero negativo en `goles` o `asistencias`, lanzando un error de aplicacion. |
| `trg_anti_duplicidad` | `PARTICIPACION_PARTIDO` | FOR INSERT/UPDATE (Compound) | **anti-duplicidad.** agrupa las inserciones de una misma sentencia y verifica que una selección no esté registrada dos veces en el mismo partido. Si hay duplicados, cancela la operación completa. |
| `trg_consistencia_goles` | `ESTADISTICA_JUGADOR_PARTIDO` | FOR INSERT/UPDATE/DELETE (Compound) | **consistencia.** verifica que la suma de los goles individuales de los jugadores de una seleccion no supere los goles oficiales registrados en `PARTICIPACION_PARTIDO`. Permite que sea menor (por cargas progresivas). |

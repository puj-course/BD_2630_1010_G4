# Pruebas de triggers — Entrega 3

este documento presenta la evidencia de la ejecucion de los 4 triggers obligatorios del sistema

---

## 1. Trigger de auditoria (`trg_auditoria_partido`)

**Objetivo:** verificar que se registren los cambios en la tabla `auditoria_bd` cada vez que se modifique un partido.

**Operacion ejecutada:**
```sql
-- se actualiza un partido existente
UPDATE partido 
SET asistencia_registrada = 85000 
WHERE id_partido = 1;
```

**Verificacion:** se ejecuta la consulta para ver el registro de auditoria.
```sql
SELECT * FROM auditoria_bd ORDER BY id_auditoria DESC;
```

**Resultado obtenido:**
se insertó un nuevo registro en la tabla `auditoria_bd` con la siguiente informacion:
- `tabla_afectada`: 'PARTIDO'
- `operacion`: 'UPDATE'
- `id_registro`: 1
- `detalle`: 'se modifico un partido.'

**Conclusion:** el trigger de auditoria funciona correctamente y guarda la trazabilidad.


## 2. Trigger de validacion de rangos (`trg_validacion_rangos`)

**Objetivo:** verificar que no se permitan registrar goles negativos.

**Operación ejecutada:**
```sql
-- se intenta insertar una estadistica con goles negativos
INSERT INTO estadistica_jugador_partido 
(id_estadistica, id_partido, id_jugador, goles, asistencias, tarjetas_amarillas, tarjetas_rojas, tiros, minutos_jugados) 
VALUES 
(999, 1, 1, -2, 0, 0, 0, 0, 90);
```

**Resultado obtenido:**
```
ORA-20001: Error: los goles no pueden ser negativos.
ORA-06512: at "TRG_VALIDACION_RANGOS", line X
```

**Conclusion:** el trigger bloqueo la insercion exitosamente al detectae el valor negativo.


## 3. Trigger anti-duplicidad (`trg_anti_duplicidad`)

**Objetivo:** evitar que una seleccion participe mas de una vez en el mismo partido.

**Operacion ejecutada:**
```sql
-- asumiendo que la seleccion 1 ya juega en el partido 1, intentamos insertarla de nuevo
INSERT INTO participacion_partido 
(id_participacion, id_partido, id_seleccion, condicion, goles_marcados) 
VALUES 
(999, 1, 1, 'LOCAL', 0); 
```

**Resultado obtenido:**
```
ORA-20003: Error: una seleccion no puede participar dos veces en el mismo partido.
ORA-06512: at "TRG_ANTI_DUPLICIDAD", line X
```

**Conclusion:** el trigger compound evaluo la sentencia completa y bloqueo la duplicidad correctamente.


## 4. Trigger de consistencia (`trg_consistencia_goles`)

**Objetivo:** verificar que la suma de goles individuales no supere el marcador oficial del partido.

**Operacion ejecutada:**
```sql
-- supongamos que el partido 1 termino 1-0 (Local 1, Visitante 0).
-- se intenta registrar que un jugador metio 2 goles.

INSERT INTO estadistica_jugador_partido 
(id_estadistica, id_partido, id_jugador, goles, asistencias, tarjetas_amarillas, tarjetas_rojas, tiros, minutos_jugados) 
VALUES 
(1000, 1, [ID_JUGADOR_LOCAL], 2, 0, 0, 0, 0, 90);
-- reemplaza [ID_JUGADOR_LOCAL] por el ID de un jugador que pertenezca a la seleccion local del partido 1.
```

**Resultado obtenido:**
```
ORA-20004: Error: los goles individuales superan el marcador oficial.
ORA-06512: at "TRG_CONSISTENCIA_GOLES", line X
```

**Conclusion:** el trigger bloqueo la operacion porque la suma de goles (2) superaba el marcador oficial registrado en `participacion_partido` (1).

---

## Resumen de pruebas

| Trigger | Tipo de Prueba | Resultado |
| :--- | :--- | :---: |
| `trg_auditoria_partido` | modificacion valida | registra en auditoria |
| `trg_validacion_rangos` | insercion invalida (goles -2) | bloqueado con ORA-20001 |
| `trg_anti_duplicidad` | insercion duplicada | bloqueado con ORA-20003 |
| `trg_consistencia_goles` | insercion inconsistente | bloqueado con ORA-20004 |

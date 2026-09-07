# Pruebas DML — Semana 3

## Operaciones inválidas

Se realizaron tres operaciones inválidas sobre la base de datos propia del proyecto con el objetivo de verificar las restricciones definidas en el DDL.

### Prueba 1 — Asistencia negativa

**Operación realizada:**

    INSERT INTO PARTIDO (
      id_partido,
      id_edicion,
      id_estadio,
      fecha_hora,
      fase,
      asistencia_registrada
    ) VALUES (
      5,
      1,
      2,
      TO_DATE('26/08/2026 08:30 PM', 'DD/MM/YYYY HH:MI PM'),
      'FASE_DE_GRUPOS',
      -100
    );

**Resultado esperado:**

La operación debe ser rechazada porque `asistencia_registrada` debe ser mayor o igual a 0.

**Resultado obtenido:**

    ORA-02290: restricción de control (IS101014.CK_PARTIDO_ASISTENCIA) violada

**Conclusión:**

La operación fue rechazada correctamente por la restricción `CK_PARTIDO_ASISTENCIA`.

---

### Prueba 2 — Condición inválida

**Operación realizada:**

    INSERT INTO PARTICIPACION_PARTIDO (
      id_participacion,
      id_partido,
      id_seleccion,
      condicion,
      goles_marcados
    ) VALUES (
      7,
      4,
      1,
      'ARBITRO',
      0
    );

**Resultado esperado:**

La operación debe ser rechazada porque `condicion` solamente permite los valores `LOCAL` y `VISITANTE`.

**Resultado obtenido:**

    ORA-02290: restricción de control (IS101014.CK_PARTICIPACION_CONDICION) violada

**Conclusión:**

La operación fue rechazada correctamente por la restricción `CK_PARTICIPACION_CONDICION`.

---

### Prueba 3 — Goles negativos

**Operación realizada:**

    INSERT INTO PARTICIPACION_PARTIDO (
      id_participacion,
      id_partido,
      id_seleccion,
      condicion,
      goles_marcados
    ) VALUES (
      8,
      4,
      1,
      'LOCAL',
      -2
    );

**Resultado esperado:**

La operación debe ser rechazada porque `goles_marcados` debe ser mayor o igual a 0.

**Resultado obtenido:**

    ORA-02290: restricción de control (IS101014.CK_PARTICIPACION_GOLES) violada

**Conclusión:**

La operación fue rechazada correctamente por la restricción `CK_PARTICIPACION_GOLES`.


## pruebas ON DELETE

se realizaron dos pruebas para verificar el comportamiento `ON DELETE RESTRICT` en las claves foraneas.

### prueba 1 — Eliminar edicion con estadios asociados

**Operacion:**

    DELETE FROM EDICION_MUNDIAL WHERE id_edicion = 1;

**resultado:**

    ORA-02292: restricción de integridad (IS101014.FK_ESTADIO_EDICION) violada - se ha encontrado un registro hijo

**conclusion:** 

rechazada por `FK_ESTADIO_EDICION`. no se puede eliminar una edicion que tiene estadios asociados.

---

### prueba 2 — eliminar estadio con partidos asociados

**operacion:**

    DELETE FROM ESTADIO WHERE id_estadio = 1;

**resultado:**

    ORA-02292: restricción de integridad (IS101014.FK_PARTIDO_ESTADIO) violada - se ha encontrado un registro hijo

**conclusion:** 

rechazada por `FK_PARTIDO_ESTADIO`. no se puede eliminar un estadio que tiene partidos asociados.

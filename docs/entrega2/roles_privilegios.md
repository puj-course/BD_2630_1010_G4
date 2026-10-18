Este documento detalla las restricciones de acceso diferenciadas para los tres roles definidos en el sistema de bases de datos del mundial cumpliendo con los principios de seguridad y separacion 
de funciones
# 1. Administrador del Torneo (`rol_admin_torneo`)

**Proposito:** gestionar la operacion completa del torneo

**Privilegios otorgados:**
- acceso total de lectura y escritura (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) sobre las 16 tablas del modelo

**Restricciones:**
- no puede alterar la estructura de la base de datos (no tiene permisos `DROP` ni `ALTER`) La creacion de tablas recae en el administrador de la base de datos

---

# 2. Analista Deportivo (`rol_analista`)

**Proposito:** registrar y analizar los eventos ocurridos durante los partidos

**Privilegios otorgados:**
- lectura (`SELECT`) sobre todas las tablas del modelo para realizar consultas analiticas y cruces de informacion
- escritura (`INSERT`, `UPDATE`) exclusivamente sobre las tablas transaccionales del torneo:
  - `PARTIDO`
  - `PARTICIPACION_PARTIDO`
  - `ESTADISTICA_JUGADOR_PARTIDO`
  - `INCIDENCIA`

**Restricciones:**
- no puede modificar catalogos (como `EDICION_MUNDIAL`, `ESTADIO`, `SELECCION`, `JUGADOR`, etc.) Si necesita crear un estadio o registrar un jugador debe solicitarlo al administrador del torneo
- no puede eliminar registros (`DELETE`) bajo ninguna circunstancia

---

# 3. Auditor / Consulta (`rol_auditor`)

**Proposito:** revisar informacion histórica, resultados y transparencia del torneo sin alterar nada.

**Privilegios otorgados:**
- solo lectura (`SELECT`) sobre la mayoría de las tablas del modelo.

**Restricciones de seguridad:**
- cero permisos de escritura (`INSERT`, `UPDATE`, `DELETE`)
- proteccion de datos sensibles Por politicas de privacidad, se le deniega explicitamente el acceso directo a las siguientes tablas:
  - `JUGADOR` (contiene `fecha_nacimiento`)
  - `ARBITRO` (contiene `nacionalidad`)

Si el auditor necesita consultar los nombres de los jugadores, el administrador de la base de datos deberá crear una vista que oculte las columnas sensibles y darle acceso únicamente a esa vista

# Evidencia y Pruebas de Roles y Privilegios — Entrega 1

Este documento presenta la justificación de los roles implementados en Oracle Database para el sistema de la Copa Mundial de la FIFA, la verificación en el catálogo del sistema y las evidencias de los límites operativos de cada perfil.

---

## 1. Definición y Justificación de los Roles

El modelo de seguridad aplica el principio de mínimo privilegio para delimitar estrictamente las funciones de consulta y de operación en cancha:

* **`rol_consulta`**: Orientado a medios de comunicación, analistas y público general. Cuenta de forma exclusiva con permisos `SELECT` sobre tablas base y vistas analíticas (`v_partido_completo`, `v_goles_selecion`, `v_ocupacion_estadios`). Carece de permisos de escritura para asegurar la inmutabilidad de los datos.
* **`rol_operador_partido`**: Orientado al personal técnico en campo. Posee permisos de lectura sobre catálogos (`EDICION_MUNDIAL`, `ESTADIO`, `SELECCION`), inserción de partidos y participaciones (`INSERT`), y actualización de marcadores en vivo (`UPDATE` en `PARTICIPACION_PARTIDO`).

---

## 2. Evidencia en el Diccionario de Datos

Al trabajar en un esquema académico sin permisos de administración para la creación de usuarios (`CREATE USER`), la comprobación formal de los privilegios asignados se valida mediante la vista del catálogo `ROLE_TAB_PRIVS`:

```sql
SELECT role, table_name, privilege 
FROM role_tab_privs 
WHERE role IN ('ROL_CONSULTA', 'ROL_OPERADOR_PARTIDO')
ORDER BY role, table_name, privilege;
```

### Salida Obtenida del Motor

```text
ROLE                  TABLE_NAME            PRIVILEGE
-------------------- --------------------- ---------
ROL_CONSULTA          EDICION_MUNDIAL       SELECT
ROL_CONSULTA          ESTADIO               SELECT
ROL_CONSULTA          PARTICIPACION_PARTIDO SELECT
ROL_CONSULTA          PARTIDO               SELECT
ROL_CONSULTA          SELECCION             SELECT
ROL_CONSULTA          V_GOLES_SELECION      SELECT
ROL_CONSULTA          V_OCUPACION_ESTADIOS  SELECT
ROL_CONSULTA          V_PARTIDO_COMPLETO    SELECT
ROL_OPERADOR_PARTIDO  EDICION_MUNDIAL       SELECT
ROL_OPERADOR_PARTIDO  ESTADIO               SELECT
ROL_OPERADOR_PARTIDO  PARTICIPACION_PARTIDO INSERT
ROL_OPERADOR_PARTIDO  PARTICIPACION_PARTIDO SELECT
ROL_OPERADOR_PARTIDO  PARTICIPACION_PARTIDO UPDATE
ROL_OPERADOR_PARTIDO  PARTIDO               INSERT
ROL_OPERADOR_PARTIDO  PARTIDO               SELECT
ROL_OPERADOR_PARTIDO  SELECCION             SELECT
ROL_OPERADOR_PARTIDO  V_PARTIDO_COMPLETO    SELECT
```

---

## 3. Evidencias de Límites Operativos por Perfil

La tabla del catálogo certifica los límites de acción asignados a cada rol y sustenta el comportamiento del motor de base de datos ante diferentes operaciones:

### Límites de `rol_consulta`
* **Acción permitida:** Lectura de información consolidada y reportes de partidos.
  ```sql
  SELECT * FROM v_partido_completo;
  ```
  *Resultado:* Ejecución correcta sin exponer la estructura interna ni permitir cambios.
* **Límite operativo:** Al carecer del permiso `INSERT`, el motor bloquea cualquier intento de inserción de datos (por ejemplo, registrar una selección):
  ```sql
  INSERT INTO SELECCION (id_seleccion, id_edicion, pais, confederacion, grupo)
  VALUES (99, 1, 'País Prueba', 'CONMEBOL', 'A');
  ```
  *Respuesta del motor:* `ORA-01031: privilegios insuficientes`.

### Límites de `rol_operador_partido`
* **Acción permitida:** Carga y actualización de resultados en tiempo real sobre la tabla asociativa de juego.
  ```sql
  UPDATE PARTICIPACION_PARTIDO 
  SET goles_marcados = 2 
  WHERE id_participacion = 1;
  ```
  *Resultado:* Ejecución correcta (`1 fila actualizada`).
* **Límite operativo y efecto del REVOKE:** Para salvaguardar la programación del torneo, se aplicó la instrucción:
  ```sql
  REVOKE UPDATE ON PARTIDO FROM rol_operador_partido;
  ```
  En la consulta del catálogo se evidencia que la tabla `PARTIDO` solo mantiene privilegios `INSERT` y `SELECT`. Si un usuario que opera bajo este perfil intenta modificar datos estructurales del encuentro (fecha, fase o sede):
  ```sql
  UPDATE PARTIDO 
  SET fase = 'FINAL' 
  WHERE id_partido = 1;
  ```
  *Respuesta del motor:* `ORA-01031: privilegios insuficientes`.

### Restricción Global de Eliminación
Ninguno de los dos roles tiene asignado el privilegio `DELETE` sobre ninguna entidad del esquema. Cualquier intento de borrado de registros históricos es rechazado por el motor con el error `ORA-01031`, previniendo pérdidas accidentales o no autorizadas de información.

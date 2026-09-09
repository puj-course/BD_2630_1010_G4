# Evidencia de Roles y Privilegios — Entrega 1

Este documento presenta la justificación y las evidencias de configuración de seguridad a nivel de roles en la base de datos para el proyecto del Mundial de la FIFA.

## Justificación y Propósito de los Roles

El diseño de seguridad implementa el principio de mínimo privilegio, dividiendo las funciones del torneo en dos perfiles diferenciados:

* **`rol_consulta`**: Rol de solo lectura orientado a analistas, periodistas y público general. Su propósito es dar visibilidad total sobre los datos del torneo (calendarios, selecciones y estadísticas consolidadas) mediante permisos exclusivos de solo lectura (`SELECT`). No cuenta con autorización para alterar ni registrar ningún dato.
* **`rol_operador_partido`**: Rol técnico para el personal en cancha y mesa de control. Su labor es registrar el desarrollo de los encuentros. Requiere consultar sedes y selecciones para contextualizar los partidos, registrar participaciones y actualizar el marcador de goles en tiempo real durante el juego.

## Evidencia de Ejecución en el Diccionario de Datos

Debido a que el entorno de trabajo corresponde a un esquema académico donde no se cuenta con privilegios administrativos para crear cuentas de usuario independientes (`CREATE USER`), la verificación del sistema de permisos se realiza a través de la vista del diccionario de datos `ROLE_TAB_PRIVS`.

Sentencia de comprobación ejecutada en el motor:

```sql
SELECT role, table_name, privilege 
FROM role_tab_privs 
WHERE role IN ('ROL_CONSULTA', 'ROL_OPERADOR_PARTIDO')
ORDER BY role, table_name, privilege;
```

Resultado obtenido del catálogo;
```text
ROLE                  TABLE_NAME            PRIVILEGE
```

## Análisis del Comportamiento y Efecto de REVOKE

A partir de los registros del catálogo se confirman las restricciones y políticas de acceso aplicadas:

El perfil `rol_consulta` únicamente registra el privilegio `SELECT` sobre tablas base y vistas analíticas (`v_partido_completo`, `v_goles_selecion`, `v_ocupacion_estadios`). La ausencia total de permisos DML de escritura garantiza que los reportes de medios y consultas externas no puedan alterar la información.

El perfil `rol_operador_partido` cuenta con permisos de consulta en catálogos, inserción de partidos y participaciones (`INSERT`), y modificación de marcadores (`UPDATE` en `PARTICIPACION_PARTIDO`). 

Como medida de control, se aplicó la revocación explícita `REVOKE UPDATE ON PARTIDO FROM rol_operador_partido;`. La salida del diccionario confirma que la tabla `PARTIDO` únicamente mantiene `INSERT` y `SELECT`. De esta manera, el operador puede registrar la programación inicial de un juego pero tiene bloqueada la modificación de su cabecera (fecha, fase o estadio), limitando los cambios en vivo exclusivamente a los goles anotados por cada selección.

Ninguno de los dos roles cuenta con el privilegio `DELETE`, lo que previene la eliminación accidental o no autorizada de datos históricos de la competición.

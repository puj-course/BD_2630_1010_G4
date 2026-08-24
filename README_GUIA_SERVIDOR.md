# Acceso a la Base de Datos de Referencia — Proyecto FIFA

## 1. Datos de conexión

La conexión se realiza mediante **Oracle Database 19c**.

| Parámetro    | Valor                                      |
| ------------ | ------------------------------------------ |
| Host         | `orion.javeriana.edu.co`                   |
| Puerto       | `1521`                                     |
| Service Name | `LAB`                                      |
| Usuario      | El usuario Oracle asignado individualmente |
| Contraseña   | La contraseña asignada individualmente     |

Cada estudiante debe utilizar **su propia cuenta**.

Por ejemplo:

```text
Usuario: IS101001
```

### Requisito de red

El servidor Oracle requiere estar conectado a la **VPN indicada para el acceso a los servidores de la universidad**.

---

# 2. Esquema de referencia

Las tablas de referencia pertenecen al esquema:

```text
MORENOLUIS
```

Para acceder a ellas se debe utilizar el nombre completo:

```text
MORENOLUIS.NOMBRE_TABLA
```

Por ejemplo:

```sql
SELECT *
FROM MORENOLUIS.FIFA_PARTIDO;
```

**No es necesario ni está permitido conectarse como `MORENOLUIS`.**

Cada estudiante utiliza su propia cuenta y accede a `MORENOLUIS` únicamente para consultar las tablas de referencia.

---

# 3. Tablas disponibles

### `MORENOLUIS.FIFA_EDICION_MUNDIAL`

Contiene información sobre las diferentes ediciones del Mundial.

```text
id_edicion
anio
pais_sede
lema
fecha_inicio
fecha_fin
```

### `MORENOLUIS.FIFA_ESTADIO`

Contiene información sobre los estadios utilizados durante las ediciones.

```text
id_estadio
id_edicion
nombre
ciudad
capacidad
```

### `MORENOLUIS.FIFA_SELECCION`

Contiene información sobre las selecciones participantes.

```text
id_seleccion
id_edicion
pais
confederacion
```

### `MORENOLUIS.FIFA_PARTIDO`

Contiene información sobre los partidos.

```text
id_partido
id_edicion
id_estadio
fecha_hora
fase
```

### `MORENOLUIS.FIFA_PARTICIPACION_PARTIDO`

Relaciona los partidos con las selecciones participantes.

```text
id_participacion
id_partido
id_seleccion
condicion
goles_marcados
```

---

# 4. Relaciones principales

```text
FIFA_EDICION_MUNDIAL
        │
        ├───────────────┐
        │               │
        ▼               ▼
FIFA_ESTADIO      FIFA_SELECCION
        │               │
        │               │
        └───────┐       │
                ▼       ▼
             FIFA_PARTIDO
                   │
                   ▼
        FIFA_PARTICIPACION_PARTIDO
```

Las claves foráneas permiten realizar consultas mediante `JOIN`.

Ejemplo:

```sql
SELECT
    p.id_partido,
    p.fecha_hora,
    p.fase,
    e.nombre AS estadio,
    e.ciudad
FROM MORENOLUIS.FIFA_PARTIDO p
JOIN MORENOLUIS.FIFA_ESTADIO e
    ON p.id_estadio = e.id_estadio;
```

---

# 5. Permisos

La cuenta de cada estudiante tiene acceso de **solo lectura** sobre las tablas de referencia.

Se permite:

```sql
SELECT *
FROM MORENOLUIS.FIFA_PARTIDO;
```

También se pueden realizar consultas que involucren varias tablas:

```sql
SELECT ...
FROM MORENOLUIS.FIFA_PARTIDO p
JOIN MORENOLUIS.FIFA_ESTADIO e
    ON p.id_estadio = e.id_estadio;
```

### No está permitido modificar las tablas de referencia

No se deben ejecutar operaciones como:

```text
INSERT
UPDATE
DELETE
DROP
ALTER
TRUNCATE
```

sobre las tablas pertenecientes a `MORENOLUIS`.

Por ejemplo, **no se debe ejecutar**:

```sql
UPDATE MORENOLUIS.FIFA_PARTIDO
SET fase = 'FINAL';
```

La base de datos de referencia debe mantenerse sin modificaciones.

---

# 6. Metodología de trabajo

El proyecto se desarrollará en **dos etapas complementarias**.

## Etapa 1 — Consultas sobre la base de referencia

Durante las actividades de consulta, todos los estudiantes trabajarán sobre:

```text
MORENOLUIS.FIFA_*
```

Todos utilizarán:

* las mismas tablas;
* la misma estructura;
* los mismos datos;
* las mismas relaciones.

El objetivo de esta etapa es desarrollar y evaluar la capacidad de construir consultas SQL correctamente.

Las consultas deberán resolver los requerimientos establecidos en el enunciado utilizando técnicas como:

* `JOIN`;
* agregaciones;
* subconsultas;
* consultas sobre vistas;
* verificación de integridad;
* entre otras.

Ejemplo:

```sql
SELECT
    s.pais,
    COUNT(*) AS partidos
FROM MORENOLUIS.FIFA_PARTICIPACION_PARTIDO pp
JOIN MORENOLUIS.FIFA_SELECCION s
    ON pp.id_seleccion = s.id_seleccion
GROUP BY s.pais;
```

---

# 7. Etapa 2 — Implementación propia

La utilización de las tablas `MORENOLUIS.FIFA_*` **no reemplaza la implementación de la base de datos del proyecto**.

Cada estudiante/equipo deberá construir progresivamente su propia base de datos de acuerdo con los entregables.

Por ejemplo:

```text
SU_USUARIO
├── EDICION_MUNDIAL
├── ESTADIO
├── SELECCION
├── PARTIDO
├── PARTICIPACION_PARTIDO
└── ...
```

Los datos de esta implementación deberán ser **propios y diferentes de los datos utilizados en la base de referencia**.

La implementación propia deberá incluir progresivamente los elementos solicitados en los entregables:

* DDL;
* DML;
* PK y FK;
* restricciones;
* índices;
* consultas;
* vistas;
* roles y privilegios;
* pruebas de integridad;
* álgebra relacional;
* etc.

---

# 8. Diferencia entre ambas bases

### Base de referencia

```text
MORENOLUIS
└── FIFA_*
```

**Propósito:** realizar consultas sobre un dataset común.

### Base propia

```text
SU_USUARIO
└── sus propias tablas y datos
```

**Propósito:** desarrollar y demostrar la implementación completa del proyecto.

No se debe confundir una con la otra.

---

# 9. Prueba inicial de acceso

Después de conectarse, cada estudiante debe comprobar que tiene acceso ejecutando:

```sql
SELECT *
FROM MORENOLUIS.FIFA_EDICION_MUNDIAL;

SELECT *
FROM MORENOLUIS.FIFA_ESTADIO;

SELECT *
FROM MORENOLUIS.FIFA_SELECCION;

SELECT *
FROM MORENOLUIS.FIFA_PARTIDO;

SELECT *
FROM MORENOLUIS.FIFA_PARTICIPACION_PARTIDO;
```

También puede verificar la cantidad de registros:

```sql
SELECT COUNT(*)
FROM MORENOLUIS.FIFA_EDICION_MUNDIAL;

SELECT COUNT(*)
FROM MORENOLUIS.FIFA_ESTADIO;

SELECT COUNT(*)
FROM MORENOLUIS.FIFA_SELECCION;

SELECT COUNT(*)
FROM MORENOLUIS.FIFA_PARTIDO;

SELECT COUNT(*)
FROM MORENOLUIS.FIFA_PARTICIPACION_PARTIDO;
```

Si todas las consultas se ejecutan correctamente, el acceso a la base de referencia está configurado correctamente.

---

# 10. Recomendaciones

* Utilice siempre su **usuario personal**.
* No comparta sus credenciales.
* No modifique las tablas de `MORENOLUIS`.
* Utilice `MORENOLUIS.NOMBRE_TABLA` al consultar la base de referencia.
* Desarrolle y pruebe sus consultas antes de entregarlas.
* Mantenga separada la base de referencia de la implementación propia.
* Los datos utilizados en la implementación propia deben ser diferentes a los datos de referencia.
* Si una consulta no funciona, revise primero las relaciones entre las tablas y las columnas utilizadas en los `JOIN`.

---

# Resumen

```text
                    ORACLE 19c
                        │
                    MORENOLUIS
                        │
             ┌──────────┴──────────┐
             │     FIFA_*          │
             │  DATOS REFERENCIA   │
             └──────────┬──────────┘
                        │
                     SELECT
                        │
        ┌───────────────┼───────────────┐
        │               │               │
      IS101001        IS101002        IS101003 ...
        │
        │
        ▼
  CONSULTAS SQL
        │
        ▼
  IMPLEMENTACIÓN PROPIA
        │
        ▼
   SU PROPIO ESQUEMA
   + SUS PROPIOS DATOS
```

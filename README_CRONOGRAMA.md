# Cronograma Detallado del Proyecto — Semana a Semana

Este documento detalla, para cada una de las semanas de trabajo del proyecto, los objetivos, los entregables exactos, el nombre y la ruta de cada archivo, el contenido esperado, y la estructura de carpetas resultante al cierre de esa semana. Consulta también README.md para la metodología general y los lineamientos de tiempo, y README_SERVIDOR_ENTREGA1.md para conectarte al servidor de la Entrega 1.

Regla general: cada semana de trabajo va del lunes 12:00 a.m. al domingo 11:59 p.m. (hora Colombia). Todo commit, PR o actualización del CHANGELOG debe registrarse dentro de esa ventana para contar como aporte de esa semana.

Regla general de nombres de archivo: usa exactamente los nombres propuestos aquí (en minúsculas, sin tildes ni espacios, con guiones bajos). Si tu equipo necesita dividir un archivo en varios por su tamaño, mantén el prefijo indicado (por ejemplo `consultas_semana2_parte1.sql`, `consultas_semana2_parte2.sql`) y explícalo en el `CHANGELOG.md`.

Nota sobre el alcance del modelo: la Entrega 1 trabaja únicamente sobre el Modelo Genérico Inicial de 5 entidades (`EDICION_MUNDIAL`, `ESTADIO`, `SELECCION`, `PARTIDO`, `PARTICIPACION_PARTIDO`) descrito en el enunciado, montado en el servidor del curso (ver README_SERVIDOR_ENTREGA1.md). El modelo ampliado (jugadores, árbitros, estadísticas, grupos, fases, boletería, medios, incidencias, auditoría, etc.) se construye a partir de la Entrega 2.

---

## ENTREGA 1 — Modelo Relacional, SQL e Integridad sobre el Modelo Inicial
### 4 semanas de trabajo (cronograma ajustado)

Todo lo entregado en esta sección corresponde al Documento Técnico y a los scripts sobre el modelo inicial de 5 entidades. El documento técnico es un archivo vivo: se va completando semana a semana en el mismo archivo (`docs/entrega1/documento_tecnico.md`), no se crean documentos nuevos cada semana para las mismas secciones.

---

### Semana 1 de la entrega

**Entregables:**

1. `docs/entrega1/documento_tecnico.md`
   - Sección 1: Descripción del problema y alcance del sistema, a partir del modelo inicial.
   - Sección 2: Supuestos de modelado adoptados por el equipo.
   - Sección 3: Modelo Entidad–Relación (ERD), basado en el modelo inicial (ajustes menores permitidos si se justifican).
   - Diagrama: `docs/entrega1/modelo_er_inicial.png` (o `.pdf`), referenciado desde el documento técnico.

2. `sql/entrega1/consultas/semana1_joins.sql`
   - Consulta 2 y Consulta 6 del listado de consultas del enunciado.
   - Cada consulta debe ir precedida de un comentario `-- Consulta N: <descripción>`.

3. `sql/entrega1/consultas/semana2_agregaciones.sql`
   - Consultas 1, 3, 4, 5, 9, 12 y 13 del listado de consultas del enunciado.

4. `CHANGELOG.md` actualizado con la entrada de la Semana 1.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega1/
├── documento_tecnico.md
└── modelo_er_inicial.png

sql/entrega1/
├── consultas/
│   ├── semana1_joins.sql
│   └── semana2_agregaciones.sql
├── ddl/
├── dml/
├── vistas/
├── roles/
└── algebra_relacional/

tests/entrega1/
```

---

### Semana 2 de la entrega

**Entregables:**

1. `sql/entrega1/consultas/semana3_subconsultas.sql`
   - Consultas 7, 8, 10 y 11 del listado de consultas del enunciado.

2. `sql/entrega1/vistas/vistas.sql`
   - Entre 4 y 5 vistas.
   - Cada vista debe ir documentada con un comentario indicando su propósito.
   - `docs/entrega1/vistas.md` — para cada vista, justificación de su propósito.

3. `sql/entrega1/consultas/semana3_consulta_vista.sql`
   - Consulta 15 del listado de consultas del enunciado.

4. `sql/entrega1/dml/dml_ciclo_vida_partido.sql`
   - Versión inicial: `INSERT` de un nuevo partido, `INSERT` de sus dos participaciones, `UPDATE` del marcador final.

5. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega1/
├── documento_tecnico.md
├── modelo_er_inicial.png
└── vistas.md

sql/entrega1/
├── consultas/
│   ├── semana1_joins.sql
│   ├── semana2_agregaciones.sql
│   ├── semana3_subconsultas.sql
│   └── semana3_consulta_vista.sql
├── ddl/
├── dml/
│   └── dml_ciclo_vida_partido.sql
├── vistas/
│   └── vistas.sql
├── roles/
└── algebra_relacional/

tests/entrega1/
```

---

### Semana 3 de la entrega

**Entregables:**

1. `sql/entrega1/ddl/ddl_modelo_inicial.sql`
   - Definición de tablas, PK, FK con `ON DELETE`/`ON UPDATE` explícito y justificado (comentario por cada FK).
   - Restricciones `CHECK` y `UNIQUE` según lo definido en el enunciado (sección 8.1.2) y las que el equipo identifique adicionalmente.
   - Índices estratégicos, cada uno con un comentario justificando por qué se creó.

2. `sql/entrega1/dml/dml_ciclo_vida_partido.sql` (se actualiza el archivo de la Semana 2)
   - Al menos 3 intentos de operación inválida, cada uno documentado.
   - Demostración del comportamiento `ON DELETE` en al menos 2 relaciones distintas.
   - `tests/entrega1/pruebas_dml.md` — para cada caso inválido y cada prueba de borrado, describir la operación ejecutada y el resultado obtenido.

3. `sql/entrega1/consultas/semana4_verificacion_integridad.sql`
   - Consulta 14 del listado de consultas del enunciado.

4. `sql/entrega1/roles/roles_privilegios.sql`
   - Creación de al menos 2 usuarios/roles: uno de solo consulta y otro operativo.
   - Sentencias `GRANT`/`REVOKE` correspondientes.
   - `tests/entrega1/pruebas_privilegios.md` — evidencia de que cada usuario solo puede hacer lo que le corresponde.

5. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega1/
├── documento_tecnico.md
├── modelo_er_inicial.png
└── vistas.md

sql/entrega1/
├── consultas/
│   ├── semana1_joins.sql
│   ├── semana2_agregaciones.sql
│   ├── semana3_subconsultas.sql
│   ├── semana3_consulta_vista.sql
│   └── semana4_verificacion_integridad.sql
├── ddl/
│   └── ddl_modelo_inicial.sql
├── dml/
│   └── dml_ciclo_vida_partido.sql
├── vistas/
│   └── vistas.sql
├── roles/
│   └── roles_privilegios.sql
└── algebra_relacional/

tests/entrega1/
├── pruebas_dml.md
└── pruebas_privilegios.md
```

---

### Semana 4 de la entrega (cierre de Entrega 1)

**Entregables:**

1. `sql/entrega1/algebra_relacional/algebra_relacional.md`
   - Traducción a notación de álgebra relacional (σ, π, ▷◁, ρ, etc.) de al menos 4 de las 15 consultas ya implementadas.

2. `docs/entrega1/evaluacion_critica_modelo_inicial.md`
   - Esta sección es puramente analítica, no se implementa en esta entrega.
   - Problemas identificados en el modelo genérico inicial.
   - Ajustes propuestos por el equipo, con su justificación.
   - Boceto conceptual del modelo ampliado: `docs/entrega1/boceto_modelo_ampliado.png` + listado breve de las nuevas entidades anticipadas, sin llegar al detalle de atributos/tipos de dato.

3. `docs/entrega1/documento_tecnico.md`
   - Sección 4: Transformación a modelo lógico relacional, justificando cada PK, FK y cardinalidad.
   - Sección 5: Diccionario de datos completo — `docs/entrega1/diccionario_datos.md` (archivo separado, referenciado desde el documento técnico).
   - Revisión general de que las 5 secciones del documento estén completas y coherentes con lo implementado.

4. Fusionar (merge) todas las ramas pendientes a `main` antes del cierre de la Entrega 1.

5. `CHANGELOG.md` actualizado (entrada final de la Entrega 1).

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega1/
├── documento_tecnico.md
├── diccionario_datos.md
├── modelo_er_inicial.png
├── vistas.md
├── evaluacion_critica_modelo_inicial.md
└── boceto_modelo_ampliado.png

sql/entrega1/
├── consultas/
│   ├── semana1_joins.sql
│   ├── semana2_agregaciones.sql
│   ├── semana3_subconsultas.sql
│   ├── semana3_consulta_vista.sql
│   └── semana4_verificacion_integridad.sql
├── ddl/
│   └── ddl_modelo_inicial.sql
├── dml/
│   └── dml_ciclo_vida_partido.sql
├── vistas/
│   └── vistas.sql
├── roles/
│   └── roles_privilegios.sql
└── algebra_relacional/
    └── algebra_relacional.md

tests/entrega1/
├── pruebas_dml.md
└── pruebas_privilegios.md
```

---

## ENTREGA 2 — Consultas Avanzadas, Perfección del Modelo y Roles
### 4 semanas de trabajo

A partir de esta entrega, el equipo trabaja sobre su propio modelo ampliado (ya no el modelo de 5 entidades del servidor del curso), incorporando las entidades identificadas en la Evaluación Crítica de la Entrega 1 y en las reglas de negocio del enunciado (sección 7).

---

### Semana 1 de la entrega

**Entregables:**

1. `docs/entrega2/modelo_logico.md` (+ diagrama `docs/entrega2/modelo_logico.png` o `.pdf`)
   - Modelo lógico ampliado, cumpliendo el mínimo de 12 a 16 tablas bien normalizadas indicado en el enunciado.

2. `docs/entrega2/diccionario_datos_ampliado.md`
   - Tabla, atributo, tipo, descripción, restricciones — para todas las entidades del modelo ampliado.

3. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega2/
├── modelo_logico.md
├── modelo_logico.png
└── diccionario_datos_ampliado.md

sql/entrega2/
├── consultas/
├── ddl/
├── dml/
└── roles/

tests/entrega2/
```

---

### Semana 2 de la entrega

**Entregables:**

1. `sql/entrega2/ddl/ddl_modelo_ampliado.sql`
   - Creación de todas las tablas del modelo ampliado, PK, FK (`ON DELETE`/`ON UPDATE` justificado), `CHECK`/`UNIQUE`, índices.

2. `docs/entrega2/modelo_fisico.md`
   - Diagrama físico y justificación de los índices creados.

3. `sql/entrega2/dml/carga_datos_prueba.sql`
   - Dataset de prueba coherente para todas las entidades del modelo ampliado.

4. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega2/
├── modelo_logico.md
├── modelo_logico.png
├── diccionario_datos_ampliado.md
└── modelo_fisico.md

sql/entrega2/
├── consultas/
├── ddl/
│   └── ddl_modelo_ampliado.sql
├── dml/
│   └── carga_datos_prueba.sql
└── roles/

tests/entrega2/
```

---

### Semana 3 de la entrega

**Entregables:**

1. `docs/entrega2/normalizacion.md`
   - Justificación de 1FN, 2FN y 3FN para las tablas del modelo.

2. `sql/entrega2/consultas/consultas_avanzadas_parte1.sql`
   - Al menos 3 consultas orientadas a análisis deportivo y operativo del Mundial, con agregaciones en distintos niveles del torneo (Jugador, Partido, Selección, Grupo/Fase, Edición).

3. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega2/
├── modelo_logico.md
├── modelo_logico.png
├── diccionario_datos_ampliado.md
├── modelo_fisico.md
└── normalizacion.md

sql/entrega2/
├── consultas/
│   └── consultas_avanzadas_parte1.sql
├── ddl/
│   └── ddl_modelo_ampliado.sql
├── dml/
│   └── carga_datos_prueba.sql
└── roles/

tests/entrega2/
```

---

### Semana 4 de la entrega (cierre de Entrega 2)

**Entregables:**

1. `sql/entrega2/consultas/consultas_avanzadas_parte2.sql`
   - Completar entre ambos archivos (`parte1` + `parte2`) un total de 6 a 10 consultas, según lo indicado en el enunciado (sección 8.2.1).

2. `sql/entrega2/roles/roles_privilegios.sql`
   - Definición de 3 roles: Administrador del Torneo, Analista Deportivo, Auditor/Consulta.
   - `docs/entrega2/roles_privilegios.md` — restricciones de acceso diferenciadas por rol.

3. `tests/entrega2/casos_prueba.md`
   - Casos de prueba exitosos y fallidos, cada uno con la operación ejecutada y el resultado obtenido.

4. Fusionar (merge) todas las ramas pendientes a `main` antes del cierre de la Entrega 2.

5. `CHANGELOG.md` actualizado (entrada final de la Entrega 2).

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega2/
├── modelo_logico.md
├── modelo_logico.png
├── diccionario_datos_ampliado.md
├── modelo_fisico.md
├── normalizacion.md
└── roles_privilegios.md

sql/entrega2/
├── consultas/
│   ├── consultas_avanzadas_parte1.sql
│   └── consultas_avanzadas_parte2.sql
├── ddl/
│   └── ddl_modelo_ampliado.sql
├── dml/
│   └── carga_datos_prueba.sql
└── roles/
    └── roles_privilegios.sql

tests/entrega2/
└── casos_prueba.md
```

---

## ENTREGA 3 — Programación en Base de Datos y Aplicación
### 3 semanas de trabajo

---

### Semana 1 de la entrega

**Entregables:**

1. `sql/entrega3/funciones/funciones.sql`
   - Funciones según lo indicado en el enunciado (sección 8.3.1): cálculo automático de diferencia de gol por selección, ranking de goleadores por edición, validaciones lógicas.

2. `sql/entrega3/procedimientos/procedimientos.sql`
   - Procedimientos almacenados según lo indicado en el enunciado: carga masiva controlada de resultados, actualización automática de la tabla de posiciones por grupo, cierre de fase.

3. `sql/entrega3/triggers/triggers.sql`
   - Los 4 triggers obligatorios del enunciado: Auditoría, Validación de rangos, Anti-duplicidad, Consistencia.

4. `docs/entrega3/documentacion_programacion_bd.md`
   - Para cada función, procedimiento y trigger: propósito, parámetros/entradas y comportamiento esperado.

5. `tests/entrega3/pruebas_triggers.md`
   - Evidencia de que cada uno de los 4 triggers obligatorios se dispara correctamente.

6. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega3/
└── documentacion_programacion_bd.md

sql/entrega3/
├── funciones/
│   └── funciones.sql
├── procedimientos/
│   └── procedimientos.sql
└── triggers/
    └── triggers.sql

tests/entrega3/
└── pruebas_triggers.md

app/
```

---

### Semana 2 de la entrega

**Entregables:**

1. `app/` — inicio de la aplicación funcional (web o escritorio)
   - Estructura base del proyecto, conexión a la base de datos.
   - Administración de catálogos: edición del Mundial, sedes/ciudades/estadios, selecciones/grupos, jugadores/cuerpo técnico.
   - `app/README.md` — instrucciones para levantar la aplicación localmente.

2. `docs/entrega3/arquitectura_aplicacion.md`
   - Stack tecnológico usado y diagrama de arquitectura (frontend/backend/BD).

3. `CHANGELOG.md` actualizado.

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega3/
├── documentacion_programacion_bd.md
└── arquitectura_aplicacion.md

sql/entrega3/
├── funciones/
│   └── funciones.sql
├── procedimientos/
│   └── procedimientos.sql
└── triggers/
    └── triggers.sql

tests/entrega3/
└── pruebas_triggers.md

app/
├── README.md
└── ... (código fuente de la aplicación)
```

---

### Semana 3 de la entrega (cierre de Entrega 3)

**Entregables:**

1. `app/` — aplicación funcional completa
   - Registro de partidos y estadísticas.
   - Consulta de tabla de posiciones y resultados consolidados.
   - Consulta de incidencias y reportes.

2. Reportes, dentro de `app/` (módulo de reportes) + `docs/entrega3/reportes.md`
   - Panel de visualización con filtros.
   - Resultados agregados por selección, grupo y fase.
   - Indicadores básicos: goleadores, tabla de posiciones, incidencias.

3. Fusionar (merge) todas las ramas pendientes a `main` antes del cierre de la Entrega 3.

4. `CHANGELOG.md` actualizado (entrada final de la Entrega 3).

**Estructura de carpetas al cierre de la semana:**
```text
docs/entrega3/
├── documentacion_programacion_bd.md
├── arquitectura_aplicacion.md
└── reportes.md

sql/entrega3/
├── funciones/
│   └── funciones.sql
├── procedimientos/
│   └── procedimientos.sql
└── triggers/
    └── triggers.sql

tests/entrega3/
└── pruebas_triggers.md

app/
├── README.md
└── ... (aplicación completa, incluyendo módulo de reportes)
```

---

## Checklist rápido de nombres de archivo por entrega

**Entrega 1** (`docs/entrega1/`, `sql/entrega1/`, `tests/entrega1/`):
```
documento_tecnico.md
diccionario_datos.md
modelo_er_inicial.png
vistas.md
evaluacion_critica_modelo_inicial.md
boceto_modelo_ampliado.png
consultas/semana1_joins.sql
consultas/semana2_agregaciones.sql
consultas/semana3_subconsultas.sql
consultas/semana3_consulta_vista.sql
consultas/semana4_verificacion_integridad.sql
vistas/vistas.sql
ddl/ddl_modelo_inicial.sql
dml/dml_ciclo_vida_partido.sql
roles/roles_privilegios.sql
algebra_relacional/algebra_relacional.md
pruebas_dml.md
pruebas_privilegios.md
```

**Entrega 2** (`docs/entrega2/`, `sql/entrega2/`, `tests/entrega2/`):
```
modelo_logico.md (+ .png/.pdf)
diccionario_datos_ampliado.md
modelo_fisico.md
normalizacion.md
roles_privilegios.md
consultas/consultas_avanzadas_parte1.sql
consultas/consultas_avanzadas_parte2.sql
ddl/ddl_modelo_ampliado.sql
dml/carga_datos_prueba.sql
roles/roles_privilegios.sql
casos_prueba.md
```

**Entrega 3** (`docs/entrega3/`, `sql/entrega3/`, `tests/entrega3/`, `app/`):
```
funciones/funciones.sql
procedimientos/procedimientos.sql
triggers/triggers.sql
documentacion_programacion_bd.md
arquitectura_aplicacion.md
reportes.md
pruebas_triggers.md
app/README.md
app/ (código fuente completo)
```

---

Esta distribución semana a semana es la que el equipo debe seguir como plan de trabajo. El contenido técnico completo de cada entrega debe cumplir en su totalidad lo especificado en el enunciado oficial del proyecto (documento PDF), independientemente de en qué semana específica se haya avanzado cada parte.

# CHANGELOG

Deben registrar el progreso semanal del proyecto, las tareas realizadas,
los responsables y las ramas utilizadas en este documento.

---

## Equipo del Proyecto
| Nombre        | GitHub / Perfil |
|--------------|-----------------|
| Juan Sebastián Quintero | github.com/jsquintero-co |
| Pablo León | github.com/pablo-leon9 |
| Nicolás Moreno | github.com/NicolasMor-16 |
| Andrés Peña | github.com/Andrés-andrew5588 |

---
# Registro real del proyecto

## Semana 1 (16–22 marzo)

### Objetivos de la semana

-Hacer el modelo E-R
-Hacer el documento técnico
-Montar las tablas
-Hacer las consultas planteadas para la semana 1

### Tareas realizadas

| Tarea | Responsable(s) | Rama utilizada | Descripción |
|------|------|------|------|
|Subir Modelo ER | Juan Sebastián Quintero | features/modelo_er_inicial | Realizó el modelo E-R inicial corregido basado en el del enunciado |
| Actualizar y Subir documento técnico | Andrés Peña, Diego Nicolas Moreno, Pablo León | features/documento-tecnico | Se creó el documento técnico basado en los índices y alcances de la primera entrega del proyecto |
| Montar las tablas | Juan Sebastián Quintero | features/creacion_tablas | Se subieron las tablas de todas las entidades planteadas en el modelo E-R corregido basado en el modelo original del enunciado |
| Hacer las consultas 2 y 6 | Juan Sebastián Quintero, Nicolas Moreno | features/semana1_joins | Se hicieron las consultas 2 y 6 del listado de consultas del enunciado de consultas |

### Cambios principales
- Se subió la imagen del modelo_er_inicial en png corregido ó actualizado basado directamente del enunciado, añadiendo atributos de grupo a las selecciones y atributos de asistencia_registrada a partidos, esto con el objetivo de poder realizar ciertas consultas que necesitan de estos atributos para ser realizadas.
- Se creó el documento técnico del proyecto donde se muestra la situación problema y las motivaciones del proyecto, junto con el modelo E-R corregido basado en el del enunciado del proyecto.
- Se crearon las tablas de cada entidad junto con sus atributos, PK y FK y los constraints.
- Se desarrollaron las consultas 2 y 6 de la lista de consultas del enunciado.
- Se hicieron las consultas de agregación para la semana 2.
### Problemas encontrados
No se han probado aún las consultas por qué aún no se han hecho los INSERTS.
Dudas sobre las limitantes del sistema fueron resueltas en clase con la monitora.

---

## Semana 2 (23–29 marzo)

### Objetivos de la semana
-Implementar y compilar las 5 vistas SQL principales para simplificar la consulta de datos.
-Desarrollar las consultas asignadas y el ciclo de vida básico del partido (INSERT/UPDATE).
-Implementar las vistas SQL requeridas para el proyecto.
-Documentar la utilidad y posibles usos de cada vista.
Probar y verificar el funcionamiento de las vistas, consultas y tablas.
-Realizar las consultas de agregación que fueron dadas para la semana 2 de la lista de enunciados.


### Tareas realizadas

| Tarea | Responsable(s) | Rama utilizada | Descripción |
|------|------|------|------|
| Consultas de agregación de la semana 2. | Juan Sebastián Quintero | features/semana2_agregación.sql | Se hicieron las consultas 1,3,4,5,9,12 y 13 del listado de consultas, estas eran consultas de agregación |
| Generar entre 4 y 5 vistas además de su documentación| Diego Nicolas Moreno Alvarez| sql/entrega1/vistas/vistas.sql | Cada vista debe ir documentada con un comentario indicando su propósito ademas de ser útil, practica y reutilizable a futuro.|
| Desarollar la consulta 15 | Andrés Peña | sql/entrega1/consultas/semana3_consulta_vista.sql | Se desarrolló la consulta 15 utilizando una vista del proyecto. |
| ersión inicial: INSERT y UPDATE  | Pablo Samuel Leon Hernandez | sql/entrega1/dml |Versión inicial: INSERT de un nuevo partido, INSERT de sus dos participaciones, UPDATE del marcador final |

### Cambios principales

Vistas implementadas: Se crearon las vistas modulares para dividir partidos en local/visitante, la vista consolidada de marcadores completos, y las vistas estadísticas de goles por selección y aforo de estadios.

Validación con datos: Se insertaron registros de prueba con sus respectivos COMMIT para verificar que las vistas retornaran datos reales sin errores de identificadores.

Documentación: Se creó el archivo docs/entrega1/vistas.md justificando la modularidad y el valor práctico de las vistas para futuras entregas.
### Problemas encontrados
Para probar que funcionaran las vistas se hizo una prueba simple con solo dos partidos y 4 selecciones para comprobar funcionamiento, a carencia de datos aun no se puede saber si toda la arquitectura funciona correctamente
No se pudieron realizar las consultas 12 y 13 del listado de consultas.
---

## Semana 3 (30 marzo–5 abril)
### Objetivos de la semana
- Definir el DDL final del modelo (tablas, PK, FK con ON DELETE/ON UPDATE, CHECK, UNIQUE).
- Actualizar el ciclo de vida del partido (DML) incluyendo operaciones inválidas y comportamiento de borrado (ON DELETE).
- Desarrollar la consulta 14 del listado de consultas (verificación de integridad).
- Crear roles y privilegios (usuario de solo consulta y usuario operativo) con pruebas de acceso.

### Tareas realizadas
| Tarea | Responsable(s) | Rama/Ruta utilizada | Descripción |
|------|------|------|------|
| DDL del modelo inicial | Juan Sebastián Quintero | sql/entrega1/ddl/ddl_modelo_inicial.sql | Corrección de tablas con PK, FK (con ON DELETE/ON UPDATE), restricciones CHECK y UNIQUE según el enunciado (sección 8.1.2). |
| Consulta 14 (verificación de integridad) | Juan Sebastián Quintero | sql/entrega1/consultas/semana4_verificacion_integridad.sql | Desarrollo de la consulta 14 del listado de consultas del enunciado. |
| Ciclo de vida del partido (DML) y pruebas | Pablo Samuel León Hernández, Andrés Peña | sql/entrega1/dml/dml_ciclo_vida_partido.sql, tests/entrega1/pruebas_dml.md | Actualización del archivo de la Semana 2 con al menos 3 intentos de operación inválida documentados y demostración del comportamiento ON DELETE en al menos 2 relaciones distintas; documentación de cada caso y resultado en pruebas_dml.md. |
| Roles y privilegios | Diego Nicolás Moreno Álvarez | sql/entrega1/roles/roles_privilegios.sql, tests/entrega1/pruebas_privilegios.md | Creación de al menos 2 usuarios/roles (uno de solo consulta y otro operativo) con sentencias GRANT/REVOKE correspondientes, y evidencia en pruebas_privilegios.md de que cada usuario solo puede realizar lo que le corresponde. |
| Creación de subconsultas semana 3| Juan Sebastián Quintero | features/semana3_subconsultas| Se crearon las consultas de la semana 3 (subconsultas) |

### Cambios principales
Se isntauraron roles ademas de los inicials grant revokes, las subconsultas de la semana correspondiente, documentaciones sobre las actualizacions y pruebas en un clico de vida ademas de comprobaciones de condciones minimas.


### Problemas encontrados


---

## Semana 4 (13–22 abril)

### Objetivos de la semana

Objetivos de la semana
Traducir al álgebra relacional al menos 4 de las 15 consultas implementadas.
Realizar la evaluación crítica del modelo inicial y proponer ajustes para el modelo ampliado.
Completar el documento técnico, incluyendo el modelo lógico y el diccionario de datos.
Fusionar las ramas pendientes a main.
Actualizar el CHANGELOG.md con el cierre de la Entrega 1.
Aunque ya se hizo la entrega 1 se siguen aqui lso añadidos particulares despues del cambio de cronograma

### Tareas realizadas

| Tarea | Responsable(s) | Rama utilizada | Descripción |
|------|------|------|------|
| Álgebra relacional | Juan Sebastian Quintero | features/algebra_relacional | Traducción de al menos 4 de las 15 consultas a notación de álgebra relacional (σ, π, ▷◁, → , τ, y). |
| Evaluación crítica del modelo inicial | Diego Nicolas Moreno Alvarez | docs/entrega1/evaluacion_critica_modelo_inicial.md | Identificación de problemas del modelo inicial, propuesta de ajustes y elaboración del boceto conceptual del modelo ampliado. |
| Documento técnico y diccionario de datos | Pablo Samuel Leon Hernandez | docs/entrega1/documento_tecnico.md | Completar la transformación al modelo lógico relacional, justificando PK, FK y cardinalidades, además del diccionario de datos y revisión de las secciones del documento. |
| Merge de ramas a main | | | Integración de las ramas pendientes para cerrar la Entrega 1. |
| Agregar diccionario de datos | Andrés Peña | feature/documento-tecnico | Se agregó el diccionario de datos completo del proyecto, incluyendo tablas, campos, restricciones, relaciones principales, vista creada y datos registrados. |
| Actualización del CHANGELOG | Diego Nicolas Moreno Alvarez | main/CHANGELOG.md | Registro de los cambios finales realizados durante la Entrega 1. |
### Cambios principales
Se incorporó la representación en álgebra relacional de consultas del proyecto usando proyección, selección, ordenamiento, agrupamiento y asignación.
Se documentaron problemas y mejoras propuestas para el modelo inicial.
Se completó la documentación del modelo lógico relacional y el diccionario de datos.
La integraron las ramas pendientes en main.
Además actualizó el CHANGELOG.md con los cambios de la Entrega 1.

### Problemas encontrados
Se requirió revisar la coherencia entre la documentación, el modelo lógico y lo implementado, debido a las posibles nuevas normas o al choque de logicas.
Fue necesario coordinar la integración de las diferentes ramas antes del cierre de la entrega adem+as de corregir diversos errores en el formato o en nombres de rama.
Se encontraron fallos en lso nombre y carpetas que tuvieron que ser corregidos.
No se logró hacer las consultas en LaTex para el .md de álgebra relacional.
Se usó el Símbolo de natural JOIN cómo reemplazo del Inner JOIN por temas de eficiencia por lo que no se pudieron hacer las consultas en LaTex.


## Semana 6 (Entrega 2- Semana 1)
### Objetivos de la semana

Ampliar el modelo lógico relacional, cumpliendo el requisito de entre 12 y 16 tablas bien normalizadas. Elaborar el diagrama del modelo lógico ampliado y completar el diccionario de datos para todas las entidades. Organizar la estructura de carpetas correspondiente a la Entrega 2 y actualizar el CHANGELOG.md con los avances realizados.

### Tareas realizadas
| Tarea | Responsable(s) | Rama utilizada | Descripción |
|------|------|------|------|
|   | Juan Sebastian Quintero |  |   |
|  | Diego Nicolas Moreno Alvarez |  |  |
|  |  |  |  |
|  | Pablo Leon Hernandez| |  |
|  | Andrés Peña |  |  |
| Actualización del CHANGELOG | Diego Nicolas Moreno Alvarez | main/CHANGELOG.md | Registro de los cambios finales realizados durante la Entrega 1. |
### Cambios principales

Ampliación del modelo lógico	Por definir	Por definir	Extensión del modelo relacional a partir de la evaluación del modelo inicial, incorporando las entidades y relaciones necesarias y manteniendo una estructura normalizada.
Diagrama del modelo lógico	Por definir	Por definir	Elaboración del diagrama del modelo ampliado e incorporación a la documentación del proyecto.
Diccionario de datos ampliado	Por definir	Por definir	Documentación de todas las tablas y sus atributos, incluyendo tipos de datos, descripciones y restricciones.
Organización de carpetas	Por definir	Por definir	Preparación de la estructura de directorios para la documentación, los scripts SQL y las pruebas de la Entrega 2.
Actualización del CHANGELOG	Por definir	Por definir	Registro de los cambios realizados durante la primera semana de trabajo de la Entrega 2.
Cambios principales

Se amplió el modelo lógico relacional tomando como referencia la evaluación crítica realizada durante la Entrega 1. Se incorporaron las entidades y relaciones necesarias para representar los requerimientos del sistema, procurando mantener la normalización y la coherencia del modelo.

Se elaboró el diagrama lógico y se amplió el diccionario de datos para documentar los atributos, tipos de datos y restricciones de las entidades.

Además, se organizó la estructura de carpetas correspondiente a la Entrega 2 y se actualizaron los registros de cambios del proyecto.

### Problemas encontrados
Por completar según las dificultades identificadas durante el desarrollo de las tareas.

## Semana 6 (Entrega 2- Semana 2)
### Objetivos de la semana

Implementar en SQL el modelo lógico ampliado mediante la creación de todas las tablas. Definir las claves primarias y foráneas, las restricciones de integridad y los índices necesarios. Documentar el modelo físico y justificar las decisiones relacionadas con los índices. Elaborar un conjunto de datos de prueba coherente con las entidades y relaciones del modelo ampliado y actualizar el CHANGELOG.md.

### Tareas realizadas
| Tarea | Responsable(s) | Rama utilizada | Descripción |
|------|------|------|------|
| | Juan Sebastian Quintero |  |  |
|  | Diego Nicolas Moreno Alvarez |  |  |
|  | Pablo Samuel Leon Hernandez |  |  |
| | Andrés Peña |  |  |
| Actualización del CHANGELOG | Diego Nicolas Moreno Alvarez | main/CHANGELOG.md | Registro de los cambios finales realizados durante la Entrega 1. |
### Cambios principales

Se implementó el modelo ampliado mediante un script DDL que define las tablas, las claves primarias y foráneas, las restricciones de integridad y los índices necesarios para la estructura de la base de datos.

Se documentó el modelo físico, incluyendo la representación de las relaciones implementadas y la justificación de los índices según las necesidades de consulta y acceso a los datos.

También se elaboró un script DML con un conjunto de datos de prueba coherente con las entidades y relaciones del modelo, con el propósito de facilitar la validación de la implementación.

Finalmente, se actualizó el CHANGELOG.md para registrar los cambios realizados durante esta fase del proyecto.

Problemas encontrados

Por completar según las dificultades identificadas durante la implementación, la carga de datos y la validación del modelo físico.

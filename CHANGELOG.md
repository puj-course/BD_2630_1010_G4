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
-Para probar que funcionaran las vistas se hizo una prueba simple con solo dos partidos y 4 selecciones para comprobar funcionamiento, a carencia de datos aun no se puede saber si toda la arquitectura funciona correctamente

---

## Semana 3 (30 marzo–5 abril)
### Objetivos de la semana
- Definir el DDL final del modelo (tablas, PK, FK con ON DELETE/ON UPDATE justificados, CHECK, UNIQUE e índices).
- Actualizar el ciclo de vida del partido (DML) incluyendo operaciones inválidas y comportamiento de borrado (ON DELETE).
- Desarrollar la consulta 14 del listado de consultas (verificación de integridad).
- Crear roles y privilegios (usuario de solo consulta y usuario operativo) con pruebas de acceso.
- Actualizar el CHANGELOG.md del proyecto.

### Tareas realizadas
| Tarea | Responsable(s) | Rama/Ruta utilizada | Descripción |
|------|------|------|------|
| DDL del modelo inicial | Juan Sebastián Quintero | sql/entrega1/ddl/ddl_modelo_inicial.sql | Definición de tablas con PK, FK (con ON DELETE/ON UPDATE justificados por comentario), restricciones CHECK y UNIQUE según el enunciado (sección 8.1.2), e índices estratégicos comentados. |
| Consulta 14 (verificación de integridad) | Juan Sebastián Quintero | sql/entrega1/consultas/semana4_verificacion_integridad.sql | Desarrollo de la consulta 14 del listado de consultas del enunciado. |
| Ciclo de vida del partido (DML) y pruebas | Pablo Samuel León Hernández, Andrés Peña | sql/entrega1/dml/dml_ciclo_vida_partido.sql, tests/entrega1/pruebas_dml.md | Actualización del archivo de la Semana 2 con al menos 3 intentos de operación inválida documentados y demostración del comportamiento ON DELETE en al menos 2 relaciones distintas; documentación de cada caso y resultado en pruebas_dml.md. |
| Roles y privilegios | Diego Nicolás Moreno Álvarez | sql/entrega1/roles/roles_privilegios.sql, tests/entrega1/pruebas_privilegios.md | Creación de al menos 2 usuarios/roles (uno de solo consulta y otro operativo) con sentencias GRANT/REVOKE correspondientes, y evidencia en pruebas_privilegios.md de que cada usuario solo puede realizar lo que le corresponde. |
| Actualización de CHANGELOG.md | Diego Nicolás Moreno Álvarez | — | Pendiente: aún sin avance. |

### Cambios principales


### Problemas encontrados


---

## Semana 4 (13–22 abril)

### Objetivos de la semana

(Describan qué querían lograr esta semana)

### Tareas realizadas

| Tarea | Responsable(s) | Rama utilizada | Descripción |
|------|------|------|------|
| | | | |
| | | | |
| | | | |

### Cambios principales


### Problemas encontrados

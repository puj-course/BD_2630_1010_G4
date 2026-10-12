# Justificación del Proceso de Normalización (1FN, 2FN y 3FN)

Este documento detalla el análisis de normalización aplicado sobre el modelo relacional del sistema de la Copa Mundial de la FIFA, compuesto por 16 entidades. El objetivo de este diseño es garantizar la consistencia de los datos, eliminar redundancias operativas y asegurar que cada hecho del torneo se registre en un único lugar lógico.

---

## 1. Primera Forma Normal (1FN)

Una relación cumple con la Primera Forma Normal si todos sus atributos contienen valores atómicos (indivisibles) y no existen grupos repetitivos ni colecciones dentro de una misma columna.

En nuestro modelo, la 1FN se garantiza a partir de las siguientes decisiones:

* **Atomicidad en los datos:** Cada columna almacena un único valor simple. Por ejemplo, en `JUGADOR` se guardan el nombre y la fecha de nacimiento de forma individual, y en `EDICION_MUNDIAL` las fechas de inicio y fin van separadas. No se utilizan campos de texto para empaquetar listas de valores ni estructuras compuestas.
* **Eliminación de grupos repetitivos:** En lugar de crear columnas fijas como `arbitro_1`, `arbitro_2` o `jugador_1`, `jugador_2` dentro de las tablas de partidos, cada asignación o convocatoria se modela como un registro independiente en una tabla puente (`ASIGNACION_ARBITRAL` y `CONVOCATORIA_JUGADOR`).
* **Desacoplamiento de eventos individuales:** Las estadísticas no se guardan como cadenas concatenadas dentro del partido. Cada registro de `ESTADISTICA_JUGADOR_PARTIDO` representa el desempeño puntual de un único jugador en un único partido, asegurando que métricas como goles o minutos jugados sean números atómicos fáciles de sumar y auditar.
* **Identificación unívoca:** Cada tabla cuenta con una clave primaria definida (`pk_*`), asegurando que no existan tuplas duplicadas en el sistema.

---

## 2. Segunda Forma Normal (2FN)

La Segunda Forma Normal exige que el esquema esté en 1FN y que ningún atributo que no forme parte de una clave dependa de manera parcial de una clave candidata compuesta. Es decir, debe existir dependencia funcional completa.

El análisis de 2FN en nuestro esquema se aborda desde dos perspectivas:

### Claves primarias subrogadas
Todas las tablas del sistema implementan un identificador numérico artificial simple como clave primaria (`id_*`). Al tener claves primarias formadas por un solo atributo, no existe posibilidad formal de dependencias parciales respecto a la clave primaria principal, satisfaciendo la 2FN por definición estructural.

### Dependencia funcional completa en claves naturales alternas
Para asegurar que el diseño sea fiel a la realidad del negocio, evaluamos las tablas asociativas considerando sus claves candidatas compuestas naturales:

* **`CONVOCATORIA_JUGADOR` (Clave natural: `id_jugador, id_seleccion`):** Atributos como `dorsal` y `es_capitan` dependen de la combinación de ambos. El número de camiseta y el rol de capitán no le pertenecen al jugador de forma eterna ni a la selección en el vacío, sino a ese jugador convocado en esa edición por ese equipo.
* **`PARTICIPACION_PARTIDO` (Clave natural: `id_partido, id_seleccion`):** La `condicion` (local o visitante) y los `goles_marcados` solo tienen sentido cuando se conoce qué selección jugó en qué encuentro específico.
* **`ASIGNACION_ARBITRAL` (Clave natural: `id_partido, rol`):** El árbitro designado (`id_arbitro`) responde a la combinación del partido y la función a desempeñar en la cancha (árbitro central, cuarto árbitro o VAR).
* **`ESTADISTICA_JUGADOR_PARTIDO` (Clave natural: `id_partido, id_jugador`):** Goles, tiros, tarjetas y minutos jugados describen únicamente la actuación de ese jugador puntual durante los 90 minutos de ese compromiso.

Al no existir atributos descriptivos que dependan únicamente de una parte de la clave natural, el modelo cumple plenamente con la 2FN.

---

## 3. Tercera Forma Normal (3FN)

La Tercera Forma Normal requiere estar en 2FN y que no existan dependencias transitivas. Esto significa que ningún atributo no clave puede depender funcionalmente de otro atributo no clave; los datos deben depender directa y exclusivamente de la clave.

En la transición del modelo inicial al modelo ampliado se corrigieron varias transitividades clave:

### Jerarquía geográfica y de infraestructura
En el modelo inicial, la entidad `ESTADIO` concentraba información de ciudad y país de sede. Esto generaba redundancia, pues si un país cambiaba de sede o una ciudad modificaba su nombre, tocaba actualizarlo en cada estadio repetido. En este modelo se desacopló la jerarquía en cuatro niveles independientes:

EDICION_MUNDIAL -> SEDE -> CIUDAD -> ESTADIO

Cada tabla guarda solo los atributos propios de su nivel territorial (`nombre` en ciudad, `capacidad` en estadio, `pais` en sede), eliminando la dependencia transitiva entre el estadio y el país sede.

### Estructura deportiva y confederaciones
Originalmente, `SELECCION` almacenaba directamente el texto de la confederación. Para evitar anomalías de modificación y asegurar consistencia institucional, se aisló la entidad `FEDERACION`, la cual contiene la sigla oficial y su confederación asociada. De esta manera, `SELECCION` solo referencia a su federación correspondiente sin duplicar información organizativa.

### Manejo de eventos e incidencias
Tanto las `INCIDENCIA` como los sucesos individuales se desacoplaron de los datos generales del encuentro. La tabla `INCIDENCIA` registra sucesos operativos ocurridos durante el partido (como revisiones del VAR, interrupciones climáticas o fallas de iluminación) referenciando únicamente a `PARTIDO`, con su minuto y tipo de evento, evitando mezclar incidencias logísticas con el resultado deportivo consolidado.

---

## 4. Reglas Semánticas Complementarias de Integridad

Algunas reglas de negocio específicas del torneo no pueden resolverse únicamente mediante formas normales y se gestionan a nivel de restricciones lógicas en el motor:

* **Unicidad de capitán en selección:** El atributo `es_capitan` en `CONVOCATORIA_JUGADOR` define si un convocado porta el brazalete. Como una selección solo puede tener un capitán titular registrado en una convocatoria, esta regla se plantea controlar mediante un trigger de validación a nivel de base de datos antes de registrar o modificar filas, impidiendo que existan dos registros afirmativos para una misma selección.

## 5. Conclusion

El modelo relacional cumple con las tres formas normales:

- **1FN:** atributos atomicos y sin grupos repetidos
- **2FN:** sin dependencias parciales de claves compuestas
- **3FN:** sin dependencias transitivas entre atributos no clave

Las decisiones de diseño (separacion de SEDE, CIUDAD y ESTADIO. creacion de FEDERACION. uso de tablas intermedias) garantizan un modelo escalable y sin redundancias

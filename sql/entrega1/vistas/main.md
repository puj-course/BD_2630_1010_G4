# Enfoque General y Filosofía de Diseño

Cuando nos enfrentamos al diseño inicial de la base de datos para la
Copa Mundial de la FIFA, notamos que el modelo base resuelve los
partidos mediante una entidad intermedia llamada
`PARTICIPACION_PARTIDO`. Esto implica que la información de un solo
encuentro deportivo queda fragmentada en dos filas separadas: una para
el equipo local y otra para el visitante.

Si un analista, un sistema web o una aplicación de consulta intenta leer
los resultados, se ve obligado a realizar combinaciones (*JOINs*) entre
varias tablas para obtener la información completa de un partido. Por
este motivo, nuestro diseño de vistas no busca únicamente mostrar datos,
sino facilitar la forma en que estos pueden ser consultados.

La propuesta se basa en una estrategia modular:

1.  Crear dos vistas especializadas, una para la selección local y otra
    para la visitante.

2.  Unificar ambas perspectivas en una tercera vista que presente el
    partido completo.

3.  Construir vistas que agrupen información estadística para facilitar
    consultas sobre goles y ocupación de estadios.

De esta manera, las vistas funcionan como una capa intermedia entre la
estructura interna de la base de datos y la información que necesitan
consultar los usuarios.

# Detalle y Justificación de las Vistas

## Vista 1: `v_partidos_local`

**Propósito y Planteamiento:**

Esta vista muestra únicamente la información relacionada con las
selecciones que participan como locales. A partir de la tabla
`PARTICIPACION_PARTIDO`, se filtran los registros cuya condición es
`’LOCAL’` y se obtiene el país y la cantidad de goles marcados.

**Valor y Escenarios de Uso:**

Esta vista facilita las consultas relacionadas con los equipos que
juegan como locales. También permite separar esta información antes de
construir una vista que muestre el partido completo.

Para un usuario, esto significa que no necesita conocer la estructura de
la tabla de participación para saber qué selección jugó como local y
cuántos goles marcó.

    CREATE OR REPLACE VIEW v_partidos_local AS
    SELECT 
        p.id_partido,
        p.fecha_hora,
        p.fase,
        s.pais AS equipo_local,
        pp.goles_marcados AS goles_local
    FROM PARTIDO p
    JOIN PARTICIPACION_PARTIDO pp 
        ON p.id_partido = pp.id_partido
    JOIN SELECCION s 
        ON pp.id_seleccion = s.id_seleccion
    WHERE pp.condicion = 'LOCAL';

## Vista 2: `v_partidos_visitante`

**Propósito y Planteamiento:**

Esta vista cumple una función similar a la anterior, pero se concentra
en las selecciones que participan como visitantes. De esta forma, se
obtiene el país visitante y los goles marcados en cada partido.

**Valor y Escenarios de Uso:**

Su principal utilidad es facilitar la consulta de los equipos visitantes
y permitir que posteriormente esta información pueda combinarse con la
vista de los equipos locales.

Para un usuario que solo necesita consultar quién jugó como visitante y
cuál fue su resultado, esta vista evita tener que revisar directamente
la tabla de participación.

    CREATE OR REPLACE VIEW v_partidos_visitante AS
    SELECT 
        p.id_partido,
        s.pais AS equipo_visitante,
        pp.goles_marcados AS goles_visitante
    FROM PARTIDO p
    JOIN PARTICIPACION_PARTIDO pp 
        ON p.id_partido = pp.id_partido
    JOIN SELECCION s 
        ON pp.id_seleccion = s.id_seleccion
    WHERE pp.condicion = 'VISITANTE';

## Vista 3: `v_partido_completo`

**Propósito:**\
Esta vista reúne la información de las dos vistas anteriores para
mostrar un partido completo en una sola fila. De esta manera, en lugar
de consultar por separado al equipo local y al visitante, se puede
obtener directamente el enfrentamiento y su marcador.

**Posible uso:**\
Podría utilizarse en una página o aplicación para mostrar los resultados
del torneo de una manera sencilla. Por ejemplo:

> Colombia 2 -- Argentina 1\
> 20 de agosto de 2026

Así, una consulta que normalmente requeriría relacionar varias tablas
puede realizarse directamente sobre la vista.

    CREATE OR REPLACE VIEW v_partido_completo AS
    SELECT 
        l.id_partido,
        l.fecha_hora,
        l.fase,
        l.equipo_local,
        l.goles_local,
        v.goles_visitante,
        v.equipo_visitante
    FROM v_partidos_local l
    JOIN v_partidos_visitante v 
        ON l.id_partido = v.id_partido;

## Vista 4: `v_goles_selecion`

**Propósito:**\
Esta vista resume los goles realizados por cada selección y muestra la
cantidad de partidos jugados y el promedio de goles por partido.

**Posible uso:**\
Podría utilizarse para generar rápidamente un ranking de las selecciones
con más goles o comparar su rendimiento durante el torneo.

Por ejemplo, una aplicación podría mostrar:

> 1\. Colombia -- 12 goles\
> 2. Argentina -- 10 goles\
> 3. Brasil -- 9 goles

De esta forma, el usuario puede consultar información estadística sin
tener que revisar cada partido individualmente.

    CREATE OR REPLACE VIEW v_goles_selecion AS
    SELECT 
        s.pais,
        s.confederacion,
        COUNT(pp.id_partido) AS partidos_jugados,
        SUM(pp.goles_marcados) AS total_goles,
        ROUND(AVG(pp.goles_marcados), 2) AS promedio_goles
    FROM SELECCION s
    JOIN PARTICIPACION_PARTIDO pp 
        ON s.id_seleccion = pp.id_seleccion
    GROUP BY s.pais, s.confederacion;

## Vista 5: `v_ocupacion_estadios`

**Propósito:**\
Esta vista muestra información sobre la cantidad de personas que asisten
a los partidos y el porcentaje promedio de ocupación de cada estadio.

**Posible uso:**\
Puede ser útil para los organizadores del torneo y también para futuros
usuarios que quieran conocer qué tan concurrida es una sede.

Por ejemplo, se podría utilizar para identificar rápidamente los
estadios con mayor ocupación o aquellos que normalmente tienen una menor
asistencia.

En una versión futura del sistema, esta información podría combinarse
con datos de boletería, precios y disponibilidad de entradas para que
una persona pueda consultar dónde y cuándo se juega un partido y planear
su asistencia.

    CREATE OR REPLACE VIEW v_ocupacion_estadios AS
    SELECT 
        e.nombre AS estadio,
        e.ciudad,
        e.capacidad,
        COUNT(p.id_partido) AS partidos_albergados,
        SUM(p.asistencia_registrada) AS asistencia_total,
        ROUND(
            AVG((p.asistencia_registrada / e.capacidad) * 100), 
            2
        ) AS porcentaje_ocupacion_promedio
    FROM ESTADIO e
    JOIN PARTIDO p 
        ON e.id_estadio = p.id_estadio
    GROUP BY e.nombre, e.ciudad, e.capacidad;

# Utilidad de las Vistas

Las vistas permiten presentar la información de la base de datos de una
forma más sencilla para diferentes necesidades. Aunque internamente un
partido puede requerir relacionar varias tablas, una vista puede
entregar directamente la información que necesita el usuario.

Por ejemplo, un aficionado puede querer consultar rápidamente el
resultado de un partido, un periodista puede necesitar un ranking de
selecciones por goles y un organizador puede estar interesado en la
ocupación de los estadios.

Para futuras entregas, estas vistas pueden ampliarse con la información
de nuevas entidades como jugadores, árbitros, tarjetas o boletería. De
esta forma, podrían crearse consultas similares para conocer los máximos
goleadores, las tarjetas recibidas o incluso información útil para una
persona que quiera asistir a un partido.

En general, el objetivo es que la estructura interna de la base de datos
no sea una dificultad para quien necesita consultar la información. Las
vistas permiten dejar preparadas consultas frecuentes y presentar los
datos de una manera más directa.

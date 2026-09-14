# Descripcion del problema y el alcance del sistema

## Descripcion del problema

Actualmente, los datos de la Copa Mundial como sedes, estadios,
selecciones y partidos se maneja entre archivos separados, lo que genera
varios problemas. Como repetición de datos con diferentes valores en
archivos diferentes, diferente capacidad del estadio en fuentes
diferentes. Y al no haber un control centralizado, es posible crear
partidos en estadios inexistentes o registrar selecciones no validas,
dejando registros huerfanos sin forma de verificar que la información
sea limpia y confiable.

Hacer consultas basicas como el ranking de goleadores o el porcentaje de
ocupacion de los estadios requiere trabajo manual y termina siendo muy
poco confiable, porque los datos no relacionados correctamente. Tampoco
hay control sobre quien modifica los datos ni una forma de validar estos
mismos. Con este proyecto se busca centralizar todo en una base de datos
relacional que aplique reglas claras mediante llaves y restricciones,
para que las consultas sean rapidas, los datos consistentes y se eviten
errores que hoy ocurren con la gestion dispersa de los datos.

## El alcance del sistema

**Fase y Grupo como atributos en letras**

Los atributos `fase` (en PARTIDO) y `grupo` (en SELECCION) se definieron
como texto libre, lo cual no garantiza consistencia en los valores
ingresados (por ejemplo, "Cuartos" vs "cuartos de final"). Como
ajuste propuesto para el modelo ampliado, se convertirían en dominios
cerrados o entidades catálogo (`FASE`, `GRUPO`), resolviendo el problema
de raíz.

**Límite de selecciones por grupo**

El modelo inicial no garantiza que un grupo tenga máximo cuatro
selecciones asociadas, ya que `grupo` es texto libre. Esta restricción
de negocio no está representada y se abordará en una etapa posterior del
proyecto.

**Asistencia registrada como atributo simple de PARTIDO**

`asistencia_registrada` se dejó como atributo directo de PARTIDO porque
el modelo inicial no maneja boletería detallada. Es una simplificación
válida para esta entrega; más adelante correspondería derivarse de una
entidad de boletería.

**Resultado del partido no derivado del marcador**

El modelo no guarda el resultado (ganó/perdió/empató) de forma
explícita; debería derivarse del marcador de ambas participaciones para
evitar inconsistencias. Se define en una etapa posterior del proyecto.

**Datos ficticios, no biométricos ni representativos de personas
reales**

El sistema no puede reflejar identidades ni datos reales de jugadores,
árbitros o espectadores, lo cual es una limitante de alcance del
proyecto, no del modelo.

**Cruce de horarios en un mismo estadio**

El sistema permite programar dos partidos en el mismo estadio y a la misma hora por error, ya que no revisa si la cancha está ocupada. Por ahora se asume que los horarios se ingresan bien, y más adelante se agregará una regla para evitar estos cruces.

# Supuestos del modelado

- La Entrega 1 se desarrolla sobre el modelo inicial de cinco entidades:
  EDICION_MUNDIAL, ESTADIO, SELECCION, PARTIDO y
  PARTICIPACION_PARTIDO. Las ampliaciones a entidades como jugadores,
  árbitros, estadísticas detalladas, boletería o incidencias corresponden
  a etapas posteriores del proyecto.

- Cada estadio pertenece a una edición del torneo y puede albergar
  múltiples partidos. Cada partido se encuentra asociado a un único
  estadio, una única edición y una fecha y hora determinada.

- Cada partido enfrenta exactamente a dos selecciones. Esta relación se
  representa mediante PARTICIPACION_PARTIDO, donde cada registro
  corresponde a una selección participante en un partido y permite
  almacenar su condición y los goles marcados.

- Una selección puede participar en múltiples partidos durante una
  edición, mientras que una participación pertenece a un único partido y
  a una única selección.

- Los goles marcados se almacenan por participación de cada selección
  dentro del partido. El resultado del partido (ganado, perdido o
  empatado) se considera derivable a partir de los goles registrados y no
  se almacena como un atributo independiente.

- Para esta entrega, la asistencia registrada se maneja directamente
  como un atributo de PARTIDO. Se asume que este valor permite estimar la
  ocupación del estadio al compararlo con su capacidad.

- Los datos utilizados en el proyecto son ficticios y se emplean con
  fines académicos. No se almacenan datos personales sensibles reales de
  jugadores, árbitros, periodistas o espectadores.

# Modelo entidad relacion

Se añadieron y ajustaron algunos atributos para que el modelo pueda
responder correctamente a las 15 consultas solicitadas sin necesidad de
crear nuevas entidades.

Se agregó *asistencia_registrada* en `PARTIDO` porque la consulta 2
necesita calcular el porcentaje de ocupación de cada estadio comparando
la asistencia del partido con la capacidad del estadio. Esta información
también es necesaria para la consulta 8, que busca los estadios cuya
ocupación está por encima del promedio.

También se agregó *grupo* en `SELECCION`, con el objetivo de identificar
a qué grupo pertenece cada selección. Esto permite construir la tabla de
posiciones y resolver la consulta 15, en la que se debe determinar qué
selección lidera cada grupo simulado.

Los demás atributos originales ya proporcionaban la información
necesaria para resolver las consultas relacionadas con goles,
diferencias de gol, partidos, selecciones y estadios.

# Diagrama

<figure id="fig:modelo entidad relacion" data-latex-placement="H">
<p><img src="./modelo e-r.png" style="width:80.0%" alt="image" /> <span
id="fig:modelo entidad relacion"
data-label="fig:modelo entidad relacion"></span></p>
</figure>

# Transformacion a modelo logico relacional

A partir del modelo entidad relacion inicial se realizo la transformacion al modelo logico relacional. Cada entidad se convirtio en una tabla, y cada relacion se represento mediante claves foraneas, a continuacion se presenta el esquema relacional resultante y la justificacion de cada decision de diseño:

## Esquema relacional
|tabla|atributos|PK|FK|
|---|---|---|---|
|EDICION_MUNDIAL|id_edicion, anio, pais_sede, lema, fecha_inicio, fecha_fin|id_edicion|-|
|ESTADIO|id_estadio, id_edicion, nombre, ciudad, capacidad|id_estadio|id_edicion->EDICION_MUNDIAL(id_edicion)|
|SELECCION|id_seleccion, id_edicion, pais, confederacion, grupo|id_seleccion|id_edicion->EDICION_MUNDIAL(id_edicion)|
|PARTIDO|id_partido, id_edicion, id_estadio, fecha_hora, fase, asistencia_registrada|id_partido|id_edicion->EDICION_MUNDIAL(id_edicion), id_estadio->ESTADIO(id_estadio)|
|PARTICIPACION_PARTIDO|id_participacion, id_partido, id_seleccion, condicion, goles_marcados|id_participacion|id_partido->PARTIDO(id_partido), id_seleccion->SELECCION(id_seleccion)|

## Justificacion de llaves primarias (PK)

|tabla|PK|justificacion|
|---|---|---|
|EDICION_MUNDIAL|id_edicion|identifica de forma unica cada edicion del torneo, no depende de otros datos como el año o el pais sede|
|ESTADIO|id_estadio|identifica de forma unica cada estadio, Se usa un ID en lugar del nombre porque dos estadios pueden compartir el nombre en ciudades diferentes|
|SELECCION|id_seleccion|identifica de forma unica cada seleccion participante, no se usa el país porque una misma seleccion puede participar en varias ediciones|
|PARTIDO|id_partido|identifica de forma unica cada partido del torneo, la combinacion de fecha, estadio y selecciones no es suficiente y puede ser mas confuso|
|PARTICIPACION_PARTIDO|id_participacion|identifica de forma unica cada participacion. aunque existe id_partido y id_seleccion, se opto por una PK extra para agilizar referencias futuras y operaciones de actualizacion|

## Justificación de llaves foráneas (FK)

|FK|tabla origen|tabla destino|justificacion|
|---|---|---|---|
|estadio_edicion|ESTADIO|EDICION_MUNDIAL|un estadio debe tener una edicion asociada|
|seleccion_edicion|SELECCION|EDICION_MUNDIAL|una seleccion debe tener una edicion asociada|
|partido_edicion|PARTIDO|EDICION_MUNDIAL|un partido debe tener una edicion asociada|
|partido_estadio|PARTIDO|ESTADIO|un partido debe jugarse en un estadio existente|
|participacion_partido|PARTICIPACION_PARTIDO|PARTIDO|una participacion debe estar asociada a un partido existente|
|participacion_seleccion|PARTICIPACION_PARTIDO|SELECCION|una participacion debe estar asociada a una seleccion existente|

## Justificación de cardinalidades

|relacion|cardinalidad|justificacion|
|---|---|---|
|EDICION_MUNDIAL->ESTADIO|1:N|una edicion del mundial puede tener muchos estadios, pero cada estadio pertenece a una sola edicion|
|EDICION_MUNDIAL->SELECCION|1:N|una edicion puede tener muchas selecciones participantes, pero cada seleccion compite en una sola edicion|
|EDICION_MUNDIAL->PARTIDO|1:N|una edicion puede tener muchos partidos, pero cada partido pertenece a una sola edicion|
|ESTADIO->PARTIDO|1:N|un estadio puede tener muchos partidos a lo largo del torneo, pero cada partido se juega en un solo estadio|
|PARTIDO<->SELECCION|N:M|un partido enfrenta a dos selecciones, y una seleccion participa en muchos partidos|


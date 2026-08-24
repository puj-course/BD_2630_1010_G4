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

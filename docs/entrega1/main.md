# Introduccion

# Descripcion del problema y el alcance del sistema

Actualmente, los datos de la Copa Mundial como sedes, estadios,
selecciones y partidos se maneja entre archivos separados, lo que genera
varios problemas. Como repetición de datos con diferentes valores en
archivos diferenetes, diferente capacidad del estadio en fuentes
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

# Supuestos del modelado

# Modelo entidad relacion

<figure id="fig:modelo entidad relacion" data-latex-placement="H">
<p><img src="./modelo e-r.png" style="width:80.0%" alt="image" /> <span
id="fig:modelo entidad relacion"
data-label="fig:modelo entidad relacion"></span></p>
</figure>

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

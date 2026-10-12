```sql
-- Entrega 2 - Consultas avanzadas, parte 1
-- Analisis deportivo y operativo del Mundial

-- 1. Ranking de goleadores por edicion
-- Muestra los goles registrados por jugador en cada edicion.

with goles_jugador as (
    select
        p.id_edicion,
        e.anio,
        j.id_jugador,
        j.nombre,
        sum(est.goles) as total_goles,
        count(distinct p.id_partido) as partidos_jugados
    from estadistica_jugador_partido est
    join jugador j
        on j.id_jugador = est.id_jugador
    join partido p
        on p.id_partido = est.id_partido
    join edicion_mundial e
        on e.id_edicion = p.id_edicion
    group by
        p.id_edicion,
        e.anio,
        j.id_jugador,
        j.nombre
)
select
    anio,
    nombre as jugador,
    total_goles,
    partidos_jugados
from goles_jugador
where total_goles > (
    select avg(total_goles)
    from goles_jugador
)
order by anio, total_goles desc;


-- 2. Rendimiento de las selecciones por grupo
-- Compara goles a favor, goles en contra y diferencia de gol.

with goles_por_seleccion as (
    select
        pp.id_partido,
        pp.id_seleccion,
        pp.goles_marcados as goles_favor,
        rival.goles_marcados as goles_contra
    from participacion_partido pp
    join participacion_partido rival
        on rival.id_partido = pp.id_partido
        and rival.id_seleccion <> pp.id_seleccion
)
select
    e.anio,
    g.nombre as grupo,
    s.pais as seleccion,
    sum(gps.goles_favor) as goles_favor,
    sum(gps.goles_contra) as goles_contra,
    sum(gps.goles_favor) - sum(gps.goles_contra) as diferencia_gol
from goles_por_seleccion gps
join seleccion s
    on s.id_seleccion = gps.id_seleccion
join partido p
    on p.id_partido = gps.id_partido
join edicion_mundial e
    on e.id_edicion = p.id_edicion
left join grupo g
    on g.id_grupo = s.id_grupo
group by
    e.anio,
    g.nombre,
    s.pais
order by
    e.anio,
    g.nombre,
    diferencia_gol desc;


-- 3. Asistencia promedio y ocupacion por fase
-- Permite comparar la asistencia registrada con la capacidad de los estadios.

select
    e.anio,
    f.nombre as fase,
    count(p.id_partido) as partidos_jugados,
    round(avg(p.asistencia_registrada), 2) as asistencia_promedio,
    round(
        avg(p.asistencia_registrada / nullif(es.capacidad, 0)) * 100,
        2
    ) as ocupacion_promedio_porcentaje
from partido p
join edicion_mundial e
    on e.id_edicion = p.id_edicion
join fase f
    on f.id_fase = p.id_fase
join estadio es
    on es.id_estadio = p.id_estadio
group by
    e.anio,
    f.nombre
having count(p.id_partido) > 0
order by
    e.anio,
    partidos_jugados desc;
```

-- Entrega 2 - Semana 2
-- DDL modelo ampliado
-- Base de datos Mundial FIFA


-- EDICION_MUNDIAL
create table edicion_mundial (
    id_edicion number(10) constraint pk_edicion_mundial primary key,
    anio number(4) not null,
    lema varchar2(200),
    fecha_inicio date not null,
    fecha_fin date not null,

    constraint uq_edicion_anio unique (anio),
    constraint ck_edicion_fechas
        check (fecha_fin >= fecha_inicio)
);


-- SEDE
create table sede (
    id_sede number(10) constraint pk_sede primary key,
    id_edicion number(10) not null,
    pais varchar2(100) not null,

    constraint fk_sede_edicion
        foreign key (id_edicion)
        references edicion_mundial(id_edicion)
        on delete cascade,

    constraint uq_sede unique (id_edicion, pais)
);


-- CIUDAD
create table ciudad (
    id_ciudad number(10) constraint pk_ciudad primary key,
    id_sede number(10) not null,
    nombre varchar2(100) not null,

    constraint fk_ciudad_sede
        foreign key (id_sede)
        references sede(id_sede)
        on delete cascade,

    constraint uq_ciudad unique (id_sede, nombre)
);


-- ESTADIO
create table estadio (
    id_estadio number(10) constraint pk_estadio primary key,
    id_ciudad number(10) not null,
    id_edicion number(10) not null,
    nombre varchar2(150) not null,
    capacidad number(10) not null,

    constraint fk_estadio_ciudad
        foreign key (id_ciudad)
        references ciudad(id_ciudad),

    constraint fk_estadio_edicion
        foreign key (id_edicion)
        references edicion_mundial(id_edicion),

    constraint uq_estadio unique (id_ciudad, nombre),
    constraint ck_estadio_capacidad
        check (capacidad > 0)
);


-- FASE
create table fase (
    id_fase number(10) constraint pk_fase primary key,
    id_edicion number(10) not null,
    nombre varchar2(100) not null,
    tipo varchar2(50) not null,

    constraint fk_fase_edicion
        foreign key (id_edicion)
        references edicion_mundial(id_edicion)
        on delete cascade,

    constraint uq_fase unique (id_edicion, nombre)
);


-- GRUPO
create table grupo (
    id_grupo number(10) constraint pk_grupo primary key,
    id_edicion number(10) not null,
    nombre varchar2(50) not null,

    constraint fk_grupo_edicion
        foreign key (id_edicion)
        references edicion_mundial(id_edicion)
        on delete cascade,

    constraint uq_grupo unique (id_edicion, nombre)
);


-- FEDERACION
create table federacion (
    id_federacion number(10) constraint pk_federacion primary key,
    nombre varchar2(150) not null,
    sigla varchar2(10) not null,
    confederacion varchar2(100) not null,

    constraint uq_federacion_sigla unique (sigla)
);


-- SELECCION
create table seleccion (
    id_seleccion number(10) constraint pk_seleccion primary key,
    id_edicion number(10) not null,
    id_federacion number(10) not null,
    id_grupo number(10),
    pais varchar2(100) not null,

    constraint fk_seleccion_edicion
        foreign key (id_edicion)
        references edicion_mundial(id_edicion)
        on delete cascade,

    constraint fk_seleccion_federacion
        foreign key (id_federacion)
        references federacion(id_federacion),

    constraint fk_seleccion_grupo
        foreign key (id_grupo)
        references grupo(id_grupo),

    constraint uq_seleccion unique (id_edicion, pais)
);


-- JUGADOR
create table jugador (
    id_jugador number(10) constraint pk_jugador primary key,
    nombre varchar2(150) not null,
    fecha_nacimiento date not null
);


-- CONVOCATORIA_JUGADOR
create table convocatoria_jugador (
    id_convocatoria number(10) constraint pk_convocatoria_jugador primary key,
    id_jugador number(10) not null,
    id_seleccion number(10) not null,
    dorsal number(2) not null,
    es_capitan varchar2(2) not null,

    constraint fk_convocatoria_jugador
        foreign key (id_jugador)
        references jugador(id_jugador)
        on delete cascade,

    constraint fk_convocatoria_seleccion
        foreign key (id_seleccion)
        references seleccion(id_seleccion)
        on delete cascade,

    constraint uq_convocatoria unique (id_jugador, id_seleccion),

    constraint ck_convocatoria_dorsal
        check (dorsal between 1 and 99),

    constraint ck_convocatoria_capitan
        check (es_capitan in ('SI', 'NO'))
);


-- PARTIDO
create table partido (
    id_partido number(10) constraint pk_partido primary key,
    id_edicion number(10) not null,
    id_fase number(10) not null,
    id_estadio number(10) not null,
    fecha_hora date not null,
    asistencia_registrada number(10),

    constraint fk_partido_edicion
        foreign key (id_edicion)
        references edicion_mundial(id_edicion)
        on delete cascade,

    constraint fk_partido_fase
        foreign key (id_fase)
        references fase(id_fase),

    constraint fk_partido_estadio
        foreign key (id_estadio)
        references estadio(id_estadio),

    constraint ck_partido_asistencia
        check (asistencia_registrada >= 0)
);


-- PARTICIPACION_PARTIDO
create table participacion_partido (
    id_participacion number(10) constraint pk_participacion primary key,
    id_partido number(10) not null,
    id_seleccion number(10) not null,
    condicion varchar2(20) not null,
    goles_marcados number(3) default 0 not null,

    constraint fk_participacion_partido
        foreign key (id_partido)
        references partido(id_partido)
        on delete cascade,

    constraint fk_participacion_seleccion
        foreign key (id_seleccion)
        references seleccion(id_seleccion)
        on delete cascade,

    constraint uq_participacion unique (id_partido, id_seleccion),

    constraint ck_participacion_condicion
        check (condicion in ('LOCAL', 'VISITANTE')),

    constraint ck_participacion_goles
        check (goles_marcados >= 0)
);


-- ARBITRO
create table arbitro (
    id_arbitro number(10) constraint pk_arbitro primary key,
    nombre varchar2(150) not null,
    nacionalidad varchar2(100) not null
);


-- ASIGNACION_ARBITRAL
create table asignacion_arbitral (
    id_asignacion number(10) constraint pk_asignacion_arbitral primary key,
    id_arbitro number(10) not null,
    id_partido number(10) not null,
    rol varchar2(30) not null,

    constraint fk_asignacion_arbitro
        foreign key (id_arbitro)
        references arbitro(id_arbitro)
        on delete cascade,

    constraint fk_asignacion_partido
        foreign key (id_partido)
        references partido(id_partido)
        on delete cascade,

    constraint uq_asignacion_rol
        unique (id_partido, rol)
);


-- ESTADISTICA_JUGADOR_PARTIDO
create table estadistica_jugador_partido (
    id_estadistica number(10) constraint pk_estadistica primary key,
    id_partido number(10) not null,
    id_jugador number(10) not null,
    goles number(3) default 0 not null,
    asistencias number(3) default 0 not null,
    tarjetas_amarillas number(2) default 0 not null,
    tarjetas_rojas number(2) default 0 not null,
    tiros number(3) default 0 not null,
    minutos_jugados number(3) default 0 not null,

    constraint fk_estadistica_partido
        foreign key (id_partido)
        references partido(id_partido)
        on delete cascade,

    constraint fk_estadistica_jugador
        foreign key (id_jugador)
        references jugador(id_jugador)
        on delete cascade,

    constraint uq_estadistica unique (id_partido, id_jugador),

    constraint ck_estadistica_goles
        check (goles >= 0),

    constraint ck_estadistica_asistencias
        check (asistencias >= 0),

    constraint ck_estadistica_amarillas
        check (tarjetas_amarillas >= 0),

    constraint ck_estadistica_rojas
        check (tarjetas_rojas >= 0),

    constraint ck_estadistica_tiros
        check (tiros >= 0),

    constraint ck_estadistica_minutos
        check (minutos_jugados between 0 and 120)
);


-- INCIDENCIA
create table incidencia (
    id_incidencia number(10) constraint pk_incidencia primary key,
    id_partido number(10) not null,
    tipo varchar2(100) not null,
    descripcion varchar2(500),
    minuto number(3),

    constraint fk_incidencia_partido
        foreign key (id_partido)
        references partido(id_partido)
        on delete cascade,

    constraint ck_incidencia_minuto
        check (minuto >= 0)
);


-- Indices para las claves foraneas
create index idx_sede_edicion
    on sede(id_edicion);

create index idx_ciudad_sede
    on ciudad(id_sede);

create index idx_estadio_ciudad
    on estadio(id_ciudad);

create index idx_estadio_edicion
    on estadio(id_edicion);

create index idx_fase_edicion
    on fase(id_edicion);

create index idx_grupo_edicion
    on grupo(id_edicion);

create index idx_seleccion_edicion
    on seleccion(id_edicion);

create index idx_seleccion_federacion
    on seleccion(id_federacion);

create index idx_seleccion_grupo
    on seleccion(id_grupo);

create index idx_convocatoria_jugador
    on convocatoria_jugador(id_jugador);

create index idx_convocatoria_seleccion
    on convocatoria_jugador(id_seleccion);

create index idx_partido_edicion
    on partido(id_edicion);

create index idx_partido_fase
    on partido(id_fase);

create index idx_partido_estadio
    on partido(id_estadio);

create index idx_participacion_partido
    on participacion_partido(id_partido);

create index idx_participacion_seleccion
    on participacion_partido(id_seleccion);

create index idx_asignacion_arbitro
    on asignacion_arbitral(id_arbitro);

create index idx_asignacion_partido
    on asignacion_arbitral(id_partido);

create index idx_estadistica_partido
    on estadistica_jugador_partido(id_partido);

create index idx_estadistica_jugador
    on estadistica_jugador_partido(id_jugador);

create index idx_incidencia_partido
    on incidencia(id_partido);

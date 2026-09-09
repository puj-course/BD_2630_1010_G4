-- DROPs para eliminar las tablas

-- DROP TABLE PARTICIPACION_PARTIDO CASCADE CONSTRAINTS;
-- DROP TABLE PARTIDO CASCADE CONSTRAINTS;
-- DROP TABLE ESTADIO CASCADE CONSTRAINTS;
-- DROP TABLE SELECCION CASCADE CONSTRAINTS;
-- DROP TABLE EDICION_MUNDIAL CASCADE CONSTRAINTS;

-- TABLA: EDICION_MUNDIAL

CREATE TABLE EDICION_MUNDIAL (
    id_edicion      NUMBER(10)      CONSTRAINT pk_edicion_mundial PRIMARY KEY,
    anio            NUMBER(4)       NOT NULL,
    pais_sede       VARCHAR2(100)   NOT NULL,
    lema            VARCHAR2(150),
    fecha_inicio    DATE            NOT NULL,
    fecha_fin       DATE            NOT NULL
);

-- TABLA: ESTADIO

CREATE TABLE ESTADIO (
    id_estadio      NUMBER(10)      CONSTRAINT pk_estadio PRIMARY KEY,
    id_edicion      NUMBER(10)      NOT NULL,
    nombre          VARCHAR2(100)   NOT NULL,
    ciudad          VARCHAR2(100)   NOT NULL,
    capacidad       NUMBER(10)      NOT NULL,

    --FK: Cada estadio pertenece a una edición mundial.

    CONSTRAINT fk_estadio_edicion
        FOREIGN KEY (id_edicion)
        REFERENCES EDICION_MUNDIAL(id_edicion),

    CONSTRAINT ck_estadio_capacidad
        CHECK (capacidad >= 40000) --Mínimo que permite la fifa por estadio
);

-- TABLA: SELECCION

CREATE TABLE SELECCION (
    id_seleccion    NUMBER(10)      CONSTRAINT pk_seleccion PRIMARY KEY,
    id_edicion      NUMBER(10)      NOT NULL,
    pais            VARCHAR2(100)   NOT NULL,
    confederacion   VARCHAR2(100)   NOT NULL,
    grupo           CHAR(1),

    -- FK: Cada selección está registrada en una edición mundial.
    CONSTRAINT fk_seleccion_edicion
        FOREIGN KEY (id_edicion)
        REFERENCES EDICION_MUNDIAL(id_edicion)
);


-- TABLA: PARTIDO

CREATE TABLE PARTIDO (
    id_partido              NUMBER(10)      CONSTRAINT pk_partido PRIMARY KEY,
    id_edicion              NUMBER(10)      NOT NULL,
    id_estadio              NUMBER(10)      NOT NULL,
    fecha_hora              DATE            NOT NULL,
    fase                    VARCHAR2(30)    NOT NULL,
    asistencia_registrada   NUMBER(10)      NOT NULL,

    -- FK: Cada partido pertenece a una edición mundial.
    CONSTRAINT fk_partido_edicion
        FOREIGN KEY (id_edicion)
        REFERENCES EDICION_MUNDIAL(id_edicion),

    -- FK: Cada partido se juega en un estadio registrado.
    CONSTRAINT fk_partido_estadio
        FOREIGN KEY (id_estadio)
        REFERENCES ESTADIO(id_estadio),

    CONSTRAINT ck_partido_asistencia
        CHECK (asistencia_registrada >= 0)
);

-- TABLA: PARTICIPACION_PARTIDO

CREATE TABLE PARTICIPACION_PARTIDO (
    id_participacion    NUMBER(10)      CONSTRAINT pk_participacion PRIMARY KEY,
    id_partido          NUMBER(10)      NOT NULL,
    id_seleccion        NUMBER(10)      NOT NULL,
    condicion           VARCHAR2(20)    NOT NULL,
    goles_marcados      NUMBER(3)       NOT NULL,

    -- FK: Cada participación pertenece a un partido existente.

    CONSTRAINT fk_participacion_partido
        FOREIGN KEY (id_partido)
        REFERENCES PARTIDO(id_partido)
        ON DELETE CASCADE,

    -- FK: Cada participación corresponde a una selección existente.
    CONSTRAINT fk_participacion_seleccion
        FOREIGN KEY (id_seleccion)
        REFERENCES SELECCION(id_seleccion),

    -- Evita registrar dos veces la misma selección en un partido.
    CONSTRAINT uq_partido_seleccion
        UNIQUE (id_partido, id_seleccion),

    CONSTRAINT ck_participacion_condicion
        CHECK (condicion IN ('LOCAL', 'VISITANTE')),

    CONSTRAINT ck_participacion_goles
        CHECK (goles_marcados >= 0)
);


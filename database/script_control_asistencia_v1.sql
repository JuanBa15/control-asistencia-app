
-- =========================================================
-- SISTEMA DE CONTROL DE ASISTENCIA
-- PostgreSQL 17
-- Sucursales: Peru y Chile
-- Base de datos: asistencia_db
-- =========================================================

BEGIN;

-- 1. SUCURSAL
CREATE TABLE sucursal (
    id_sucursal INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    zona_horaria VARCHAR(100) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',
    fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_sucursal_pais
        CHECK (pais IN ('PERU', 'CHILE')),

    CONSTRAINT chk_sucursal_estado
        CHECK (estado IN ('ACTIVA', 'INACTIVA'))
);

-- 2. TRABAJADOR
CREATE TABLE trabajador (
    id_trabajador INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sucursal INTEGER NOT NULL,
    codigo_empleado VARCHAR(30) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    cargo VARCHAR(100) NOT NULL DEFAULT 'Desarrollador',
    fecha_ingreso DATE NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
    fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_trabajador_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal),

    CONSTRAINT chk_trabajador_estado
        CHECK (estado IN ('ACTIVO', 'INACTIVO', 'SUSPENDIDO'))
);

-- 3. TURNO
CREATE TABLE turno (
    id_turno INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    minutos_descanso INTEGER NOT NULL DEFAULT 60,
    tolerancia_minutos INTEGER NOT NULL DEFAULT 0,
    cruza_medianoche BOOLEAN NOT NULL DEFAULT FALSE,
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',

    CONSTRAINT chk_turno_descanso
        CHECK (minutos_descanso >= 0),

    CONSTRAINT chk_turno_tolerancia
        CHECK (tolerancia_minutos >= 0),

    CONSTRAINT chk_turno_estado
        CHECK (estado IN ('ACTIVO', 'INACTIVO')),

    CONSTRAINT chk_turno_horas
        CHECK (
            (cruza_medianoche = FALSE AND hora_fin > hora_inicio)
            OR
            (cruza_medianoche = TRUE AND hora_fin <= hora_inicio)
        )
);

-- 4. ASIGNACION_TURNO
CREATE TABLE asignacion_turno (
    id_asignacion INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_trabajador INTEGER NOT NULL,
    id_turno INTEGER NOT NULL,
    fecha_jornada DATE NOT NULL,
    inicio_programado TIMESTAMPTZ NOT NULL,
    fin_programado TIMESTAMPTZ NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'PROGRAMADA',
    observacion TEXT,
    fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_asignacion_trabajador
        FOREIGN KEY (id_trabajador)
        REFERENCES trabajador(id_trabajador),

    CONSTRAINT fk_asignacion_turno
        FOREIGN KEY (id_turno)
        REFERENCES turno(id_turno),

    CONSTRAINT chk_asignacion_fechas
        CHECK (fin_programado > inicio_programado),

    CONSTRAINT chk_asignacion_estado
        CHECK (
            estado IN (
                'PROGRAMADA',
                'EN_CURSO',
                'COMPLETADA',
                'AUSENTE',
                'CANCELADA'
            )
        ),

    CONSTRAINT uq_asignacion_trabajador
        UNIQUE (id_asignacion, id_trabajador)
);

-- 5. MARCACION
CREATE TABLE marcacion (
    id_marcacion INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_trabajador INTEGER NOT NULL,
    id_asignacion INTEGER,
    tipo_marcacion VARCHAR(30) NOT NULL,
    fecha_hora TIMESTAMPTZ NOT NULL,
    origen VARCHAR(20) NOT NULL DEFAULT 'WEB',
    estado VARCHAR(20) NOT NULL DEFAULT 'VALIDA',
    observacion TEXT,
    fecha_registro TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_marcacion_trabajador
        FOREIGN KEY (id_trabajador)
        REFERENCES trabajador(id_trabajador),

    CONSTRAINT fk_marcacion_asignacion
        FOREIGN KEY (id_asignacion, id_trabajador)
        REFERENCES asignacion_turno(id_asignacion, id_trabajador),

    CONSTRAINT chk_marcacion_tipo
        CHECK (
            tipo_marcacion IN (
                'ENTRADA',
                'INICIO_DESCANSO',
                'FIN_DESCANSO',
                'SALIDA'
            )
        ),

    CONSTRAINT chk_marcacion_origen
        CHECK (origen IN ('WEB', 'MOVIL', 'MANUAL')),

    CONSTRAINT chk_marcacion_estado
        CHECK (estado IN ('VALIDA', 'PENDIENTE', 'ANULADA'))
);

-- 6. FERIADO
CREATE TABLE feriado (
    id_feriado INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sucursal INTEGER NOT NULL,
    fecha DATE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    laborable BOOLEAN NOT NULL DEFAULT FALSE,
    estado VARCHAR(20) NOT NULL DEFAULT 'VIGENTE',

    CONSTRAINT fk_feriado_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal),

    CONSTRAINT chk_feriado_tipo
        CHECK (tipo IN ('NACIONAL', 'REGIONAL', 'LOCAL')),

    CONSTRAINT chk_feriado_estado
        CHECK (estado IN ('VIGENTE', 'ANULADO')),

    CONSTRAINT uq_feriado_sucursal_fecha_nombre
        UNIQUE (id_sucursal, fecha, nombre)
);

-- 7. INCIDENCIA_ASISTENCIA
CREATE TABLE incidencia_asistencia (
    id_incidencia INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_trabajador INTEGER NOT NULL,
    id_asignacion INTEGER NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    minutos INTEGER,
    estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    descripcion TEXT,
    fecha_registro TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_incidencia_trabajador
        FOREIGN KEY (id_trabajador)
        REFERENCES trabajador(id_trabajador),

    CONSTRAINT fk_incidencia_asignacion
        FOREIGN KEY (id_asignacion, id_trabajador)
        REFERENCES asignacion_turno(id_asignacion, id_trabajador),

    CONSTRAINT chk_incidencia_tipo
        CHECK (
            tipo IN (
                'TARDANZA',
                'SALIDA_ANTICIPADA',
                'AUSENCIA',
                'MARCACION_FALTANTE'
            )
        ),

    CONSTRAINT chk_incidencia_minutos
        CHECK (minutos IS NULL OR minutos >= 0),

    CONSTRAINT chk_incidencia_estado
        CHECK (
            estado IN (
                'PENDIENTE',
                'JUSTIFICADA',
                'INJUSTIFICADA'
            )
        )
);

COMMIT;

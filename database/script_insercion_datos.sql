
-- ============================================
-- PASO 4.1: REGISTRO DE SUCURSALES
-- ============================================

INSERT INTO sucursal (
    nombre,
    pais,
    ciudad,
    zona_horaria,
    estado
)
VALUES
(
    'Sucursal Lima',
    'PERU',
    'Lima',
    'America/Lima',
    'ACTIVA'
),
(
    'Sucursal Santiago',
    'CHILE',
    'Santiago',
    'America/Santiago',
    'ACTIVA'
);

-- Verificar los registros insertados
SELECT
    id_sucursal,
    nombre,
    pais,
    ciudad,
    zona_horaria,
    estado
FROM sucursal
ORDER BY id_sucursal;

-- ============================================
-- PASO 4.2: REGISTRO DE TURNOS
-- ============================================

INSERT INTO turno (
    nombre,
    hora_inicio,
    hora_fin,
    minutos_descanso,
    tolerancia_minutos,
    cruza_medianoche,
    estado
)
VALUES
(
    'DIURNO',
    '09:00:00',
    '18:00:00',
    60,
    5,
    FALSE,
    'ACTIVO'
),
(
    'TARDE',
    '13:00:00',
    '22:00:00',
    60,
    5,
    FALSE,
    'ACTIVO'
),
(
    'NOCTURNO',
    '20:00:00',
    '05:00:00',
    60,
    5,
    TRUE,
    'ACTIVO'
);

-- Verificar los turnos insertados
SELECT
    id_turno,
    nombre,
    hora_inicio,
    hora_fin,
    minutos_descanso,
    tolerancia_minutos,
    cruza_medianoche,
    estado
FROM turno
ORDER BY id_turno;

-- ============================================
-- PASO 4.3: REGISTRO DE TRABAJADORES
-- ============================================

INSERT INTO trabajador (
    id_sucursal,
    codigo_empleado,
    nombres,
    apellidos,
    correo,
    cargo,
    fecha_ingreso,
    estado
)
VALUES
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    'DEV-PE-001',
    'Ana',
    'Torres',
    'ana.torres@ejemplo.com',
    'Desarrolladora Backend',
    '2025-03-10',
    'ACTIVO'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    'DEV-PE-002',
    'Luis',
    'Ramírez',
    'luis.ramirez@ejemplo.com',
    'Desarrollador Frontend',
    '2025-05-15',
    'ACTIVO'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    'DEV-PE-003',
    'María',
    'López',
    'maria.lopez@ejemplo.com',
    'Desarrolladora Full Stack',
    '2025-07-01',
    'SUSPENDIDO'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    'DEV-CL-001',
    'Carlos',
    'Muñoz',
    'carlos.munoz@ejemplo.com',
    'Desarrollador Backend',
    '2025-02-20',
    'ACTIVO'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    'DEV-CL-002',
    'Sofía',
    'Rojas',
    'sofia.rojas@ejemplo.com',
    'Desarrolladora Frontend',
    '2025-04-12',
    'ACTIVO'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    'DEV-CL-003',
    'Diego',
    'Pérez',
    'diego.perez@ejemplo.com',
    'Desarrollador Full Stack',
    '2025-06-18',
    'INACTIVO'
);

-- =====================================================
-- PASO 4.4: ASIGNACION DE TURNOS A LOS TRABAJADORES
-- Base de datos: asistencia_db
-- =====================================================

INSERT INTO asignacion_turno (
    id_trabajador,
    id_turno,
    fecha_jornada,
    inicio_programado,
    fin_programado,
    estado,
    observacion
)
VALUES

-- Ana Torres: turno diurno en Lima
(
    (SELECT id_trabajador FROM trabajador
     WHERE codigo_empleado = 'DEV-PE-001'),
    (SELECT id_turno FROM turno
     WHERE nombre = 'DIURNO'),
    '2026-10-20',
    '2026-10-20 09:00:00-05',
    '2026-10-20 18:00:00-05',
    'PROGRAMADA',
    'Jornada diurna en Lima'
),

-- Ana Torres: turno de tarde al dia siguiente
(
    (SELECT id_trabajador FROM trabajador
     WHERE codigo_empleado = 'DEV-PE-001'),
    (SELECT id_turno FROM turno
     WHERE nombre = 'TARDE'),
    '2026-10-21',
    '2026-10-21 13:00:00-05',
    '2026-10-21 22:00:00-05',
    'PROGRAMADA',
    'Cambio de horario durante la semana'
),

-- Luis Ramirez: jornada en sabado
(
    (SELECT id_trabajador FROM trabajador
     WHERE codigo_empleado = 'DEV-PE-002'),
    (SELECT id_turno FROM turno
     WHERE nombre = 'DIURNO'),
    '2026-10-24',
    '2026-10-24 09:00:00-05',
    '2026-10-24 18:00:00-05',
    'PROGRAMADA',
    'Trabajo programado en fin de semana'
),

-- Carlos Munoz: turno nocturno en Santiago
(
    (SELECT id_trabajador FROM trabajador
     WHERE codigo_empleado = 'DEV-CL-001'),
    (SELECT id_turno FROM turno
     WHERE nombre = 'NOCTURNO'),
    '2026-10-20',
    '2026-10-20 20:00:00-03',
    '2026-10-21 05:00:00-03',
    'PROGRAMADA',
    'Turno nocturno que cruza medianoche'
),

-- Carlos Munoz: turno diurno otro dia
(
    (SELECT id_trabajador FROM trabajador
     WHERE codigo_empleado = 'DEV-CL-001'),
    (SELECT id_turno FROM turno
     WHERE nombre = 'DIURNO'),
    '2026-10-22',
    '2026-10-22 09:00:00-03',
    '2026-10-22 18:00:00-03',
    'PROGRAMADA',
    'Cambio de turno nocturno a diurno'
),

-- Sofia Rojas: turno de tarde en Santiago
(
    (SELECT id_trabajador FROM trabajador
     WHERE codigo_empleado = 'DEV-CL-002'),
    (SELECT id_turno FROM turno
     WHERE nombre = 'TARDE'),
    '2026-10-21',
    '2026-10-21 13:00:00-03',
    '2026-10-21 22:00:00-03',
    'PROGRAMADA',
    'Jornada de tarde en Santiago'
);

-- =====================================================
-- PASO 4.5: REGISTRO DE MARCACIONES
-- Base de datos: asistencia_db
-- =====================================================

WITH datos_marcacion (
    codigo_empleado,
    fecha_jornada,
    tipo_marcacion,
    fecha_hora,
    origen,
    estado
) AS (
    VALUES

    -- ANA TORRES - PERU
    -- Jornada diurna del 20/10/2026
    ('DEV-PE-001', DATE '2026-10-20',
     'ENTRADA', TIMESTAMPTZ '2026-10-20 09:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-001', DATE '2026-10-20',
     'INICIO_DESCANSO', TIMESTAMPTZ '2026-10-20 13:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-001', DATE '2026-10-20',
     'FIN_DESCANSO', TIMESTAMPTZ '2026-10-20 14:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-001', DATE '2026-10-20',
     'SALIDA', TIMESTAMPTZ '2026-10-20 18:00:00-05',
     'WEB', 'VALIDA'),

    -- ANA TORRES - PERU
    -- Jornada de tarde del 21/10/2026
    ('DEV-PE-001', DATE '2026-10-21',
     'ENTRADA', TIMESTAMPTZ '2026-10-21 13:02:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-001', DATE '2026-10-21',
     'INICIO_DESCANSO', TIMESTAMPTZ '2026-10-21 17:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-001', DATE '2026-10-21',
     'FIN_DESCANSO', TIMESTAMPTZ '2026-10-21 18:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-001', DATE '2026-10-21',
     'SALIDA', TIMESTAMPTZ '2026-10-21 22:00:00-05',
     'WEB', 'VALIDA'),

    -- LUIS RAMIREZ - PERU
    -- Jornada del sabado 24/10/2026
    -- Entrada 20 minutos tarde
    ('DEV-PE-002', DATE '2026-10-24',
     'ENTRADA', TIMESTAMPTZ '2026-10-24 09:20:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-002', DATE '2026-10-24',
     'INICIO_DESCANSO', TIMESTAMPTZ '2026-10-24 13:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-002', DATE '2026-10-24',
     'FIN_DESCANSO', TIMESTAMPTZ '2026-10-24 14:00:00-05',
     'WEB', 'VALIDA'),

    ('DEV-PE-002', DATE '2026-10-24',
     'SALIDA', TIMESTAMPTZ '2026-10-24 18:00:00-05',
     'WEB', 'VALIDA'),

    -- CARLOS MUNOZ - CHILE
    -- Jornada nocturna del 20 al 21/10/2026
    -- Entrada 12 minutos tarde
    ('DEV-CL-001', DATE '2026-10-20',
     'ENTRADA', TIMESTAMPTZ '2026-10-20 20:12:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-001', DATE '2026-10-20',
     'INICIO_DESCANSO', TIMESTAMPTZ '2026-10-20 23:30:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-001', DATE '2026-10-20',
     'FIN_DESCANSO', TIMESTAMPTZ '2026-10-21 00:30:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-001', DATE '2026-10-20',
     'SALIDA', TIMESTAMPTZ '2026-10-21 05:10:00-03',
     'WEB', 'VALIDA'),

    -- CARLOS MUNOZ - CHILE
    -- Jornada diurna del 22/10/2026
    ('DEV-CL-001', DATE '2026-10-22',
     'ENTRADA', TIMESTAMPTZ '2026-10-22 09:00:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-001', DATE '2026-10-22',
     'INICIO_DESCANSO', TIMESTAMPTZ '2026-10-22 13:00:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-001', DATE '2026-10-22',
     'FIN_DESCANSO', TIMESTAMPTZ '2026-10-22 14:00:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-001', DATE '2026-10-22',
     'SALIDA', TIMESTAMPTZ '2026-10-22 18:00:00-03',
     'WEB', 'VALIDA'),

    -- SOFIA ROJAS - CHILE
    -- Jornada de tarde del 21/10/2026
    -- Salida 30 minutos anticipada
    ('DEV-CL-002', DATE '2026-10-21',
     'ENTRADA', TIMESTAMPTZ '2026-10-21 13:00:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-002', DATE '2026-10-21',
     'INICIO_DESCANSO', TIMESTAMPTZ '2026-10-21 17:00:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-002', DATE '2026-10-21',
     'FIN_DESCANSO', TIMESTAMPTZ '2026-10-21 18:00:00-03',
     'WEB', 'VALIDA'),

    ('DEV-CL-002', DATE '2026-10-21',
     'SALIDA', TIMESTAMPTZ '2026-10-21 21:30:00-03',
     'WEB', 'VALIDA')
)

INSERT INTO marcacion (
    id_trabajador,
    id_asignacion,
    tipo_marcacion,
    fecha_hora,
    origen,
    estado
)
SELECT
    t.id_trabajador,
    a.id_asignacion,
    d.tipo_marcacion,
    d.fecha_hora,
    d.origen,
    d.estado
FROM datos_marcacion AS d
INNER JOIN trabajador AS t
    ON t.codigo_empleado = d.codigo_empleado
INNER JOIN asignacion_turno AS a
    ON a.id_trabajador = t.id_trabajador
   AND a.fecha_jornada = d.fecha_jornada;

-- =====================================================
-- PASO 4.6.1: DETECTAR INCIDENCIAS
-- No modifica los datos
-- =====================================================

WITH resumen AS (
    SELECT
        a.id_asignacion,
        t.codigo_empleado,
        t.nombres || ' ' || t.apellidos AS trabajador,
        s.zona_horaria,
        a.fecha_jornada,
        a.inicio_programado,
        a.fin_programado,
        tu.tolerancia_minutos,

        MIN(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'ENTRADA'
              AND m.estado = 'VALIDA'
        ) AS entrada_real,

        MAX(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'SALIDA'
              AND m.estado = 'VALIDA'
        ) AS salida_real

    FROM asignacion_turno a
    INNER JOIN trabajador t
        ON a.id_trabajador = t.id_trabajador
    INNER JOIN sucursal s
        ON t.id_sucursal = s.id_sucursal
    INNER JOIN turno tu
        ON a.id_turno = tu.id_turno
    LEFT JOIN marcacion m
        ON a.id_asignacion = m.id_asignacion

    GROUP BY
        a.id_asignacion,
        t.codigo_empleado,
        t.nombres,
        t.apellidos,
        s.zona_horaria,
        a.fecha_jornada,
        a.inicio_programado,
        a.fin_programado,
        tu.tolerancia_minutos
)

SELECT
    codigo_empleado,
    trabajador,
    fecha_jornada,

    inicio_programado AT TIME ZONE zona_horaria
        AS inicio_programado_local,

    entrada_real AT TIME ZONE zona_horaria
        AS entrada_real_local,

    fin_programado AT TIME ZONE zona_horaria
        AS fin_programado_local,

    salida_real AT TIME ZONE zona_horaria
        AS salida_real_local,

    CASE
        WHEN entrada_real >
             inicio_programado
             + tolerancia_minutos * INTERVAL '1 minute'
        THEN 'TARDANZA'

        WHEN salida_real < fin_programado
        THEN 'SALIDA_ANTICIPADA'

        ELSE 'SIN_INCIDENCIA'
    END AS resultado,

    CASE
        WHEN entrada_real >
             inicio_programado
             + tolerancia_minutos * INTERVAL '1 minute'
        THEN FLOOR(
            EXTRACT(EPOCH FROM (
                entrada_real - inicio_programado
            )) / 60
        )::INTEGER

        WHEN salida_real < fin_programado
        THEN FLOOR(
            EXTRACT(EPOCH FROM (
                fin_programado - salida_real
            )) / 60
        )::INTEGER

        ELSE 0
    END AS minutos_incidencia

FROM resumen
ORDER BY codigo_empleado, fecha_jornada;

-- =====================================================
-- PASO 4.6.2: REGISTRAR INCIDENCIAS
-- Tardanzas y salidas anticipadas
-- =====================================================

WITH resumen AS (
    SELECT
        a.id_asignacion,
        a.id_trabajador,
        a.inicio_programado,
        a.fin_programado,
        tu.tolerancia_minutos,

        MIN(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'ENTRADA'
              AND m.estado = 'VALIDA'
        ) AS entrada_real,

        MAX(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'SALIDA'
              AND m.estado = 'VALIDA'
        ) AS salida_real

    FROM asignacion_turno a
    INNER JOIN turno tu
        ON a.id_turno = tu.id_turno
    LEFT JOIN marcacion m
        ON a.id_asignacion = m.id_asignacion

    WHERE a.estado <> 'CANCELADA'

    GROUP BY
        a.id_asignacion,
        a.id_trabajador,
        a.inicio_programado,
        a.fin_programado,
        tu.tolerancia_minutos
),

incidencias_detectadas AS (

    -- TARDANZAS
    SELECT
        id_trabajador,
        id_asignacion,
        'TARDANZA'::VARCHAR AS tipo,

        FLOOR(
            EXTRACT(EPOCH FROM (
                entrada_real - inicio_programado
            )) / 60
        )::INTEGER AS minutos,

        'PENDIENTE'::VARCHAR AS estado,
        'Entrada posterior a la tolerancia permitida'
            ::TEXT AS descripcion

    FROM resumen
    WHERE entrada_real >
          inicio_programado
          + tolerancia_minutos * INTERVAL '1 minute'

    UNION ALL

    -- SALIDAS ANTICIPADAS
    SELECT
        id_trabajador,
        id_asignacion,
        'SALIDA_ANTICIPADA'::VARCHAR AS tipo,

        FLOOR(
            EXTRACT(EPOCH FROM (
                fin_programado - salida_real
            )) / 60
        )::INTEGER AS minutos,

        'PENDIENTE'::VARCHAR AS estado,
        'Salida anterior al horario programado'
            ::TEXT AS descripcion

    FROM resumen
    WHERE salida_real < fin_programado
)

INSERT INTO incidencia_asistencia (
    id_trabajador,
    id_asignacion,
    tipo,
    minutos,
    estado,
    descripcion
)
SELECT
    i.id_trabajador,
    i.id_asignacion,
    i.tipo,
    i.minutos,
    i.estado,
    i.descripcion
FROM incidencias_detectadas i
WHERE NOT EXISTS (
    SELECT 1
    FROM incidencia_asistencia existente
    WHERE existente.id_asignacion = i.id_asignacion
      AND existente.tipo = i.tipo
);

-- =====================================================
-- PASO 4.7.1: CALCULO DE HORAS TRABAJADAS
-- Incluye turnos diurnos, tarde y nocturnos
-- =====================================================

WITH eventos AS (
    SELECT
        a.id_asignacion,
        a.fecha_jornada,
        a.inicio_programado,
        a.fin_programado,
        t.codigo_empleado,
        t.nombres || ' ' || t.apellidos AS trabajador,
        s.pais,
        s.zona_horaria,
        tu.nombre AS turno,
        tu.minutos_descanso AS descanso_programado,

        MIN(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'ENTRADA'
              AND m.estado = 'VALIDA'
        ) AS entrada_real,

        MAX(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'SALIDA'
              AND m.estado = 'VALIDA'
        ) AS salida_real,

        MIN(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'INICIO_DESCANSO'
              AND m.estado = 'VALIDA'
        ) AS inicio_descanso,

        MAX(m.fecha_hora) FILTER (
            WHERE m.tipo_marcacion = 'FIN_DESCANSO'
              AND m.estado = 'VALIDA'
        ) AS fin_descanso

    FROM asignacion_turno a

    INNER JOIN trabajador t
        ON a.id_trabajador = t.id_trabajador

    INNER JOIN sucursal s
        ON t.id_sucursal = s.id_sucursal

    INNER JOIN turno tu
        ON a.id_turno = tu.id_turno

    LEFT JOIN marcacion m
        ON a.id_asignacion = m.id_asignacion

    GROUP BY
        a.id_asignacion,
        a.fecha_jornada,
        a.inicio_programado,
        a.fin_programado,
        t.codigo_empleado,
        t.nombres,
        t.apellidos,
        s.pais,
        s.zona_horaria,
        tu.nombre,
        tu.minutos_descanso
),

calculos AS (
    SELECT
        *,

        CASE
            WHEN entrada_real IS NOT NULL
             AND salida_real >= entrada_real
            THEN EXTRACT(
                EPOCH FROM (salida_real - entrada_real)
            ) / 60
        END AS minutos_permanencia,

        CASE
            WHEN inicio_descanso IS NOT NULL
             AND fin_descanso >= inicio_descanso
            THEN EXTRACT(
                EPOCH FROM (fin_descanso - inicio_descanso)
            ) / 60
        END AS minutos_descanso_real,

        EXTRACT(
            EPOCH FROM (
                fin_programado - inicio_programado
            )
        ) / 60 - descanso_programado
            AS minutos_programados_netos

    FROM eventos
)

SELECT
    codigo_empleado,
    trabajador,
    pais,
    fecha_jornada,
    turno,

    entrada_real AT TIME ZONE zona_horaria
        AS entrada_local,

    salida_real AT TIME ZONE zona_horaria
        AS salida_local,

    ROUND(
        minutos_permanencia / 60, 2
    ) AS horas_permanencia,

    ROUND(
        minutos_descanso_real / 60, 2
    ) AS horas_descanso,

    ROUND(
        (minutos_permanencia - minutos_descanso_real)
        / 60, 2
    ) AS horas_efectivas,

    ROUND(
        minutos_programados_netos / 60, 2
    ) AS horas_programadas_netas,

    CASE
        WHEN minutos_permanencia IS NULL
          OR minutos_descanso_real IS NULL
        THEN 'MARCACIONES_INCOMPLETAS'

        WHEN inicio_descanso < entrada_real
          OR fin_descanso > salida_real
        THEN 'REVISAR_DESCANSO'

        WHEN minutos_permanencia < minutos_descanso_real
        THEN 'REVISAR_MARCACIONES'

        ELSE 'CALCULADO'
    END AS estado_calculo

FROM calculos
ORDER BY
    codigo_empleado,
    fecha_jornada;

-- =====================================================
-- PASO 4.8.1: REGISTRO DE FERIADOS
-- Peru y Chile - Año 2026
-- =====================================================

INSERT INTO feriado (
    id_sucursal,
    fecha,
    nombre,
    tipo,
    laborable,
    estado
)
VALUES

-- FERIADOS DE PERU
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    '2026-07-28',
    'Fiestas Patrias - 28 de julio',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    '2026-07-29',
    'Fiestas Patrias - 29 de julio',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    '2026-10-08',
    'Combate de Angamos',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Lima'),
    '2026-12-25',
    'Navidad',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),

-- FERIADOS DE CHILE
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    '2026-09-18',
    'Independencia Nacional',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    '2026-09-19',
    'Dia de las Glorias del Ejercito',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    '2026-10-12',
    'Encuentro de Dos Mundos',
    'NACIONAL',
    FALSE,
    'VIGENTE'
),
(
    (SELECT id_sucursal FROM sucursal
     WHERE nombre = 'Sucursal Santiago'),
    '2026-12-25',
    'Navidad',
    'NACIONAL',
    FALSE,
    'VIGENTE'
);


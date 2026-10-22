
-- ============================================
-- VERIFICAR TRABAJADORES Y SUCURSALES
-- ============================================

SELECT
    t.id_trabajador,
    t.codigo_empleado,
    t.nombres,
    t.apellidos,
    t.cargo,
    s.nombre AS sucursal,
    s.pais,
    t.estado
FROM trabajador AS t
INNER JOIN sucursal AS s
    ON t.id_sucursal = s.id_sucursal
ORDER BY
    s.pais,
    t.codigo_empleado;

SELECT
    s.nombre AS sucursal,
    t.estado,
    COUNT(*) AS cantidad_trabajadores
FROM trabajador AS t
INNER JOIN sucursal AS s
    ON t.id_sucursal = s.id_sucursal
GROUP BY
    s.nombre,
    t.estado
ORDER BY
    s.nombre,
    t.estado;

-- Jordanas asignadas
SELECT
    a.id_asignacion,
    t.codigo_empleado,
    t.nombres || ' ' || t.apellidos AS trabajador,
    s.pais,
    tu.nombre AS turno,
    a.fecha_jornada,
    a.inicio_programado AT TIME ZONE s.zona_horaria
        AS inicio_local,
    a.fin_programado AT TIME ZONE s.zona_horaria
        AS fin_local,
    a.estado
FROM asignacion_turno AS a
INNER JOIN trabajador AS t
    ON a.id_trabajador = t.id_trabajador
INNER JOIN sucursal AS s
    ON t.id_sucursal = s.id_sucursal
INNER JOIN turno AS tu
    ON a.id_turno = tu.id_turno
ORDER BY
    a.fecha_jornada,
    s.pais,
    t.codigo_empleado;

-- Cantidad de jornadas que tiene cada trabajador
SELECT
    t.codigo_empleado,
    t.nombres || ' ' || t.apellidos AS trabajador,
    COUNT(a.id_asignacion) AS total_jornadas
FROM trabajador AS t
LEFT JOIN asignacion_turno AS a
    ON t.id_trabajador = a.id_trabajador
GROUP BY
    t.id_trabajador,
    t.codigo_empleado,
    t.nombres,
    t.apellidos
ORDER BY t.codigo_empleado;

-- Marcaciones registradas
SELECT
    t.codigo_empleado,
    t.nombres || ' ' || t.apellidos AS trabajador,
    s.pais,
    a.fecha_jornada,
    m.tipo_marcacion,
    m.fecha_hora AT TIME ZONE s.zona_horaria AS hora_local,
    m.estado
FROM marcacion AS m
INNER JOIN trabajador AS t
    ON m.id_trabajador = t.id_trabajador
INNER JOIN sucursal AS s
    ON t.id_sucursal = s.id_sucursal
INNER JOIN asignacion_turno AS a
    ON m.id_asignacion = a.id_asignacion
ORDER BY
    t.codigo_empleado,
    a.fecha_jornada,
    m.fecha_hora;

-- Incidencias registradas
SELECT
    i.id_incidencia,
    t.codigo_empleado,
    t.nombres || ' ' || t.apellidos AS trabajador,
    a.fecha_jornada,
    i.tipo,
    i.minutos,
    i.estado,
    i.descripcion
FROM incidencia_asistencia i
INNER JOIN trabajador t
    ON i.id_trabajador = t.id_trabajador
INNER JOIN asignacion_turno a
    ON i.id_asignacion = a.id_asignacion
ORDER BY
    a.fecha_jornada,
    t.codigo_empleado;

-- Verificar feriados
SELECT
    f.id_feriado,
    s.nombre AS sucursal,
    s.pais,
    f.fecha,
    f.nombre AS feriado,
    f.tipo,
    f.laborable,
    f.estado
FROM feriado f
INNER JOIN sucursal s
    ON f.id_sucursal = s.id_sucursal
ORDER BY
    s.pais,
    f.fecha;

-- Identificamos joranadas programadas en feriados
SELECT
    t.codigo_empleado,
    t.nombres || ' ' || t.apellidos AS trabajador,
    s.pais,
    a.fecha_jornada,
    tu.nombre AS turno,
    f.nombre AS feriado,
    f.laborable
FROM asignacion_turno a
INNER JOIN trabajador t
    ON a.id_trabajador = t.id_trabajador
INNER JOIN sucursal s
    ON t.id_sucursal = s.id_sucursal
INNER JOIN turno tu
    ON a.id_turno = tu.id_turno
INNER JOIN feriado f
    ON f.id_sucursal = s.id_sucursal
   AND f.fecha = a.fecha_jornada
WHERE f.estado = 'VIGENTE'
ORDER BY
    a.fecha_jornada,
    t.codigo_empleado;

-- Consultmos las jornadas e indicamos si son feriados
SELECT
    t.codigo_empleado,
    t.nombres || ' ' || t.apellidos AS trabajador,
    s.pais,
    a.fecha_jornada,
    tu.nombre AS turno,

    CASE
        WHEN EXISTS (
            SELECT 1
            FROM feriado f
            WHERE f.id_sucursal = s.id_sucursal
              AND f.fecha = a.fecha_jornada
              AND f.estado = 'VIGENTE'
              AND f.laborable = FALSE
        )
        THEN 'SI'
        ELSE 'NO'
    END AS es_feriado_no_laborable

FROM asignacion_turno a
INNER JOIN trabajador t
    ON a.id_trabajador = t.id_trabajador
INNER JOIN sucursal s
    ON t.id_sucursal = s.id_sucursal
INNER JOIN turno tu
    ON a.id_turno = tu.id_turno
ORDER BY
    a.fecha_jornada,
    t.codigo_empleado;

-- Comprobaciones luego de reiniciar el contenedor
SELECT 'sucursal' AS tabla, COUNT(*) AS registros FROM sucursal
UNION ALL
SELECT 'turno', COUNT(*) FROM turno
UNION ALL
SELECT 'trabajador', COUNT(*) FROM trabajador
UNION ALL
SELECT 'asignacion_turno', COUNT(*) FROM asignacion_turno
UNION ALL
SELECT 'marcacion', COUNT(*) FROM marcacion
UNION ALL
SELECT 'incidencia_asistencia', COUNT(*) FROM incidencia_asistencia
UNION ALL
SELECT 'feriado', COUNT(*) FROM feriado;


SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'feriado'
ORDER BY ordinal_position;


SELECT
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS tabla_referenciada,
    ccu.column_name AS columna_referenciada
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'public'
  AND tc.table_name = 'feriado'
ORDER BY tc.constraint_type, kcu.column_name;


SELECT
    column_name,
    is_identity,
    identity_generation,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'feriado'
  AND column_name = 'id_feriado';


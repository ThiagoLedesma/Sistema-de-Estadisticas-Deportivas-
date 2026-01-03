-- Views
-- vw_jugadores_por_partido
CREATE VIEW vw_jugadores_por_partido AS
SELECT
    p.fecha,
    el.nombre AS equipo_local,
    ev.nombre AS equipo_visitante,
    j.nombre AS jugador,
    es.goles,
    es.asistencias,
    es.minutos_jugados
FROM estadisticas_jugador es
JOIN jugadores j ON es.jugador_id = j.jugador_id
JOIN partidos p ON es.partido_id = p.partido_id
JOIN equipos el ON p.equipo_local_id = el.equipo_id
JOIN equipos ev ON p.equipo_visitante_id = ev.equipo_id;


-- vw_resultados_equipo
CREATE VIEW vw_resultados_equipo AS
SELECT
    p.fecha,
    e.equipo_id,
    e.nombre AS equipo,
    CASE
        WHEN e.equipo_id = p.equipo_local_id AND p.goles_local > p.goles_visitante THEN 'G'
        WHEN e.equipo_id = p.equipo_visitante_id AND p.goles_visitante > p.goles_local THEN 'G'
        WHEN p.goles_local = p.goles_visitante THEN 'E'
        ELSE 'P'
    END AS resultado
FROM partidos p
JOIN equipos e
  ON e.equipo_id IN (p.equipo_local_id, p.equipo_visitante_id);


-- vw_rachas_equipo
  CREATE VIEW vw_rachas_equipo AS
WITH base AS (
    SELECT
        equipo,
        fecha,
        resultado,
        CASE
            WHEN resultado = LAG(resultado)
                 OVER (PARTITION BY equipo ORDER BY fecha)
            THEN 0
            ELSE 1
        END AS corte
    FROM vw_resultados_equipo
),
rachas AS (
    SELECT
        equipo,
        fecha,
        resultado,
        SUM(corte) OVER (
            PARTITION BY equipo
            ORDER BY fecha
        ) AS racha_id
    FROM base
)
SELECT
    equipo,
    resultado,
    racha_id,
    COUNT(*) AS partidos_seguidos
FROM rachas
GROUP BY equipo, resultado, racha_id;


-- vw_rendimiento_jugador
CREATE VIEW vw_rendimiento_jugador AS
SELECT
    j.jugador_id,
    j.nombre AS jugador,
    e.nombre AS equipo,
    COUNT(DISTINCT ej.partido_id) AS partidos_jugados,
    SUM(ej.goles) AS goles,
    SUM(ej.asistencias) AS asistencias,
    SUM(ej.minutos_jugados) AS minutos_totales
FROM estadisticas_jugador ej
JOIN jugadores j ON ej.jugador_id = j.jugador_id
JOIN equipos e ON j.equipo_id = e.equipo_id
GROUP BY j.jugador_id, j.nombre, e.nombre;


-- vw_rendimiento_equipo
CREATE VIEW vw_rendimiento_equipo AS
SELECT
    e.equipo_id,
    e.nombre AS equipo,
    COUNT(p.partido_id) AS partidos_jugados,
    SUM(
        CASE
            WHEN e.equipo_id = p.equipo_local_id THEN p.goles_local
            ELSE p.goles_visitante
        END
    ) AS goles_favor,
    SUM(
        CASE
            WHEN e.equipo_id = p.equipo_local_id THEN p.goles_visitante
            ELSE p.goles_local
        END
    ) AS goles_contra
FROM equipos e
JOIN partidos p
    ON e.equipo_id IN (p.equipo_local_id, p.equipo_visitante_id)
GROUP BY e.equipo_id, e.nombre;



-- Ranking de goleadores Premier League 2024
SELECT
    j.nombre AS jugador,
    e.nombre AS equipo,
    SUM(es.goles) AS goles_totales
FROM estadisticas_jugador es
JOIN jugadores j ON es.jugador_id = j.jugador_id
JOIN equipos e ON j.equipo_id = e.equipo_id
GROUP BY j.nombre, e.nombre
ORDER BY goles_totales DESC;


-- Goles totales por equipo - Premier League 2024
SELECT
    e.nombre AS equipo,
    SUM(es.goles) AS goles_totales
FROM estadisticas_jugador es
JOIN jugadores j ON es.jugador_id = j.jugador_id
JOIN equipos e ON j.equipo_id = e.equipo_id
GROUP BY e.nombre
ORDER BY goles_totales DESC;


-- Partidos con más goles - Premier League 2024
SELECT
    p.partido_id,
    el.nombre AS equipo_local,
    ev.nombre AS equipo_visitante,
    p.goles_local,
    p.goles_visitante,
    (p.goles_local + p.goles_visitante) AS goles_totales
FROM partidos p
JOIN equipos el ON p.equipo_local_id = el.equipo_id
JOIN equipos ev ON p.equipo_visitante_id = ev.equipo_id
ORDER BY goles_totales DESC
LIMIT 10;


-- Jugadores y goles por partido - Premier League 2024
SELECT
    p.fecha,
    el.nombre AS equipo_local,
    ev.nombre AS equipo_visitante,
    j.nombre AS jugador,
    es.goles
FROM estadisticas_jugador es
JOIN jugadores j ON es.jugador_id = j.jugador_id
JOIN partidos p ON es.partido_id = p.partido_id
JOIN equipos el ON p.equipo_local_id = el.equipo_id
JOIN equipos ev ON p.equipo_visitante_id = ev.equipo_id
ORDER BY p.fecha;


-- Racha de victorias del Arsenal en Premier League 2024
SELECT
    equipo,
    resultado,
    COUNT(*) AS partidos_seguidos
FROM vw_resultados_equipo
WHERE equipo = 'Arsenal'
GROUP BY equipo, resultado
ORDER BY partidos_seguidos DESC;



-- =====================================================
-- Rachas exactas de resultados por equipo
-- Premier League 2024
-- Usa window functions (LAG, SUM OVER)
-- =====================================================

WITH base AS (
    -- Marca dónde se corta una racha
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
    -- Asigna un ID a cada racha
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
-- Cuenta la duración de cada racha
SELECT
    equipo,
    resultado,
    racha_id,
    COUNT(*) AS partidos_seguidos
FROM rachas
GROUP BY equipo, resultado, racha_id
ORDER BY partidos_seguidos DESC;


-- Mejor racha de victorias por equipo - Premier League 2024
SELECT
    equipo,
    MAX(partidos_seguidos) AS mejor_racha_victorias
FROM vw_rachas_equipo
WHERE resultado = 'G'
GROUP BY equipo
ORDER BY mejor_racha_victorias DESC;


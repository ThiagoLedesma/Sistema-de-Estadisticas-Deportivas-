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

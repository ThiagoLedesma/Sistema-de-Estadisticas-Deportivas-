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
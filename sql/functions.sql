CREATE OR REPLACE FUNCTION fn_resultados_equipo()
RETURNS TABLE (
    equipo TEXT,
    fecha DATE,
    goles_favor INT,
    goles_contra INT,
    resultado TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.nombre::TEXT,
        p.fecha,
        CASE
            WHEN e.equipo_id = p.equipo_local_id THEN p.goles_local
            ELSE p.goles_visitante
        END,
        CASE
            WHEN e.equipo_id = p.equipo_local_id THEN p.goles_visitante
            ELSE p.goles_local
        END,
        CASE
            WHEN
                (CASE
                    WHEN e.equipo_id = p.equipo_local_id THEN p.goles_local
                    ELSE p.goles_visitante
                END) >
                (CASE
                    WHEN e.equipo_id = p.equipo_local_id THEN p.goles_visitante
                    ELSE p.goles_local
                END)
            THEN 'G'
            WHEN
                (CASE
                    WHEN e.equipo_id = p.equipo_local_id THEN p.goles_local
                    ELSE p.goles_visitante
                END) <
                (CASE
                    WHEN e.equipo_id = p.equipo_local_id THEN p.goles_visitante
                    ELSE p.goles_local
                END)
            THEN 'P'
            ELSE 'E'
        END
    FROM partidos p
    JOIN equipos e
        ON e.equipo_id IN (p.equipo_local_id, p.equipo_visitante_id);
END;
$$ LANGUAGE plpgsql;




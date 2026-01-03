-- 🟢 Tabla de equipos
CREATE TABLE equipos (
    equipo_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    estadio VARCHAR(100),
    pais VARCHAR(50) DEFAULT 'Inglaterra'
);

-- 🟢 Tabla de jugadores
CREATE TABLE jugadores (
    jugador_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    equipo_id INTEGER REFERENCES equipos(equipo_id),
    posicion VARCHAR(50),
    edad INTEGER,
    nacionalidad VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);


-- 🟢 Tabla de partidos
CREATE TABLE partidos (
    partido_id SERIAL PRIMARY KEY,
    equipo_local_id INTEGER REFERENCES equipos(equipo_id),
    equipo_visitante_id INTEGER REFERENCES equipos(equipo_id),
    goles_local INTEGER,
    goles_visitante INTEGER,
    fecha DATE
);

-- 🟢 Tabla de estadísticas de jugadores
CREATE TABLE estadisticas_jugador (
    estadistica_id SERIAL PRIMARY KEY,
    jugador_id INTEGER REFERENCES jugadores(jugador_id),
    partido_id INTEGER REFERENCES partidos(partido_id),
    goles INTEGER DEFAULT 0,
    asistencias INTEGER DEFAULT 0,
    tarjetas_amarillas INTEGER DEFAULT 0,
    tarjetas_rojas INTEGER DEFAULT 0,
    minutos_jugados INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);


CREATE INDEX idx_resultados_equipo_fecha
ON vw_resultados_equipo (equipo, fecha);

CREATE INDEX idx_partidos_fecha
ON partidos (fecha);

CREATE INDEX idx_partidos_local
ON partidos (equipo_local_id);

CREATE INDEX idx_partidos_visitante
ON partidos (equipo_visitante_id);

CREATE INDEX idx_estadisticas_jugador_partido
ON estadisticas_jugador (jugador_id, partido_id);

CREATE INDEX idx_jugadores_equipo
ON jugadores (equipo_id);


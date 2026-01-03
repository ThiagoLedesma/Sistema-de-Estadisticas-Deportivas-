# Sistema-de-Estadisticas-Deportivas-
⚽ Automated sports analytics platform. Tracks team performance, player statistics, and match results using PostgreSQL, Python, and API integration.

⚽ Football Stats Data System – Premier League 2024

Sistema de análisis de estadísticas deportivas enfocado en la Premier League 2024, diseñado como proyecto de Data Engineering con énfasis en modelado relacional, SQL avanzado y análisis de métricas reales.

🧠 Objetivo del proyecto

Construir un sistema que permita:

almacenar datos deportivos relacionales

analizar rendimiento de jugadores y equipos

generar métricas útiles mediante SQL avanzado

servir como base para futuros pipelines ETL y visualizaciones

Este proyecto simula un escenario real de trabajo de un Data Engineer junior / trainee.

🏗️ Arquitectura general
API / Datos manuales
        ↓
   PostgreSQL
        ↓
 SQL (Views, Functions, Indexes)
        ↓
  Análisis y métricas
        ↓
 (Futuro) Python / ETL / Dashboards

🗄️ Modelo de datos
Tablas principales

equipos

jugadores

partidos

estadisticas_jugador

clasificacion

Relaciones clave:

equipos → jugadores (1:N)

equipos → partidos (local / visitante)

jugadores → estadísticas → partidos

El diseño prioriza normalización, claridad y consultas analíticas eficientes.

📊 Análisis implementados
🔹 Rendimiento de jugadores

goles

asistencias

partidos jugados

contribución ofensiva

contribución por partido

Vista principal:

vw_rendimiento_jugador

🔹 Rendimiento de equipos

goles a favor / en contra

diferencia de gol

promedio de goles por partido

Vista principal:

vw_rendimiento_equipo

🔹 Rachas (SQL avanzado)

rachas de victorias, empates y derrotas

uso de:

CTEs

window functions

funciones SQL personalizadas

Función clave:

fn_resultados_equipo()

⚡ Optimización

Se implementaron índices estratégicos sobre:

claves de join

fechas

estadísticas de jugador

Ejemplo:

CREATE INDEX idx_estadisticas_jugador_partido
ON estadisticas_jugador (jugador_id, partido_id);

🛠️ Tecnologías utilizadas

PostgreSQL

SQL (avanzado)

JOINs

agregaciones

views

CTEs

window functions

funciones PL/pgSQL

DBeaver

Linux (Ubuntu)

🚀 Próximos pasos

Integración con API deportiva

Pipeline ETL en Python

Automatización de carga

Dashboard interactivo (Streamlit / Power BI)

Dockerización del entorno

👤 Autor

Proyecto desarrollado por Tyty
Estudiante de Ingeniería en Sistemas
Enfocado en Data Engineering

💬 Este proyecto prioriza claridad, buenas prácticas y pensamiento analítico por sobre volumen de código.

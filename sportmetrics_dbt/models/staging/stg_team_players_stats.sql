{{ config(materialized='view') }}

WITH base AS (
    SELECT DISTINCT
        CAST(GAME_ID AS STRING)  AS game_id,
        CAST(TEAM_ID AS STRING)  AS team_id,
        TEAM_ABBREVIATION,
        TEAM_CITY,
        CAST(PLAYER_ID AS STRING) AS player_id,
        PLAYER_NAME,
        NICKNAME,
        START_POSITION,
        COMMENT,

        -- Convert "30:11" → 30 + 11/60
        CASE
            WHEN REGEXP_CONTAINS(MIN, r':')
            THEN SAFE_CAST(SPLIT(MIN, ':')[OFFSET(0)] AS FLOAT64)
                 + SAFE_CAST(SPLIT(MIN, ':')[OFFSET(1)] AS FLOAT64)/60
            ELSE SAFE_CAST(MIN AS FLOAT64)
        END AS minutes_played,

        SAFE_CAST(FGM AS INT64) AS fgm,
        SAFE_CAST(FGA AS INT64) AS fga,
        SAFE_CAST(FG_PCT AS FLOAT64) AS fg_pct,
        SAFE_CAST(FG3M AS INT64) AS fg3m,
        SAFE_CAST(FG3A AS INT64) AS fg3a,
        SAFE_CAST(FG3_PCT AS FLOAT64) AS fg3_pct,
        SAFE_CAST(FTM AS INT64) AS ftm,
        SAFE_CAST(FTA AS INT64) AS fta,
        SAFE_CAST(FT_PCT AS FLOAT64) AS ft_pct,
        SAFE_CAST(OREB AS INT64) AS oreb,
        SAFE_CAST(DREB AS INT64) AS dreb,
        SAFE_CAST(REB AS INT64) AS reb,
        SAFE_CAST(AST AS INT64) AS ast,
        SAFE_CAST(STL AS INT64) AS stl,
        SAFE_CAST(BLK AS INT64) AS blk,
        SAFE_CAST(TO AS INT64)  AS turnovers,
        SAFE_CAST(PF AS INT64)  AS personal_fouls,
        SAFE_CAST(PTS AS INT64) AS pts,
        SAFE_CAST(PLUS_MINUS AS INT64) AS plus_minus
    FROM {{ source('foufous_de_sochaux', 'players_stats') }}
)

SELECT * FROM base;

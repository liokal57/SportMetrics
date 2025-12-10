{{ config(materialized='view') }}

WITH base AS (
    SELECT DISTINCT
        CAST(GAME_ID AS STRING) AS game_id,
        CAST(TEAM_ID AS STRING) AS team_id,
        TEAM_NAME,
        TEAM_ABBREVIATION,
        TEAM_CITY,

        CASE
            WHEN REGEXP_CONTAINS(MIN, r':') THEN SAFE_CAST(SPLIT(MIN, ':')[OFFSET(0)] AS INT64)
            ELSE SAFE_CAST(MIN AS INT64)
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
    FROM {{ source('foufous_de_sochaux','team_boxscores') }}
)

SELECT * FROM base;

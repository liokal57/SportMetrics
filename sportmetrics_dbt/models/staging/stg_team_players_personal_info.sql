{{ config(materialized='view') }}

WITH base AS (
    SELECT DISTINCT
        CAST(PLAYER_ID AS STRING) AS player_id,
        PLAYER_NAME,
        FIRST_NAME,
        LAST_NAME,
        DISPLAY_FIRST_LAST,

        SAFE.PARSE_DATE('%Y-%m-%d %H:%M:%S', BIRTHDATE) AS birthdate,
        SCHOOL,
        COUNTRY,

        -- Convert "6-6" → 198 cm
        CASE
            WHEN REGEXP_CONTAINS(HEIGHT, r'-')
            THEN SAFE_CAST(
                (SPLIT(HEIGHT, '-')[OFFSET(0)] * 30.48) +
                (SPLIT(HEIGHT, '-')[OFFSET(1)] * 2.54)
                AS FLOAT64
            )
            ELSE NULL
        END AS height_cm,

        -- Convert lbs → kg
        SAFE_CAST(WEIGHT AS FLOAT64) * 0.453592 AS weight_kg,

        SAFE_CAST(SEASON_EXP AS INT64) AS season_exp,
        SAFE_CAST(JERSEY AS INT64) AS jersey,
        POSITION,
        ROSTER_STATUS,
        SAFE_CAST(FROM_YEAR AS INT64) AS from_year,
        SAFE_CAST(TO_YEAR AS INT64) AS to_year,

        DRAFT_YEAR,
        DRAFT_ROUND,
        DRAFT_NUMBER,

        SAFE_CAST(HEIGHT_CM AS FLOAT64) AS height_cm_raw,
        SAFE_CAST(WEIGHT_KG AS FLOAT64) AS weight_kg_raw,
        SAFE_CAST(AGE AS INT64) AS age
    FROM {{ source('foufous_de_sochaux','team_players_personal_info') }}
)

SELECT * FROM base;

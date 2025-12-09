{{ config(materialized='view') }}

select
    cast(PLAYER_ID as string)            as player_id,
    PLAYER_NAME                          as player_name,
    FIRST_NAME                           as first_name,
    LAST_NAME                            as last_name,
    DISPLAY_FIRST_LAST                   as display_first_last,
    BIRTHDATE                            as birthdate,
    SCHOOL                               as school,
    COUNTRY                              as country,
    HEIGHT                               as height,
    WEIGHT                               as weight,
    SEASON_EXP                           as season_experience,
    JERSEY                               as jersey_number,
    POSITION                             as position,
    ROSTER_STATUS                        as roster_status,
    FROM_YEAR                            as from_year,
    TO_YEAR                              as to_year,
    DRAFT_YEAR                           as draft_year,
    DRAFT_ROUND                          as draft_round,
    DRAFT_NUMBER                         as draft_number,
    HEIGHT_CM                            as height_cm,
    WEIGHT_KG                            as weight_kg,
    AGE                                  as age

from {{ source('foufous_de_sochaux', 'players_personal_info') }}

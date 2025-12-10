{{ config(materialized='view') }}

with raw as (
    select distinct
        cast(PLAYER_ID as int64)                   as player_id,
        PLAYER_NAME                                as player_name,
        FIRST_NAME                                 as first_name,
        LAST_NAME                                  as last_name,
        DISPLAY_FIRST_LAST                         as display_first_last,

        SAFE.PARSE_DATE('%Y-%m-%d', BIRTHDATE)     as birthdate,

        SCHOOL                                     as school,
        COUNTRY                                    as country,

        case
            when regexp_contains(HEIGHT, r'-') then
                round(
                    cast(split(HEIGHT, '-')[offset(0)] as float64) * 30.48 +
                    cast(split(HEIGHT, '-')[offset(1)] as float64) * 2.54,
                    1
                )
        end                                         as height_cm,

        round(WEIGHT * 0.453592, 1)                as weight_kg,

        cast(SEASON_EXP as int64)                  as season_exp,
        cast(JERSEY as int64)                      as jersey_number,
        POSITION                                   as position,
        ROSTER_STATUS                              as roster_status,
        cast(FROM_YEAR as int64)                   as from_year,
        cast(TO_YEAR as int64)                     as to_year,

        cast(DRAFT_YEAR as int64)                  as draft_year,
        cast(DRAFT_ROUND as int64)                 as draft_round,
        cast(DRAFT_NUMBER as int64)                as draft_number,

        cast(AGE as int64)                         as age
    from {{ source('foufous_de_sochaux', 'players_personal_info') }}
)

select *
from raw

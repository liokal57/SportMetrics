{{ config(materialized='view') }}

with raw as (
    select distinct
        cast(Game_ID as int64)                 as game_id,
        cast(Team_ID as int64)                 as team_id,
        TEAM_NAME                              as team_name,
        TEAM_ABBREVIATION                      as team_abbreviation,
        TEAM_CITY                              as team_city,

        case
            when regexp_contains(MIN, r':') then
                cast(split(MIN, ':')[offset(0)] as int64)
            else 
                cast(MIN as int64)
        end as minutes_played,

        cast(FGM as int64)                     as field_goals_made,
        cast(FGA as int64)                     as field_goal_attempts,
        cast(FG_PCT as float64)                as field_goal_pct,
        cast(FG3M as int64)                    as three_point_made,
        cast(FG3A as int64)                    as three_point_attempts,
        cast(FG3_PCT as float64)               as three_point_pct,
        cast(FTM as int64)                     as free_throws_made,
        cast(FTA as int64)                     as free_throw_attempts,
        cast(FT_PCT as float64)                as free_throw_pct,

        cast(OREB as int64)                    as offensive_rebounds,
        cast(DREB as int64)                    as defensive_rebounds,
        cast(REB as int64)                     as total_rebounds,

        cast(AST as int64)                     as assists,
        cast(STL as int64)                     as steals,
        cast(BLK as int64)                     as blocks,

        cast(`TO` as int64)                    as turnovers,

        cast(PF as int64)                      as personal_fouls,
        cast(PTS as int64)                     as points,
        cast(PLUS_MINUS as int64)              as plus_minus
    from {{ source('foufous_de_sochaux', 'team_boxscores') }}
)

select *
from raw

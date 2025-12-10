{{ config(materialized='view') }}

with base as (
    select
        cast(GAME_ID as int64)                     as game_id,
        cast(PLAYER_ID as int64)                   as player_id,
        PLAYER_NAME                                as player_name,
        NICKNAME                                   as nickname,
        START_POSITION                             as start_position,
        COMMENT                                     as comment,

        (COMMENT like 'DNP%')                      as is_dnp,

        case 
            when COMMENT like 'DNP%' then null
            when regexp_contains(MIN, r':') then
                cast(split(MIN, ':')[offset(0)] as float64) +
                cast(split(MIN, ':')[offset(1)] as float64) / 60
            else 
                cast(MIN as float64)
        end as minutes_played,

        case when COMMENT like 'DNP%' then null else cast(FGM as int64) end as fgm,
        case when COMMENT like 'DNP%' then null else cast(FGA as int64) end as fga,
        case when COMMENT like 'DNP%' then null else cast(FG_PCT as float64) end as fg_pct,
        case when COMMENT like 'DNP%' then null else cast(FG3M as int64) end as fg3m,
        case when COMMENT like 'DNP%' then null else cast(FG3A as int64) end as fg3a,
        case when COMMENT like 'DNP%' then null else cast(FG3_PCT as float64) end as fg3_pct,
        case when COMMENT like 'DNP%' then null else cast(FTM as int64) end as ftm,
        case when COMMENT like 'DNP%' then null else cast(FTA as int64) end as fta,
        case when COMMENT like 'DNP%' then null else cast(FT_PCT as float64) end as ft_pct,
        case when COMMENT like 'DNP%' then null else cast(OREB as int64) end as oreb,
        case when COMMENT like 'DNP%' then null else cast(DREB as int64) end as dreb,
        case when COMMENT like 'DNP%' then null else cast(REB as int64) end as reb,
        case when COMMENT like 'DNP%' then null else cast(AST as int64) end as ast,
        case when COMMENT like 'DNP%' then null else cast(STL as int64) end as stl,
        case when COMMENT like 'DNP%' then null else cast(BLK as int64) end as blk,

        case when COMMENT like 'DNP%' then null else cast(`TO` as int64) end as turnovers,

        case when COMMENT like 'DNP%' then null else cast(PF as int64) end as personal_fouls,
        case when COMMENT like 'DNP%' then null else cast(PTS as int64) end as points,
        case when COMMENT like 'DNP%' then null else cast(PLUS_MINUS as int64) end as plus_minus
    from {{ source('foufous_de_sochaux', 'players_stats') }}
)

select *
from base

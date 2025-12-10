{{ config(materialized='view') }}

select
    cast(GAME_ID as string)                      as game_id,
    cast(TEAM_ID as string)                      as team_id,
    TEAM_ABBREVIATION                            as team_abbreviation,
    TEAM_CITY                                    as team_city,

    cast(PLAYER_ID as string)                    as player_id,
    PLAYER_NAME                                   as player_name,
    NICKNAME                                      as nickname,
    START_POSITION                                as start_position,
    COMMENT                                       as comment,

    -- Playing time & shooting
    MIN                                           as minutes_played,
    FGM                                           as field_goals_made,
    FGA                                           as field_goal_attempts,
    FG_PCT                                        as field_goal_pct,

    FG3M                                          as three_point_made,
    FG3A                                          as three_point_attempts,
    FG3_PCT                                       as three_point_pct,

    FTM                                           as free_throws_made,
    FTA                                           as free_throw_attempts,
    FT_PCT                                        as free_throw_pct,

    -- Rebounds
    OREB                                          as offensive_rebounds,
    DREB                                          as defensive_rebounds,
    REB                                           as total_rebounds,

    -- Playmaking & defense
    AST                                           as assists,
    STL                                           as steals,
    BLK                                           as blocks,
    `TO`                                          as turnovers,
    PF                                            as personal_fouls,

    -- Scoring
    PTS                                           as points,

    -- +/- Indicator
    PLUS_MINUS                                    as plus_minus

from {{ source('foufous_de_sochaux', 'players_stats') }}

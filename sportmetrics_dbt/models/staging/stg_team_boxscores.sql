{{ config(materialized='view') }}

select
    cast(GAME_ID as string)                      as game_id,
    cast(TEAM_ID as string)                      as team_id,

    TEAM_NAME                                     as team_name,
    TEAM_ABBREVIATION                             as team_abbreviation,
    TEAM_CITY                                      as team_city,

    -- Playing time
    MIN                                           as minutes_played,

    -- Shooting efficiency
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
    'TO'                                            as turnovers,
    PF                                            as personal_fouls,

    -- Scoring & impact
    PTS                                           as points,
    PLUS_MINUS                                     as plus_minus

from {{ source('foufous_de_sochaux', 'team_boxscores') }}

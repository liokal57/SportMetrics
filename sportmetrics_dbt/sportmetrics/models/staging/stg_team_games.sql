{{ config(materialized='view') }}

select
    cast(Team_ID as string)                    as team_id,
    cast(Game_ID as string)                    as game_id,

    GAME_DATE                                   as game_date,
    MATCHUP                                     as matchup,
    WL                                          as win_loss,
    W                                           as wins,
    L                                           as losses,
    W_PCT                                       as win_pct,

    -- Playing time
    MIN                                         as minutes_played,

    -- Shooting
    FGM                                         as field_goals_made,
    FGA                                         as field_goal_attempts,
    FG_PCT                                      as field_goal_pct,

    FG3M                                        as three_point_made,
    FG3A                                        as three_point_attempts,
    FG3_PCT                                     as three_point_pct,

    FTM                                         as free_throws_made,
    FTA                                         as free_throw_attempts,
    FT_PCT                                      as free_throw_pct,

    -- Rebounds
    OREB                                        as offensive_rebounds,
    DREB                                        as defensive_rebounds,
    REB                                         as total_rebounds,

    -- Playmaking & defense
    AST                                         as assists,
    STL                                         as steals,
    BLK                                         as blocks,
    TOV                                         as turnovers,
    PF                                          as personal_fouls,

    -- Scoring
    PTS                                         as points

from {{ source('foufous_de_sochaux', 'team_games') }}

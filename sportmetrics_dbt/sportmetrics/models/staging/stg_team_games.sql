{{ config(materialized='view') }}

SELECT
  -- colonnes techniques airbyte
  _airbyte_raw_id,
  _airbyte_extracted_at,
  _airbyte_generation_id,
  _airbyte_meta,

  -- indicateurs de résultat
  L        AS losses,
  W        AS wins,
  PF       AS points_for,
  WL       AS win_loss_record,

  -- stats de jeu
  AST      AS assists,
  BLK      AS blocks,
  FGA      AS field_goal_attempts,
  FGM      AS field_goals_made,
  FG_PCT   AS field_goal_pct,
  FG3A     AS three_pt_attempts,
  FG3M     AS three_pt_made,
  FG3_PCT  AS three_pt_pct,
  FTA      AS free_throw_attempts,
  FTM      AS free_throws_made,
  FT_PCT   AS free_throw_pct,
  MIN      AS minutes_played,
  PTS      AS points,
  REB      AS rebounds,
  OREB     AS offensive_rebounds,
  DREB     AS defensive_rebounds,
  STL      AS steals,
  TOV      AS turnovers,
  W_PCT    AS win_pct,

  -- infos match / équipe
  CAST(Game_ID AS INT64)                 AS game_id,
  CAST(Team_ID AS STRING)                AS team_id,
  MATCHUP                                AS matchup,
  SAFE.PARSE_DATE('%Y-%m-%d', GAME_DATE) AS game_date

FROM {{ source('sportmetrics_raw', 'team_games') }}


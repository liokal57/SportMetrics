-- Merge des tables boxscores et games
SELECT g.*, plus_minus
FROM dbt_foufous.stg_team_boxscores b
JOIN dbt_foufous.stg_team_games g ON b.game_id = g.game_id
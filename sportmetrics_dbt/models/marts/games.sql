SELECT
    g.*,
    b.plus_minus
FROM {{ ref('stg_team_boxscores') }} b
JOIN {{ ref('stg_team_games') }} g
    ON CAST(b.game_id AS INT64) = CAST(g.game_id AS INT64)

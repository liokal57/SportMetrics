{{ config(materialized='view') }}
select * from {{ source('sportmetrics_raw', 'team_players_personal_info') }}

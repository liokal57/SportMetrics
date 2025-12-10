{{ config(materialized='view') }}
select * from {{ source('sportmetrics_raw', 'team_training_sessions') }}

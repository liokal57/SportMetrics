{{ config(materialized='view') }}

with raw as (
    select distinct
        Session_ID                                 as session_id,
        cast(PLAYER_ID as int64)                   as player_id,
        PLAYER_NAME                                as player_name,
        SAFE.PARSE_DATE('%Y-%m-%d', Session_Date)  as session_date,

        cast(Days_Before_Match as int64)           as days_before_match,
        SAFE.PARSE_DATE('%Y-%m-%d', Next_Match_Date) as next_match_date,
        cast(Next_Match_ID as int64)               as next_match_id,

        cast(Age as float64)                       as age,
        cast(Height_cm as float64)                 as height_cm,
        cast(Weight_kg as float64)                 as weight_kg,

        Position                                   as position,
        Exercise_Type                              as exercise_type,
        cast(Duration_min as int64)                as duration_min,
        cast(Heart_Rate as int64)                  as heart_rate,
        cast(Respiratory_Rate as int64)            as respiratory_rate,
        cast(Body_Temperature as float64)          as body_temperature,

        cast(Accel_X as float64)                   as accel_x,
        cast(Accel_Y as float64)                   as accel_y,
        cast(Accel_Z as float64)                   as accel_z,
        cast(Gyro_X as float64)                    as gyro_x,
        cast(Gyro_Y as float64)                    as gyro_y,
        cast(Gyro_Z as float64)                    as gyro_z,

        cast(Steps as int64)                       as steps,
        cast(Strength_Score as float64)            as strength_score,
        cast(Agility_sec as float64)               as agility_sec,
        cast(Endurance_Score as float64)           as endurance_score,
        cast(Jump_Height_cm as float64)            as jump_height_cm,

        cast(Shooting_Accuracy__ as float64)       as shooting_accuracy_pct,
        cast(Dribbling_Speed_sec as float64)       as dribbling_speed_sec,
        cast(Passing_Accuracy__ as float64)        as passing_accuracy_pct,

        cast(Defense_Rating as float64)            as defense_rating,
        cast(Focus_Level as float64)               as focus_level,
        cast(Weekly_Training_Hours as float64)     as weekly_training_hours,
        cast(Load_Intensity_Score as float64)      as load_intensity_score,
        cast(Fatigue_Level as float64)             as fatigue_level,
        cast(Injury_Risk as float64)               as injury_risk,
        Injury_Risk_Level                          as injury_risk_level,
        cast(Recovery_Time_hours as float64)       as recovery_time_hours,
        cast(Performance_Score as float64)         as performance_score,

        Team                                       as team_name,
        Team_Code                                  as team_code,
        Season                                     as season
    from {{ source('foufous_de_sochaux', 'team_training_sessions') }}
)

select *
from raw

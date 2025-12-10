{{ config(materialized='view') }}

select
    cast(Session_ID as string)                as session_id,
    cast(Player_ID as string)                 as player_id,
    Player_Name                               as player_name,
    Session_Date                              as session_date,
    Days_Before_Match                         as days_before_match,
    Next_Match_Date                           as next_match_date,
    cast(Next_Match_ID as string)             as next_match_id,

    -- Player physical info
    Age                                       as age,
    Height_cm                                 as height_cm,
    Weight_kg                                 as weight_kg,
    Position                                  as position,

    -- Training info
    Exercise_Type                             as exercise_type,
    Duration_min                              as duration_min,

    -- Physiological metrics
    Heart_Rate                                as heart_rate,
    Respiratory_Rate                          as respiratory_rate,
    Body_Temperature                          as body_temperature,

    -- Accelerometer
    Accel_X                                   as accel_x,
    Accel_Y                                   as accel_y,
    Accel_Z                                   as accel_z,

    -- Gyroscope
    Gyro_X                                    as gyro_x,
    Gyro_Y                                    as gyro_y,
    Gyro_Z                                    as gyro_z,

    -- Movement
    Steps                                     as steps,

    -- Performance metrics
    Strength_Score                            as strength_score,
    Agility_sec                               as agility_sec,
    Endurance_Score                           as endurance_score,
    Jump_Height_cm                             as jump_height_cm,
    Shooting_Accuracy__                       as shooting_accuracy_pct,
    Dribbling_Speed_sec                       as dribbling_speed_sec,
    Passing_Accuracy__                        as passing_accuracy_pct,
    Defense_Rating                            as defense_rating,

    -- Additional metrics
    Focus_Level                               as focus_level,
    Weekly_Training_Hours                     as weekly_training_hours,
    Load_Intensity_Score                      as load_intensity_score,
    Fatigue_Level                             as fatigue_level,
    Injury_Risk                               as injury_risk,
    Injury_Risk_Level                         as injury_risk_level,
    Recovery_Time_hours                       as recovery_time_hours,
    Performance_Score                          as performance_score,

    -- Team info
    Team                                      as team,
    Team_Code                                 as team_code,
    Season                                    as season

from {{ source('foufous_de_sochaux', 'team_training_sessions') }}

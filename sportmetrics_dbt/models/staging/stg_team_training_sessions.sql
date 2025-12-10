{{ config(materialized='view') }}

WITH base AS (
    SELECT DISTINCT
        Session_ID,
        CAST(Player_ID AS STRING) AS player_id,
        Player_Name,

        SAFE.PARSE_DATE('%Y-%m-%d', Session_Date) AS session_date,
        SAFE_CAST(Days_Before_Match AS INT64) AS days_before_match,
        SAFE.PARSE_DATE('%Y-%m-%d', Next_Match_Date) AS next_match_date,
        CAST(Next_Match_ID AS STRING) AS next_match_id,

        SAFE_CAST(Age AS INT64) AS age,
        SAFE_CAST(Height_cm AS FLOAT64) AS height_cm,
        SAFE_CAST(Weight_kg AS FLOAT64) AS weight_kg,

        Position,
        Exercise_Type,
        SAFE_CAST(Duration_min AS FLOAT64) AS duration_min,
        SAFE_CAST(Heart_Rate AS FLOAT64) AS heart_rate,
        SAFE_CAST(Respiratory_Rate AS FLOAT64) AS respiratory_rate,
        SAFE_CAST(Body_Temperature AS FLOAT64) AS body_temperature,

        Accel_X, Accel_Y, Accel_Z,
        Gyro_X, Gyro_Y, Gyro_Z,

        SAFE_CAST(Steps AS INT64) AS steps,
        SAFE_CAST(Strength_Score AS FLOAT64) AS strength_score,
        SAFE_CAST(Agility_sec AS FLOAT64) AS agility_sec,
        SAFE_CAST(Endurance_Score AS FLOAT64) AS endurance_score,
        SAFE_CAST(Jump_Height_cm AS FLOAT64) AS jump_height_cm,
        SAFE_CAST(Shooting_Accuracy_% AS FLOAT64) AS shooting_accuracy_pct,
        SAFE_CAST(Dribbling_Speed_sec AS FLOAT64) AS dribbling_speed_sec,
        SAFE_CAST(Passing_Accuracy_% AS FLOAT64) AS passing_accuracy_pct,
        SAFE_CAST(Defense_Rating AS FLOAT64) AS defense_rating,

        Focus_Level,
        SAFE_CAST(Weekly_Training_Hours AS FLOAT64) AS weekly_training_hours,
        SAFE_CAST(Load_Intensity_Score AS FLOAT64) AS load_intensity_score,
        SAFE_CAST(Fatigue_Level AS FLOAT64) AS fatigue_level,
        SAFE_CAST(Injury_Risk AS FLOAT64) AS injury_risk,
        Injury_Risk_Level,
        SAFE_CAST(Recovery_Time_hours AS FLOAT64) AS recovery_time_hours,
        SAFE_CAST(Performance_Score AS FLOAT64) AS performance_score,

        Team,
        Team_Code,
        Season
    FROM {{ source('foufous_de_sochaux','team_training_sessions') }}
)

SELECT * FROM base;

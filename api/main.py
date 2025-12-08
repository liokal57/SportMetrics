from fastapi import FastAPI
import pandas as pd

app = FastAPI(title="SportMetrics API")

# === ROUTE DE TEST ===
@app.get("/health")
def health_check():
    return {"status": "ok"}

# === 1. team_boxscores.csv ===
@app.get("/team_boxscores")
def get_team_boxscores():
    df = pd.read_csv("data/team_boxscores.csv")
    return df.to_dict(orient="records")

# === 2. team_games_dataset.csv ===
@app.get("/team_games_dataset")
def get_team_games_dataset():
    df = pd.read_csv("data/team_games_dataset.csv")
    return df.to_dict(orient="records")

# === 3. team_players_personal_info.csv ===
@app.get("/team_players_personal_info")
def get_team_players_personal_info():
    df = pd.read_csv("data/team_players_personal_info.csv")
    return df.to_dict(orient="records")

# === 4. team_players_stats.csv ===
@app.get("/team_players_stats")
def get_team_players_stats():
    df = pd.read_csv("data/team_players_stats.csv")
    return df.to_dict(orient="records")

# === 5. team_training_sessions.csv ===
@app.get("/team_training_sessions")
def get_team_training_sessions():
    df = pd.read_csv("data/team_training_sessions.csv")
    return df.to_dict(orient="records")

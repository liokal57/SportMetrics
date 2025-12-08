from fastapi import FastAPI, HTTPException
import pandas as pd
from pathlib import Path

# Le dossier data se trouve un niveau au-dessus de /api
ROOT_DIR = Path(__file__).parent.parent
DATA_DIR = ROOT_DIR / "data"

app = FastAPI(title="SportMetrics API", version="1.0")

def load_data():
    """Charge tous les fichiers CSV"""
    training = pd.read_csv(DATA_DIR / "team_training_sessions.csv")
    games = pd.read_csv(DATA_DIR / "team_games_dataset.csv")
    players_stats = pd.read_csv(DATA_DIR / "team_players_stats.csv")
    players_info = pd.read_csv(DATA_DIR / "team_players_personal_info.csv")
    boxscores = pd.read_csv(DATA_DIR / "team_boxscores.csv")
    return {
        "training": training,
        "games": games,
        "players_stats": players_stats,
        "players_info": players_info,
        "boxscores": boxscores
    }

DATA = load_data()

@app.get("/health")
def health():
    """Vérifie que l'API fonctionne et que les données sont chargées"""
    return {
        "status": "ok",
        "players": len(DATA["players_info"]),
        "games": len(DATA["games"]),
        "trainings": len(DATA["training"])
    }

@app.get("/players")
def get_players(limit: int = 5):
    """Liste les joueurs"""
    df = DATA["players_info"]
    return df.head(limit).to_dict(orient="records")

@app.get("/games")
def get_games(limit: int = 5):
    """Liste les matchs"""
    df = DATA["games"]
    return df.head(limit).to_dict(orient="records")

@app.get("/players/{player_id}")
def get_player(player_id: int):
    """Détail d'un joueur"""
    df = DATA["players_info"]
    if "PLAYER_ID" not in df.columns:
        raise HTTPException(status_code=500, detail="Colonne PLAYER_ID manquante")
    player = df[df["PLAYER_ID"] == player_id]
    if player.empty:
        raise HTTPException(status_code=404, detail="Joueur introuvable")
    return player.iloc[0].to_dict()
@app.get("/trainings")
def get_trainings():
    df = pd.read_csv("data/team_training_sessions.csv")
    return df.to_dict(orient="records")

@app.get("/stats")
def get_stats():
    df = pd.read_csv("data/team_players_stats.csv")
    return df.to_dict(orient="records")

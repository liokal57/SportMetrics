from fastapi import FastAPI, HTTPException
from pathlib import Path
import pandas as pd

app = FastAPI(title="SportMetrics API", version="1.0")

# Dossier racine du projet, puis dossier data/
ROOT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT_DIR / "data"


def read_csv(filename: str) -> pd.DataFrame:
    """
    Fonction utilitaire pour lire un CSV dans le dossier data.
    Si ça plante, on renvoie une erreur HTTP 500 avec le message clair.
    """
    path = DATA_DIR / filename
    try:
        return pd.read_csv(path)
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur lors de la lecture du fichier {path.name}: {e}",
        )


@app.get("/health")
def health_check():
    """Vérifie que l'API tourne."""
    return {"status": "ok"}


@app.get("/team_boxscores")
def get_team_boxscores(limit: int = 100):
    """Retourne les boxscores."""
    df = read_csv("team_boxscores.csv")
    return df.head(limit).to_dict(orient="records")


@app.get("/team_games_dataset")
def get_team_games_dataset(limit: int = 100):
    """Retourne les données des matchs."""
    df = read_csv("team_games_dataset.csv")
    return df.head(limit).to_dict(orient="records")


@app.get("/team_players_personal_info")
def get_team_players_personal_info(limit: int = 100):
    """Retourne les infos personnelles des joueurs."""
    df = read_csv("team_players_personal_info.csv")
    return df.head(limit).to_dict(orient="records")


@app.get("/team_players_stats")
def get_team_players_stats(limit: int = 100):
    """Retourne les stats des joueurs."""
    df = read_csv("team_players_stats.csv")
    return df.head(limit).to_dict(orient="records")


@app.get("/team_training_sessions")
def get_team_training_sessions(limit: int = 100):
    """Retourne les sessions d'entraînement."""
    df = read_csv("team_training_sessions.csv")
    return df.head(limit).to_dict(orient="records")

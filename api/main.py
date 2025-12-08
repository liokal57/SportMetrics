from fastapi import FastAPI, HTTPException
from pathlib import Path
import pandas as pd

app = FastAPI(
    title="SportMetrics API",
    version="1.0",
    description="API de lecture des CSV SportMetrics",
)

# Dossier du projet (SportMetrics) puis dossier data/
ROOT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT_DIR / "data"


def read_csv(filename: str) -> pd.DataFrame:
    """
    Lit un CSV dans le dossier data avec un encodage compatible Excel/Windows.
    Si ça plante, on renvoie une erreur HTTP claire.
    """
    path = DATA_DIR / filename

    try:
        # encodage typique des fichiers CSV enregistrés depuis Excel en français
        return pd.read_csv(path, encoding="latin-1")
        # Si vraiment besoin, on pourrait tester "cp1252" ou ajouter sep=";"
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur lors de la lecture du fichier {path.name} : {e}",
        )


# ---------- ROUTE DE SANTÉ ----------

@app.get("/health")
def health_check():
    """Vérifie que l'API tourne bien."""
    return {"status": "ok"}


# ---------- CSV 1 : team_boxscores.csv ----------

@app.get("/team_boxscores")
def get_team_boxscores(limit: int = 100):
    """
    Retourne les boxscores de l'équipe.
    """
    df = read_csv("team_boxscores.csv")
    return df.head(limit).to_dict(orient="records")


# ---------- CSV 2 : team_games_dataset.csv ----------

@app.get("/team_games_dataset")
def get_team_games_dataset(limit: int = 100):
    """
    Retourne les données des matchs.
    """
    df = read_csv("team_games_dataset.csv")
    return df.head(limit).to_dict(orient="records")


# ---------- CSV 3 : team_players_personal_info.csv ----------

@app.get("/team_players_personal_info")
def get_team_players_personal_info(limit: int = 100):
    """
    Retourne les informations personnelles des joueurs.
    """
    df = read_csv("team_players_personal_info.csv")
    return df.head(limit).to_dict(orient="records")


# ---------- CSV 4 : team_players_stats.csv ----------

@app.get("/team_players_stats")
def get_team_players_stats(limit: int = 100):
    """
    Retourne les statistiques des joueurs.
    """
    df = read_csv("team_players_stats.csv")
    return df.head(limit).to_dict(orient="records")


# ---------- CSV 5 : team_training_sessions.csv ----------

@app.get("/team_training_sessions")
def get_team_training_sessions(limit: int = 100):
    """
    Retourne les sessions d'entraînement.
    """
    df = read_csv("team_training_sessions.csv")
    return df.head(limit).to_dict(orient="records")

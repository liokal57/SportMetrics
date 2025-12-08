from fastapi import FastAPI, HTTPException
from pathlib import Path
import pandas as pd
import numpy as np

app = FastAPI(
    title="SportMetrics API",
    version="1.1",
    description="API de lecture des CSV SportMetrics (avec gestion des NaN)",
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
        df = pd.read_csv(path, encoding="latin-1")

        # Nettoyage : remplacer les NaN et inf par None pour compatibilité JSON
        df = df.replace([np.inf, -np.inf], np.nan)
        df = df.where(pd.notnull(df), None)

        return df

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur lors de la lecture du fichier {path.name} : {e}",
        )


def df_to_json_records(df: pd.DataFrame, limit: int = 100):
    """
    Transforme un DataFrame en liste de dictionnaires JSON-compatibles.
    """
    return df.head(limit).to_dict(orient="records")


# ---------- ROUTE DE SANTÉ ----------

@app.get("/health")
def health_check():
    """Vérifie que l'API tourne bien."""
    return {"status": "ok"}


# ---------- ROUTES CSV ----------

@app.get("/team_boxscores")
def get_team_boxscores(limit: int = 100):
    """Retourne les boxscores de l'équipe."""
    df = read_csv("team_boxscores.csv")
    return df_to_json_records(df, limit)


@app.get("/team_games_dataset")
def get_team_games_dataset(limit: int = 100):
    """Retourne les données des matchs."""
    df = read_csv("team_games_dataset.csv")
    return df_to_json_records(df, limit)


@app.get("/team_players_personal_info")
def get_team_players_personal_info(limit: int = 100):
    """Retourne les infos personnelles des joueurs."""
    df = read_csv("team_players_personal_info.csv")
    return df_to_json_records(df, limit)


@app.get("/team_players_stats")
def get_team_players_stats(limit: int = 100):
    """Retourne les statistiques des joueurs."""
    df = read_csv("team_players_stats.csv")
    return df_to_json_records(df, limit)


@app.get("/team_training_sessions")
def get_team_training_sessions(limit: int = 100):
    """Retourne les sessions d'entraînement."""
    df = read_csv("team_training_sessions.csv")
    return df_to_json_records(df, limit)

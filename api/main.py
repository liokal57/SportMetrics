from fastapi import FastAPI, HTTPException
from pathlib import Path
import pandas as pd
import numpy as np
import math

app = FastAPI(
    title="SportMetrics API",
    version="1.3",
    description="API de lecture des CSV SportMetrics (avec nettoyage NaN/inf)",
)

# Dossier racine du projet (SportMetrics), puis dossier data/
ROOT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT_DIR / "data"


def read_csv(filename: str) -> pd.DataFrame:
    """
    Lit un CSV dans le dossier data.
    - Vérifie que le fichier existe
    - Tente un encodage standard
    (on ne fait ici que le minimum, le gros du nettoyage est fait après)
    """
    path = DATA_DIR / filename

    if not path.exists():
        raise HTTPException(
            status_code=500,
            detail=f"Fichier introuvable dans /data : {path.name}",
        )

    try:
        df = pd.read_csv(path, encoding="latin-1")
        return df
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur lors de la lecture du fichier {path.name} : {e}",
        )


def clean_value(v):
    """
    Nettoie une valeur individuelle pour être JSON-compatible.
    - Remplace NaN, inf, -inf par None
    """
    if isinstance(v, float):
        if math.isnan(v) or v == float("inf") or v == float("-inf"):
            return None
    return v


def df_to_json_records(df: pd.DataFrame, limit: int = 100):
    """
    Transforme un DataFrame en liste de dictionnaires JSON-sérialisables.
    Nettoyage profond après conversion.
    """
    records = df.head(limit).to_dict(orient="records")
    cleaned_records = []

    for row in records:
        new_row = {}
        for k, v in row.items():
            new_row[k] = clean_value(v)
        cleaned_records.append(new_row)

    return cleaned_records


# ---------- ROUTE DE SANTÉ ----------

@app.get("/health")
def health_check():
    """Vérifie que l'API tourne bien."""
    return {"status": "ok"}


# ---------- CSV 1 : team_boxscores.csv ----------

@app.get("/team_boxscores")
def get_team_boxscores(limit: int = 100):
    """Retourne les boxscores de l'équipe."""
    df = read_csv("team_boxscores.csv")
    return df_to_json_records(df, limit)


# ---------- CSV 2 : team_games_dataset.csv ----------

@app.get("/team_games_dataset")
def get_team_games_dataset(limit: int = 100):
    """Retourne les données des matchs."""
    df = read_csv("team_games_dataset.csv")
    return df_to_json_records(df, limit)


# ---------- CSV 3 : team_players_personal_info.csv ----------

@app.get("/team_players_personal_info")
def get_team_players_personal_info(limit: int = 100):
    """Retourne les informations personnelles des joueurs."""
    df = read_csv("team_players_personal_info.csv")
    return df_to_json_records(df, limit)


# ---------- CSV 4 : team_players_stats.csv ----------

@app.get("/team_players_stats")
def get_team_players_stats(limit: int = 100):
    """Retourne les statistiques des joueurs."""
    df = read_csv("team_players_stats.csv")
    return df_to_json_records(df, limit)


# ---------- CSV 5 : team_training_sessions.csv ----------

@app.get("/team_training_sessions")
def get_team_training_sessions(limit: int = 100):
    """Retourne les sessions d'entraînement."""
    df = read_csv("team_training_sessions.csv")
    return df_to_json_records(df, limit)

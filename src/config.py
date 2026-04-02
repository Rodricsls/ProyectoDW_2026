"""
config.py — Carga de configuración desde .env
Todos los notebooks hacen: from config import MY_ENGINE, CH
"""
import os
from pathlib import Path
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import clickhouse_connect


BASE_DIR = Path(__file__).resolve().parent.parent 
load_dotenv(BASE_DIR / '.env')

# ── PostgreSQL ─────────────────────────────────────────────────
MY_HOST     = os.getenv('MY_HOST')
MY_PORT     = int(os.getenv('MY_PORT', 3306))
MY_DATABASE = os.getenv('MY_DATABASE')
MY_USER     = os.getenv('MY_USER')
MY_PASSWORD = os.getenv('MY_PASSWORD')

MY_ENGINE = create_engine(
    f"mysql+pymysql://{MY_USER}:{MY_PASSWORD}"
    f"@{MY_HOST}:{MY_PORT}/{MY_DATABASE}",
    pool_pre_ping=True    # reconecta si la conexión cayó
)

# ── ClickHouse ─────────────────────────────────────────────────
CH_HOST     = os.getenv('CH_HOST', 'localhost')
CH_PORT     = int(os.getenv('CH_PORT', 8123))
CH_USER     = os.getenv('CH_USER', 'default')
CH_PASSWORD = os.getenv('CH_PASSWORD', '')

CH = clickhouse_connect.get_client(
    host=CH_HOST,
    port=CH_PORT,
    username=CH_USER,
    password=CH_PASSWORD,
)

# ── Nombres de bases de datos por capa ────────────────────────
BRONZE_DB = os.getenv('BRONZE_DB', 'bronze')
SILVER_DB = os.getenv('SILVER_DB', 'silver')
GOLD_DB   = os.getenv('GOLD_DB',   'gold')

# ── Pipeline ──────────────────────────────────────────────────
LOG_LEVEL  = os.getenv('LOG_LEVEL', 'INFO')
BATCH_SIZE = int(os.getenv('BATCH_SIZE', 50000))

# ── Verificación rápida al importar ───────────────────────────
if __name__ == '__main__':
    with MY_ENGINE.connect() as conn:
        print("MySQL:", conn.execute(text("SELECT version()")).scalar())
    result = CH.query("SELECT version()")
    print("ClickHouse:", result.result_rows[0][0])
    print(f"Capas: {BRONZE_DB} | {SILVER_DB} | {GOLD_DB}")
    print("✓ Config OK")
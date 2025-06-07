import os
from pathlib import Path
from dotenv import load_dotenv

PROJECT_ROOT = Path(__file__).resolve().parent.parent
DOTENV_PATH = PROJECT_ROOT / '.env'
load_dotenv(dotenv_path=DOTENV_PATH)

DATABASE_URL = os.getenv("DATABASE_URL")
print(f"DATABASE_URL successfully loaded: {DATABASE_URL}")
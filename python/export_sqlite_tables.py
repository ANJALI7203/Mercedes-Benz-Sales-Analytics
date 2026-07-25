import sqlite3
import pandas as pd
from pathlib import Path

# Project root
BASE_DIR = Path(__file__).resolve().parent.parent

# SQLite database
db_path = BASE_DIR / "data" / "cleaned" / "mercedes.db"

# Output folder
output_folder = BASE_DIR / "data" / "cleaned"

conn = sqlite3.connect(db_path)

tables = ["Sales", "Models", "Regions"]

for table in tables:
    df = pd.read_sql(f"SELECT * FROM {table}", conn)
    df.to_csv(output_folder / f"{table}.csv", index=False)
    print(f"✅ {table}.csv exported!")

conn.close()

print("\n🎉 All tables exported successfully.")
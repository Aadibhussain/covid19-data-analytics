#!/usr/bin/env python3
import pandas as pd
import sqlite3
import os

RAW_DATA = 'data/raw/covid_data.csv'
CLEANED_DATA = 'data/cleaned/covid_data_cleaned.csv'
DB_PATH = 'database/covid19_analysis.db'

def create_dirs():
    os.makedirs('data/raw', exist_ok=True)
    os.makedirs('data/cleaned', exist_ok=True)
    os.makedirs('database', exist_ok=True)
    os.makedirs('reports', exist_ok=True)
    print("✓ Directories created")

def load_clean_data(filepath):
    print(f"Loading data from {filepath}...")
    df = pd.read_csv(filepath)
    print(f"✓ Loaded {len(df)} records")
    
    df = df.drop_duplicates()
    df = df.fillna(0)
    print(f"✓ Cleaned: {len(df)} records")
    return df

def save_to_db(df, db_path):
    conn = sqlite3.connect(db_path)
    df.to_sql('covid_data', conn, if_exists='replace', index=False)
    print(f"✓ Saved to {db_path}")
    conn.close()

def main():
    print("COVID-19 Data Processing")
    print("="*50)
    
    create_dirs()
    
    if not os.path.exists(RAW_DATA):
        print(f"⚠ Place dataset at {RAW_DATA}")
        return
    
    df = load_clean_data(RAW_DATA)
    df.to_csv(CLEANED_DATA, index=False)
    save_to_db(df, DB_PATH)
    
    print("\n✓ Complete!")

if __name__ == "__main__":
    main()


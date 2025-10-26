-- COVID-19 Database Schema

DROP TABLE IF EXISTS covid_data;

CREATE TABLE covid_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    country TEXT NOT NULL,
    confirmed INTEGER DEFAULT 0,
    deaths INTEGER DEFAULT 0,
    recovered INTEGER DEFAULT 0,
    active INTEGER DEFAULT 0,
    new_cases INTEGER DEFAULT 0,
    new_deaths INTEGER DEFAULT 0
);

CREATE INDEX idx_date ON covid_data(date);
CREATE INDEX idx_country ON covid_data(country);
CREATE INDEX idx_date_country ON covid_data(date, country);

CREATE VIEW country_summary AS
SELECT 
    country,
    MAX(confirmed) as total_cases,
    MAX(deaths) as total_deaths,
    ROUND(MAX(deaths) * 100.0 / NULLIF(MAX(confirmed), 0), 2) as mortality_rate
FROM covid_data
GROUP BY country
ORDER BY total_cases DESC;

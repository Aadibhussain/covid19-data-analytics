-- COVID-19 Analysis Queries

-- Top 20 Countries by Cases
SELECT 
    country,
    MAX(confirmed) as total_cases,
    MAX(deaths) as total_deaths,
    ROUND(MAX(deaths) * 100.0 / NULLIF(MAX(confirmed), 0), 2) as mortality_rate
FROM covid_data
GROUP BY country
ORDER BY total_cases DESC
LIMIT 20;

-- Daily Global Statistics
SELECT 
    date,
    SUM(new_cases) as daily_new_cases,
    SUM(new_deaths) as daily_new_deaths
FROM covid_data
GROUP BY date
ORDER BY date DESC
LIMIT 30;

-- Monthly Trends
SELECT 
    strftime('%Y-%m', date) as month,
    SUM(new_cases) as monthly_cases
FROM covid_data
GROUP BY month
ORDER BY month DESC;

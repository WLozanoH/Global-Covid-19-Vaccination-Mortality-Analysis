
-- " Análisis de Mortalidad y Vacunación Global por COVID-19 (2020-2024)"

--Puedes descargar la data para importar ambas tablas aquí:
--👉covid_deaths: https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/CovidDeaths.zip
--👉covid_vaccinations: https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/CovidVaccinations.zip


DROP TABLE IF EXISTS covid_deaths;
--Crea la tabla con los tipos de datos adecuados para covid_deaths

CREATE TABLE covid_deaths (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    population BIGINT,
    total_cases INT,
    new_cases INT,
    new_cases_smoothed FLOAT,
    total_deaths INT,
    new_deaths INT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients INT,
    icu_patients_per_million FLOAT,
    hosp_patients INT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions INT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions INT,
    weekly_hosp_admissions_per_million FLOAT
);

	
--Usa el comando COPY para importar los datos desde el archivo CSV.
	
COPY covid_deaths FROM 'C:\Users\LENOVO\Desktop\Projects\Covid-19\CovidDeaths.csv' --ruta de donde se extraerá los datos a importar
DELIMITER ';'
HEADER CSV;

--Verifica los datos después de la importación.
SELECT
	*
FROM covid_deaths;

--Crea la tabla con los tipos de datos adecuados para covid_Vaccinations

DROP TABLE IF EXISTS covid_vaccinations;

CREATE TABLE covid_vaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_tests BIGINT,
    new_tests BIGINT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed FLOAT,
    new_tests_smoothed_per_thousand FLOAT,
    positive_rate FLOAT,
    tests_per_case FLOAT,
    tests_units VARCHAR(50),
    total_vaccinations BIGINT,
    people_vaccinated BIGINT,
    people_fully_vaccinated BIGINT,
    total_boosters BIGINT,
    new_vaccinations BIGINT,
    new_vaccinations_smoothed BIGINT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    total_boosters_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,
    new_people_vaccinated_smoothed BIGINT,
    new_people_vaccinated_smoothed_per_hundred FLOAT,
    stringency_index FLOAT,
    population_density FLOAT,
    median_age FLOAT,
    aged_65_older FLOAT,
    aged_70_older FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    cardiovasc_death_rate FLOAT,
    diabetes_prevalence FLOAT,
    female_smokers FLOAT,
    male_smokers FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT,
    excess_mortality_cumulative_absolute FLOAT,
    excess_mortality_cumulative FLOAT,
    excess_mortality FLOAT,
    excess_mortality_cumulative_per_million FLOAT
);

--Usa el comando COPY para importar los datos desde el archivo CSV.
	
COPY covid_vaccinations FROM 'C:\Users\LENOVO\Desktop\Projects\Covid-19\CovidVaccinations.csv' --ruta de donde se extraerá los datos a importar
DELIMITER ';'
HEADER CSV;

--Verifica los datos después de la importación.
SELECT
	*
FROM covid_vaccinations;

----PORTFOLIO PROJECT - SQL DATA EXPLORATION
-- CREATE TABLE 'CovidVaccinations'
-- CREATE TABLE 'CovidDeaths'

-- Observando la data completa
-- Looking whole data

SELECT
	*
FROM covid_deaths
WHERE continent IS NOT NULL
order by 3,4;
--

-- Seleccionamos la data a usar
-- Selecting data to use
SELECT
	location, date, population, total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2,3;

--Observamos 'total_cases' vs 'total_deaths'
--Obtenemos el porcentaje de muertes respecto a la totalidad de contagios
SELECT
	location, date, total_cases, total_deaths,
	ROUND((total_deaths::NUMERIC/NULLIF(total_cases,0)),2)*100 AS death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
AND total_cases IS NOT NULL
AND total_cases <> 0
ORDER BY 1,2;

-- Obtenemos el porcentaje de muerte mas alto por país 
--Análisis sobre 10 países durante '2020-04-01' / '2021-06-30'
SELECT
	location,
	MAX(death_percentage) AS max_death_percentage_per_country
FROM( SELECT
		location, date, total_cases, total_deaths,
		ROUND((total_deaths::NUMERIC/(total_cases)),2)*100 AS death_percentage
	FROM covid_deaths
	WHERE continent IS NOT NULL
	AND total_cases IS NOT NULL
	AND total_cases <> 0
	AND date BETWEEN '2020-04-01' AND '2021-06-30'
	AND location IN('China','United States',
	'India','Brazil','United Kingdom','Italy','Mexico',
	'Germany','New Zealand','Peru')
) AS Percentage_deaths_countries
GROUP BY location
ORDER BY location;
/* 
Porcentaje más alto:
- "United Kingdom" - 23%
Porcentaje más bajo:
-"New Zealand"- 2%
Porcentaje de muerte en Perú
-"Peru" - 14%
*/

-- Paises con la infeccion más alta respecto a su población 
-- Countries with highest infection per population
SELECT
	location,
	MAX(percentPopulationInfected) AS country_infected
	FROM( SELECT
		location, date, total_cases, population, 
		ROUND((total_cases::NUMERIC/population),2) *100 AS percentPopulationInfected
	FROM covid_deaths
	WHERE continent IS NOT NULL
	AND total_cases IS NOT NULL
	AND total_cases > 0
	AND date BETWEEN '2020-04-01' AND '2021-06-30'
	AND location IN('China','United States',
	'India','Brazil','United Kingdom','Italy','Mexico',
	'Germany','New Zealand','Peru')
	) AS countries_infected
GROUP BY location
ORDER BY country_infected DESC;
/* Tasa de contagio respecto a su población

País con mayor tasa de contagio:
- Estados unidos: 10%
País con menor tasa de contagio:
-Nueva Zelanda: 0%
Perú: 6%
*/

--Mostrando los países con la cantidad de muertes más alta por poblacion 
--Showing countries with highest death count per population

SELECT
	location,
	MAX(total_deaths) As MAX_Deaths_Count
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
HAVING MAX(total_deaths) IS NOT NULL
ORDER BY MAX_Deaths_Count DESC;
/* Países con la mayor cantidad de muertes por contagio
TOP 7
1.- Estados Unidos: 1'193'165
2.- Brasil: 702'116
3.- India: 533'623
4.- Rusia: 403'188
5.- Mexico: 334'551
6.- Reino Unido: 232'112
7.- Peru: 220'975
*/

--Observamos los datos por continentes
--Showing the dates per continents

--Mostrando los continentes con la cantidad de muerte mas alta por poblacion
--showing continents with highest deaths count per population

SELECT
	continent,
	MAX(total_deaths) AS Max_deaths_per_continent
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Max_deaths_per_continent DESC;
-- TOP 3: Norte América , Sur América, Asia

--numeros globales
--Global numbers

SELECT
	SUM(new_cases) AS total_new_cases,
	SUM(new_deaths) AS total_new_deaths,
	(SUM(new_deaths::NUMERIC)/SUM(new_cases::NUMERIC))*100 AS deathsNewPercentage
FROM covid_deaths
WHERE continent IS NOT NULL
AND new_cases IS NOT NULL
AND new_deaths IS NOT NULL;
--Hasta junio de 2024
-- El total de casos nuevos en el mundo 775'888'147
-- total de nuevas muertes 6'990'824
-- porcentaje de muertes nuevas 0,9 %

--Uniendo las dos tablas : 'CovidDeaths' y 'CovidVaccinations'
--Join two tables: 'CovidDeaths' and 'CovidVaccinations'

-- Observamos la poblacion total vs la vacunación
--Looking at total population vs vaccinations

SELECT
	d.continent, d.location, d.date, d.population, 
	v.new_vaccinations,
	SUM(v.new_vaccinations) OVER (PARTITION BY d.location 
	ORDER BY d.location,d.date) AS new_vaccination_per_location_acumulate,
	(SUM(v.new_vaccinations) OVER (PARTITION BY d.location
	 ORDER BY d.location, d.date) / d.population) *100 AS vaccinations_percentage_habitants
FROM 
covid_deaths d
	INNER JOIN
covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
AND v.new_vaccinations IS NOT NULL
	AND d.location IN('China','United States',
	'India','Brazil','United Kingdom','Italy','Mexico',
	'Germany','New Zealand','Peru')
ORDER BY 1,2;

--Creamos una tabla temporal con 'WITH'
--Create a temporal table to 'WITH'

WITH PopVsVac AS (
    SELECT
        d.continent,
        d.location,
        d.date,
        d.population,
        v.new_vaccinations,
        SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.date) AS new_vaccination_per_location_acumulate,
        (SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.date) / d.population) * 100 AS vaccinations_percentage_habitants
    FROM 
        covid_deaths d
    INNER JOIN
        covid_vaccinations v
    ON 
        d.location = v.location
        AND d.date = v.date  
    WHERE 
        d.continent IS NOT NULL
		AND new_vaccinations <>0
    ORDER BY 
        d.location, d.date
)

--Verificar que los datos se hayan unido correctamente
SELECT
	*
FROM PopVsVac;

-- GUARDANDO LA DATA ANALIZADA: 'PercentagePopulationVaccinated'
COPY(
WITH PopVsVac AS (
        SELECT
            d.continent,
            d.location,
            d.date,
            d.population,
            v.new_vaccinations,
            SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.date) AS new_vaccination_per_location_acumulate,
            (SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.date) / d.population) * 100 AS vaccinations_percentage_habitants
        FROM 
            covid_deaths d
        INNER JOIN
            covid_vaccinations v
        ON 
            d.location = v.location
            AND d.date = v.date  
        WHERE 
            d.continent IS NOT NULL
            AND new_vaccinations <> 0
        ORDER BY 
            d.location, d.date
    )
    SELECT *
    FROM PopVsVac
)
TO 'C:\Users\LENOVO\Desktop\Projects\Covid-19\PercentagePopulationVaccinated.csv' --ruta donde se guardará el archivo junto a su extensión
WITH (FORMAT CSV, HEADER);

----CREAMOS UNA NUEVA TABLA SOLO CON LA DATA ANALIZADA

--ELIMINAMOS LA TABLA SI EXISTE
DROP TABLE IF EXISTS PercentagePopulationVaccinated;
--CREAMOS LA NUEVA TABLA
CREATE TABLE PercentagePopulationVaccinated(

continent VARCHAR(50),
location VARCHAR(100),
date DATE,
population BIGINT,
new_vaccinations BIGINT,
new_vaccinations_per_location_acumulate NUMERIC,
vaccinations_percentage_habitants NUMERIC
);

--COPIAMOS LOS DATOS ANALIZADOS A LA NUEVA TABLA 'PercentagePopulationVaccinated'
COPY PercentagePopulationVaccinated 
FROM 'C:\Users\LENOVO\Desktop\Projects\Covid-19\PercentagePopulationVaccinated.csv'
DELIMITER ','
CSV HEADER;

--OBSERVANDO LA NUEVA TABLA 
SELECT
	location, date,
	vaccinations_percentage_habitants	
FROM PercentagePopulationVaccinated
WHERE vaccinations_percentage_habitants > 100
AND vaccinations_percentage_habitants < 101
ORDER BY date;

/*Vacunación 100% por país y fecha

UNK:10 junio 2021
USA: 29 Junio 2021
GERMANY: 10 Julio 2021
ITALIA: 13 Julio 2021
CHINA: 22 Julio 2021
BRASIL: 14 Sep 2021
NUEVA ZELANDA: 30 Sep 2021
PERU: 23 Octubre 2021
INDIA: 6 Enero 2022
MEXICO: 21 Enero 2022

*/

--Limpiamos la tabla analizada
DROP TABLE IF EXISTS PercentagePopulationVaccinated;

--Links de data procesada: 👉PercentagePopulationVaccinated: https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/PercentagePopulationVaccinated.zip

--Link de dashboard en Tableau: 👉VISUALIZACIÓN DE DATOS: https://public.tableau.com/app/profile/wilmer.lozano/viz/Global-Covid-19-Vaccination-Mortality-Analysis2020-2024/Dashboard1?publish=yes

--that's it
-- "ANÁLISIS DE MORTALIDAD Y VACUNACIÓN GLOBAL POR COVID-19(2020-2024)"

-- Crear las tablas en python y luego pasarlas a SQL para realizar el análisis
'''
### Importar las librerías necesarias
import pandas as pd 
from sqlalchemy import create_engine 

### Cargar los datos de la tabla "covid_deaths":
covid_deaths = pd.read_csv('CovidDeaths.csv', sep=';', parse_dates=['date'], dayfirst=True)

### Cargar los datos de la tabla "covid_vaccinations"
covid_vaccinations = pd.read_csv('CovidVaccinations.csv', sep=';', parse_dates=['date'])

###Convertir los datos a tablas en SQL usando la librería "sqlalchemy"

# Parámetros de conexión (reemplázalos por tus datos de conexión)
usuario = 'postgres'
contraseña = 'Coloca tu contraseña'
base_de_datos = 'Coloca el nombre de tu base de datos donde cargarás tus archivos'
host = 'localhost' #Servidor de PostgreSQL
puerto = '5432' # Puerto por defecto de PostgreSQL

# Crear el engine de SQLAlchemy para la conexión con postgreSQL
engine = create_engine(f'postgresql://{usuario}:{contraseña}@{host}:{puerto}/base_de_datos')

#Cargar los datos en la base de datos
covid_deaths.to_sql('covid_deaths', conn=engine, if_exists='replace', index = False)
covid_vaccinations.to_sql('covid_vaccinations', con=engine, if_exists='replace',index=False)
'''


-- VERIFICACIÓN DE LOS DATOS CARGADOS EN 'covid_deaths'
-- Hacemos una consulta para ver los primeros registros de la tabla y verificar que la importación fue exitosa.
SELECT * FROM covid_deaths;

-- VERIFICACIÓN DE LOS DATOS CARGADOS EN 'covid_vaccinations'
SELECT * FROM covid_vaccinations;

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

-- Verificar si hay registros con datos faltantes o nulos en las columnas clave
SELECT * FROM covid_deaths WHERE total_cases IS NULL OR total_deaths IS NULL;

-- Reemplazar los valores nulos con 0
UPDATE covid_deaths
SET total_cases = COALESCE(total_cases, 0),
    total_deaths = COALESCE(total_deaths, 0);

-- SELECCIONAMOS LOS DATOS DE INTERÉS
-- Extraemos una muestra representativa de los datos de casos, muertes y población de 'covid_deaths'.
SELECT
	location, date, population, total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2,3;

-- CALCULAMOS EL PORCENTAJE DE MUERTES RESPECTO A LOS CASOS
-- Comparamos las muertes totales con los casos totales, calculando el porcentaje de muertes por cada país.
SELECT
	location, date, total_cases, total_deaths,
	ROUND((total_deaths::NUMERIC/NULLIF(total_cases,0)),2)*100 AS death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
AND total_cases IS NOT NULL
AND total_cases <> 0
ORDER BY 1,2;

-- SELECCIONAMOS LOS PAÍSES CON EL PORCENTAJE DE MUERTES MÁS ALTO
-- Analizamos el porcentaje máximo de muertes por país en el periodo entre 2020-04-01 y 2021-06-30.
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

-- ANALIZAMOS LOS PAÍSES CON LA INFECCIÓN MÁS ALTA POR POBLACIÓN
-- Analizamos qué países tienen la mayor tasa de infección más alta
SELECT
	location,
	MAX(percentPopulationInfected) AS country_infected
	FROM( SELECT
		location, date, total_cases, population, 
		ROUND((total_cases::NUMERIC / population),2) *100 AS percentPopulationInfected
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
	ROUND((SUM(new_deaths::NUMERIC)/SUM(new_cases::NUMERIC)*100),2) AS deathsNewPercentage
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
FROM 'C:\Users\LENOVO\Desktop\Projects\Covid-19\PercentagePopulationVaccinated.csv' --ruta donde se encuentra el archivo
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

'''
GLOSARIO: 'covid_deaths'

iso_code: Código ISO del país
continent: Continente
location: Nombre del país o región
date: Fecha de la medición
population: Población del país
total_cases: Total de casos de COVID-19
new_cases: Nuevos casos reportados
new_cases_smoothed: Nuevos casos suavizados
total_deaths: Total de muertes por COVID-19
new_deaths: Nuevas muertes reportadas
new_deaths_smoothed: Nuevas muertes suavizadas
total_cases_per_million: Total de casos por millón de habitantes
new_cases_per_million: Nuevos casos por millón de habitantes
new_cases_smoothed_per_million: Nuevos casos suavizados por millón
total_deaths_per_million: Total de muertes por millón de habitantes
new_deaths_per_million: Nuevas muertes por millón de habitantes
new_deaths_smoothed_per_million: Nuevas muertes suavizadas por millón
reproduction_rate: Tasa de reproducción del virus
icu_patients: Número de pacientes en cuidados intensivos
icu_patients_per_million: Pacientes en cuidados intensivos por millón
hosp_patients: Número de pacientes hospitalizados
hosp_patients_per_million:Pacientes hospitalizados por millón
weekly_icu_admissions: Ingresos semanales en unidades de cuidados intensivos
weekly_icu_admissions_per_million: Ingresos semanales por millón en unidades de cuidados intensivos
weekly_hosp_admissions: Ingresos semanales hospitalarios
weekly_hosp_admissions_per_million: Ingresos semanales hospitalarios por millón


GLOSARIO: 'covid_vaccinations'

total_tests: Total de pruebas realizadas.
new_tests: Nuevas pruebas realizadas.
total_tests_per_thousand: Total de pruebas por mil habitantes.
new_tests_per_thousand: Nuevas pruebas por mil habitantes.
new_tests_smoothed: Nuevas pruebas suavizadas.
new_tests_smoothed_per_thousand: Nuevas pruebas suavizadas por mil habitantes.
positive_rate: Tasa de resultados positivos.
tests_per_case: Número de pruebas por caso.
tests_units: Unidades de prueba.
total_vaccinations: Total de vacunas administradas.
people_vaccinated: Personas vacunadas al menos una vez.
people_fully_vaccinated: Personas completamente vacunadas.
total_boosters: Total de dosis de refuerzo administradas.
new_vaccinations: Nuevas vacunas administradas.
new_vaccinations_smoothed: Nuevas vacunas suavizadas.
total_vaccinations_per_hundred: Total de vacunas por cada 100 habitantes.
people_vaccinated_per_hundred: Personas vacunadas por cada 100 habitantes.
people_fully_vaccinated_per_hundred: Personas completamente vacunadas por cada 100 habitantes.
total_boosters_per_hundred: Dosis de refuerzo por cada 100 habitantes.
new_vaccinations_smoothed_per_million: Nuevas vacunas suavizadas por millón de habitantes.
new_people_vaccinated_smoothed: Nuevas personas vacunadas suavizadas.
new_people_vaccinated_smoothed_per_hundred: Nuevas personas vacunadas por cada 100 habitantes.
stringency_index: Índice de severidad de las medidas de control.
population_density: Densidad poblacional.
median_age: Edad media de la población.
aged_65_older: Porcentaje de personas mayores de 65 años.
aged_70_older: Porcentaje de personas mayores de 70 años.
gdp_per_capita: Producto interno bruto per cápita.
extreme_poverty: Porcentaje de población en extrema pobreza.
cardiovasc_death_rate: Tasa de muertes por enfermedades cardiovasculares.
diabetes_prevalence: Prevalencia de diabetes.
female_smokers: Porcentaje de mujeres fumadoras.
male_smokers: Porcentaje de hombres fumadores.
handwashing_facilities: Porcentaje de población con acceso a instalaciones para lavarse las manos.
hospital_beds_per_thousand: Número de camas hospitalarias por mil habitantes.
life_expectancy: Esperanza de vida.
human_development_index: Índice de desarrollo humano.
excess_mortality_cumulative_absolute: Mortalidad excedente acumulada absoluta.
excess_mortality_cumulative: Mortalidad excedente acumulada.
excess_mortality: Mortalidad excedente.
excess_mortality_cumulative_per_million: Mortalidad excedente acumulada por millón de habitantes.
'''
# 🌍 ANÁLISIS DE MORTALIDAD Y VACUNACIÓN GLOBAL POR COVID-19 (2020-2024)

Este proyecto realiza un análisis exploratorio y visual de los datos globales relacionados con la mortalidad y la vacunación por COVID-19 durante el período 2020–2024. Se utilizaron herramientas de Python, PostgreSQL y Tableau para llevar a cabo un estudio exhaustivo de tendencias, tasas de vacunación y su relación con las muertes por COVID-19 en todo el mundo.

## 🧠  Objetivo del proyecto

- Analizar los datos globales de muertes y vacunación por COVID-19.
- Examinar la relación entre la tasa de vacunación y la mortalidad acumulada por país.
- Identificar tendencias y patrones por región.
- Visualizar de manera clara y accesible los hallazgos principales.

## 🗂️ Herramientas y tecnologías utilizadas

- Lenguaje de programación: Python (pandas, sqlalchemy, psycopg2)
- Base de datos: PostgreSQL
- Visualización: Tableau
- Entorno: Jupyter Notebook

## 📊 Visualización final (Dashboard Tableau)
👉 [Dashboard en Tableau](https://public.tableau.com/app/profile/wilmer.lozano/viz/Global-Covid-19-Vaccination-Mortality-Analysis2020-2024/Dashboard1)

## 📁 Estructura del proyecto

```
Global-Covid-19-Vaccination-Mortality-Analysis/
├── CovidDeaths.csv
├── CovidVaccinations.csv
├── Global_Covid_Vaccination_Mortality_Analysis.ipynb
├── PercentagePopulationVaccinated.csv
└── README.md
```
📌 Principales insights obtenidos

- A partir de un total de 263 países y territorios, solo 97 tenían datos completos sobre muertes y vacunación.
- Se observó una alta variabilidad entre países en términos de porcentaje de población vacunada y tasa de mortalidad por COVID-19.
- Algunos países, como Canadá, España y Noruega, mostraron altos niveles de vacunación y bajas tasas de mortalidad acumulada.
- Otros países con bajas tasas de vacunación, como varias naciones africanas, registraron niveles variables de mortalidad, lo que sugiere factores adicionales como subregistro o diferencias demográficas.
- En el Top 10 países con mayor porcentaje de población vacunada, la tasa de mortalidad promedio fue del 0.17%.
- En el Bottom 10 países con menor porcentaje de población vacunada, la tasa de mortalidad promedio fue del 0.32%.

## 📎 Fuentes de datos

[Our World in Data – COVID-19 dataset](https://ourworldindata.org/coronavirus)

## 🛠️ Instrucciones para ejecutar y replicar el proyecto
Para ejecutar este proyecto de análisis de mortalidad y vacunación global por COVID-19 (2020–2024), sigue estos pasos:

1.- Clonar el repositorio
```
git clone https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis.git
cd Global-Covid-19-Vaccination-Mortality-Analysis
```
2.- Instalar las dependencias necesarias
Asegúrate de tener Python 3.8 o superior y PostgreSQL instalado. Luego, instala las siguientes librerías:
```
pip install pandas sqlalchemy psycopg2
```
3.- Configurar la conexión a la base de datos PostgreSQL
Edita el bloque de conexión en el archivo .ipynb o en tu script de Python:
```
usuario = 'postgres'
contraseña = 'TU_CONTRASEÑA'
base_de_datos = 'NOMBRE_DE_TU_BD'
host = 'localhost'
puerto = '5432'
```
4.- Importar los archivos CSV
Asegúrate de tener los archivos:

- **CovidDeaths.csv**
- **CovidVaccinations.csv**

5.- Cargar los datos a PostgreSQL
El script cargará automáticamente los archivos CSV en la base de datos, creando las tablas **covid_deaths** y **covid_vaccinations**.

6.- Ejecutar las consultas SQL
Utiliza pgAdmin, DBeaver o cualquier cliente de SQL compatible para ejecutar el análisis incluido en el archivo .sql o directamente desde Jupyter Notebook si estás usando sqlalchemy.

7.- Exportar los resultados
El script genera un archivo PercentagePopulationVaccinated.csv con los resultados del análisis y crea una nueva tabla SQL con los datos acumulados por país.

8.- Visualizar el dashboard
Accede a la visualización interactiva en Tableau:
👉 [Dashboard en Tableau](https://public.tableau.com/app/profile/wilmer.lozano/viz/Global-Covid-19-Vaccination-Mortality-Analysis2020-2024/Dashboard1)

### Autor

Wilmer Gastón Lozano Huamán

Correo: wglozanoh@gmail.com

### Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar este proyecto, abre un pull request o contacta al autor.

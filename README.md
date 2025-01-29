# Análisis Global de Mortalidad y Vacunación por COVID-19 (2020-2024)

Este proyecto realiza un análisis detallado de los datos de mortalidad y vacunación a nivel global, proporcionando una visión clara sobre cómo la pandemia de COVID-19 ha afectado a diferentes países y continentes entre 2020 y 2024. Los datos utilizados provienen de dos fuentes clave: muertes por COVID-19 y estadísticas de vacunación.

## Enlaces a los Datos
* [Datos de Muertes por COVID-19](https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/CovidDeaths.zip)
* [Datos de Vacunación por COVID-19](https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/PercentagePopulationVaccinated.zip)

## Visualización de los Resultados
El dashboard de Tableau con los resultados visuales de este análisis está disponible en el siguiente enlace:

* [Visualización de Datos en Tableau](https://public.tableau.com/app/profile/wilmer.lozano/viz/Global-Covid-19-Vaccination-Mortality-Analysis2020-2024/Dashboard1)

## Descripción del Proyecto

Este análisis investiga la relación entre las muertes por COVID-19 y la tasa de vacunación en diferentes países y regiones. A través de consultas SQL, el análisis incluye:

- **Cálculo del porcentaje de muertes por cada país**: Determinamos el porcentaje de muertes con respecto al total de casos de COVID-19 en cada país.
- **Análisis por país y por continente**: Comparamos tasas de mortalidad y casos por millón de habitantes entre países y continentes.
- **Tasa de vacunación**: Calculamos la tasa de vacunación acumulada y el porcentaje de la población vacunada.
- **Exportación de datos procesados**: Los resultados del análisis se exportan en formato CSV para su posterior análisis y visualización.


## Resultados

### 1. **Países con el porcentaje de muertes más alto (2020-2021)**:
Durante el periodo entre abril de 2020 y junio de 2021, los países con el porcentaje más alto de muertes en relación con los casos confirmados fueron:

| País                | Porcentaje de muertes |
|---------------------|-----------------------|
| United Kingdom       | 23.00%                |
| Mexico              | 17.00%                |
| Italy               | 15.00%                |
| Peru                | 14.00%                |
| Brazil              | 7.00%                 |
| China               | 6.00%                 |
| United States       | 6.00%                 |
| Germany             | 5.00%                 |
| India               | 3.00%                 |
| New Zealand         | 2.00%                 |

### 2. **Países con la mayor tasa de infección por población**:
La tasa de infección más alta por población durante el periodo mencionado es la siguiente:

| País                | Tasa de infección (%) |
|---------------------|-----------------------|
| United States       | 10.00%                |
| Brazil              | 9.00%                 |
| United Kingdom      | 7.00%                 |
| Italy               | 7.00%                 |
| Peru                | 6.00%                 |
| Germany             | 4.00%                 |
| Mexico              | 2.00%                 |
| India               | 2.00%                 |
| China               | 0.00%                 |

### 3. **Países con la cantidad de muertes más alta por población**:
Los países con la mayor cantidad de muertes por población son:

| País                | Muertes Totales |
|---------------------|-----------------|
| United States       | 1,193,165       |
| Brazil              | 702,116         |
| India               | 533,623         |
| Russia              | 403,188         |
| Mexico              | 334,551         |
| United Kingdom      | 232,112         |
| Peru                | 220,975         |
| Italy               | 197,307         |
| Germany             | 174,979         |
| France              | 168,091         |

### 4. **Mortalidad por continente**:
La mortalidad más alta por continente se distribuye de la siguiente forma:

| Continente          | Muertes Totales |
|---------------------|-----------------|
| North America       | 1,193,165       |
| South America       | 702,116         |
| Asia                | 533,623         |
| Europe              | 403,188         |
| Africa              | 102,595         |
| Oceania             | 25,236          |

### 5. **Números Globales**:
Hasta junio de 2024, a nivel global:

- **Total de nuevos casos**: 775,888,147
- **Total de nuevas muertes**: 6,990,824
- **Porcentaje de nuevas muertes**: 0.90%

## Tecnologías Utilizadas

- **PostgreSQL**: (versión 8.10) Para el análisis de los datos, con el uso de consultas SQL avanzadas para combinar tablas y calcular métricas.
- **CSV**: Formato de archivo utilizado para importar y exportar los datos.
- **Tableau**: Herramienta utilizada para crear visualizaciones interactivas a partir de los datos procesados.

## Estructura de las Tablas

### covid_deaths
Contiene los datos sobre las muertes por COVID-19:

- `iso_code`: Código ISO del país.
- `continent`: Continente al que pertenece el país.
- `location`: Nombre del país o región.
- `date`: Fecha del registro.
- `total_cases`: Total de casos confirmados.
- `new_cases`: Nuevos casos confirmados.
- `total_deaths`: Total de muertes.
- Y otras métricas relacionadas con los casos y muertes por COVID-19.

### covid_vaccinations
Contiene los datos sobre las vacunaciones contra el COVID-19:

- `iso_code`: Código ISO del país.
- `continent`: Continente al que pertenece el país.
- `location`: Nombre del país o región.
- `date`: Fecha del registro.
- `total_vaccinations`: Total de vacunas administradas.
- `people_vaccinated`: Personas vacunadas al menos una vez.
- `people_fully_vaccinated`: Personas completamente vacunadas.
- Y otras métricas relacionadas con la vacunación y las pruebas.

## Dashboard Tableau

### 1. **Visión General**
* **Números globales**: En 2020, el mundo reportó un total de 30.4 millones de casos y 983 millones de muertes, con una tasa de mortalidad global de 3.2%. Para 2024, los casos alcanzaron los 712.8 millones, con 6.39 millones de muertes y una tasa de mortalidad de 0.9%.

### 2. **Distribución Acumulada de Vacunas**:
* La visualización muestra a los países con la mayor cantidad de vacunas administradas, como China, India, y Estados Unidos, permitiendo comparar el progreso en la vacunación.

### 3. **Mapa Interactivo**:
El mapa interactivo muestra las tasas de mortalidad por país, destacando Brasil, Perú y Estados Unidos como los países con las tasas más altas.

### 4. **Interactividad**:
Los filtros permiten cambiar entre los diferentes años de análisis (2020-2024) para observar cómo ha evolucionado la pandemia a lo largo del tiempo.

## Instrucciones para Ejecutar el Proyecto

1. Clona este repositorio:
   git clone https://github.com/tu_usuario/Analisis-Covid-19.git
2. Instalar PostgreSQL: Asegúrate de tener PostgreSQL instalado y configurado correctamente.
3. Crear la base de datos: Crea una base de datos y asegúrate de tener los permisos necesarios para importar los archivos CSV.
4. Ejecutar los scripts SQL: Ejecuta los scripts SQL para cargar y analizar los datos en tu base de datos PostgreSQL.
5. Cargar los archivos CSV: Utiliza el comando COPY para importar los archivos CSV de datos de muertes y vacunación en las tablas correspondientes.
   
### Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar este proyecto, abre un pull request o contacta al autor.

### Autor

Wilmer Gastón Lozano Huamán

Correo: wglozanoh@gmail.com

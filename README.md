# Análisis Global de Mortalidad y Vacunación por COVID-19 (2020-2024)

Este proyecto realiza un análisis detallado de los datos de mortalidad y vacunación a nivel global, proporcionando una visión clara sobre cómo la pandemia de COVID-19 ha afectado a diferentes países y continentes entre 2020 y 2024. Los datos utilizados provienen de dos fuentes clave: muertes por COVID-19 y estadísticas de vacunación.

## Enlaces a los Datos
* [Datos de Muertes por COVID-19](https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/CovidDeaths.zip)
* [Datos de Vacunación por COVID-19](https://github.com/WLozanoH/Global-Covid-19-Vaccination-Mortality-Analysis/blob/main/PercentagePopulationVaccinated.zip)

## Visualización de los Resultados
El dashboard de Tableau con los resultados visuales de este análisis está disponible en el siguiente enlace:

* [Visualización de Datos en Tableau](https://public.tableau.com/app/profile/wilmer.lozano/viz/Global-Covid-19-Vaccination-Mortality-Analysis2020-2024/Dashboard1)

## Descripción del Proyecto

El proyecto analiza la relación entre las muertes por COVID-19 y la tasa de vacunación en diferentes países y regiones. A través de consultas SQL, el análisis incluye:

- **Cálculo del porcentaje de muertes por cada país**: Se calcula el porcentaje de muertes con respecto al total de casos.
- **Análisis por país y por continente**: Comparación de tasas de mortalidad y casos por millón de habitantes.
- **Tasa de vacunación**: Cálculo de la tasa de vacunación acumulada y el porcentaje de la población vacunada.
- **Exportación de datos procesados**: Los resultados del análisis se exportan en formato CSV para su posterior análisis o visualización.

## Resultados

Los resultados del análisis incluyen:

- Comparación de la mortalidad por COVID-19 entre países.
- Identificación de los países con mayores tasas de vacunación.
- Análisis de la correlación entre la tasa de mortalidad y la tasa de vacunación.
- Exportación de los resultados procesados a un archivo CSV.

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
### 1. Visión general
* Los números globales para 2020
Número de Casos y Muertes: Con un total de 30,438 millones de casos, 983 millones de muertes y una tasa de mortalidad de 3,2%.
Número de Casos y Muertes: Con un total de 712,804 millones de casos, 6386 millones de muertes y una tasa de mortalidad de 0.9%.

### 2. Distribución Acumulada de Vacunas:
* La visualización de la distribución acumulada de dosis de vacunas muestra claramente los países que lideran en vacunación (China, India, y Estados Unidos). Este gráfico es útil para comparar la cantidad de vacunas administradas en los países más afectados.

### 3. Mapa Interactivo:
El mapa muestra las tasas de mortalidad por país, destacando las tasas más altas en Brasil, Perú y Estados Unidos. Esto hace fácil visualizar cómo varían las tasas de mortalidad entre las diferentes regiones del mundo.

### 4. Interactividad:
El filtro para cambiar entre años (2020) permite interactuar con la visualización y ajustar el análisis según diferentes periodos. Esto es útil para observar cómo cambian los datos a lo largo del tiempo.

## Instrucciones para Ejecutar el Proyecto

1. Clona este repositorio:
   git clone https://github.com/tu_usuario/Analisis-Covid-19.git
2. Asegúrate de tener PostgreSQL instalado y crear una base de datos para importar los datos.
3. Ejecuta los scripts SQL para cargar y analizar los datos.
   
### Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar este proyecto, abre un pull request o contacta al autor.

### Autor

Wilmer Gastón Lozano Huamán

Correo: wglozanoh@gmail.com

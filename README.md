# 🧹 Análisis de Despidos en Empresas Tech

Este proyecto explora un dataset de despidos en el sector tecnológico. Se realizaron tareas de limpieza de datos y análisis exploratorio utilizando SQL. Finalmente se completo el proyecto realizando un dashboard en Tableau.

## 📊 Dataset

Fuente: layoffs.csv

Contiene información sobre despidos en distintas empresas de tecnología, incluyendo columnas como:

- `company`
- `location`
- `industry`
- `total_laid_off`
- `percentage_laid_off`
- `date`
- `stage`
- `country`
- `funds_raised_millions`

## 🧼 Limpieza de datos (`A-DATA-CLEANING.sql`)

- Eliminación de duplicados con `ROW_NUMBER()`
- Estandarización de nombres de empresa, industrias y países
- Conversión de la columna `date` de texto a formato `DATE`
- Imputación de valores faltantes en la columna `industry`
- Eliminación de filas sin datos útiles (`total_laid_off` y `percentage_laid_off` nulos)

> Tabla final: `layoffs_staging2`

## 🔍 Análisis exploratorio (`B-EXPLORATORY-DATA-ANALYSIS.sql`)

Consultas principales:

- Despidos por año
- Industrias con más quiebras (100% de despidos)
- Despidos por país
- Empresas con más despidos por año
- Ranking de industrias por cantidad de despidos
- Evolución acumulada de despidos mensuales

## 🛠 Herramientas

- SQL (MySQL)

## 📈 Visualización en Tableau

El análisis fue complementado con un dashboard interactivo publicado en Tableau Public:

🔗 [Ver dashboard completo](https://public.tableau.com/views/laidoffs_visualizations/Dashboard1)

![image](https://github.com/user-attachments/assets/ba472a0d-bb58-4d2e-81a1-188345e1d2f3)


Se visualizaron los despidos desde el inicio de la pandemia (2020 T2) hasta la crisis tecnológica de 2022.

### 🎯 Principales insights del dashboard

- **Retail y Consumer** fueron las industrias con mayor cantidad de despidos, incluso con ingresos elevados.
- **Transport**, a pesar de ser la industria con mayores ingresos, también tuvo despidos considerables.
- **El cuarto trimestre de 2022 (2022 T4)** marcó el pico más alto de despidos, posiblemente vinculado con la crisis post-burbuja del sector tech.
- **Amazon lidera en cantidad de despidos dentro de Retail**, seguido por empresas como Google y Meta en Consumer.
- El **boxplot** evidencia que algunas empresas ejecutaron despidos masivos fuera de la mediana del sector (outliers).
- En varias industrias, los despidos no se correlacionan directamente con bajos ingresos → posibles causas: reestructuraciones, sobrecontratación, cambios estratégicos.

---

Este proyecto no solo representa un ejercicio técnico de limpieza y análisis de datos, sino también una herramienta útil para comprender cómo las empresas reaccionaron ante contextos críticos como la pandemia y la crisis tecnológica de 2022.

Se identificaron patrones claros de despidos por industria, país y empresa. Estos hallazgos permiten no solo describir el pasado, sino también informar decisiones estratégicas:

- **Recursos Humanos** puede anticipar sectores de riesgo en futuras crisis.

- **Inversores** pueden evaluar el nivel de exposición según industria y etapa de crecimiento.

- **Startups y empresas consolidadas** pueden planificar con más cautela su crecimiento y estructura de costos.


## 🔚 Conclusión

Este proyecto muestra el proceso completo de análisis de datos:
1. Limpieza de datos y análisis exploratorio en SQL 
2. Visualización en Tableau
3. Generación de insights con valor de negocio


## ✍️ Autor

**Bautista Grau** – Estudiante de Ingeniería en Sistemas  


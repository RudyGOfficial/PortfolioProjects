/*GET STARTED: REVIEW DATASETS*/

--View the entire covid deaths table ordered by columns 3 and 4--
SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4

--View the entire covid vaccinations table ordered by columns 3 and 4--
SELECT *
FROM PortfolioProject..CovidVaccinations
ORDER BY 3,4

--View columns that will be selected for valuable analysis--
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

/*COVID DEATHS TABLE: DEATHS AND CASES IN THE UNITED STATES*/

--Calculates death percentages from Covid based on deaths per cases in a chosen location (ex: USA)--
SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS float) / CAST(total_cases AS Float))*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1,2

--Calculates case percentages for Covid based on cases per population in a chosen location (ex: USA)--
SELECT location, date, total_cases, population, (CAST(total_cases AS float) / CAST(population AS Float))*100 AS case_percentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1,2

/*COVID DEATHS TABLE: RATES BY COUNTRY AND CONTINENT*/

--Identifies the Countries with the Highest Infection Rate--
--Calculates percentage of population infected based on highest infection count per population count in each country--
--Results are then ordered in descending order--
SELECT location, population, MAX(total_cases) AS highest_infection_count,
	MAX((CAST(total_cases AS float) / CAST(population AS Float)))*100 AS percent_population_infected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected DESC

--Showing Countries (using location column) with Highest Death Count per Population--
--Note: The continent column is not null when the location value is a country--
SELECT location, MAX(total_deaths) as total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC

--Showing Continents (using location column) with Highest Death Count per Population--
--Note: The continent column is null when the location value is a continent--
SELECT location, MAX(total_deaths) as total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_death_count DESC

--Showing Continents (using continent column) with Highest Death Count per Population--
--Note: This query's aggregates data has different results than the above query due to using the continent column--
SELECT continent, MAX(total_deaths) as total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC

/*COVID DEATHS TABLE: GLOBAL ANALYSIS*/

--Calculates the global cases, deaths, and percentage for all dates in the table--
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(CAST(new_deaths AS float))/SUM(CAST(new_cases AS float))*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

--Calculates the global cases, deaths, and percentage for each date in the table--
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(CAST(new_deaths AS float))/SUM(CAST(new_cases AS float))*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2

/*COVID VACCINATIONS TABLE: ROLLING VACCINATION COUNTS & PERCENTAGES*/

--Continuously Adds new vaccinations with a location & date partition to get a rolling vaccination count--
--Note: dea.location casted to reduce varchar size and resolve LOB type error for ORDER BY clause--
SELECT dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER 
		(PARTITION BY dea.location ORDER BY CAST(dea.location AS varchar(50)), dea.date) AS rolling_vaccination_count
FROM PortfolioProject..CovidDeaths as dea
JOIN PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

/*COVID VACCINATIONS TABLE: CTE, TEMP TABLE, TABLE VIEW*/

--Convert the rolling vaccination count table to a Common Table Expression(CTE)--
--This will then calculate for a rolling percentage vaccinated update column--
WITH PopVsVac (continent, location, date, population, new_vaccinations, rolling_vaccination_count)
AS
(SELECT dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER 
		(PARTITION BY dea.location ORDER BY CAST(dea.location AS varchar(50)), dea.date) AS rolling_vaccination_count
FROM PortfolioProject..CovidDeaths as dea
JOIN PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3
)
SELECT *, (CAST(rolling_vaccination_count AS float)/CAST(population AS float))*100 AS rolling_percentage_vaccinated
FROM PopVsVac

--Convert the rolling vaccination count table to a Temp Table--
--This will then calculate for a rolling percentage vaccinated update column--
DROP TABLE IF EXISTS #percent_population_vaccinated;
CREATE TABLE #percent_population_vaccinated (
continent nvarchar(255),
location nvarchar(255),
date date,
population numeric,
new_vaccinations numeric,
rolling_vaccination_count numeric)

INSERT INTO #percent_population_vaccinated
SELECT dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER 
		(PARTITION BY dea.location ORDER BY CAST(dea.location AS varchar(50)), dea.date) AS rolling_vaccination_count
FROM PortfolioProject..CovidDeaths as dea
JOIN PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

SELECT *, (rolling_vaccination_count/population)*100 AS rolling_percentage_vaccinated
FROM #percent_population_vaccinated

--Use the rolling vaccination count table to build a View Table--
--This will then be selected to calculate for a rolling percentage vaccinated update column--
DROP VIEW IF EXISTS percent_population_vaccinated;
CREATE VIEW percent_population_vaccinated AS --Run with no statements above so error doesn't occur
SELECT dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER 
		(PARTITION BY dea.location ORDER BY CAST(dea.location AS varchar(50)), dea.date) AS rolling_vaccination_count
FROM PortfolioProject..CovidDeaths as dea
JOIN PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3

SELECT *, (CAST(rolling_vaccination_count AS float)/CAST(population AS float))*100 AS rolling_percentage_vaccinated
FROM percent_population_vaccinated

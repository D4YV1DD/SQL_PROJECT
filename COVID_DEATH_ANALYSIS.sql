USE Undergroundz;

SELECT * 
FROM CovidDeaths$;

SELECT  location,date,total_cases,new_cases,total_deaths,population
FROM CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2;

--HOW MANY DEATH IN THIER COUNTRY AND HOW MANY DEATH THEY HAVE
SELECT location,date,total_cases,new_cases,total_deaths,population, (total_deaths/total_cases) * 100 as DeathPercentage
FROM CovidDeaths$
WHERE  new_cases IS not NULL AND total_deaths IS NOT NULL 
ORDER BY  1,2;

--TOTAL CASES AND  POPULATION 

SELECT location,date,total_cases,population, (total_cases/population) * 100 as casesOfPopulation
FROM CovidDeaths$
WHERE location like '%States%'
ORDER BY  1,2;

--COUNTRY HIGHEST INFECTION RATE
SELECT location,population,MAX(total_cases) AS HIghestCountINFECTION, SUM((total_cases/population)) as PercentPopulationInfected
FROM CovidDeaths$
--WHERE location like '%States%'
GROUP BY location,population
ORDER BY  PercentPopulationInfected DESC;


--Showing country with Highest Death Count by continent

SELECT continent,MAX(CAST(total_deaths AS INT)) as HighestDEathCount 
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY HighestDEathCount  DESC;


--Showing country with Highest Death Count by location
SELECT location,MAX(CAST(total_deaths AS INT)) as HighestDEathCount 
FROM CovidDeaths$
WHERE continent IS NULL
GROUP BY location
ORDER BY HighestDEathCount  DESC;

SELECT SUM(CAST(continent AS int)) as GlobalInfectionResult 
FROM CovidDeaths$
ORDER BY GlobalInfectionResult;

SELECT MAX(total_cases) AS total_case, SUM(total_cases/continent) as DeathPercentage
FROM CovidDeaths$;

SELECT  SUM(new_cases) AS TotalCases,SUM(CAST(new_deaths AS INT)) as Totaldeaths,  SUM(CAST(new_deaths AS INT))/SUM(new_cases) * 100 as DeathPercentage
FROM CovidDeaths$
WHERE continent IS NOT NULL
--GROUP BY DATE
ORDER BY DeathPercentage DESC;

SELECT * 
FROM CovidVaccinations$ VAC
JOIN CovidDeaths$ DEA
ON DEA.location = VAC.location
and DEA.date = VAC.date;


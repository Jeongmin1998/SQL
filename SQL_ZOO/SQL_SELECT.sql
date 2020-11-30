# https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
# 'world'테이블; 나라명, 대륙, 면적, 인구, GDP
# SELECT Tutorial

--1. List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');
      
** SELECT문 안에 SELECT문 묶을 수 있다!** : 서브쿼리


--2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world
WHERE continent='Europe' 
AND gdp/population > (SELECT gdp/population FROM world WHERE name='United Kingdom');

--3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent FROM world
WHERE continent IN ('South America', 'Oceania') 
ORDER BY name;

--4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name='Canada')
AND population < (SELECT population FROM world WHERE name='Poland');

--5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
# The format should be Name, Percentage 

SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100,0), '%')
FROM world
WHERE continent='Europe'; 

**문자 붙이고 싶을 때 CONCAT!**

--6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent='Europe' AND gdp>0);

**ALL 주의!**

--7. Find the largest country (by area) in each continent, show the continent, the name and the area

SELECT x.continent, x.name, x.area
FROM world x
WHERE x.area = (
  SELECT MAX(y.area)
  FROM world y
  WHERE x.continent = y.continent);
  
**corrlated sub query**





# https://sqlzoo.net/wiki/SUM_and_COUNT
# 'world' 테이블; 나라명, 대륙, 면적, 인구, GDP

#SUM AND COUNT 

--1. Show the total population of the world.

SELECT SUM(population)
FROM world;

--2. List all the continents - just once each.

SELECT DISTINCT continent
FROM world;

--3. Give the total GDP of Africa

SELECT SUM(gdp)
FROM world
WHERE continent='Africa';

--4. How many countries have an area of at least 1000000

SELECT COUNT(name)
FROM world
WHERE area>=1000000;

--5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')

SELECT sum(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

--6. For each continent show the continent and number of countries.

SELECT continent, COUNT(name)
FROM world
GROUP BY continent;


--7. For each continent show the continent and number of countries with populations of at least 10 million.

SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

--8. List the continents that have a total population of at least 100 million.

**HAVING 절**
- WHERE 절에서는 집계함수를 사용 할 수 없다.
- HAVING 절은 집계함수를 가지고 조건비교를 할 때 사용한다.
- HAVING절은 GROUP BY절과 함께 사용이 된다.

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population)>=100000000;


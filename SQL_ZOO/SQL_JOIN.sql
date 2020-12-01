# https://sqlzoo.net/wiki/The_JOIN_operation

# 'game', 'goal', 'eteam' 테이블

** THE JOIN OPERATION **

--1. Modify it to show the matchid and player name for all goals scored by Germany. 

SELECT matchid, player FROM goal 
WHERE teamid = 'GER';

--2. Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2 FROM game
WHERE id='1012';


--3. Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM goal
LEFT JOIN game ON (id=matchid) 
WHERE teamid = 'GER';

--4. Show the team1, team2 and player for every goal scored by a player called Mario

SELECT team1, team2, player
FROM goal LEFT JOIN game ON (id=matchid) 
WHERE player LIKE 'Mario%';

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON teamid=eteam.id
WHERE gtime<=10;

--6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT game.mdate, eteam.teamname
FROM game JOIN eteam ON game.team1=eteam.id
WHERE eteam.coach='Fernando Santos';

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT goal.player
FROM goal JOIN game ON game.id=goal.matchid
WHERE game.stadium='National Stadium, Warsaw';

--8. Show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER';

--9. Show teamname and the total number of goals scored.

SELECT eteam.teamname, COUNT(goal.matchid)
FROM eteam JOIN goal ON id=teamid
GROUP BY eteam.teamname;

--10. Show the stadium and the number of goals scored in each stadium.

SELECT game.stadium, COUNT(goal.matchid)
FROM game JOIN goal ON id=matchid
GROUP BY game.stadium;

--11. For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT game.id, game.mdate, COUNT(matchid)
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY game.id, game.mdate;

--12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid,mdate,COUNT(matchid)
FROM game JOIN goal ON matchid = id 
WHERE (teamid='GER')
GROUP BY matchid,mdate;

--13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.

**CASE 사용법**
: CASE WHEN 조건절 THEN 참일때 값 ELSE 거짓일때 값 END 컬럼명

SELECT mdate, team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate,matchid,team1,team2;






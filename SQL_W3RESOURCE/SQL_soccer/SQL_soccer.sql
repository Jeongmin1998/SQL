#https://www.w3resource.com/sql-exercises/soccer-database-exercise/basic-exercises-on-soccer-database.php

--1. Write a query in SQL to find the number of venues for EURO cup 2016.


SELECT COUNT(*)
FROM soccer_venue;


--2. Write a query in SQL to find the number of countries participated in the EURO cup 2016.


SELECT COUNT(DISTINCT team_id)
FROM player_mast;


--3. Write a query in SQL to find the number goals scored in EURO cup 2016 within normal play schedule.


SELECT COUNT(*)
FROM goal_details;


--4. Write a query in SQL to find the number of matches ended with a result. 


SELECT COUNT(*) FROM match_mast
WHERE results='WIN';


--5. Write a query in SQL to find the number of matches ended with draws.


SELECT COUNT(*) FROM match_mast
WHERE results='DRAW';


--6. Write a query in SQL to find the date when did Football EURO cup 2016 begin.


SELECT MIN(play_date) "Beginning Date"
FROM match_mast


----(Sample Solution)

SELECT play_date "Beginning Date"
FROM match_mast
WHERE match_no=1;

**보기 답안에서는 맨 처음 경기 번호를 조건으로 걸어주어서 날짜를 추출했고,
  나는 경기가 열린 날 중의 가장 이른 날짜를 추출했다.**


--7. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.


SELECT COUNT(*) 
FROM goal_details 
WHERE goal_type='O';


--8. Write a query in SQL to count the number of matches ended with a results in group stage.


SELECT COUNT(*) 
FROM match_mast 
WHERE results='WIN' 
AND play_stage='G';


--9. Write a query in SQL to find the number of matches got a result by penalty shootout.


SELECT COUNT(DISTINCT match_no)
FROM penalty_shootout;


--10. Write a query in SQL to find the number of matches decided by penalties in the Round of 16.


SELECT COUNT(*) 
FROM match_mast 
WHERE decided_by='P' AND play_stage='R';


--11. Write a query in SQL to find the number of goal scored in every match within normal play schedule.


SELECT match_no, COUNT(*)
FROM goal_details
GROUP BY match_no
ORDER BY match_no;


--12. Write a query in SQL to find the match no, date of play, and goal scored for that match in which no stoppage time have been added in 1st half of play.


SELECT match_no, play_date, goal_score
FROM match_mast
WHERE stop1_sec=0;


--13. Write a query in SQL to find the number of matches ending with a goalless draw in group stage of play.


SELECT COUNT(DISTINCT match_no)
FROM match_details
WHERE goal_score=0 AND win_lose='D' AND play_stage='G';


--14. Write a query in SQL to find the number of matches ending with only one goal win except those matches which was decided by penalty shootout.


SELECT COUNT(DISTINCT match_no)
FROM match_details
WHERE goal_score=1 AND win_lose='W' AND decided_by<>'P';


--15. Write a query in SQL to find the total number of players replaced in the tournament.


SELECT COUNT(DISTINCT player_id)
FROM player_in_out
WHERE in_out='I';

----Sample Solution)
SELECT COUNT(*) as "Player Replaced"
FROM player_in_out
WHERE in_out='I';

**보기 답안에서는 중복 제거를 안 해주었다. 해석이 차이인 것 같다.
나는 중간에 투입된 선수의 수를 구할 때 중복을 제거했고, 보기 답안은 중간에 투입된 횟수의 수를 구한 것 같다. 


--16. Write a query in SQL to find the total number of palyers replaced within normal time of play.


SELECT COUNT(DISTINCT player_id)
FROM player_in_out
WHERE in_out='I' AND play_schedule='NT'; 

-----Sample Solution)
SELECT COUNT(*) as "Player Replaced"
FROM player_in_out
WHERE in_out='I' 
AND play_schedule='NT';


--17. Write a query in SQL to find the number of players replaced in the stoppage time.


SELECT COUNT(DISTINCT player_id)
FROM player_in_out
WHERE in_out='I' AND play_schedule='ST'; 

-----Sample Solution)
SELECT COUNT(*) as "Player Replaced"
FROM player_in_out
WHERE in_out='I' 
AND play_schedule='ST';


--18. Write a query in SQL to find the total number of players replaced in the first half of play.


SELECT COUNT(DISTINCT player_id)
FROM player_in_out
WHERE in_out='I' AND play_schedule='NT' AND play_half=1; 

----Sample Solution)
SELECT COUNT(*) as "Player Replaced"
FROM player_in_out
WHERE in_out='I'
AND play_schedule='NT'
AND play_half=1;


--19. Write a query in SQL to find the total number of goalless draws have there in the entire tournament.


SELECT COUNT(DISTINCT match_no)
FROM match_details
WHERE goal_score=0 AND win_lose='D';


--20. Write a query in SQL to find the total number of players replaced in the extra time of play.


SELECT COUNT(*) 
FROM  player_in_out 
WHERE play_schedule='ET'
AND in_out='I';


--21. Write a query in SQL to compute a list to show the number of substitute happened in various stage of play for the entire tournament.


SELECT play_half, play_schedule, COUNT(*)
FROM player_in_out
WHERE in_out='I'
GROUP BY play_half,play_schedule
ORDER BY play_half,play_schedule,count(*);

**list! 다른 컬럼과 count 컬럼이 함께 있음. GROUP BY 필요


--22. Write a query in SQL to find the number of shots taken in penalty shootout matches.


SELECT COUNT(*)
FROM penalty_shootout;


--23. Write a query in SQL to find the number of shots socred goal in penalty shootout matches.


SELECT COUNT(*) 
FROM penalty_shootout
WHERE score_goal='Y';


--24. Write a query in SQL to find the number of shots missed or saved in penalty shootout matches.


SELECT COUNT(*) 
FROM penalty_shootout
WHERE score_goal='N';


--25. Write a query in SQL to prepare a list of players with number of shots they taken in penalty shootout matches.


SELECT ps.match_no, s.country_name, pm.player_name, pm.jersey_no, ps.score_goal, ps.kick_no
FROM soccer_country s, penalty_shootout ps, player_mast pm
WHERE s.country_id=ps.team_id AND p.player_id=pm.player_id 


--26. Write a query in SQL to find the number of penalty shots taken by the teams.


SELECT a.country_name, COUNT(b.*) as "Number of Shots" 
FROM soccer_country a, penalty_shootout b
WHERE b.team_id=a.country_id
GROUP BY a.country_name;


--27. Write a query in SQL to find the number of booking happened in each half of play within normal play schedule.


SELECT play_half,play_schedule,COUNT(*) 
FROM player_booked
WHERE play_schedule='NT'
GROUP BY play_half,play_schedule;


--28. Write a query in SQL to find the number of booking happened in stoppage time.


SELECT COUNT(*) 
FROM player_booked
WHERE play_schedule='ST';


--29. Write a query in SQL to find the number of booking happened in extra time.


SELECT COUNT(*)
FROM player_booked
WHERE play_schedule='ET';
 


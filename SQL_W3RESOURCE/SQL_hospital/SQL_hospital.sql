# https://www.w3resource.com/sql-exercises/hospital-database-exercise/sql-exercise-on-hospital-database.php

#'hospital' 데이터베이스

--1. Write a query in SQL to find all the information of the nurses who are yet to be registered. 

SELECT * FROM nurse
WHERE registered='false';



--2. Write a query in SQL to find the name of the nurse who are the head of their department.  

SELECT name FROM nurse 
WHERE position='Head Nurse';



--3. Write a query in SQL to obtain the name of the physicians who are the head of each department. 

SELECT p.name
FROM physician p, department d
WHERE p.employeeid=d.head;



--4. Write a query in SQL to count the number of patients who taken appointment with at least one physician. 

SELECT COUNT(DISTINCT patient) FROM appointment
WHERE physician >= 1;



--5. Write a query in SQL to find the floor and block where the room number 212 belongs to.

SELECT blockfloor, blockcode FROM room
WHERE roomnumber=212;



--6. Write a query in SQL to count the number available rooms.

SELECT count(*) FROM room
WHERE unavailable='false';



--7. Write a query in SQL to count the number of unavailable rooms. 

SELECT count(*) FROM room
WHERE unavailable='true';



--8. Write a query in SQL to obtain the name of the physician and the departments they are affiliated with. 

SELECT p.name AS P, d.name AS D
FROM physician p, department d, affiliated_with a
WHERE p.employeeid=a.physician AND a.department=d.departmentid;

** 위와 같이 컬럼명 똑같을  별도로 설정해줬을 때 원하는 결과 나왔음



--9. Write a query in SQL to obtain the name of the physicians who are trained for a special treatement.

SELECT DISTINCT p.name
FROM physician p, procedure pr, trained_in t
WHERE p.employeeid=t.physician AND t.treatment=pr.code


----Sample Solution

SELECT p.name AS "Physician",
       c.name AS "Treatement"
FROM physician p,
     PROCEDURE c,
               trained_in t
WHERE t.physician=p.employeeid
  AND t.treatment=c.code;



--10. Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.

SELECT p.name AS "Physician",
       p.position,
       d.name AS "Department"
FROM physician p
LEFT JOIN affiliated_with a ON a.physician=p.employeeid
LEFT JOIN department d ON a.department=d.departmentid
WHERE primaryaffiliation='false';



--11. Write a query in SQL to obtain the name of the physicians who are not a specialized physician.

SELECT p.name 
FROM physician p
LEFT JOIN trained_in t ON t.physician=p.employeeid
WHERE t.treatment IS NULL;



--12. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement.

SELECT pa.name AS "Patient Name", ph.name AS "Physician Name"
FROM patient pa, physician ph 
WHERE pa.pcp=ph.employeeid;


----Sample Solution

SELECT t.name AS "Patient",
       t.address AS "Address",
       p.name AS "Physician"
FROM patient t
JOIN physician p ON t.pcp=p.employeeid;



--13. Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.

SELECT p.name AS "Patient", count(a.physician) AS "Number of Physician"
FROM patient p, appointment a 
WHERE p.ssn=a.patient
GROUP BY p.name;


----Sample Solution

SELECT p.name "Patient",
       count(t.patient) "Appointment for No. of Physicians"
FROM appointment t
JOIN patient p ON t.patient=p.ssn
GROUP BY p.name
HAVING count(t.patient)>=1;



--14. Write a query in SQL to count number of unique patients who got an appointment for examination room C.

SELECT COUNT(DISTINCT patient)
FROM appointment
WHERE examinationroom='C';



--15. Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.

SELECT p.name, a.examinationroom
FROM patient p, appointment a
WHERE p.ssn=a.patient;


----Sample Solution

SELECT p.name AS "Patient",
       a.examinationroom AS "Room No.",
       a.start_dt_time AS "Date and Time of appointment"
FROM patient p
JOIN appointment a ON p.ssn=a.patient;



--16. Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.

SELECT n.name, a.examinationroom
FROM nurse n, appointment a
WHERE n.employeeid=a.prepnurse;


--Sample Solution

SELECT n.name AS "Name of the Nurse",
       a.examinationroom AS "Room No."
FROM nurse n
JOIN appointment a ON a.prepnurse=n.employeeid;



--17. Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no.

SELECT p.name AS "Patient", 
ph.name AS "Physician", 
n.name AS "Nurse", 
a.examinationroom AS "Room No."
FROM patient p, appointment a, nurse n, physician ph
WHERE p.ssn=a.patient 
AND a.prepnurse=n.employeeid
AND a.physician=ph.employeeid
AND a.start_dt_time='2008-04-25 10:00:00';


----Sample Solution

SELECT t.name AS "Name of the patient",
       n.name AS "Name of the Nurse assisting the physician",
       p.name AS "Name of the physician",
       a.examinationroom AS "Room No.",
       a.start_dt_time
FROM patient t
JOIN appointment a ON a.patient=t.ssn
JOIN nurse n ON a.prepnurse=n.employeeid
JOIN physician p ON a.physician=p.employeeid
WHERE start_dt_time='2008-04-25 10:00:00';



--18. Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.

SELECT p.name AS "Patient", ph.name AS "Physician"
FROM patient p, physician ph, appointment a
WHERE p.ssn=a.patient AND a.physician=ph.employeeid
AND a.prepnurse IS NULL;


----Sample Solution

SELECT t.name AS "Name of the patient",
       p.name AS "Name of the physician",
       a.examinationroom AS "Room No."
FROM patient t
JOIN appointment a ON a.patient=t.ssn
JOIN physician p ON a.physician=p.employeeid
WHERE a.prepnurse IS NULL;



--19. Write a query in SQL to find the name of the patients, their treating physicians and medication.

SELECT p.name AS "Patient", ph.name AS "Physician", m.name
FROM patient p, prescribes pr, physician ph, medication m
WHERE p.ssn=pr.patient AND pr.medication=m.code AND pr.physician=ph.employeeid; 


----Sample Solution

SELECT t.name AS "Patient",
       p.name AS "Physician",
       m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code;



--20. Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.

SELECT p.name AS "Patient", ph.name AS "Physician", m.name AS "Medication"
FROM patient p, prescribes pr, physician ph, medication m
WHERE p.ssn=pr.patient AND m.code=pr.medication AND pr.physician=ph.employeeid 
AND pr.appointment IS NOT NULL;


----Sample Solution

SELECT t.name AS "Patient",
       p.name AS "Physician",
       m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NOT NULL;



--21. Write a query in SQL to find the name and medication for those patients who did not take any appointment.

SELECT p.name AS "Patient", m.name AS "Medication"
FROM patient p, medication m, prescribes pr
WHERE p.ssn=pr.patient AND pr.medication=m.code AND pr.appointment IS NULL;


----Sample Solution

SELECT t.name AS "Patient",
       p.name AS "Physician",
       m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NULL;



--22. Write a query in SQL to count the number of available rooms in each block.

SELECT blockcode, COUNT(*)
FROM room
WHERE unavailable='false'
GROUP BY blockcode
ORDER BY blockcode;


----Sample Solution

SELECT blockcode AS "Block",
       count(*) "Number of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockcode
ORDER BY blockcode;



--23. Write a query in SQL to count the number of available rooms in each floor.

SELECT blockfloor, COUNT(*)
FROM room
WHERE unavailable='false'
GROUP BY blockfloor
ORDER BY blockfloor;



--24. Write a query in SQL to count the number of available rooms for each block in each floor.

SELECT blockfloor, blockcode, COUNT(*)
FROM room
WHERE unavailable='false'
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode;



--25. Write a query in SQL to count the number of unavailable rooms for each block in each floor.

SELECT blockfloor, blockcode, COUNT(*)
FROM room
WHERE unavailable='true'
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode;



--26. Write a query in SQL to find out the floor where the maximum no of rooms are available.


----1) 층별로 사용할 수 있는 방의 개수
(SELECT blockfloor, count(*) AS t1
FROM room
WHERE anavailable='false'
GROUP BY blockfloor) AS t2

----2) + 층별 최대 룸넘버

SELECT max(t1) AS highest_total
FROM t2

----3) + 제일 큰 룸넘버가 있는 층

SELECT blockfloor as "Floor",
       count(*) AS  "No of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockfloor
HAVING count(*) =
  (SELECT max(t1) AS highest_total
   FROM
     ( SELECT blockfloor ,
              count(*) AS t1
      FROM room
      WHERE unavailable='false'
      GROUP BY blockfloor ) AS t2 );
      


--27. Write a query in SQL to find out the floor where the minimum no of rooms are available.

SELECT blockfloor as "Floor",
       count(*) AS  "No of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockfloor
HAVING count(*) =
  (SELECT min(t1) AS highest_total
   FROM
     ( SELECT blockfloor ,
              count(*) AS t1
      FROM room
      WHERE unavailable='false'
      GROUP BY blockfloor ) AS t2 )
ORDER BY blockfloor;
      


--28. Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted.

SELECT p.name "Patient", r.blockcode "Block", r.blockfloor "Floor", s.room "Room"
FROM stay s, patient p, room r
WHERE p.ssn=s.patient AND s.room=r.roomnumber;


-----* 이름 따로 정해줄 때 'AS=공백이어서' 아무거나 사용해주면 됨.
-----* 대문자를 살려서 이름 정해주고 싶을 땐 반드시 ""사용해주어야함.



--29. Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.

SELECT n.name "Nurse",
       o.blockcode "Block"
FROM nurse n, on_call o 
WHERE o.nurse=n.employeeid;



--30. Write a query in SQL to make a report which will show - a) name of the patient, b) name of the physician who is treating him or her, c) name of the nurse who is attending him or her, d) which treatement is going on to the patient, e) the date of release, f) in which room the patient has admitted and which floor and block the room belongs to respectively.

SELECT pa.name "Patient", ph.name "Physician", n.name "Nurse", pr.name "Treatment",
s.end_time "Date of Release", r.roomnumber "RoomNO", r.blockfloor "Floor", r.blockcode "Block"
FROM patient pa, physician ph, nurse n, procedure pr, stay s, room r, undergoes u
WHERE u.patient=pa.ssn AND u.physician=ph.employeeid AND u.assistingnurse=n.employeeid
AND u.patient=s.patient AND s.room=r.roomnumber AND pr.code=u.procedure;


----* 이러한 방식으로 코드를 짰을 ; 'Nurse'컬럼에 결측치가 있는데 결측치가 포함된 행은 나오지 않음
----* JOIN문을 써줘야 함

----Sample Solution

SELECT p.name AS "Patient",
       y.name AS "Physician",
       n.name AS "Nurse",
       s.end_time AS "Date of release",
       pr.name as "Treatement going on",
       r.roomnumber AS "Room",
       r.blockfloor AS "Floor",
       r.blockcode AS "Block"
FROM undergoes u
JOIN patient p ON u.patient=p.ssn
JOIN physician y ON u.physician=y.employeeid
LEFT JOIN nurse n ON u.assistingnurse=n.employeeid
JOIN stay s ON u.patient=s.patient
JOIN room r ON s.room=r.roomnumber
JOIN procedure pr on u.procedure=pr.code;












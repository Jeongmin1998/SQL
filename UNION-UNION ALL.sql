UNION & UNION ALL 


1. 공통점: 두 개 이상의 쿼리문을 하나로 합치는 데 사용한다. 



2. 차이점: UNION ALL은 중복을 포함하지만 UNION은 중복을 포함하지 않는다.

1) UNION : 쿼리의 결과를 합친다. 중복된 row는 제거한다. (ONLY distinct values)

SELECT 컬럼명 FROM 테이블 
UNION
SELECT *위와 동일한* 컬럼명 FROM 테이블 2

2) UNION ALL
: 쿼리의 결과를 합친다. 완전히 같은 row도 모두 보여준다. 중복이 제거되지 않는 '단순 합치기' --> 속도 빠름

SELECT 컬럼명 FROM 테이블 
UNION ALL
SELECT *위와 동일한* 컬럼명 FROM 테이블 2


**주의할 점
- 컬럼명이 같아야한다. (같이 않을 경우는 따로 이름을 같게 설정해줘야함. AS나 공백 사용)
- 컬럼별 데이터 타입이 같아야한다.



3. 예제 (출처: https://www.w3schools.com/sql/sql_ref_union.asp)

1) UNION
--Q: The cities (only distinct values) from both the "Customers" and the "Suppliers" table:

SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

2) UNION ALL
--Q: The cities (duplicate values also) from both the "Customers" and the "Suppliers" table:

SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;



4. 언제 사용?

1) UNION
-ex) 오프라인 매장과 온라인 매장에서 매출이 난 날짜 조회
-오프라인 매장과 온라인 매장 각각의 정보에서 회원 정보 추출할 때 중복되는 회원 제거해줘야 함

2) UNION ALL
-오프라인 매장과 온라인 매장의 매출 구하고 싶을 때 (중복해야 함!!)
-중복되는 값이 없다고 확신할 때 속도가 빠른 UNION ALL







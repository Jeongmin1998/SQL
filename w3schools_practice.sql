# https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all

--1. 어떤 테이블들이 있는지 살펴보고 이해해보기

Customers: 소비자 ID, 이름, 불리는 이름, 주소, 도시, 우편번호, 국가
Categories: 카테고리 ID, 카테고리 이름(음료, 유제품 등), 부연설명 (카테고리에 포함되는 제품들)
Employees: 직원 ID, 성, 이름, 생일, 사진, 노트(이력)
OrderDetails: 주문 디테일 ID, 주문 ID, 제품 ID, 수량
Orders: 주문 ID, 소비자 ID, 직원 ID, 주문 날짜, 배송업체 ID
Products: 제품 ID, 제품명, 공급자 ID, 카테고리 ID, 단위, 가격
Shippers: 배송 업체 ID, 배송 업체 이름, 전화번호
Suppliers: 공급자 ID, 공급자(공급 업체) 이름, 담당자 이름, 주소, 도시, 우편번호, 국가, 전화번호

--2. 테이블과 테이블 간의 관계

- Customers & Orders: 주문 내역에 소비자 정보
- Categories & Products: 제품 정보에 어느 카테고리에 속하는지 표시
- Employees & Orders: 주문 내역에 담당 직원 정보
- OrderDetails & Orders
- OrderDetails & Products
- Orders & Shippers: 주문 내역에 어느 배송 업체 썼는지
- Products & Suppliers: 제품 정보에 어느 공급업체를 이용했는지



--3. 이 데이터베이스는 어떤 비즈니스를 처리하기 위한 것인지 테이블과 데이터를 살펴보며 정리해보기

주문, 주문상세 테이블과 고객, 상품, 상품카테고리, 상품제공업체, 배송업체, 종업원 테이블이 있는 것으로 봐서 유통업체의 데이터
제품 카테고리별 판매 가격 등 다양한 계산 용이하게 할 수 있음

--4. (JOIN 개념 이해) 주문정보에 고객이름, 고객주소, 도시, 국가 정보를 함께 조회하는 쿼리를 작성하고 결과를 출력해보세요.

SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.ShipperID, C.CustomerName, C.Address, C.City, C.Country 
FROM Customers C, Orders
WHERE C.CustomerID=Orders.CustomerID;

--5. (GROUP BY 집계 개념 이해) 앞에 작성한 쿼리를 기초로 국가별 주문 건수를 구하는 쿼리로 변형하여 작성하고 결과를 출력해보세요.

SELECT COUNT(Orders.OrderID), C.Country
FROM Customers C, Orders
WHERE C.CustomerID=Orders.CustomerID
GROUP BY C.Country;

--6. GROUP BY에서 사용 가능한 집계 합수
; COUNT, COUNT(DISTINCT), SUM, AVG, MAX, MIN ...

--7
---(1) 주문이 들어온 제품카테고리별 수량

SELECT OD.OrderID, OD.ProductID, P.ProductName, P.CategoryID, C.CategoryName, OD.Quantity 
FROM Categories C, Products P, OrderDetails OD
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID;

---(2) 주문이 들어온 카테고리명별 평균 주문수량과 주문수량 총합

SELECT OD.OrderID, OD.ProductID, P.ProductName, P.CategoryID, C.CategoryName, AVG(OD.Quantity), SUM(OD.Quantity)
FROM Categories C, Products P, OrderDetails OD
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID
GROUP BY C.CategoryName;

---(3) +고객의 수까지

SELECT C.CategoryName, AVG(OD.Quantity), SUM(OD.Quantity), COUNT(DISTINCT O.CustomerID)
FROM Categories C, Products P, OrderDetails OD, Orders O
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID AND O.OrderID=OD.OrderID 
GROUP BY C.CategoryName;

--8. (LEFT JOIN 이해) 소비자별, 주문한 가장 마지막 날짜
(주문하지 않은 고객은 null로)

SELECT Customers.CustomerName, Customers.ContactName, Customers.Address, MAX(Orders.OrderDate)
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Customers.ContactName, Customers.Address

--9. 테이블 맨 마지막 날짜 (8번 이용해서)

SELECT MAX(t1.MaxDate)
From  (SELECT Customers.CustomerName, Customers.ContactName, Customers.Address, MAX(Orders.OrderDate) MaxDate
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Customers.ContactName, Customers.Address) t1


        


        






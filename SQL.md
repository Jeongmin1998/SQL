# SQL 정리
### w3schools에서 실습해봄

![image]("C:\Users\김정민\Downloads\image.png")
-> 1:n 관계성 보여주는 그림

1. 어떤 테이블이 있는지 살펴보기  
Customers: 소비자 ID, 이름, 불리는 이름, 주소, 도시(아마 지점), 우편번호, 국가  
Categories: 카테고리 ID, 카테고리 이름(음료, 유제품 등), 부연설명 (카테고리에 포함되는 제품들)  
Employees: 직원 ID, 성, 이름, 생일, 사진, 노트(이력)  
OrderDetails: 주문 디테일 ID, 주문 ID, 제품 ID, 수량  
Orders: 주문 ID, 소비자 ID, 직원 ID, 주문 날짜, 배송업체 ID  
Products: 제품 ID, 제품명, 공급자 ID, 카테고리 ID, 단위, 가격  
Shippers: 배송 업체 ID, 배송 업체 이름, 전화번호
Suppliers: 공급자 ID, 공급자(공급 업체) 이름, 담당자 이름, 주소, 도시, 우편번호, 국가, 전화번호    
    
2. 테이블과 테이블간의 관계는 어떠한지 이해해보기  
: 그림 참고

3. 실습
   
(1) Join개념 이해

### Inner Join (교집합)
Q: 주문정보에 고객이름, 고객주소, 도시, 국가 정보를 함께 조회하는 쿼리를 작성하고 결과를 출력해보세요.

_SELECT_ Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders. OrderDate, Orders.ShipperID, Customers.CustomerName, Customers.Address, Customers.City, Customers.Country  
_FROM_ Orders, Customers
_WHERE_ Orders.CustomerID=Customers.CustomerID


****테이블명 다 적기 귀찮다면 _FROM_ 옆에 있는 테이블명+(공백)+단축어**


### Outer Join
- Left Join/ Right Join

(2) Group By 개념 이해 (집계)

COUNT, AVG, MAX, MIN, SUM  
중복 제외하고 싶을 때: COUNT(DISTINCT+공백+컬럼명)  

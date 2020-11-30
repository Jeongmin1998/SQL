# https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all

--1. � ���̺���� �ִ��� ���캸�� �����غ���

Customers: �Һ��� ID, �̸�, �Ҹ��� �̸�, �ּ�, ����, �����ȣ, ����
Categories: ī�װ� ID, ī�װ� �̸�(����, ����ǰ ��), �ο����� (ī�װ��� ���ԵǴ� ��ǰ��)
Employees: ���� ID, ��, �̸�, ����, ����, ��Ʈ(�̷�)
OrderDetails: �ֹ� ������ ID, �ֹ� ID, ��ǰ ID, ����
Orders: �ֹ� ID, �Һ��� ID, ���� ID, �ֹ� ��¥, ��۾�ü ID
Products: ��ǰ ID, ��ǰ��, ������ ID, ī�װ� ID, ����, ����
Shippers: ��� ��ü ID, ��� ��ü �̸�, ��ȭ��ȣ
Suppliers: ������ ID, ������(���� ��ü) �̸�, ����� �̸�, �ּ�, ����, �����ȣ, ����, ��ȭ��ȣ

--2. ���̺�� ���̺� ���� ����

- Customers & Orders: �ֹ� ������ �Һ��� ����
- Categories & Products: ��ǰ ������ ��� ī�װ��� ���ϴ��� ǥ��
- Employees & Orders: �ֹ� ������ ��� ���� ����
- OrderDetails & Orders
- OrderDetails & Products
- Orders & Shippers: �ֹ� ������ ��� ��� ��ü �����
- Products & Suppliers: ��ǰ ������ ��� ���޾�ü�� �̿��ߴ���



--3. �� �����ͺ��̽��� � ����Ͻ��� ó���ϱ� ���� ������ ���̺�� �����͸� ���캸�� �����غ���

�ֹ�, �ֹ��� ���̺�� ��, ��ǰ, ��ǰī�װ�, ��ǰ������ü, ��۾�ü, ������ ���̺��� �ִ� ������ ���� �����ü�� ������
��ǰ ī�װ��� �Ǹ� ���� �� �پ��� ��� �����ϰ� �� �� ����

--4. (JOIN ���� ����) �ֹ������� ���̸�, ���ּ�, ����, ���� ������ �Բ� ��ȸ�ϴ� ������ �ۼ��ϰ� ����� ����غ�����.

SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.ShipperID, C.CustomerName, C.Address, C.City, C.Country 
FROM Customers C, Orders
WHERE C.CustomerID=Orders.CustomerID;

--5. (GROUP BY ���� ���� ����) �տ� �ۼ��� ������ ���ʷ� ������ �ֹ� �Ǽ��� ���ϴ� ������ �����Ͽ� �ۼ��ϰ� ����� ����غ�����.

SELECT COUNT(Orders.OrderID), C.Country
FROM Customers C, Orders
WHERE C.CustomerID=Orders.CustomerID
GROUP BY C.Country;

--6. GROUP BY���� ��� ������ ���� �ռ�
; COUNT, COUNT(DISTINCT), SUM, AVG, MAX, MIN ...

--7
---(1) �ֹ��� ���� ��ǰī�װ��� ����

SELECT OD.OrderID, OD.ProductID, P.ProductName, P.CategoryID, C.CategoryName, OD.Quantity 
FROM Categories C, Products P, OrderDetails OD
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID;

---(2) �ֹ��� ���� ī�װ��� ��� �ֹ������� �ֹ����� ����

SELECT OD.OrderID, OD.ProductID, P.ProductName, P.CategoryID, C.CategoryName, AVG(OD.Quantity), SUM(OD.Quantity)
FROM Categories C, Products P, OrderDetails OD
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID
GROUP BY C.CategoryName;

---(3) +���� ������

SELECT C.CategoryName, AVG(OD.Quantity), SUM(OD.Quantity), COUNT(DISTINCT O.CustomerID)
FROM Categories C, Products P, OrderDetails OD, Orders O
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID AND O.OrderID=OD.OrderID 
GROUP BY C.CategoryName;

--8. (LEFT JOIN ����) �Һ��ں�, �ֹ��� ���� ������ ��¥
(�ֹ����� ���� ���� null��)

SELECT Customers.CustomerName, Customers.ContactName, Customers.Address, MAX(Orders.OrderDate)
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Customers.ContactName, Customers.Address

--9. ���̺� �� ������ ��¥ (8�� �̿��ؼ�)

SELECT MAX(t1.MaxDate)
From  (SELECT Customers.CustomerName, Customers.ContactName, Customers.Address, MAX(Orders.OrderDate) MaxDate
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Customers.ContactName, Customers.Address) t1


        


        






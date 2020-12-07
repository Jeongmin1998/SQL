# ��ó: https://rfriend.tistory.com/323?category=653567 


-- Q: "��ǰ ī�װ� �� 'Dairy Products', 'Grains/Cereals', 'Seafood', 'Condiments' ī�װ��� ���ؼ� ī�װ����� �ǸŰ� �Ͼ(�ֹ��� �߻���) ��ǰ���� ������ �հ�, �� �ֹ� �߻� ȸ��, ��ǰ���� ������ ����� ���Ͻÿ�.  

-- ��, ī�װ��� ��ǰ ������ �հ谡 1,100 �̻��� ��츸 ���� ����� �����ϵ�, ������ �հ踦 �������� ������������ �����Ͽ� �����Ͻÿ�."

 
������ �亯:

SELECT e.CategoryName AS CategoryName, SUM(e.Price) AS Price_sum, COUNT(*) AS Order_cnt, AVG(e.Price) AS Price_avg
FROM (SELECT c.OrderID, c.ProductID, c.Price, c.CategoryID, d.CategoryName  -- sub query 2
      FROM (SELECT a.OrderID, a.ProductID, b.Price, b.CategoryID  -- sub query 1
FROM OrderDetails a
INNER JOIN Products b ON a.ProductID = b.ProductID) c
LEFT JOIN Categories d ON c.CategoryID = d.CategoryID) e
WHERE e.CategoryName IN ('Dairy Products', 'Grains/Cereals', 'Seafood', 'Condiments')
GROUP BY e.CategoryName
HAVING Price_sum > 1100
ORDER BY Price_sum DESC;  

�� �亯:


SELECT C.CategoryName, SUM(P.Price), COUNT(*), AVG(P.Price)
FROM Categories C, Products P, OrderDetails OD
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID AND C.CategoryName IN ('Dairy Products', 'Grains/Cereals', 'Seafood', 'Condiments')
GROUP BY C.CategoryName
HAVING SUM(P.Price) >= 1100
ORDER BY SUM(P.Price) DESC;


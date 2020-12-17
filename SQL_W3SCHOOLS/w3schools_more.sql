# 출처: https://rfriend.tistory.com/323?category=653567 


-- Q: "제품 카테고리 중 'Dairy Products', 'Grains/Cereals', 'Seafood', 'Condiments' 카테고리에 대해서 카테고리별로 판매가 일어난(주문이 발생한) 제품들의 가격의 합계, 총 주문 발생 회수, 제품들의 가격의 평균을 구하시오.  

-- 단, 카테고리별 제품 가격의 합계가 1,100 이상인 경우만 집계 결과를 제시하되, 가격의 합계를 기준으로 내림차순으로 정렬하여 제시하시오."

 
원작자 답변:

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

내 답변:


SELECT C.CategoryName, SUM(P.Price), COUNT(*), AVG(P.Price)
FROM Categories C, Products P, OrderDetails OD
WHERE C.CategoryID=P.CategoryID AND P.ProductID=OD.ProductID AND C.CategoryName IN ('Dairy Products', 'Grains/Cereals', 'Seafood', 'Condiments')
GROUP BY C.CategoryName
HAVING SUM(P.Price) >= 1100
ORDER BY SUM(P.Price) DESC;


결과는 동일하게 나온다.


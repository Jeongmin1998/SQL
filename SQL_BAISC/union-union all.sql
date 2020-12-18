UNION & UNION ALL 


--1. ������: �� �� �̻��� �������� �ϳ��� ��ġ�� �� ����Ѵ�. 



--2. ������: UNION ALL�� �ߺ��� ���������� UNION�� �ߺ��� �������� �ʴ´�.

----1) UNION : ������ ����� ��ģ��. �ߺ��� row�� �����Ѵ�. (ONLY distinct values)

SELECT �÷��� FROM ���̺� 
UNION
SELECT *���� ������* �÷��� FROM ���̺� 2

----2) UNION ALL
: ������ ����� ��ģ��. ������ ���� row�� ��� �����ش�. �ߺ��� ���ŵ��� �ʴ� '�ܼ� ��ġ��' --> �ӵ� ����

SELECT �÷��� FROM ���̺� 
UNION ALL
SELECT *���� ������* �÷��� FROM ���̺� 2


--**������ ��
--�÷����� ���ƾ��Ѵ�. (���� ���� ���� ���� �̸��� ���� �����������. AS�� ���� ���)
-- �÷��� ������ Ÿ���� ���ƾ��Ѵ�.



--3. ���� (��ó: https://www.w3schools.com/sql/sql_ref_union.asp)

----1) UNION
--Q: The cities (only distinct values) from both the "Customers" and the "Suppliers" table:

SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

----2) UNION ALL
--Q: The cities (duplicate values also) from both the "Customers" and the "Suppliers" table:

SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;



--4. ���� ���?

----1) UNION
--ex) �������� ����� �¶��� ���忡�� ������ �� ��¥ ��ȸ
--�������� ����� �¶��� ���� ������ �������� ȸ�� ���� ������ �� �ߺ��Ǵ� ȸ�� ��������� ��

----2) UNION ALL
--�������� ����� �¶��� ������ ���� ���ϰ� ���� �� (�ߺ��ؾ� ��!!)
--�ߺ��Ǵ� ���� ���ٰ� Ȯ���� �� �ӵ��� ���� UNION ALL







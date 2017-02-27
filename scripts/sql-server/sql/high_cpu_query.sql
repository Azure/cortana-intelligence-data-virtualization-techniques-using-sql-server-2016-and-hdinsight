USE AdventureWorks2012;

SELECT
	T1.*
FROM
	HumanResources.Employee T1,
	Person.Address T2,
	Production.WorkOrder T3,
	Sales.Customer T4;
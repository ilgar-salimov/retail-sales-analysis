/*Business Problem:
 List all products cost more than $50*/

SELECT ProductID, ProductName, Price 
FROM Products
WHERE Price>50
;

/*Business Problem: 
Marketing wants to know which countries our customers come from to plan a new ad campaign.*/

SELECT DISTINCT Country 
FROM Customers
;

/*Business Problem: 
Which category has the most products.*/

SELECT Categories.CategoryId, CategoryName, Count(ProductID) as Number_of_Product 
FROM Products
	INNER JOIN Categories
		ON Products.CategoryId=Categories.CategoryId
GROUP BY CategoryID, CategoryName
ORDER BY Number_of_Product DESC
LIMIT 1
;

/*Business Problem:
Each Shipper is handling how many orders.*/

Select Shippers.ShipperID, ShipperName, Count(OrderId) as Number_of_Orders
From Orders 
	Inner Join Shippers
		on Orders.ShipperId=Shippers.ShipperId
Group by ShipperID, ShipperName
ORDER BY Number_of_Orders DESC
;

/*Business Problem: 
Identify 5 customers based on how much money they have spent.*/

SELECT Customers.CustomerID, CustomerName, Sum(quantity*price) as Total_amount
FROM Orderdetails
	INNER JOIN Orders
		ON Orderdetails.OrderId=Orders.OrderId
	INNER JOIN Products 
		ON 	Products.ProductID=Orderdetails.ProductID
	INNER JOIN Customers
		ON Customers.CustomerID=Orders.CustomerId
GROUP BY Customers.CustomerID, CustomerName
ORDER BY Total_amount DESC
LIMIT 5
;

/*Business Problem: 
 How much total revenue each employee has generated.*/

SELECT FirstName, LastName, Sum(quantity*price) as Total_amount
FROM Orderdetails
	INNER JOIN Orders
		ON Orderdetails.OrderId=Orders.OrderId
	INNER JOIN Products 
		ON 	Products.ProductID=Orderdetails.ProductID
	INNER JOIN Employees
		on Employees.employeeid=Orders.Employeeid
	GROUP BY FirstName, LastName
    ORDER BY Total_amount desc
;
        
/*Business Problem: 
Find products that have never been ordered so they can be removed from the catalog.*/

SELECT ProductName
FROM Products 
	LEFT JOIN Orderdetails 
		ON Products.ProductId=Orderdetails.ProductID
WHERE Orderdetails.ProductID IS NULL
;

/*Business Problems:
Indicate total revenue trend month-by-month to identify if the business is growing.*/

SELECT `Year`, MonthName, sum(Quantity*price) as Revenue
FROM Products
	INNER JOIN OrderDetails
		ON Products.ProductID=OrderDetails.ProductID
	INNER JOIN Orders
		ON Orders.OrderID=OrderDetails.OrderID
	INNER JOIN `Date` 
		ON `Date`.FullDate=Orders.OrderDate
GROUP BY `Year`, MonthName
;

/*Business Problem:
Indicate if the company sell more on Weekends versus Weekdays.*/

SELECT
	CASE
		WHEN DayName in ('Saturday','Sunday') THEN 'Weekend'
        ELSE 'Weekday'
END AS  Day_Type, sum(Quantity*price) as Revenue
FROM Products
	INNER JOIN OrderDetails
		ON Products.ProductID=OrderDetails.ProductID
	INNER JOIN Orders
		ON Orders.OrderID=OrderDetails.OrderID
	INNER JOIN `Date` 
		ON `Date`.FullDate=Orders.OrderDate
GROUP BY Day_Type
ORDER BY Revenue DESC
;

/*Business Problem:
Which categories generated more than $5,000 in revenue during the year 1997.*/

SELECT Categories.CategoryId, CategoryName, sum(Quantity*price) as Revenue
FROM Categories
	INNER JOIN Products
		ON Categories.CategoryId=Products.CategoryID
	INNER Join OrderDetails
		ON Products.ProductId=Orderdetails.ProductId
	INNER JOIN Orders
		ON Orders.OrderId=OrderDetails.OrderId
WHERE Year(OrderDate)=1997
GROUP BY CategoryId, CategoryName
HAVING Revenue>5000
;

/*Business Problem:
Find the employee who handled the highest number of unique orders in 1996.*/

SELECT FirstName,LastName, Count(Distinct OrderId) as Unique_Number_of_Orders
FROM Employees
	INNER JOIN Orders
		ON Employees.EmployeeId=Orders.EmployeeId
WHERE Year(OrderDate)=1996
GROUP BY FirstName, LastName
ORDER BY Unique_Number_of_Orders DESC
LIMIT 1
;
    
/*Business Problem:
In which Country did have the highest number of orders during Quarter 3 (any year)?*/

SELECT Country, Count(OrderId) as NumberOfOrders
FROM Customers
	INNER JOIN Orders
		ON Customers.CustomerId=Orders.CustomerId
	INNER JOIN `date`
		ON Orders.OrderDate=`date`.FullDate
WHERE Quarter= 3
GROUP BY Country
ORDER BY NumberOfOrders DESC
LIMIT 1
;	

/*Business Problem:
Which Supplier’s products are contributing the most to total revenue? List the Top 3 Suppliers.*/

Select SupplierName, sum(Quantity*price) as Revenue
FROM Suppliers
	INNER JOIN Products
		On Suppliers.SupplierId=Products.SupplierId
	INNER JOIN Orderdetails
		On Orderdetails.ProductId=Products.ProductId
Group BY SupplierName
Order by Revenue DESC
LIMIT 3
;

/*Business Problem: 
Use a Window Function RANK() to rank every customer based on their total spending,
and assign them "Gold", "Silver", or "Bronze" status. First Write in Subquerry Format*/

SELECT*,
	CASE
		WHEN CustomerRank BETWEEN 1 and 25 THEN 'Gold'
        WHEN CustomerRank BETWEEN 26 and 50 THEN 'Silver'
			ELSE 'Bronze' 
            END AS CustomerStatus
FROM(

SELECT *,
	RANK() OVER(ORDER BY Revenue DESC) AS CustomerRank
FROM 
	(SELECT Customers.CustomerId, Customers.CustomerName,sum(Quantity*price) as Revenue
FROM Orders
	INNER JOIN OrderDetails
		ON Orders.OrderId=OrderDetails.OrderId
	INNER JOIN Products
		ON Products.ProductId=OrderDetails.ProductID
	INNER JOIN Customers
		ON Customers.CustomerId=Orders.CustomerId
GROUP BY Customers.CustomerId, Customers.CustomerName) as Customer_total) 
AS  RankedCustomers
;

/*The same querry result with CTE*/

WITH Cte_example1 AS(
SELECT Customers.CustomerId, Customers.CustomerName,sum(Quantity*price) as Revenue
	FROM Orders
			INNER JOIN OrderDetails
				ON Orders.OrderId=OrderDetails.OrderId
			INNER JOIN Products
				ON Products.ProductId=OrderDetails.ProductID
			INNER JOIN Customers
				ON Customers.CustomerId=Orders.CustomerId
GROUP BY Customers.CustomerId, Customers.CustomerName),

Cte_example2 AS ( 
SELECT*,
	RANK() OVER (ORDER BY Revenue DESC) AS CustomerRank
From Cte_example1)

SELECT*,
	CASE
		WHEN CustomerRank BETWEEN 1 and 25 THEN 'Gold'
        WHEN CustomerRank BETWEEN 26 and 50 THEN 'Silver'
			ELSE 'Bronze' 
            END AS CustomerStatus
FROM Cte_example2
;




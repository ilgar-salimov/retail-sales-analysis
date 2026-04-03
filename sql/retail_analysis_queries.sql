/*Business Problem:
 The Warehouse Manager needs a list of all products that cost more than $50*/

Select* from Products
Where Price>50;

/*Business Problem: 
Marketing wants to know which countries our customers come from to plan a new ad campaign.*/

Select distinct country 
From customers;

/*Business Problem: 
The company wants to know which category has the most products.*/

Select CategoryName, Count(ProductID) as Number_of_Product 
From products
	Inner Join categories
		on products.CategoryId=categories.CategoryId
Group by CategoryName
Order by Number_of_Product DESC;

/*Business Problem:
We want to see which Shipper is handling the most orders.*/

Select ShipperName, Count(OrderId) as Number_of_Orders
From Orders 
	Inner Join Shippers
		on Orders.ShipperId=Shippers.ShipperId
Group by ShipperName
ORDER BY Number_of_Orders DESC
;

/*Business Problem: 
We want to identify 5 customers based on how much money they have spent.*/

Select Customers.CustomerID, CustomerName, Sum(quantity*price) as Total_amount
From Orderdetails
	INNER JOIN Orders
		ON Orderdetails.OrderId=Orders.OrderId
	INNER JOIN Products 
		ON 	Products.ProductID=Orderdetails.ProductID
	INNER JOIN Customers
		ON Customers.CustomerID=Orders.CustomerId
Group BY Customers.CustomerID, CustomerName
Order by Total_amount DESC
LIMIT 5	;

/*Business Problem: 
We need to see how much total revenue each employee has generated.*/

Select FirstName, LastName, Sum(quantity*price) as Total_amount
From Orderdetails
	INNER JOIN Orders
		ON Orderdetails.OrderId=Orders.OrderId
	INNER JOIN Products 
		ON 	Products.ProductID=Orderdetails.ProductID
	INNER JOIN Employees
		on Employees.employeeid=Orders.Employeeid
	Group by FirstName, LastName
    Order By Total_amount desc
        ;

/*Business Problem: 
The Manager wants to find products that have never been ordered so they can be removed from the catalog.*/
Select   ProductName
From Products 
	LEFT JOIN Orderdetails 
		ON Products.ProductId=Orderdetails.ProductID
Where Orderdetails.ProductID IS NULL
;





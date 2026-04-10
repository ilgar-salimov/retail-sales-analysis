This project is sales analytics solution built using Power BI and connection to MySQL. It focuses on data modeling, DAX calculations, and building business insights from raw transactional data.

Data Source:
The dataset is stored in a SQL database called retail_sales_db. I designed it from scratch using an ER diagram and built proper relationships between tables using primary and foreign keys. Power BI is connected directly to this database for analysis.

Tables Used:
Customers, Orders, OrderDetails, Products, Categories, Suppliers, Employees, Shippers

KPIs:

• Total Sales 
• Total Profit 
• Total Orders 
• Average Order Value 
• Total Quantity Sold 

Analysis Covered:

• Sales and profit trends over time (year and month) 
• Profit by product category 
• Top profitable products using ranking logic 
• Sales and profit by country 
• Top customers by total sales 
• Customer segmentation based on value using ranking and SWITCH logic 

DAX & Logic Used:

• DAX is used for Total Sales, Profit, and Average Order Value measures
• Used SUMX for row-level calculations 
• Used RANKX for customer and product ranking 
• Used SWITCH(TRUE()) for customer segmentation (High, Medium, Low value groups) 

Key Takeaways:

The charts shows which products and customers bring the most value, how profit changes across categories and countries, and how the business performs over time. It helps turn raw data into clear business insights.

Tools Used:
MySQL, Power BI, DAX, Power Query.


# Walmart_sales

This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." source

Purposes Of The Project
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

About Data
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

Column	Description	Data Type
invoice_id	Invoice of the sales made	VARCHAR(30)
branch	Branch at which sales were made	VARCHAR(5)
city	The location of the branch	VARCHAR(30)
customer_type	The type of the customer	VARCHAR(30)
gender	Gender of the customer making purchase	VARCHAR(10)
product_line	Product line of the product solf	VARCHAR(100)
unit_price	The price of each product	DECIMAL(10, 2)
quantity	The amount of the product sold	INT
VAT	The amount of tax on the purchase	FLOAT(6, 4)
total	The total cost of the purchase	DECIMAL(10, 2)
date	The date on which the purchase was made	DATE
time	The time at which the purchase was made	TIMESTAMP
payment_method	The total amount paid	DECIMAL(10, 2)
cogs	Cost Of Goods sold	DECIMAL(10, 2)
gross_margin_percentage	Gross margin percentage	FLOAT(11, 9)
gross_income	Gross Income	DECIMAL(10, 2)
rating	Rating	FLOAT(2, 1)
Analysis List
Product Analysis
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

Sales Analysis
This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

Customer Analysis
This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

Approach Used
Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
Build a database
Create table and insert the data.
Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.
Feature Engineering: This will help use generate some new columns from existing ones.
Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

Conclusion:

Business Questions To Answer
Generic Question
How many unique cities does the data have?
In which city is each branch?
Product
How many unique product lines does the data have?
What is the most common payment method?
What is the most selling product line?
What is the total revenue by month?
What month had the largest COGS?
What product line had the largest revenue?
What is the city with the largest revenue?
What product line had the largest VAT?
Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
Which branch sold more products than average product sold?
What is the most common product line by gender?
What is the average rating of each product line?
Sales
Number of sales made in each time of the day per weekday
Which of the customer types brings the most revenue?
Which city has the largest tax percent/ VAT (Value Added Tax)?
Which customer type pays the most in VAT?
Customer
How many unique customer types does the data have?
How many unique payment methods does the data have?
What is the most common customer type?
Which customer type buys the most?
What is the gender of most of the customers?
What is the gender distribution per branch?
Which time of the day do customers give most ratings?
Which time of the day do customers give most ratings per branch?
Which day fo the week has the best avg ratings?
Which day of the week has the best average ratings per branch?
Revenue And Profit Calculations
$ COGS = unitsPrice * quantity $

$ VAT = 5% * COGS $

V
A
T
 is added to the 
C
O
G
S
 and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

Gross Margin is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

Example with the first row in our DB:

Data given:

$ \text{Unite Price} = 45.79 $
$ \text{Quantity} = 7 $
$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5% * COGS\= 5% 320.53 = 16.0265 $

$ total = VAT + COGS\= 16.0265 + 320.53 = 
336.5565

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\=\frac{16.0265}{336.5565} = 0.047619\\approx 4.7619% $


```sql

create database walmart;
use walmart;
create table walmart_sales(
Invoice_ID varchar(30) primary key,
Branch varchar(5),
City varchar(30),
Customer_type varchar(30),
Gender varchar(20),
Produc_line varchar(60),
Unit_price float,
Quantity int,
Tax float,
Total float,
Date_d date,
Time_t time,
Payment varchar(30),
cogs float,
gross_margin_percentage float,
gross_income float,
Rating float
);

-- Generic Question
-- 1.How many unique cities does the data have?

select count(distinct City)
from walmart_sales;

-- 2. In which city is each branch?

select City,branch from walmart_sales
group by City,Branch;

-- Product
-- 1.How many unique product lines does the data have?

select count(Produc_line) from walmart_sales;

-- 2.What is the most common payment method?
select Payment,count(Payment)from walmart_sales
group by Payment
order by count(Payment) desc
limit 1;

-- 3.What is the most selling product line?

select Produc_line,sum(Quantity) from walmart_sales
group by Produc_line
order by sum(Quantity) desc
limit 1;

-- 4.What is the total revenue by month?
select SUM(Total),extract(month from Date_d) as months
from walmart_sales
group  by months
order by sum(Total) desc
limit 1;


-- 5.What month had the largest COGS?
select cogs,extract(month from Date_d)as months
from walmart_sales
order by cogs desc
limit 1;


-- 6.What product line had the largest revenue?

select Produc_line, sum(Total)
from walmart_sales
group by Produc_line
order by sum(Total) desc
limit 1;


-- 7.What is the city with the largest revenue?

select City,sum(Total)
from walmart_sales
group by City
order by sum(Total) desc
limit 1;

-- 8.What product line had the largest VAT?

select Produc_line from walmart_sales
order by Tax desc
limit 1;

-- 9.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

select produc_line,
case
when Total>(select avg(Total)from walmart_sales) then 'good'
else 'Bad'
end as sale_stat
from walmart_sales;


-- 10.Which branch sold more products than average product sold?

select Branch,sum(Quantity)from walmart_sales
group by Branch
order by sum(Quantity) desc
limit 1;


-- 11.What is the most common product line by gender?

select Produc_line,Gender,count(Produc_line) from walmart_sales
group by Gender,Produc_line
order by count(Produc_line)desc;

-- 12.What is the average rating of each product line?

select Produc_line, avg(Rating)from walmart_sales
group by Produc_line
order by avg(Rating) desc;

-- Sales
-- 1. Number of sales made in each time of the day per weekday

select count(Invoice_ID),dayname(Date_d) from walmart_sales
group by dayname(Date_d);

-- 2.Which of the customer types brings the most revenue?

select Customer_type,SUm(Total)from walmart_sales
group by Customer_type
order by sum(Total) desc
limit 1;

-- 3.Which city has the largest tax percent/ VAT (Value Added Tax)?

select City, sum(Tax) from walmart_sales
group by City
order by sum(tax) desc
limit 1;

-- .Which customer type pays the most in VAT?

select Customer_type,sum(Tax)from walmart_sales
group by Customer_type
order by sum(Tax) desc
limit 1;

-- Customer
-- 1.How many unique customer types does the data have?

select count(distinct Customer_type) from walmart_sales;

-- 2. How many unique payment methods does the data have?

select count(distinct Payment) from walmart_sales;

-- 4. What is the most common customer type?

select  Customer_type from walmart_sales
group by Customer_type
order by count( Customer_type) desc
limit 1;

-- 5. Which customer type buys the most?
select Customer_type,sum(Quantity)
from walmart_sales
group by Customer_type
order by Sum(Quantity) desc
limit 1;

-- 6. What is the gender of most of the customers?

select Gender from walmart_sales
group by Gender
order by count(Invoice_ID) desc
limit 1;

-- 7. What is the gender distribution per branch?

select Branch,Gender,count(Gender)from walmart_sales
group by Branch,Gender;

-- 8. Which time of the day do customers give most ratings?

select 
case
when extract(hour from Time_t) <12 and extract(hour from Time_t) >6 then 'Morning'
when extract(hour from Time_t) <16 and extract(hour from Time_t) >12 then 'After noon'
when extract(hour from Time_t) <19 and extract(hour from Time_t) >16 then 'Evening'
else 'Night'
end as TIME_OF_DAY
from walmart_sales
group by  TIME_OF_DAY
order by Count(Invoice_ID) desc
limit 1;

-- 9. Which time of the day do customers give most ratings per branch?

select 
Branch,
Count(Invoice_ID),
case
when extract(hour from Time_t) <12 and extract(hour from Time_t) >6 then 'Morning'
when extract(hour from Time_t) <16 and extract(hour from Time_t) >12 then 'After noon'
when extract(hour from Time_t) <19 and extract(hour from Time_t) >16 then 'Evening'
else 'Night'
end as TIME_OF_DAY
from walmart_sales
group by  Branch,TIME_OF_DAY
;

-- 10. Which day fo the week has the best avg ratings?

select dayname(Date_d) from walmart_sales
group by dayname(Date_d)
order by avg(Rating) desc
limit 1;

-- 11. Which day of the week has the best average ratings per branch?

select Branch,dayname(Date_d) from walmart_sales
group by branch,dayname(Date_d)
order by avg(Rating) desc;

```

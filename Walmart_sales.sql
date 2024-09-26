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

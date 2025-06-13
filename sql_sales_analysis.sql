SELECT * FROM sql_project_p2.retail_sales;
use sql_project_p2;

select count(*) from retail_sales;

#Data cleaning

select * from retail_sales where transaction_id is null;
select * from retail_sales where sale_date is null;
select * from retail_sales where sale_time is null;
select * from retail_sales where customer_id is null;
select * from retail_sales where gender is null;
select * from retail_sales where age is null;
select * from retail_sales where category is null;
select * from retail_sales where total_sale is null;
select * from retail_sales where quantity is null;
select * from retail_sales where price_per_unit is null;
select * from retail_sales where cogs is null;
select * from retail_sales where transaction_id=679;
delete from retail_sales where total_sale=0;
set sql_safe_updates=0;

#Data Exploration and Data Analysis
#Q1.write sql query to retrieve all columns for sales made on '2022-11-05' 

select * from retail_sales where sale_date="2022-11-05";

#Q2.write a sql query to retrieve all transactions where the category is 'clothing' and the 
#quantity sold is more than 10 in the month of nov-2022  

select * from retail_sales where category="Clothing" and quantity>3 and month(sale_date)=11 and year(sale_date)=2022;

#Q3.Write a sql query to calculate total sales (total_sales) for each category 

select category,sum(total_sale) as net_sale from retail_sales group by category;

#Q4.Write a sql query to find the average age of customers who purchased items from the 'beauty' category

select round(avg(age),2) as avg_age_customer from retail_sales where category="beauty"; 

#Q.5 Write a sql query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales where total_sale > 1000;

#Q.6 Write a sql query to find the total_number of transaction (transaaction_id) made by each gender in each category 
select gender,category,count(transaction_id) as transaction_count from retail_sales group by gender,category;

#Q.7 Write a sql query to calculate the average sale for each month.Find out best selling month in each year
select year(sale_date) as year,month(sale_date) as month,round(avg(total_sale),2) as avg_month_sale,rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks from retail_sales group by month(sale_date),year(sale_date) order by month(sale_date);


#Q.8 Write sql query to find top 5 customer based on the highest total_sales
select customer_id as customer,sum(total_sale) from retail_sales group by customer_id order by sum(total_sale) desc limit 5;

#Q.9 Write a sql query to find the number of unique customers who purchased items from each category
select count(Distinct customer_id) as customer,category from retail_sales group by category; 

#Q.10 Write a SQL query to create each shift and number of orders (example morning<=12, Afternoon Between 12 & 17 , Evening > 17)
Select 
case 
when hour(sale_time) < 12 then "Morning"
when hour(sale_time) between 12 and 17 then "Afternoon"
else "Evening" 
end as shift,
count(*) as orders
from retail_sales
group by shift;



CREATE TABLE retail_sales(
row_id TEXT,
order_id TEXT,
order_date TEXT,
ship_date TEXT,
ship_mode TEXT,
customer_id TEXT,
customer_name TEXT,
segment TEXT,
country TEXT,
city TEXT,
state TEXT,
postal_code TEXT,
region TEXT,
product_id TEXT,
category TEXT,
sub_category TEXT,
product_name TEXT,
sales TEXT,
quantity TEXT,
discount TEXT,
profit TEXT
);

select * from retail_sales;

select sum(cast(sales as float) ) from retail_sales;

select sum(cast(profit as float))as total_profit from retail_sales;

select count(order_id) from retail_sales;

select sum(cast(sales as float) )as total_sales,region from retail_sales
group by region

select sum(cast(profit as float))as total_profit ,region from retail_sales
group by region 

select sum(cast(sales as float) )as total_sales,category from retail_sales
group by category
order by total_sales desc


select sum(cast(profit as float)) as total_profit , category from retail_sales
group by category

select product_name,sum(cast(sales as float))as total_sales, rank()over(order by sum(cast(sales as float))desc)as rnk from retail_sales
group by product_name

select * from(select product_name, sum(cast(profit as float))as total_profit, rank()over(order by sum(cast(profit as float)) desc)as rnk from retail_sales
group by product_name )t
where rnk<=5


select order_date,sum(cast(sales as float)) as total_sales ,sum(sum(cast(sales as float)))over(order by order_date) from retail_sales
group by order_date

select region,(sum(cast(profit as float))/sum(cast(sales as float)))*100 as profit_margin from retail_sales
group by region


select product_name , sum(cast (sales as float))as sales, sum(cast(profit as float ))as profit from retail_sales
group by product_name
having sum(cast (sales as float)) >5000
and sum(cast(profit as float )) <500
ORDER BY sum(cast (sales as float)) desc


select region,(sum(cast(sales as float ))/(select sum(cast(sales as float )) from retail_sales)*100  from retail_sales
group by region 


select product_name ,sum(cast(sales as float))as total_sales 
from retail_sales 
group by product_name
having sum(cast(sales as float)) > 
(
select avg(product_sales)
from 
(
select sum(cast(sales as float))as product_sales 
from retail_sales 
group by product_name))
order by total_sales desc

select * from (select category,
sub_category,
sum(cast(profit as float)),
rank()over(partition by category order by sum(cast(profit as float)) desc )as rnk
from retail_sales
group by category,sub_category)
where rnk=1


select product_name ,
case
when sum(cast(profit as float)) <0 then 'loss'
when sum(cast(profit as float)) between 0 and 500 then 'low profit'
else 'high profit'
end as profit_status
from retail_sales 
group by product_name


select category,sum(cast(sales as float)) as sales,
sum(cast(profit as float)) as profit
from retail_sales 
group by category


select customer_id ,count(order_id)as total_orders
from retail_sales 
group by customer_id
having count(order_id)>5
order by count(order_id) desc



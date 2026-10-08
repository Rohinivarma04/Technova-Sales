create database TechNova;
use TechNova;

--Retreving data from  table
select * from technova_sales;

--how to check datatypes in sql
desc technova_sales;

--Cleaning the data
--checking with duplicates for 'Order_ID'
select Order_ID,count(*) as Order_count 
from technova_sales
group by Order_ID
having Order_count > 1; 

--which assigns unique number --row number
select * ,
row_number() over(partition by Order_ID order by Order_Date) as rn
from technova_sales;

--so for this creating new table where rn = 1 --it means not vaing any duplicates
create table sales select *
from (
select * ,
row_number() over(partition by Order_ID order by Order_Date) as rn
from technova_sales
) t
where rn = 1;

select * from sales;

--checking the dupicates for sales table
select Order_ID , count(*)
from sales
group by Order_ID 
having count(*) > 1;

droping rn from table sales
alter table sales drop column rn;

--checking with nulls
select * from sales
where Order_ID is Null
       or we use 
select * from sales
where Order_ID = '';

select * from sales
where Order_Date = '';

select * from sales
where Customer = '';

select * from sales
where City = '';

update sales
set City = 'Unknow'
where City = '';
      or if safe mode is not working temporiraly we use
update sales
set City = 'Unknow'
where City = '';
SET SQL_SAFE_UPDATES = 0;

select * from sales
where Product= '';

select * from sales
where Category= '';

select * from sales
where Sales_Rep= '';

select * from sales
where Quantity= '';

select * from sales
where Unit_Price= '';

select * from sales
where Discount= '';
--having nulls in dupliocates so we update

Update sales
set Discount = '0%'
where Discount = '';

select * from sales
where Revenue= '';

select * from sales
where Payment_Mode= '';

--checking with datatypes
desc sales;

--type casting (changing one data type to another data)
--changing discount str to decimal
alter table sales
add column Modified_Discount decimal(5,2);

--cast(before as decimal)
--cast(replace(discount,'%','')as decimal)
Update sales 
set Modified_Discount = cast(replace(Discount,'%', '') as decimal(5,3));

alter table sales drop column Discount;

--Feature Extraction
--creating column 'profit'
alter table sales add column Profit Decimal(15,2);

update sales set Profit = Revenue *0.25;

--add column order_day
alter table sales add column Order_Day INT;
update sales set Order_Day = day(Order_Date);

--add column order_month
alter table sales add column Order_Month INT;
update sales set Order_Month = month(Order_Date);

--add column order_year
alter table sales add column Order_Year INT;
update sales set Order_Year = year(Order_Date);

in sql we use directly in python we use zcore,etc...
--max function
select max(Revenue)
from sales;

--min
select min(Revenue)
from sales;

select max(Modified_Discount)
from sales;

select min(Modified_Discount)
from sales;

select max(Unit_Price)
from sales;

select min(Unit_Price)
from sales;

--Data visualization

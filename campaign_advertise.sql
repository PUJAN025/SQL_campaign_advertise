# cusomer advertising report

create database customer_advertising;
use customer_advertising;
create table customer
(id int,first_name varchar(50),last_name varchar(50));
insert into customer values
(1, "sanjay","sharma"),
(2,"parth","patel"),
(3,"shrestha","vyas");
select * from customer;

create table campaigns
(id int,customer_id varchar(50) ,name varchar(50));
insert into campaigns values
(2,1,"overcoming challenges"),
(4,1,"business rules"),
(3,2,"YUI"),
(1,3,"quantitative finance"),
(5,3,"MMC");
select * from campaigns;

create table events__
(campaign_id int, status varchar(50));
insert into events__ values 
(1,"success"),
(1,"success"),
(2,"success"),
(2,"success"),
(2,"success"),
(2,"success"),
(2,"success"),
(3,"success"),
(3,"success"),
(3,"success"),
(4,"success"),
(4,"success"),
(4,"failure"),
(4,"failure"),
(5,"failure"),
(5,"failure"),
(5,"failure"),
(5,"failure"),
(5,"failure"),
(5,"failure");

select * from events__;


with cte as
(
select e.status as event_type, 
concat(cu.first_name, ' ', cu.last_name) as customer,
group_concat(distinct c.name separator ', ') as campaign,
count(e.status) as total,
rank() over (partition by e.status order by count(e.status) desc) as rnk

from events__ e join campaigns c on e.campaign_id = c.id
join customer cu on c.customer_id = cu.id
group by customer, e.status
order by e.status, total desc
)

select event_type,customer,campaign,total from cte
where rnk=1
order by event_type desc;
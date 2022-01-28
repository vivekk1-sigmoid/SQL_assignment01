select * from giraffe.airbnb_calendar;
desc giraffe.airbnb_calendar;




/*Q1*/
select max(date), min(date) from giraffe.airbnb_calendar;

/*Q2*/
/*Q2.1*/
select  listing_id, date, count(*) as freq from giraffe.airbnb_calendar
group by listing_id, date
having freq>1;

/*Q2.2*/
select distinct * from giraffe.airbnb_calendar;

/*Q3*/
drop table availab;
create table availab (
	listing_id int primary key,
    available int,
    not_available int,
    total int,
    percentage decimal(5, 2)
);
insert into availab
	select listing_id, sum(available = 't'), sum(available = 'f'), count(*),
	 sum(available = 't')/count(*)*100 from giraffe.airbnb_calendar group by listing_id;
select * from availab;

/*Q4*/
/*Q4.1*/
select count(*) as available_more_50per from availability where percentage > 50;

/*Q4.2*/
select count(*) as available_more_75per from availability where percentage > 75;

/*5*/

update giraffe.airbnb_calendar set price=NULL where price=' ';
update giraffe.airbnb_calendar set price=TRIM(LEADING '$' from price);


/*In the below cmd there is some problem */
alter table giraffe.airbnb_calendar modify price decimal (5, 2);
/*drop table price_range;*/
create table price_range(
	id int primary key,
    min_price int,
    max_price int,
    avg_price decimal(5, 2)
);

insert into price_range
	select listing_id, min(price), max(price),
		avg(price) from giraffe.airbnb_calendar group by listing_id;
    
select * from price_range;


/*Q6*/
select * from price_range where avg_price > 500;





sp_help club_item;
sp_columns club_item;
--查询大sql 所有记录
select
 count(1) 
from item it 
inner join offer_item as oi on cast(it.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id
inner join club_item ci on ci.item_nbr= it.item_nbr and club_nbr=4969 and ci.item_status_code in ('A','S','O','C') 
left join inventory inv on it.item_nbr=inv.item_nbr
where it.dept_nbr='50'
and it.subclass_nbr !='61' --special order

select count(inv.item_nbr),inv.item_nbr from inventory inv group by item_nbr having count(inv.item_nbr)>1

--etl 缓存
select
--count(1)  --8416
top 100 i.item_nbr,i.subclass_nbr,i.item1_desc,i.item2_desc,i.upc_nbr,i.signing_desc2,i.vendor_nbr,i.unit_cost_amt,i.item_status_code,i.units_sold,i.load_range,i.vendor_stock_id,o.Side_Wall,o.long_Desc,o.Tire_Diameter,o.Specifications,o.Brand,o.Short_Desc,o.Load_Index,o.Product_Name,o.Product_Id,o.Tire_Ratio,o.Tire_Width,o.Speed_Rating,o.Image_URL,cast(t.avg_mileage as int) as avg_mileage,t.responsiveness,t.wet_handling,t.winter_traction,t.ride_comfort,t.off_road,t.mileage
from item as i 
inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id 
left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc
 where dept_nbr=50

 --查询库存
select ci.club_nbr,ci.item_nbr,ci.unit_retail_amt,ci.item_status_code,inv.on_hand_qty,inv.node_type 
from club_item as ci 
left join inventory as inv on ci.item_nbr=inv.item_nbr 
and cast(ci.club_nbr as varchar(16))=inv.ship_node 
and inv.node_type='I' where ci.club_nbr=4969 
and ci.item_status_code in ('A','S','O','C')

select top 100 * from vendor_club_mapping
 
 select top 1000 * from item  it where it.dept_nbr ='82' and item_nbr='980083903'
 select * from item where item_nbr='21918'
 select * from offer_item where item_nbr='21918'  --itemId 13791	prod12850150	21918
 select * from offer where Product_Id ='prod12850150'
 select top 100 * from vendor_club_mapping where vendor_nbr = '1012013';

select count(1) from item  it where it.dept_nbr ='82' and it.item_nbr in(select item.item_nbr from item where item_nbr='50')

select count(1) from item where dept_nbr='50';
select * from item where item_nbr='21918'
--itemId =21918   -->980083903



select top 100 * from offer where id='3184024'; --3184024

select top 100 * from job_record order by id desc;


CREATE TABLE job_record (
	id int identity(1,1) primary key,
	job_id varchar(100) ,
	partition_key varchar(100),
	job_type int,
	start_time datetime,
	duration_sec varchar(20),
	end_time datetime,
	status varchar(20),
	server_name varchar(100),
	server_ip varchar(20),
	process_id int,
	name varchar(20),
	handle_user_id varchar(50),
	properties nvarchar(4000),
);

select * fr
drop table job_record
alter table job_record alter column id varchar(50)
--美国sql
select i.vendor_nbr, inv.on_hand_qty from inventory inv, item i, vendor_club_mapping vcm 
where i.item_nbr = inv.item_nbr
and inv.ship_node = vcm.vendor_ship_node 
and i.vendor_nbr = vcm.vendor_nbr
and i.item_nbr = 449005
and vcm.sams_ship_node = 4969
and inv.node_type = 'V'
select top 100 * from vendor_club_mapping order by sams_ship_node;

select * from item where item_nbr in (980168609,980168610,980168611) and subclass_nbr !=61 ;
select * from inventory where  item_nbr in (980168609,980168610,980168611) and node_type ='V';


--查询 special order 
select inv.item_nbr,sum(inv.on_hand_qty) as on_hand_qty
                 from inventory as inv inner join vendor_club_mapping as v on inv.ship_node=v.vendor_ship_node
                inner join item as i on i.item_nbr=inv.item_nbr and i.vendor_nbr=v.vendor_nbr
                where v.sams_ship_node='4969'
                and inv.node_type='V'
                and inv.item_nbr not in (select item_nbr from inventory where inv.ship_node='4969' and inv.node_type='I')
                group by inv.item_nbr;


select count(e.item_nbr),e.item_nbr from
(select ci.club_nbr,ci.item_nbr,ci.unit_retail_amt,ci.item_status_code,i.on_hand_qty,i.node_type 
from club_item as ci 
left join inventory as i 
on ci.item_nbr=i.item_nbr and cast(ci.club_nbr as varchar(16))=i.ship_node and i.node_type='I' where ci.club_nbr=4969 and ci.item_status_code in ('A','S','O','C') )as e group by e.item_nbr having count(e.item_nbr)

--tbc获取库存信息inclub
select inv.on_hand_qty from item as i
 inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
 inner join offer as o on o.Product_Id=oi.Product_Id 
 left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc
  where i.dept_nbr=50
and i.item_nbr not in(
select i.item_nbr as item_nbr from item as i 
inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id 
left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc 
inner join club_item ci on ci.item_nbr=i.item_nbr 
left join inventory as inv on  ci.item_nbr=i.item_nbr and cast(ci.club_nbr as varchar(16))=inv.ship_node and inv.node_type ='v' 
where ci.club_nbr=4969 and ci.item_status_code in ('A','S','O','C') and i.subclass_nbr =61 and  i.dept_nbr=50) ;

--查询spec
select count(1) 
--i.item_nbr as item_nbr 
from item as i 
inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id 
left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc 
inner join club_item ci on ci.item_nbr=i.item_nbr 
left join inventory as inv on  ci.item_nbr=i.item_nbr and cast(ci.club_nbr as varchar(16))=inv.ship_node and inv.node_type ='v' 
where ci.club_nbr=4969 and ci.item_status_code in ('A','S','O','C') and i.subclass_nbr =61 and  i.dept_nbr=50


select count(1) from item as i 
inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id 
left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc 
inner join club_item ci on ci.item_nbr=i.item_nbr 
left join inventory as inv on  ci.item_nbr=i.item_nbr and cast(ci.club_nbr as varchar(16))=inv.ship_node and inv.node_type ='v' 
where ci.club_nbr=4969 and ci.item_status_code in ('A','S','O','C') and i.subclass_nbr =61 and  i.dept_nbr=50

select i.item_nbr,inv.on_hand_qty,inv.node_typefrom offer o ,club_item ci ,inventory inv ,item i where i.dept_nbr = 50and ci.item_nbr = i.item_nbrand i.item_nbr = inv.item_nbrand inv.ship_node = 4969and inv.node_type='I' 

--查詢库存 spe
select i.item_nbr,inv.on_hand_qty,inv.node_typefrom offer o ,club_item ci ,inventory inv ,item i where i.dept_nbr = 50 and i.subclass_nbr=and ci.item_nbr = i.item_nbrand i.item_nbr = inv.item_nbrand inv.ship_node = 4969and inv.node_type='I' 

--tbc获取item所有信息
select top 100 i.item_nbr,i.subclass_nbr,i.item1_desc,i.item2_desc,i.upc_nbr,i.signing_desc2,i.vendor_nbr,i.unit_cost_amt,i.item_status_code,i.units_sold
,i.load_range,i.vendor_stock_id,o.Side_Wall,o.long_Desc,o.Tire_Diameter,o.Specifications,o.Brand,o.Short_Desc,o.Load_Index,o.Product_Name,o.Product_Id,o.Tire_Ratio,
o.Tire_Width,o.Speed_Rating,o.Image_URL,cast(t.avg_mileage as int) as avg_mileage,t.responsiveness,t.wet_handling,t.winter_traction,t.ride_comfort,t.off_road,
t.mileage from item as i 
inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id 
left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc and o.Brand=t.brand where i.item_nbr in (980129765,18666,24851,12390)

select * from item where item_nbr ='18666'
select * from offer_item where item_nbr in (18666,24851,12390);
--where o.Product_Name not like '% - %'''
-- where i.item1_desc like '%ST%';Cooper Discoverer AT3 4S - 225/75R16 104T'215/55R17 94V WRDY'

select SUBSTRING(a.item1_desc,1,(charindex(' ',a.item1_desc))) as e,a.item1_desc as e from (select top 100 i.item_nbr,i.subclass_nbr,i.item1_desc,i.item2_desc,i.upc_nbr,i.signing_desc2,i.vendor_nbr,i.unit_cost_amt,i.item_status_code,i.units_sold
,i.load_range,i.vendor_stock_id,o.Side_Wall,o.long_Desc,o.Tire_Diameter,o.Specifications,o.Brand,o.Short_Desc,o.Load_Index,o.Product_Name,o.Product_Id,o.Tire_Ratio,
o.Tire_Width,o.Speed_Rating,o.Image_URL,cast(t.avg_mileage as int) as avg_mileage,t.responsiveness,t.wet_handling,t.winter_traction,t.ride_comfort,t.off_road,
t.mileage from item as i 
inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr 
inner join offer as o on o.Product_Id=oi.Product_Id 
left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc and o.Brand=t.brand) as a

select * from offer where Product_Name like '%12.50R15C%'

select top 10 ci.club_nbr,ci.item_nbr,ci.unit_retail_amt,ci.item_status_code,i.on_hand_qty from club_item as ci left join inventory as i on ci.item_nbr=i.item_nbr and cast(ci.club_nbr as varchar(16))=i.ship_node where  ci.item_status_code in ('A','S','O','C')

select top 10 * from offer where Product_Name ='';

--special order mapping
select top 100 * from vendor_club_mapping order by sams_ship_node ;
select distinct sams_ship_node from vendor_club_mapping order by sams_ship_node ;

select count(1) from inventory

select  count(1) from item  as i inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr and i.subclass_nbr='61' and i.fineline_nbr='10'
inner join offer as o on o.Product_Id=oi.Product_Id left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc and o.Brand=t.brand 
order by i.item_nbr  offset 20 rows fetch next 20 rows only 

select top 10 * i.item_nbr,i.subclass_nbr,i.item1_desc,i.item2_desc,i.upc_nbr,i.signing_desc2,i.vendor_nbr,i.unit_cost_amt,i.item_status_code,i.units_sold,i.load_range,i.vendor_stock_id,o.Side_Wall,o.long_Desc,o.Tire_Diameter,o.Specifications,o.Brand,o.Short_Desc,o.Load_Index,o.Product_Name,o.Product_Id,o.Tire_Ratio,o.Tire_Width,o.Speed_Rating,o.Image_URL ,t.avg_mileage,t.responsiveness,t.wet_handling,t.winter_traction,t.ride_comfort,t.off_road,t.mileage from item as i left join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr left join offer as o on o.Product_Id=oi.Product_Id left join tireLineRating  as t on i.signing_desc2 = t.tire_line_signing_2_desc and o.Brand = t.brand and mileage is not null

select top 10 item_nbr,link_item_nbr from linked_club_item;
select top 10 * from linked_club_item;

select top 100 * from acquire_job order by job_schedule_time desc

select count(1) from club_item where club_nbr=;

select id,item_nbr,dept_nbr,signing_desc2 from item  where dept_nbr='82' order by  id  offset 5 rows fetch next 5 rows only 
select top 100 * from item where dept_nbr='82' and item_nbr='980083903' order by  id ;

select count(item_nbr) ,item_nbr from item where dept_nbr='82' group by item_nbr having count(item_nbr)>1;

select top 100 * from item where dept_nbr='82' and id='776990' order by  id ;

select top 100 * from item ;
select count(subclass_nbr),subclass_nbr from item where dept_nbr='82' group by subclass_nbr
select count(1) from item where dept_nbr='82'  and
='46';  --40466  --1748
select count(subclass_nbr),subclass_nbr from item where dept_nbr='82' group by subclass_nbr;  --40466  --1748

select count(1) from item where dept_nbr='82'    and vendor_dept_nbr ='61' 

select top 10 * from item where  item_nbr in('980075353','980083903')  ;--dept_nbr='82'  and

select count(1) from club_item where club_nbr in(4969,6217,5513,4919,6279,6643,8211,8203,6646,8287,8166,8209) ;

select  * from inventory where ship_node in('4969','6217','5513','4919','6279','6643','8211','8203','6646','8287','8166','8209');

select top 10 * from linked_club_item;
select count(1) from linked_club_item where club_nbr in(4969,6217,5513,4919,6279,6643,8211,8203,6646,8287,8166,8209) ;


select count(1) from item;

select count(*) from (select * from item where item_nbr in (select link_item_nbr from linked_club_item)) w 


select * from item where item_nbr in (select link_item_nbr from linked_club_item)

--select * from  systypes where name collate SQL_Latin1_General_CP1_CS_AS ='Image' 
select distinct side_wall from  offer  where side_wall  collate SQL_Latin1_General_CP1_CS_AS not in ('Black circumferential serration','Black letters','Black sdewall','Black serrated letters','Black sidewall'
,'Black sidewall','Broken serrated band','Diagonal serrated band','Extra-narrow white stripe','Outlined raised white letters','Outlined white letters','Raised Black'
,'Raised black letters','Raised serrated band','Raised white letters','Raised white letters ','Serrated black letters','Vertical serrated band','Vertically serrated broken band'
,'Vertically serrated undulating band','Vertically serrated unevenly broken band','White sidewall') order by side_wall;


select distinct load_index from offer where ISNUMERIC(load_index)=0?

--SELECT * FROM TABLE WHERE ISNUMERIC(COLUMN)=0
select distinct collate SQL_Latin1_General_CP1_CS_AS  side_wall from  offer  where side_wall is not null

insert into dbo 'Raised white letters '


select distinct lf

select * from(
	select distinct ltrim(rtrim(side_wall))  collate SQL_Latin1_General_CP1_CS_AS as a from offer
) where a collate SQL_Latin1_General_CP1_CS_AS not in('Black circumferential serration','Black letters','Black sdewall','Black serrated letters','Black sidewall'  ,'Black sidewall','Broken serrated band','Diagonal serrated band','Extra-narrow white stripe','Outlined raised white letters','Outlined white letters','Raised Black'  ,'Raised black letters','Raised serrated band','Raised white letters','Raised white letters?','Serrated black letters','Vertical serrated band','Vertically serrated broken band'  ,'Vertically serrated undulating band','Vertically serrated unevenly broken band','White sidewall') order by side_wall;


select * from(
	select distinct ltrim(rtrim(side_wall))  collate SQL_Latin1_General_CP1_CS_AS as a from offer
)as b where a collate SQL_Latin1_General_CP1_CS_AS not in('Black circumferential serration','Black letters','Black sdewall','Black serrated letters','Black sidewall'  ,'Black sidewall','Broken serrated band','Diagonal serrated band','Extra-narrow white stripe','Outlined raised white letters','Outlined white letters','Raised Black'  ,'Raised black letters','Raised serrated band','Raised white letters','Raised white letters?','Serrated black letters','Vertical serrated band','Vertically serrated broken band'  ,'Vertically serrated undulating band','Vertically serrated unevenly broken band','White sidewall') order by a;

select distinct ltrim(rtrim(side_wall)) collate SQL_Latin1_General_CP1_CS_AS as source_value from  offer order by source_value 


select i.item_nbr,i.subclass_nbr,i.item1_desc,i.item2_desc,i.upc_nbr,i.signing_desc2,i.vendor_nbr,i.unit_cost_amt,i.item_status_code,i.units_sold,i.load_range,i.vendor_stock_id,o.Side_Wall,o.long_Desc,o.Tire_Diameter,o.Specifications,o.Brand,o.Short_Desc,o.Load_Index,o.Product_Name,o.Product_Id,o.Tire_Ratio,o.Tire_Width,o.Speed_Rating,o.Image_URL,cast(t.avg_mileage as int) as avg_mileage,t.responsiveness,t.wet_handling,t.winter_traction,t.ride_comfort,t.off_road,t.mileage from item as i inner join offer_item as oi on cast(i.item_nbr as varchar(16))=oi.Item_Nbr inner join offer as o on o.Product_Id=oi.Product_Id left join tireLineRating as t on i.signing_desc2=t.tire_line_signing_2_desc and o.Brand=t.brand


select distinct ltrim(rtrim(side_wall)) collate SQL_Latin1_General_CP1_CS_AS  as b from  offer order by b

select distinct ltrim(rtrim(side_wall)) collate SQL_Latin1_General_CP1_CS_AS  from  offer  where side_wall  collate SQL_Latin1_General_CP1_CS_AS not in ('Black circumferential serration','Black letters','Black sdewall','Black serrated letters','Black sidewall'  ,'Black sidewall','Broken serrated band','Diagonal serrated band','Extra-narrow white stripe','Outlined raised white letters','Outlined white letters','Raised Black'  ,'Raised black letters','Raised serrated band','Raised white letters','Raised white letters?','Serrated black letters','Vertical serrated band','Vertically serrated broken band'  ,'Vertically serrated undulating band','Vertically serrated unevenly broken band','White sidewall') order by side_wall;
select * from dbo.student;

CREATE TABLE special_column_mapping (
	id int identity(1,1),
	source_value varchar(100),
	target_value varchar(100),
	status_code int
);

insert into special_column_mapping(source_value) select source_value from Query where source_value is not null

select * from special_column_mapping;
alter table special_column_mapping add  column_name varchar(50)


select ri from Query

update special_column_mapping set column_name='side_wall',table_name='offer'

update special_column_mapping set target_value='Black sidewall',status_code=1,remark='单词拼错' where id=4
update special_column_mapping set target_value='Black serrated letters',status_code=1,remark='非首字母大写' where id=5
update special_column_mapping set target_value='Black sidewall',status_code=1,remark='非首字母大写' where id=7
update special_column_mapping set target_value='Black sidewall',status_code=1,remark='含特殊字符' where id=9
update special_column_mapping set target_value='Black sidewall',status_code=1,remark='单词拼错' where id=11
update special_column_mapping set target_value='Broken serrated band',status_code=1,remark='非首字母大写' where id=12
update special_column_mapping set target_value='Diagonal serrated band',status_code=1,remark='非首字母大写' where id=14
update special_column_mapping set target_value='Outlined raised white letters',status_code=1,remark='非首字母大写' where id=17
update special_column_mapping set target_value='Outlined white letters',status_code=1,remark='非首字母大写' where id=19
update special_column_mapping set target_value='Raised black',status_code=1,remark='非首字母大写' where id=21
update special_column_mapping set target_value='Raised black letters',status_code=1,remark='非首字母大写' where id=22
update special_column_mapping set target_value='Raised white letters',status_code=1,remark='非首字母大写' where id=25
update special_column_mapping set target_value='Raised white letters',status_code=1,remark='含特殊字符' where id=27
update special_column_mapping set target_value='Raised white letters',status_code=1,remark='含特殊空格字符' where id=28

update special_column_mapping set target_value='Vertical serrated band',status_code=1,remark='非首字母大写' where id=30

select * from [dbo].[monitor_result_value_exception]
[dbo].[monitor_result_value_exception]
select monitor_column,check_expression from monitor_special_columns;

select top 10 *  from  item

--数据结构变化
select top 1000 * from monitor_datastructure  where table_name='club_item' order by monitor_date desc ; 

--数据变化
select * from monitor_data_version  order by monitor_date desc; 

--查看监控结果 表字段变化
select monitor_date as monitorDate ,table_name as  tableName,column_changed_content as 'desc' from monitor_result_column_changed where monitor_date='2019-02-21' order by monitor_date desc;
--查看监控结果，表改变
select * from monitor_result_table_changed order by monitor_date desc;

select max(monitor_date) from monitor_table_infoAndcount where monitor_date<@monitor_date;

exec monitor_data_structure_check '2019-02-21'

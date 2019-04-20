

drop table if exists move_marketinglist.crm_targetmonth
;

create table move_marketinglist.crm_targetmonth
select *
from move_marketinglist.crm_latest
where `Campaign Name` like '%${target_month_name}%'
;


drop table if exists move_marketinglist.target_marketinglist
;

create table move_marketinglist.target_marketinglist
select *
from move_marketinglist.iaps_campaign_marketinglist c
where c.Name like replace('%${target_month_name}%',',','')	
;


drop table if exists move_marketinglist.new_marketinglist
;

create table move_marketinglist.new_marketinglist
select b.`(Do Not Modify) Lead`
		,b.`(Do Not Modify) Modified On`
		,b.`(Do Not Modify) Row Checksum`
		,b.Campaign
		,b.`Marketing List`
		,c.Name
from move_marketinglist.crm_targetmonth a
left join move_marketinglist.iaps_evolution b
	on a.`Lead ID`=b.`(Do Not Modify) Lead`
left join move_marketinglist.target_marketinglist c
	on b.Campaign=c.`Name (Campaign) (Campaign)` 
;
	

drop table if exists move_marketinglist.final_output
;

create table move_marketinglist.final_output
select `(Do Not Modify) Lead`
		,`(Do Not Modify) Row Checksum`
		,`(Do Not Modify) Modified On`
		,Name `Marketing List`
from move_marketinglist.new_marketinglist
where `(Do Not Modify) Lead` is not null
	and `Marketing List`<>Name

	
	
	
	


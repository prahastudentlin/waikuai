
drop table if exists stage_${country_code}.iaps_not_crm
;

create table stage_${country_code}.iaps_not_crm as
select a.*
from stage_${country_code}.iaps_latest a
left join stage_${country_code}.crm_latest b
	on a.`(Do Not Modify) Lead`=b.`Lead ID`
where b.`Lead ID` is null
;


drop table if exists stage_${country_code}.for_crm
;
create table stage_${country_code}.for_crm as
select null `(Do Not Modify) Customer`
		,null `(Do Not Modify) Row Checksum`
		,null `(Do Not Modify) Modified On`
		,(select Projects 
			from public.crm_project_campaign 
			where `Fiscal Month`='${fiscal_month_name}' 
			and `Subsidiary (Projects) (Projects)`='${country_name}'
			and `Engagement Type (Projects) (Projects)` in ('Compliance VL','Whitespace')
		) `Project Name`
		,(select `Name` 
			from public.crm_project_campaign 
			where `Fiscal Month`='${fiscal_month_name}' 
			and `Subsidiary (Projects) (Projects)`='${country_name}'
			and `Engagement Type (Projects) (Projects)` in ('Compliance VL','Whitespace')
		) `Campaign Name`
		,convert(@n := @n +1, varchar(10)) `Customer ID`
		,`Multiple TPID`
		,`Account Name` `Company Name`
		,null `Other Company Name`
		,`Address 1` `Address`
		,`City`
		,`ZIP/Postal Code` `Postal Code`
		,`State/Province`
		,`Country`
		,`Preferred Language` `Language`
		,`Org Phone Number` `Company Phone`
		,null `Company Email`
		,null `Company Website`
		,null `Number of Workstations`
		,null `Number of Employess`
		,'To Be Contacted'  `Call Status`
		,'Qualify 10%' `Sales Stage`
		,null `Next Action Date`
		,`(Do Not Modify) Lead` `Lead ID`
		,`Start Engagement Date`
		,`Start Engagement Date` `Revenue Recognition Start Date`
		,`Revenue Recognition Expiration` `Revenue Recognition End Date`
		,'${owner}' `Owner`
		,'${owner_alias}' `Owner Alias`
from stage_${country_code}.iaps_not_crm, (SELECT @n := ${customer_id}) m
limit ${assign_amount}
;



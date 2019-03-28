
drop table if exists stage_${country}.iaps_not_crm
;

create table stage_${country}.iaps_not_crm as
select a.*
from stage_${country}.iaps_latest a
left join stage_${country}.crm_latest b
	on a.`(Do Not Modify) Lead`=b.`Lead ID`
where b.`Lead ID` is null
;


drop table if exists stage_${country}.for_crm
;
create table stage_${country}.for_crm as
select null `(Do Not Modify) Customer`
		,null `(Do Not Modify) Row Checksum`
		,null `(Do Not Modify) Modified On`
		,'${project_name}' `Project Name`
		,'${campaign_name}' `Campaign Name`
		,convert(${customer_id}, varchar(10)) `Customer ID`
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
from stage_${country}.iaps_not_crm
limit ${assign_amount}
;




drop table if exists stage_${country}.iaps_not_crm
;

create table stage_${country}.iaps_not_crm as
select *
from stage_${country}.iaps_latest
where `(Do Not Modify) Lead` not in (select `Lead ID` from stage_${country}.crm_latest)
;


drop table if exists stage_${country}.for_crm
;
create table stage_${country}.for_crm as
select null `(Do Not Modify) Customer`
		,null `(Do Not Modify) Row Checksum`
		,null `(Do Not Modify) Modified On`
		,'${project_name}' `Project Name`
		,'${campaign_name}' `Campaign Name`
		,null `Customer ID`
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


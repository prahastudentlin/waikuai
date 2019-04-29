
drop table if exists mss.mss_forconsultants
;

create table mss.mss_forconsultants
select `End Customer Top Parent Organization Name`
		,`End Customer Top Parent Organization ID`
		,`End Customer Address1`
		,`End Customer City`
		,`Usage Subsidiary`
		,null `Lead ID`		
		,null `Customer ID`
from mss.mss_latest
group by 1,2,3,4
order by 1,2,3,4
;







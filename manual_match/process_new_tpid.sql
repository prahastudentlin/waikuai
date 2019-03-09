

drop table if exists manualmatch.iaps_split
;
create table manualmatch.iaps_split as
select a.`(Do Not Modify) Lead` lead_id
		,substring_index(substring_index(a.`Multiple TPID`,';',b.num),';',-1) tpid
from manualmatch.from_iaps a
join public.numbers b
on b.num<=length(replace(a.`Multiple TPID`,';',';;'))-length(a.`Multiple TPID`)+1
;


drop table if exists manualmatch.tpid_union
;
create table manualmatch.tpid_union as
select distinct lead_id
		,tpid
from 
(
select *
from manualmatch.iaps_split
union all
select `Lead ID`
		,`End Customer Top Parent Organization ID`
from manualmatch.from_consultants
) a
order by 1,2
;


drop table if exists manualmatch.tpid_multiple
;
create table manualmatch.tpid_multiple as
select lead_id
		,GROUP_CONCAT(tpid SEPARATOR ';') multipe_tpid
from manualmatch.tpid_union
group by lead_id
;

----------------------------------------------

drop table if exists manualmatch.comparison
;
create table manualmatch.comparison as
select a.`(Do Not Modify) Lead`
		,a.`(Do Not Modify) Row Checksum`
		,a.`(Do Not Modify) Modified On`
		,a.`Multiple TPID`
		,b.multipe_tpid
		,case when a.`Multiple TPID`=b.multipe_tpid then 0 else 1 end updated
from manualmatch.from_iaps a
inner join manualmatch.tpid_multiple b
on a.`(Do Not Modify) Lead`=b.lead_id
;


drop table if exists manualmatch.for_iaps
;
create table manualmatch.for_iaps as
select `(Do Not Modify) Lead`
		,`(Do Not Modify) Row Checksum`
		,`(Do Not Modify) Modified On`
		,multipe_tpid `Multiple TPID`
from manualmatch.comparison
where updated=1
;


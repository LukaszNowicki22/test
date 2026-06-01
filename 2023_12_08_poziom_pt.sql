; With doba As (
Select 

	  year_number
	, Sum(Case When year_number < 2022 Then provys_real_eq_grp_A1649
	
			Else provys_real_eq_grp_A1659 End)  AS GRP_doba

From rap.client

where chanlx_id not in (71) and sptpvs_id = 7

Group By year_number

),

off_day As (
Select 

	  year_number
	, Sum(Case When year_number < 2022 Then provys_real_eq_grp_A1649
	
			Else provys_real_eq_grp_A1659 End)  AS GRP_off

From rap.client

where chanlx_id not in (71) and daypart = 'OFF' and sptpvs_id = 7

Group By year_number
),

pt_day As (
Select 

	  year_number
	, Sum(Case When year_number < 2022 Then provys_real_eq_grp_A1649
	
			Else provys_real_eq_grp_A1659 End)  AS GRP_pt

From rap.client

where chanlx_id not in (71) and daypart = 'PT' and sptpvs_id = 7

Group By year_number
)

Select

 dba.year_number
,dba.GRP_doba
,ofd.GRP_off
,ptd.GRP_pt
,ptd.GRP_pt/dba.GRP_doba AS udzial_pt

From doba As dba

Join off_day as ofd on ofd.year_number = dba.year_number
Join pt_day	as	ptd on ptd.year_number = dba.year_number

Order by dba.year_number
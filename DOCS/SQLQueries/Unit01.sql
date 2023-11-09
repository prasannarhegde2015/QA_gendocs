use unit01
Select count(*)  from Job  where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100)
--Exclude  and System Jobs  and Template Jobs
DECLARE @PJ INT, @RJ INT, @CJ INT, @NJ INT
set @NJ= 18
set @PJ = 7
Set @RJ = 4
set @CJ = 3

Update job set jobFK_r_JobStatus=1 where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100) --Update to Some Dummay Key 
Update job set jobFK_r_JobStatus=@NJ where jobPrimaryKey in 
(Select top 10009 jobPrimaryKey from Job 
  where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100)
  order by NEWID()
)
Update job set jobFK_r_JobStatus=7 where jobPrimaryKey in
 (Select top 5000 jobPrimaryKey from Job 
 where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100) and 
 jobFK_r_JobStatus <> @NJ
 order by NEWID()
 )


Update job set jobFK_r_JobStatus=4 where jobPrimaryKey in 
(
	Select top 5000 jobPrimaryKey from Job 
	where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100)
	 and jobFK_r_JobStatus <> @NJ
	 and jobFK_r_JobStatus <> @PJ
	order by NEWID()
)
Update job set jobFK_r_JobStatus=3 where jobPrimaryKey in  
(
	Select top 5000 jobPrimaryKey from Job 
	where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100) 
	and jobFK_r_JobStatus <>  @NJ  
	and jobFK_r_JobStatus <>  @PJ
	and jobFK_r_JobStatus <>  @RJ
	order by NEWID()
)

use Foresite_VS


--Exclude  and System Jobs  and Template Jobs
DECLARE @PJ BIGINT, @RJ BIGINT, @CJ BIGINT, @NJ BIGINT,@TotalJobs BIGINT, @jobcount BIGINT, @jobcountfornostatus BIGINT
set @TotalJobs = -1
set @NJ= 1002408265751
set @PJ = 1002408265735
Set @RJ = 1002408265731
set @CJ = 1002408265729
set @TotalJobs = (Select count(*)  from Job  where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100))
set @jobcount = 10000 --- Update as per DB
set @jobcountfornostatus = @TotalJobs - (3 *  @jobcount) --- Update  as per DB
print @jobcountfornostatus

Update job set jobFK_r_JobStatus=1 where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100) --Update to Some Dummay Key 
Update job set jobFK_r_JobStatus=@NJ where jobPrimaryKey in 
(Select top (@jobcountfornostatus) jobPrimaryKey from Job 
  where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100)
  order by NEWID()
)
Update job set jobFK_r_JobStatus=@PJ where jobPrimaryKey in
 (Select top (@jobcount) jobPrimaryKey from Job 
 where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100) and 
 jobFK_r_JobStatus <> @NJ
 order by NEWID()
 )


Update job set jobFK_r_JobStatus=@RJ where jobPrimaryKey in 
(
	Select top (@jobcount) jobPrimaryKey from Job 
	where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100)
	 and jobFK_r_JobStatus <> @NJ
	 and jobFK_r_JobStatus <> @PJ
	order by NEWID()
)
Update job set jobFK_r_JobStatus=@CJ where jobPrimaryKey in  
(
	Select top (@jobcount) jobPrimaryKey from Job 
	where jobPrimaryKey not in ( -100,-200,-300) and jobFK_Assembly not in (-100) 
	and jobFK_r_JobStatus <>  @NJ  
	and jobFK_r_JobStatus <>  @PJ
	and jobFK_r_JobStatus <>  @RJ
	order by NEWID()
)

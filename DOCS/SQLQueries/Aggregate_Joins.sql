use POP

Select W.welWellName "WellNAme"  from Well W
inner join DataConnection
 on W.welFK_DataConnection = DataConnection.dacPrimaryKey
 where dacProductionDomain=9077
 --Query to find the number of concluded jobs in Job Table
 Select * from Job

 Select count(*) as "Count",r_JobStatus.mgsMessageStatus from Job
 Inner Join r_JobStatus ON job.jobFK_r_JobStatus = r_JobStatus.mgsPrimaryKey
 Group By r_JobStatus.mgsMessageStatus

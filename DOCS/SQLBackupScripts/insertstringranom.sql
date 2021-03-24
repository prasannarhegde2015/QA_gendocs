use POP431
DECLARE @Varcntr int  = 1
DECLARE @randname varchar(500) 
DECLARE @index INT
DECLARE @WellCount int = 358

-- Insert Random GeopgrpahicREgions
set @Varcntr = 0
WHILE  (@Varcntr   < @WellCount)
BEGIN
  SET  @index = CAST(RAND()*(6)+1 AS INT)   
  Update Well set welGeographicRegion =  CHOOSE( @index ,'Asia','Australia','Africa' ,'Europe','North America','South America') where welPrimaryKey = @Varcntr
  set @Varcntr = @Varcntr +1
END 
set @Varcntr = 0
--Insert Random Engineer Names
WHILE  (@Varcntr   < @WellCount)
BEGIN
  SET  @index = CAST(RAND()*(9)+1 AS INT)   
  Update Well set welEngineer =  CHOOSE( @index ,'Anit','Hardik','Hima' ,'Prasanna','Pravin','Sudhir','Vandana','Ritu','Swati') where welPrimaryKey = @Varcntr
  set @Varcntr = @Varcntr +1
END 

Select welWellName , welEngineer, welGeographicRegion from Well 

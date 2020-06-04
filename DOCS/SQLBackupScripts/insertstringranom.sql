
DECLARE @Varcntr int  = 1
DECLARE @randname varchar(500) 
DECLARE @index INT


WHILE  (@Varcntr   < 378)
BEGIN
  SET  @index = CAST(RAND()*(6)+1 AS INT)   
  Update Well set welGeographicRegion =  CHOOSE( @index ,'Asia','Australia','Africa' ,'Europse','North America','South America') where welPrimaryKey = @Varcntr
  set @Varcntr = @Varcntr +1
END 


Select welWellName , welGeographicRegion from Well where welGeographicRegion= 'Africa'

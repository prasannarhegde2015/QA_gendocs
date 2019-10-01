

DECLARE @Counter INT, @TotalCount INT, @UserId INT
SET @TotalCount = (SELECT COUNT(*) FROM Permission)
SET @Counter = 1
WHILE (@Counter <=@TotalCount)
BEGIN
--select TOP 1 @ID = altPrimaryKey FROM r_AlarmType where altPrimaryKey < 24 ORDER BY NEWID()  
   SELECT TOP (@Counter) @UserId = perPrimaryKey FROM Permission 
    INSERT INTO RoleHasPermission values ( 1, @UserId)
    SET @Counter = @Counter + 1
END


DECLARE @i int = 0 --(Well Start primarykey - 1)
DECLARE @ID int
DECLARE @j int = 365 --No.of Alarms
WHILE @i <= 2000 --Well End Primarykey
BEGIN
                SET @i = @i + 1
                                WHILE @j > 0
                                BEGIN
                                                SET @j = @j - 1
                                                BEGIN                                                                   
                                                                select TOP 1 @ID = altPrimaryKey FROM r_AlarmType where altPrimaryKey < 24 ORDER BY NEWID()  
                                                                Insert into Alarm (almFK_r_AlarmType,almFK_Well,almAlarmOn,almTimestamp,almAlarmValue,almChangeTime,almChangeUserId) values(@ID,@i,1,GETDATE()-@j,109,GETDATE()-@i,3)
                                                                Insert into Alarm (almFK_r_AlarmType,almFK_Well,almAlarmOn,almTimestamp,almAlarmValue,almChangeTime,almChangeUserId) values(@ID,@i,0,GETDATE()-@j+1,109,GETDATE()-@i+1,3)             
                                                END                                       
                                END  
                SET @j = 365
END

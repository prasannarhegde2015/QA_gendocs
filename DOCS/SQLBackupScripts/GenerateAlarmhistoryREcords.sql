-- DATEADD(year,-1,GETDATE())
DECLARE @CurDate Datetime = GETDATE()
DECLARE @VarDate Datetime = DATEADD(YEAR,-4,GETDATE())
DECLARE @VarDateC Datetime =DATEADD(MINUTE, 2, @VarDate)
DECLARE @Varalm int  =RAND()*(200.00 - 50.00)+50.00
DECLARE @Varcntr int  =1
DECLARE @Varalmid int  =RAND()*(103 - 75)+75
DECLARE @Varwellid int  =RAND()*(50 - 0)+0

WHILE (@Varcntr <= 6000000) or  (@VarDate   < @CurDate)
BEGIN
        INSERT INTO HistoricalAlarm(halFK_r_AlarmType,halFK_Well,halStartTime,halNumericValue,halStringValue,halEndTime,halAlarmDeviation)
        VALUES (@Varalmid,@Varwellid,@VarDate,@Varalm,@Varalm,@VarDateC,NULL)
  SET @VarDate = DATEADD(MINUTE, 4, @VarDate)
  SET @VarDateC =DATEADD(MINUTE, 2, @VarDate)
  SET @Varalm   =RAND()*(200.00 - 50.00)+50.00
  SET @Varcntr = @Varcntr +1
  SET @Varalmid   =RAND()*(103 - 75)+75
 SET @Varwellid  =RAND()*(50 - 0)+0
END 

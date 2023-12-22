
use POP
-- User Input -------  Model ID -----------------------------------
DECLARE @SNModelID bigint  = 36  --- 
-- User Input -------  Model ID -----------------------------------
DECLARE @SNScenarioID bigint  = 1
DECLARE @scenariocountforModel bigint  = 1
DECLARE @loopcounter bigint  = 1
DECLARE @welltemp bigint  = 1
DECLARE @WellidsForSceanrio TABLE (id Bigint)
DECLARE @wellcnt bigint  = 1
DECLARE @wellid bigint  = 1
declare @CNTsneuippermodel as bigint
declare @equipidformodel as bigint
declare @equiploopcount as bigint
set @CNTsneuippermodel  = 1
set  @equipidformodel = 1
set @equiploopcount = 1
set @scenariocountforModel  = (select count(*) from SNScenario  A where A.snsFK_SNMModelId=@SNModelID)

WHILE (@loopcounter < @scenariocountforModel)
BEGIN 
set @SNScenarioID  = (select top 1 snsPrimaryKey from SNScenario  A where A.snsFK_SNMModelId=@SNModelID)
Print 'Deleteing SN Scenario ID: ------------- ' + CAST(@SNScenarioID as varchar)
set @wellcnt = (Select count(*) from SNMWell  A where A.snwFK_SNScenario=@SNScenarioID)
WHILE ( @welltemp < @wellcnt + 1 )
BEGIN
set @wellid = (Select  snwPrimaryKey from SNMWell A where A.snwFK_SNScenario=@SNScenarioID order by snwPrimaryKey OFFSET @welltemp -1  rows FETCH next 1 rows only  )
insert into @WellidsForSceanrio values(@wellid)
set @welltemp = @welltemp + 1
END 


delete from SNMCompressor where cmpFK_SNScenario=@SNScenarioID
print '1. Deleted SNMCompressor for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMConnector where  ctrFK_SNScenario=@SNScenarioID
print '2. Deleted SNMConnector for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMConstraint where cnsFK_SNScenario=@SNScenarioID
print '3. Deleted SNMConstraint for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMSocket where sktFK_SNScenario=@SNScenarioID
print '4. Deleted SNMSocket for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMOptimizerParameter where opsFK_SNScenario=@SNScenarioID
print '5. Deleted SNMOptimizerParameter for Scenario ' + CAST(@SNScenarioID as varchar)

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)

Delete from  SNMFluidParameters where flpFK_SNMWell = @wellid
print '6. A Deleted Well s from SNMFluidParameters for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMGLWellWellHeadPressures where gwpFK_SNMWell = @wellid
print '6. B Deleted Well s from SNMGLWellWellHeadPressures for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END


set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMMultiStageSeparator where mssFK_SNMWell = @wellid
print '6. C Deleted Well s from SNMMultiStageSeparator for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMPerformanceSurfaceParameters where pspFK_SNMWell = @wellid
print '6. D  Deleted Well s from SNMPerformanceSurfaceParameters for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END


set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMSourcePriceAndCosts where splFK_SNMWell = @wellid
print '6. E  Deleted Well s from SNMSourcePriceAndCosts for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMWellPerformanceParameter where wppFK_SNMWell = @wellid
print '6. F  Deleted Well s from SNMWellPerformanceParameter for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMGLWellKickoff  where gwkFK_SNMWell = @wellid
print '6. G  Deleted Well s from SNMGLWellKickoff for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMGLWellPerformanceSurface  where grsFK_SNMWell = @wellid
print '6. H  Deleted Well s from SNMGLWellPerformanceSurface for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END

set @welltemp = 1
WHILE (@welltemp < @wellcnt + 1)
BEGIN
set @wellid =  (Select  id from @WellidsForSceanrio order by id OFFSET @welltemp -1  rows FETCH next 1 rows only)
Delete from  SNMPerformanceSurface  where prsFK_SNMWell = @wellid
print '6. I  Deleted Well s from SNMPerformanceSurface for  Well ID ' + CAST(@wellid  as varchar) 
set @welltemp = @welltemp +1
END



--Delete from  SNMGLWellWellHeadPressures where gwpFK_SNMWell in  (@linkedWell1,@linkedWell2,@linkedWell3,@linkedWell4)
--Delete from  SNMMultiStageSeparator where mssFK_SNMWell in  (@linkedWell1,@linkedWell2,@linkedWell3,@linkedWell4)
--Delete from  SNMPerformanceSurfaceParameters where pspFK_SNMWell in (@linkedWell1,@linkedWell2,@linkedWell3,@linkedWell4)
--Delete from  SNMSourcePriceAndCosts  where splFK_SNMWell in (@linkedWell1,@linkedWell2,@linkedWell3,@linkedWell4)
--Delete from  SNMWellPerformanceParameter where wppFK_SNMWell in (@linkedWell1,@linkedWell2,@linkedWell3,@linkedWell4)
Delete from  SNMWell  where snwFK_SNScenario = @SNScenarioID
print '7. Deleted SNMWell for Scenario ' + CAST(@SNScenarioID as varchar)

delete from SNMJunction  where sjuFK_SNScenario=@SNScenarioID
print '8. Deleted SNMJunction for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMPipe  where pipFK_SNScenario=@SNScenarioID
print '9. Deleted SNMPipe for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenarioBlockValveData  where sdfFK_SNScenario=@SNScenarioID
print '10. Deleted SNScenarioBlockValveData for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenarioChokeData  where scdFK_SNScenario=@SNScenarioID
print '11. Deleted SNScenarioChokeData for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenarioWellData  where swdFK_SNScenario=@SNScenarioID
print '12. Deleted SNScenarioWellData for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenarioPressureConstraintData where spcFK_SNScenario=@SNScenarioID
print '13. Deleted SNScenarioPressureConstraintData for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenarioGasConstraintData  where sgcFK_SNScenario=@SNScenarioID
print '14. Deleted SNScenarioGasConstraintData for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenarioLiquidConstraintData where slcFK_SNScenario=@SNScenarioID
print '15. Deleted SNScenarioLiquidConstraintData for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMSeparatorStage  where ssgFK_SNScenario=@SNScenarioID
print '16. Deleted SNMSeparatorStage for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMSink  where snkFK_SNScenario=@SNScenarioID
print '17. Deleted SNMSink for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMBlockValve   where bkvFK_SNScenario =@SNScenarioID
print '18. Deleted SNMBlockValve for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNMChoke   where chkFK_SNScenario=@SNScenarioID
print '19. Deleted SNMChoke for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNScenario where snsPrimaryKey =@SNScenarioID
print '20 . Deleted SNScenario for Scenario ' + CAST(@SNScenarioID as varchar)
set @loopcounter = @loopcounter + 1;
END


set @CNTsneuippermodel = (Select count(*) from SNMEquipment  where eqpFK_SNMModelId = @SNModelID)
WHILE (@equiploopcount < @CNTsneuippermodel )
BEGIN
set @equipidformodel = (Select eqpPrimaryKey from SNMEquipment  where eqpFK_SNMModelId = @SNModelID order by eqpPrimaryKey OFFSET @equiploopcount -1  rows FETCH next 1 rows only)

Delete from SNMWellMapping where wmpFK_SNMEquipment = @equipidformodel
print '21_1 Deleted SNMWellMapping for related Equipemt Id' + cast(@equipidformodel as varchar) + ' for model Id ' 
set @equiploopcount = @equiploopcount + 1

END

delete from SNMEquipment  where eqpFK_SNMModelId=@SNModelID
print '21. Deleted SNMEquipment for Scenario ' + CAST(@SNScenarioID as varchar)
delete from SNEquipmentCygNetMapping where secFK_SNMModel=@SNModelID
print '22. Deleted SNEquipmentCygNetMapping for Scenario ' + CAST(@SNScenarioID as varchar)


delete from SNMModel where smmPrimaryKey=@SNModelID
print '23. Deleted SNMModel for ID ' + CAST(@SNModelID as varchar)







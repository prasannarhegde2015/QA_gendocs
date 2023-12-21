use WKS6_POP45_175
DECLARE @SNScenarioID bigint  = 101
DECLARE @SNScenarioRUNID bigint  = 1
DECLARE @Varcntr bigint  = 1
WHILE  (@Varcntr   < 4975)

BEGIN
print @Varcntr 
set @SNScenarioRUNID = (Select top 1 B.sorPrimaryKey from SNOptimizationRun B where B.sorFK_SNScenario=@SNScenarioID);

Delete from SNOptimizationWellResults where swrFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationWellResultsInsitu  where swiFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationChokeResults  where socFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationSinkResults  where ssrFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationPipeResults  where nprFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationSimpleCompressorResults  where sscFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationSinkResultsInsitu  where ssiFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationSocketResults  where nsrFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationSocketResultsInsitu  where nsiFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNOptimizationWellResultsInsitu  where swiFK_SNOptimizationRun=@SNScenarioRUNID
Delete from SNMMassAndHeatResult where mhrFK_SNOptimizationRunId = @SNScenarioRUNID
delete from SNMBOMolarRateResult where bomFK_SNOptimizationRunId = @SNScenarioRUNID
delete from SNMCOMolarRateResult where comFK_SNOptimizationRunId = @SNScenarioRUNID
Delete from SNMSCBSourceConstraint where scsFK_SNOptimizationRunId=@SNScenarioRUNID
Delete from SNMSCBUserConstraint where  scuFK_SNOptimizationRunId= @SNScenarioRUNID
delete from SNMSCBObjectConstraint  where scoFK_SNOptimizationRunId = @SNScenarioRUNID
Delete from SNOptimizationRun where sorPrimaryKey = @SNScenarioRUNID


set @Varcntr = @Varcntr + 1
END

delete from SNScenarioScheduleHistory where sshFK_SNScenario = @SNScenarioID









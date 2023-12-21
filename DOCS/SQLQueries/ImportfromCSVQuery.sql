use POP
Select * from  SNMGLWellKickoff
Create table SNMGLWellKickoff(
gwkPrimaryKey  bigint, 
gwkFK_SNMWell bigint,
gwkWellheadPressure numeric(28, 18),
gwkGasInjectionThresholdRate numeric(28, 18),
);

Create Table SNMGLWellPerformanceSurface(
grsPrimaryKey bigint,
grsFK_SNMWell bigint,
grsWellheadTemperature numeric(28, 18),
grsWellheadPressure numeric(28, 18),
grsCasingHeadPressure numeric(28, 18),
grsNextValveOpeningPressure numeric(28, 18),
grsGasInjectionRate numeric(28, 18),
grsGasFormationRate numeric(28, 18),
grsOilProductionRate numeric(28, 18),
grsWaterProductionRate numeric(28, 18),
);

Create Table SNMPerformanceSurface(
prsPrimaryKey bigint,
prsFK_SNMWell bigint,
prsPressure numeric(28, 18),
prsTemperature numeric(28, 18),
prsGasRate numeric(28, 18),
prsOilRate numeric(28, 18),	
prsLiquidRate numeric(28, 18),
prsGOR numeric(28, 18),
prsWCT numeric(28, 18),
prsCGR numeric(28, 18),
prsWGR numeric(28, 18),
prsGLR numeric(28, 18),
prsFrequency numeric(28, 18),
prsRotationalSpeed numeric(28, 18)
);
-- import the file
BULK INSERT dbo.SNMGLWellKickoff
FROM 'C:\Databases\SNMGLWellKickoff.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


BULK INSERT dbo.SNMGLWellPerformanceSurface
FROM 'C:\Databases\SNMGLWellPerformanceSurface.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO


BULK INSERT dbo.SNMPerformanceSurface
FROM 'C:\Databases\SNMPerformanceSurface.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
)
GO

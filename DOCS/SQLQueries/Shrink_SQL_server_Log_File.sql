USE spotfire_server

ALTER DATABASE spotfire_server
SET RECOVERY SIMPLE
GO
DBCC SHRINKFILE (spotfire_server_log, 1)
GO
 ALTER DATABASE spotfire_server
SET RECOVERY FULL

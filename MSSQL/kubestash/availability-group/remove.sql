-- Step 1: Suspend data movement on the primary replica
ALTER DATABASE [agdb1] SET HADR SUSPEND;
GO

-- Step 2: Remove the database from the Availability Group on the primary replica
ALTER AVAILABILITY GROUP [mssqlserverag] REMOVE DATABASE [agdb1];
GO

-- Step 3: Set seeding mode to manual for each replica
DECLARE @replicaName NVARCHAR(128);
DECLARE replica_cursor CURSOR FOR
SELECT replica_server_name FROM sys.availability_replicas
WHERE group_id = (SELECT group_id FROM sys.availability_groups WHERE name = 'mssqlserverag');

OPEN replica_cursor;

FETCH NEXT FROM replica_cursor INTO @replicaName;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'ALTER AVAILABILITY GROUP [mssqlserverag] MODIFY REPLICA ON [' + @replicaName + '] WITH (SEEDING_MODE = MANUAL);';
    PRINT @sql; -- Print the command for verification
    EXEC sp_executesql @sql;

    FETCH NEXT FROM replica_cursor INTO @replicaName;
END

CLOSE replica_cursor;
DEALLOCATE replica_cursor;
GO

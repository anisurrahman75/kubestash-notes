DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql = @sql + N'DROP CREDENTIAL [' + name + N'];' + CHAR(13) + CHAR(10) FROM sys.credentials;

EXEC sp_executesql @sql;



/var/opt/mssql/security/ca-certificates


## Connect

/opt/mssql-tools/bin/sqlcmd -S sample-mssql -U sa -P "Pa55w0rd!"

- RESTORE DATABASE [Dummy] WITH RECOVERY;

- ALTER DATABASE [Dummy] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

- ALTER DATABASE [Dummy] SET MULTI_USER WITH ROLLBACK IMMEDIATE;

- ALTER AVAILABILITY GROUP [samplemssql] REMOVE DATABASE [Dummy];

- ALTER AVAILABILITY GROUP [samplemssql] ADD DATABASE [Dummy];


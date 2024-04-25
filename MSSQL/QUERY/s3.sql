-- CREATE CREDENTIAL   [s3://172.17.0.2:9000/stashqa]
-- WITH    
--         IDENTITY    = 'S3 Access Key'
-- ,       SECRET      = 'minioadmin:minioadmin';
-- GO


-- SELECT name FROM sys.credentials
-- GO

BACKUP DATABASE demo   
TO URL = 's3://172.17.0.2:9000/stashqa/demo.bak' WITH FORMAT

GO
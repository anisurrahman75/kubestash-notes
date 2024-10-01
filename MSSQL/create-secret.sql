/* Delete Credential */

-- DROP CREDENTIAL "http://stashqa.blob.localhost:10000/stashqa";
-- GO

/* Azurite Emulator */

-- IF NOT EXISTS  
-- (SELECT * FROM sys.credentials   
-- WHERE name = 'azure_secret')  
-- CREATE CREDENTIAL [azure_secret] WITH IDENTITY = ''  
-- ,SECRET = '';

/* Azure Storage */

-- IF NOT EXISTS  
-- (SELECT * FROM sys.credentials   
-- WHERE name = 'azure_secret')  
-- CREATE CREDENTIAL [azure_secret] WITH IDENTITY = ''  
-- ,SECRET = '';


/* SAS  **Working */

-- IF NOT EXISTS  
-- (SELECT * FROM sys.credentials   
-- WHERE name = 'https://stashqa.blob.core.windows.net/stashqa')  
-- CREATE CREDENTIAL [https://stashqa.blob.core.windows.net/stashqa] 
--    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',  
--    SECRET = ''; 


/* SAS Azurite Default Credentials*/

-- IF NOT EXISTS  
-- (SELECT * FROM sys.credentials   
-- WHERE name = 'http://127.0.0.1:10000/devstoreaccount1/kubestash')  
-- CREATE CREDENTIAL [http://127.0.0.1:10000/devstoreaccount1/kubestash] 
--    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',  
--    SECRET = '?';




/* SAS Azurite Custom Credental Credentials with (Production-style URL) */

-- IF NOT EXISTS  
-- (SELECT * FROM sys.credentials   
-- WHERE name = 'http://stashqa.blob.localhost:10000/stashqa')  
-- CREATE CREDENTIAL [http://stashqa.blob.localhost:10000/stashqa] 
--    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',  
--    SECRET = '';

/*
Same Problem here also,
	Started executing query at Line 1
	
	Msg 3078, Level 16, State 1, Line 20
The file name "http://stashqa.blob.localhost:10000/stashqa/demo.bak" is invalid as a backup device name for the specified device type. Reissue the BACKUP statement with a valid file name and device type. 
	
	Msg 3013, Level 16, State 1, Line 20
BACKUP DATABASE is terminating abnormally. */







SELECT name FROM sys.credentials
GO
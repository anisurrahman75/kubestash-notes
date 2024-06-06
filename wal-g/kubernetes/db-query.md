CREATE LOGIN [backupuser] WITH PASSWORD = 'backuppass1!';
ALTER SERVER ROLE [sysadmin] ADD MEMBER [backupuser];
CREATE CREDENTIAL [https://walg-service.demo.svc/basebackups_005] WITH IDENTITY='SHARED ACCESS SIGNATURE', SECRET = 'does_not_matter';
CREATE CREDENTIAL [https://walg-service.demo.svc/wal_005] WITH IDENTITY='SHARED ACCESS SIGNATURE', SECRET = 'does_not_matter';
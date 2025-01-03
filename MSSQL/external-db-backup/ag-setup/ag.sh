sqlcmd -S localhost -U SA -P "$SA_PASSWORD"

CREATE LOGIN dbm_login WITH PASSWORD = 'Pa55w0rd!';

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa55w0rd!';

CREATE CERTIFICATE dbm_certificate WITH SUBJECT = 'dbm';

BACKUP CERTIFICATE dbm_certificate
TO FILE = '/tmp/dbm_certificate.cer'
WITH PRIVATE KEY (
      FILE = '/tmp/dbm_certificate.pvk',
      ENCRYPTION BY PASSWORD = 'Pa55w0rd!'
   );
GO


CREATE ENDPOINT [Hadr_endpoint]
   AS TCP (LISTENER_IP = (0.0.0.0), LISTENER_PORT = 5022)
   FOR DATA_MIRRORING (
      ROLE = ALL,
      AUTHENTICATION = CERTIFICATE dbm_certificate,
      ENCRYPTION = REQUIRED ALGORITHM AES
      );


ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED;

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [dbm_login];


docker cp primary:/tmp/dbm_certificate.cer ./certs/
docker cp primary:/tmp/dbm_certificate.pvk .certs/

docker cp ./certs/dbm_certificate.cer secondary1:/tmp/
docker cp ./certs/dbm_certificate.pvk secondary1:/tmp/

docker cp ./certs/dbm_certificate.cer secondary2:/tmp/
docker cp ./certs/dbm_certificate.pvk secondary2:/tmp/


## Secondary only

chown mssql:mssql /tmp/dbm_certificate.*

CREATE LOGIN dbm_login WITH PASSWORD = 'Pa55w0rd!';

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa55w0rd!';

CREATE CERTIFICATE dbm_certificate FROM FILE = '/tmp/dbm_certificate.cer' WITH PRIVATE KEY ( FILE = '/tmp/dbm_certificate.pvk', DECRYPTION BY PASSWORD = 'Pa55w0rd!');

CREATE ENDPOINT [Hadr_endpoint] AS TCP (LISTENER_IP = (0.0.0.0), LISTENER_PORT = 5022) FOR DATA_MIRRORING ( ROLE = ALL, AUTHENTICATION = CERTIFICATE dbm_certificate, ENCRYPTION = REQUIRED ALGORITHM AES );

ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED;

-- Grant the login permission to connect to the endpoint
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [dbm_login];


# All Replicas
ALTER EVENT SESSION  AlwaysOn_health ON SERVER WITH (STARTUP_STATE=ON);



# Primary Replica

CREATE AVAILABILITY GROUP [AG1]
      WITH (CLUSTER_TYPE = NONE)
      FOR REPLICA ON
      N'primary'
            WITH (
            ENDPOINT_URL = N'tcp://6cd29ba83bea:5022',
            AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
               SEEDING_MODE = AUTOMATIC,
               FAILOVER_MODE = MANUAL,
            SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
               ),
      N'secondary1'
            WITH (
            ENDPOINT_URL = N'tcp://0ba510499daa:5022',
            AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
               SEEDING_MODE = AUTOMATIC,
               FAILOVER_MODE = MANUAL,
            SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
               ),
      N'secondary2'
            WITH (
            ENDPOINT_URL = N'tcp://1dad2949a910:5022',
            AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
               SEEDING_MODE = AUTOMATIC,
               FAILOVER_MODE = MANUAL,
            SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
               );








CREATE AVAILABILITY GROUP [AG1]
      WITH (CLUSTER_TYPE = NONE)
      FOR REPLICA ON
      N'sqlserver-0'
            WITH (
            ENDPOINT_URL = N'tcp://sqlserver-0:5022',
            AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
               SEEDING_MODE = AUTOMATIC,
               FAILOVER_MODE = MANUAL,
            SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
               );



SELECT name FROM sys.availability_groups
#!/bin/bash
# Environment variables

SA_PASSWORD=${SA_PASSWORD:-"Pa55w0rd!"}
DATABASE_NAME="test_db"

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
until sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1"; do
  echo -e "2\n" | /opt/mssql/bin/mssql-conf setup
  echo "SQL Server is not ready yet. Retrying in 5 seconds..."
  systemctl restart mssql-server.service
  sleep 20
done
echo "SQL Server is up!"

# Create the database if it doesn't exist
echo "Ensuring the database '$DATABASE_NAME' exists..."
sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'$DATABASE_NAME') BEGIN CREATE DATABASE [$DATABASE_NAME]; END;"

if [ $? -eq 0 ]; then
  echo "Database '$DATABASE_NAME' ensured successfully."
else
  echo "Error: Failed to ensure the database '$DATABASE_NAME'."
fi


# # Set the database to FULL recovery model
# echo "Setting recovery model of '$DATABASE_NAME' to FULL..."
# sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "ALTER DATABASE [$DATABASE_NAME] SET RECOVERY FULL"

# # Configure the Availability Group
# echo "Configuring the Availability Group..."
# sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "
# CREATE AVAILABILITY GROUP [MyAG]
# WITH (CLUSTER_TYPE = NONE)
# FOR DATABASE [$DATABASE_NAME]
# REPLICA ON
#   N'primary' WITH (
#     ENDPOINT_URL = 'TCP://primary:5022',
#     AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
#     FAILOVER_MODE = AUTOMATIC),
#   N'secondary1' WITH (
#     ENDPOINT_URL = 'TCP://secondary1:5022',
#     AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
#     FAILOVER_MODE = AUTOMATIC),
#   N'secondary2' WITH (
#     ENDPOINT_URL = 'TCP://secondary2:5022',
#     AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
#     FAILOVER_MODE = AUTOMATIC);
# "
# echo "Availability Group configured successfully!"

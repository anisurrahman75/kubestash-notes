
# List of databases which joined the x avaivalibity group:
```bash
$ kubectl exec -it -n demo mssqlserver-ag-0 -c mssql -- /opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P "Pa55w0rd!" -C -Q "SELECT adc.database_name FROM sys.availability_databases_cluster adc JOIN sys.availability_groups ag ON adc.group_id = ag.group_id WHERE ag.name = 'mssqlserverag' ORDER BY adc.database_name;"
```

# 

```bash
kubectl exec -it -n demo mssqlserver-ag-0 -c mssql -- /opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P "Pa55w0rd!" -C -Q " ALTER AVAILABILITY GROUP [mssqlserverag] ADD DATABASE [agdb1];"

kubectl exec -it -n demo mssqlserver-ag-0 -c mssql -- /opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P "Pa55w0rd!" -C -Q " ALTER AVAILABILITY GROUP [mssqlserverag] ADD DATABASE [agdb2];"

kubectl exec -it -n demo mssqlserver-ag-0 -c mssql -- /opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P "Pa55w0rd!" -C -Q " ALTER AVAILABILITY GROUP [mssqlserverag] ADD DATABASE [anisur];"
```
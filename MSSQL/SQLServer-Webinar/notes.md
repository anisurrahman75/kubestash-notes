## View all secret
```bash
$ kubectl view-secret -n demo mssqlserver-custom-auth  --all
```

## Run SQLCMD command: 
```bash
$  kubectl exec -it -n demo pod/sample-mssqlserver-0 -c mssql -- bash -c "/opt/mssql-tools18/bin/sqlcmd -S sample-mssqlserver -U sa -P Pa55w0rd -No"
```

## Insert sample data into database
```bash
1> USE demo;
2> CREATE TABLE equipment (id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, type NVARCHAR(50), quant INT, color NVARCHAR(25));
3> INSERT INTO equipment (type, quant, color) VALUES ('Swing', 10, 'Red'), ('Slide', 5, 'Blue'), ('Monkey Bars', 3, 'Yellow');
4> INSERT INTO equipment (type, quant, color) VALUES ('Seesaw', 4, 'Green'), ('Trampoline', 2, 'Orange'), ('Climbing Wall', 6, 'Purple');
5> GO
```

## Verify Data restored Successfully:
```bash
> select * from equipment;
> go
```


id          type                                               quant       color                    
----------- -------------------------------------------------- ----------- -------------------------
          1 Swing                                                       10 Red                      
          2 Slide                                                        5 Blue                     
          3 Monkey Bars                                                  3 Yellow                   
          4 Seesaw                                                       4 Green                    
          5 Trampoline                                                   2 Orange                   
          6 Climbing Wall                                                6 Purple     
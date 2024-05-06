---------------------------------------------Sign With CA -----------------------------------------------------------------------------
## Add /etc/hosts
-  Add `127.0.0.1       backup.local`

## Create CA certificate:
- cd ~/tls-certs
- mkdir CA; cd CA;
- openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/O=kubedb"
- cp ca.crt /usr/local/share/ca-certificates/test-ca.crt
- cp ca.crt /usr/share/ca-certificates/test-ca.crt
- update-ca-certificates
- dpkg-reconfigure ca-certificates


## Create server certificate for proxy-server:
- cd ~/tls-certs/proxy-server
- echo "subjectAltName=IP:127.0.0.1,DNS:backup.local" > altsubj.ext
- openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=backup.local"
- openssl x509 -req -in server.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out server.crt -days 365 -extfile ./altsubj.ext


## Create server certificate for sql-server: 
- ref: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-encrypted-connections?view=sql-server-ver16&tabs=server
- cd ~/tls-certs/sql-server
- echo "subjectAltName=IP:127.0.0.1,DNS:localhost" > altsubj.ext
- openssl req -newkey rsa:2048 -nodes -keyout mssql.key -out mssql.csr -subj "/CN=localhost"
- openssl x509 -req -in mssql.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out mssql.pem -days 365 -extfile ./altsubj.ext

## Configure SQL Server and Restart:
- chmod 600 mssql.pem mssql.key
- sudo /opt/mssql/bin/mssql-conf set network.tlscert /var/opt/mssql/tls-certs/sql-server/mssql.pem
- sudo /opt/mssql/bin/mssql-conf set network.tlskey /var/opt/mssql/tls-certs/sql-server/mssql.key
- sudo /opt/mssql/bin/mssql-conf set network.tlsprotocols 1.2
- sudo /opt/mssql/bin/mssql-conf set network.forceencryption 1
- systemctl restart mssql-serve

## Register the certificate on client machine:
- cp mssql.pem  mssql.crt
- sudo cp mssql.crt  /usr/local/share/ca-certificates/
- sudo update-ca-certificates


---------error-------------

INFO: 2024/05/07 07:48:33.387155 running proxy at backup.local:443
INFO: 2024/05/07 07:48:33.610118 database [demo] size is 3381248, required blob count 1
INFO: 2024/05/07 07:48:33.610290 starting backup database [demo] to URL = 'https://backup.local/basebackups_005/base_20240507T074833Z/demo/blob_000'
2024/05/07 07:48:33 http2: server: error reading preface from client 127.0.0.1:44289: read tcp 127.0.0.1:443->127.0.0.1:44289: read: connection reset by peer
ERROR: 2024/05/07 07:48:33.654088 database [demo] backup failed: mssql.Error{Number:3013, State:0x1, Class:0x10, Message:"BACKUP DATABASE is terminating abnormally.", ServerName:"localhost", ProcName:"", LineNo:1}
ERROR: 2024/05/07 07:48:33.654252 overall backup failed: mssql: BACKUP DATABASE is terminating abnormally
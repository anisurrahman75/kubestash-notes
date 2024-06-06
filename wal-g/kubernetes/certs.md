## Add /etc/hosts
```bash
echo "<POD_IP>       walg-service.demo.svc" >> /etc/hosts
```

#!/bin/bash

# Generate CA key and certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/O=kubedb"

# Copy CA certificate to system trust store
cp ca.crt /usr/local/share/ca-certificates/test-ca.crt
update-ca-certificates

# Create subjectAltName extension file
echo "subjectAltName=DNS:walg-service.demo.svc" > altsubj.ext

# Generate server key and certificate signing request (CSR)
openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=walg-service.demo.svc"

# Sign the server certificate using the CA
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365 -extfile altsubj.ext


### Check Wal-g Proxy Running or not:

curl https://walg-service.demo.svc/basebackups_005/base_20240508T042630Z/demo/foobar

## walg-conf:

WALG_FILE_PREFIX: "/backup-data/backup"
SQLSERVER_BLOB_CERT_FILE: "/backup-data/tls-certs/server.crt"
SQLSERVER_BLOB_KEY_FILE:  "/backup-data/tls-certs/server.key"
SQLSERVER_BLOB_LOCK_FILE: "./wal-g.lock"
SQLSERVER_BLOB_HOSTNAME:  "walg-service.demo.svc"
SQLSERVER_CONNECTION_STRING: "sqlserver://backupuser:backuppass1!@repl-0.repl.demo.svc:1433/instance"

WALG_UPLOAD_CONCURRENCY:   8  # how many block upload requests handle concurrently
WALG_DOWNLOAD_CONCURRENCY: 8  # how many block read requests handle concurrently 
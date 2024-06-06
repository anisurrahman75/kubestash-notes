#!/bin/bash

# Generate CA key and certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/O=kubedb"

# Copy CA certificate to system trust store
cp ca.crt /usr/local/share/ca-certificates/test-ca.crt
update-ca-certificates

# Create subjectAltName extension file
echo "subjectAltName=DNS:tls-service.demo.svc" > altsubj.ext

# Generate server key and certificate signing request (CSR)
openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=tls-service.demo.svc"

# Sign the server certificate using the CA
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365 -extfile altsubj.ext

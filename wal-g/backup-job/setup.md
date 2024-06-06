## LOAD CA to LOCAL CA AUTHORITY
```bash
kubectl view-secret  -n demo mssqlserver-ca -a # copy ca.crt, ca.key and create them. 
cp ca.crt /usr/local/share/ca-certificates/test-ca.crt
update-ca-certificates
```
## Create server certificate for proxy-server:
> Note: We can't add pod name here, because:
# Err: 4047C239537C0000:error:06800097:asn1 encoding routines:ASN1_mbstring_ncopy:string too long:../crypto/asn1/a_mbstr.c:106:maxsize=64

```bash
echo "subjectAltName=DNS:backup-job-service.demo.svc" > altsubj.ext
openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=backup-job-service.demo.svc"
openssl x509 -req -in server.csr -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -out server.crt -days 365 -extfile ./altsubj.ext

```

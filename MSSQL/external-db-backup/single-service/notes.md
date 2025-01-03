## Use LoadBalancer in Kind:

```bash
$ kubectl label node kind-control-plane node.kubernetes.io/exclude-from-external-load-balancers-
```


# Testing Environment: Linux Host Machine + Kind cluster 
- Kind Load balance: https://github.com/kubernetes-sigs/cloud-provider-kind
- Established Endpoints and services inside the cluster to access host machine servers e.g (SQLServer)

# Get IP of ingress:
```bash
kubectl get services \
   --namespace ingress-nginx \
   ingress-nginx-controller \
   --output jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

# Working Backup Command In Kubernetes:
```bash
$ /opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P 'Pa55w0rd' -Q "BACKUP DATABASE [agdb1] TO URL = 'https://mssqlserver-ag-backup-frequent-backup-1735902788.demo.svc/basebackups_005/base_20250102T123457Z/agdb1/blob_000' WITH FORMAT, MAXTRANSFERSIZE=4194304, COMPRESSION, COPY_ONLY;"
```


------------------------------------ Using Ingress---------------------------------------------------














------------------------------------Worked in LoadBalancer--------------------------------------------
# Before backup cmd do below stuff in `/etc/hosts`

```bash
172.18.0.4	mssqlserver-ag-backup-frequent-backup-1735906581.demo.svc
```

# Locally Tried:

```bash
$ sqlcmd -S localhost:1433 -U SA -P Pa55w0rd! -Q "BACKUP DATABASE [demo] TO URL = 'https://mssqlserver-ag-backup-frequent-backup-1735906581.demo.svc/basebackups_005/base_20250102T123457Z/demo/blob_000' WITH FORMAT, MAXTRANSFERSIZE=4194304, COMPRESSION, COPY_ONLY;"
```
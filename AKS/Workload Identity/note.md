Resources:
- https://azureglobalblackbelts.com/2023/09/21/workload-identity-example.html


```bash
export RG=anisur
export LOC=eastus
export CLUSTER_NAME=idenity-test
export MANAGED_IDENTITY=identity_test
```
## Create a single node cluster

```bash
az aks create -g $RG -n $CLUSTER_NAME \
--node-count 1 \
--enable-oidc-issuer \
--enable-workload-identity \
--generate-ssh-keys \
--os-sku Ubuntu
```

## Set up the identity

# Get the OIDC Issuer URL
```bash
export AKS_OIDC_ISSUER="$(az aks show -n $CLUSTER_NAME -g $RG --query "oidcIssuerProfile.issuerUrl" -otsv)"
```

# Create the managed identity
- I've created this through UI


# Get identity client ID
```bash
export USER_ASSIGNED_CLIENT_ID=$(az identity show --resource-group $RG --name $MANAGED_IDENTITY --query 'clientId' -o tsv)
```

# Create a service account to federate with the managed identity
```bash
➤ echo "apiVersion: v1
  kind: ServiceAccount
  metadata:
    annotations:
      azure.workload.identity/client-id: "$USER_ASSIGNED_CLIENT_ID"
    labels:
      azure.workload.identity/use: \"true\"
    name: identity-test
    namespace: default" | kubectl apply -f -
```

# Federate the identity
```bash
➤ az identity federated-credential create \
--name identity-test-demo-federated-id \
--identity-name $MANAGED_IDENTITY \
--resource-group $RG \
--issuer $AKS_OIDC_ISSUER \
--subject system:serviceaccount:default:identity-test
```

Her's the main issue, Azure has limit to create federated-credential for a user managed identity. 

So, we need to do something else like accessing every SA of any Namespace or whole clusters SA. 

```bash
"subject": "system:serviceaccount:*:*" # Full Cluster Access
"subject": "system:serviceaccount:<target_namespace>:*" # Specific Namespace Access
"subject": "system:serviceaccount:<target_namespace>:<sa_name_prefix>*" # Namespace + Service Account Prefix Access
```

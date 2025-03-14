1. https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
2. https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html


# Create Cluster
```bash
$ eksctl create cluster -f cluster-conf.yaml
```

## Follow the aws docs, I prefer CLI always, but fot berinners consolse are more firenly...



# Create an IAM OIDC provider for your cluster

```bash
$ export oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
$ aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
$ eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

# CREATE POOLICY:

```bash
$ aws iam create-policy --policy-name bucket-accessor --policy-document file://my-policy.json
```

# Verify Policy:
```bash
$ aws iam list-policies --query 'Policies[?PolicyName==`bucket-accessor`]' --region=$region
```

# Get Account ID:
```bash
$ export account_id=$(aws sts get-caller-identity --query "Account" --output text)
```

# Create and associate IAM Role:
```bash
$ eksctl create iamserviceaccount \
            --name kubestash-kubestash-operator \
            --namespace stash \
            --cluster=$cluster_name \
            --role-name=bucket-accessor
            --region=$region \
            --attach-policy-arn arn:aws:iam::$account_id:policy/bucket-accessor \
            --approve \
            --override-existing-serviceaccounts
```
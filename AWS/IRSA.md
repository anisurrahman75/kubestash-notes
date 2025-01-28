1. https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
2. https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html

CREATE POOLICY:

```bash
$ aws iam list-policies --query 'Policies[?PolicyName==`MyPolicyName`]'

```

Verify Policy:
```bash
$ aws iam list-policies --query 'Policies[?PolicyName==`bucket-accessor`]' --region=$region
```

Create and associate IAM Role:
```bash
$ eksctl create iamserviceaccount \
            --name kubestash-kubestash-operator \
            --namespace stash \
            --cluster irsa-test \
            --region=$region \
            --attach-policy-arn arn:aws:iam::453903318604:policy/bucket-accessor \
            --approve \
            --override-existing-serviceaccounts
```
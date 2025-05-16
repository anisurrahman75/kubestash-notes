
## References:
- https://docs.aws.amazon.com/eks/latest/userguide/pod-identities.html
- https://docs.aws.amazon.com/eks/latest/userguide/pod-id-how-it-works.html
- https://docs.aws.amazon.com/eks/latest/userguide/pod-id-agent-setup.html

> Note: For Pod Identity: The SDK uses the environment variables to connect to the EKS Pod Identity Agent and retrieve the credentials.

# Create Cluster:
```bash
$ eksctl create cluster -f cluster_config.yaml
```

# List Cluser:
```bash
$ eksctl get cluster --region=$REGION
```

# Install Agent inside cluster to every node:
```bash
$ aws eks create-addon --cluster-name $CLUSTER_NAME --addon-name eks-pod-identity-agent --addon-version v1.0.0-eksbuild.1 --region=$REGION
```

# Add ebs-csi driver to cluster

```bash
$ eksctl utils associate-iam-oidc-provider --region $REGION --cluster $CLUSTER_NAME --approve
$ eksctl create addon --name aws-ebs-csi-driver --cluster $CLUSTER_NAME --region $REGION --force
```
- Your IAM administrator adds the following principal to the trust policy of any role to make it usable by EKS Pod Identities.

```bash
"Principal": {
    "Service": "pods.eks.amazonaws.com"
}
```

- Pod Identity Agent: (Have to install pod identity agent)
  - Setup agent with AWS CLI: https://docs.aws.amazon.com/eks/latest/userguide/pod-id-agent-setup.html
  
  - ```bash
    $ aws eks create-addon --cluster-name my-cluster --addon-name eks-pod-identity-agent --addon-version v1.0.0-eksbuild.1
    ```
  - ```bash
    kubectl get pods -n kube-system | grep 'eks-pod-identity-agent'
    ```

- Assign an IAM role to a Kubernetes service accoun: https://docs.aws.amazon.com/eks/latest/userguide/pod-id-association.html

- Configure pods to access AWS services with service accounts: https://docs.aws.amazon.com/eks/latest/userguide/pod-id-configure-pods.html


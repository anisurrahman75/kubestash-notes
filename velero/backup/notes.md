```bash
$ velero backup create my-specific-backup \
    --include-resources deployments,pods,pvc,pv,configmaps,secrets,services,clusterroles,clusterrolebindings,serviceaccounts \
    --selector app=my-app \
    --namespace default \
    --include-cluster-resources=true \
    --snapshot-volumes=false \
    --wait
  ```
```bash
$ velero backup create deployment-backup \
      --selector app=my-app \
      --include-namespaces=demo \
      --include-cluster-resources=true \
      --snapshot-volumes=false \
      --default-volumes-to-fs-backup=true \
      --storage-location=gcs-backup \
      --wait
  ```


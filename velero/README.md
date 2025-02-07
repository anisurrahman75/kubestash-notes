## Install Velero CLI
- Binary Download Link: https://github.com/vmware-tanzu/velero/releases/
```bash
$ tar -xvf <RELEASE-TARBALL-NAME>.tar.gz
```

## Add VMware Tanzu repository to Helm repos:
```bash
$ helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
```

## Installing the Velero server
```bash
$ helm install velero vmware-tanzu/velero \
          --namespace velero \
          --create-namespace \
          --set-file credentials.secretContents.cloud=/home/anisur/GCS_CREDENTIAL/GOOGLE_SERVICE_ACCOUNT_JSON_KEY \
          --set configuration.backupStorageLocation[0].name=gcs-backup \
          --set configuration.backupStorageLocation[0].provider=velero.io/gcp \
          --set configuration.backupStorageLocation[0].bucket=anisur-velero \
          --set configuration.backupStorageLocation[0].config.prefix=backups/velero \
          --set initContainers[0].name=velero-plugin-for-gcp \
          --set initContainers[0].image=velero/velero-plugin-for-gcp:v1.11.0 \
          --set initContainers[0].volumeMounts[0].mountPath=/target \
          --set initContainers[0].volumeMounts[0].name=plugins \
          --set configuration.volumeSnapshotLocation[0].name=gcs-snapshot \
          --set configuration.volumeSnapshotLocation[0].provider=velero.io/gcp \
          --set configuration.volumeSnapshotLocation[0].config.snapshotLocation=us-central1 \
          --set configuration.volumeSnapshotLocation[0].config.credentialsFile=/credentials/cloud
```



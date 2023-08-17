# Volume Snapshots
***
## Installation:
***
-  Must have CSI driver running on your machine. If you are using cloud native K8s cluster.
- For me i am using linode cluster:
- #### Install External- Snapshooter Crds First
- `git clone https://github.com/kubernetes-csi/external-snapshotter/tree/v5.0.0`  
- ` Note: I am using  release: V5.00 `
- ` Go into the download Repository `
- `kubectl kustomize client/config/crd | kubectl create -f -`
- `kubectl -n kube-system kustomize deploy/kubernetes/snapshot-controller | kubectl create -f -`
- `kubectl kustomize deploy/kubernetes/csi-snapshotter | kubectl create -f -` 



- ### Install longhorn:
- `helm repo add longhorn https://charts.longhorn.io`
- `helm repo update`
- `helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace --version 1.5.1`

- ### Testing yaml:
- ``https://github.com/anisurrahman75/kubestash-notes/tree/main/volume-Snapshots/longhorn``

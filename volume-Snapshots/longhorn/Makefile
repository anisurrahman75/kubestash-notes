REPO_DIR ?= "/home/anisur/go/src/github.com/external-snapshotter"

.PHONY: install_vs

install_vs:
	@echo 'Installing VS from Dir='$(REPO_DIR)
	cd $(REPO_DIR); \
    git pull; \
    kubectl kustomize client/config/crd | kubectl create -f -; \
    kubectl -n kube-system kustomize deploy/kubernetes/snapshot-controller | kubectl create -f -; \
    kubectl kustomize deploy/kubernetes/csi-snapshotter | kubectl create -f -; \
    helm repo add longhorn https://charts.longhorn.io; \
    helm repo update; \
    helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace --version 1.6.0 \

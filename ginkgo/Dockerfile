docker run                                                 \
    -i                                                      \
    -u 1000:1000                                  \
    -v /home/anisur/go/src/kubestash.dev/kubestash:/src                                         \
    -w /src                                                 \
    --net=host                                              \
    -v /home/anisur/.kube:/.kube                                 \
    -v /home/anisur/.minikube:/home/anisur/.minikube                  \
    -v /home/anisur/.credentials:/home/anisur/.credentials            \
    -v /home/anisur/go/src/kubestash.dev/kubestash/.go/bin/linux_amd64:/go/bin                \
    -v /home/anisur/go/src/kubestash.dev/kubestash/.go/bin/linux_amd64:/go/bin/linux_amd64  \
    -v /home/anisur/go/src/kubestash.dev/kubestash/.go/cache:/.cache                            \
    --env HTTP_PROXY=                          \
    --env HTTPS_PROXY=                        \
    --env KUBECONFIG=                          \
    --env-file=/home/anisur/go/src/kubestash.dev/kubestash/hack/config/.env                     \
    ghcr.io/appscode/golang-dev:1.22                                          \
    /bin/bash -c "                                          \
        ARCH=amd64                                        \
        OS=linux                                            \
        VERSION=v0.6.1                                  \
        DOCKER_REGISTRY=ghcr.io/kubestash  \
        TAG=v0.6.1_linux_amd64                                          \
        KUBECONFIG=${KUBECONFIG#/home/anisur}                   \
        GINKGO_ARGS='"--flake-attempts=2"'                        \
        TEST_ARGS=' --image-tag=v0.6.1_linux_amd64'         \
        ./hack/e2e.sh                                       \
    "

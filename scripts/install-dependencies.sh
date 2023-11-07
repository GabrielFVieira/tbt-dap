cd /tmp

KERNEL=$(uname)
KERNEL=$(echo "${KERNEL,,}")

echo "1) Install apt dependencies"
sudo apt update
sudo apt upgrade
sudo apt install -y git curl wget openssl net-tools

echo "2) Install yq"
YQ_BIN=yq
YQ_VERSION=3.4.1

if [ -z $(which ${YQ_BIN}) ]; then
    sudo wget -qO /usr/local/bin/${YQ_BIN} https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${KERNEL}_amd64
    sudo chmod a+x /usr/local/bin/${YQ_BIN}
    ${YQ_BIN} --version
else
    echo "YQ is most likely installed"
fi

echo "3) Install kubectl"
KUBECTL_BIN=kubectl
KUBECTL_VERSION=v1.22.2

if [ -z $(which ${KUBECTL_BIN}) ]; then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${KERNEL}/amd64/kubectl
    chmod +x ${KUBECTL_BIN}
    sudo mv ${KUBECTL_BIN} /usr/local/bin/${KUBECTL_BIN}
    sudo ln -sf /usr/local/bin/${KUBECTL_BIN} /usr/bin/${KUBECTL_BIN}
    ${KUBECTL_BIN} version --client
else
    echo "Kubectl is most likely installed"
fi

echo "4) Install kubectx"
KUBECTX_BIN=kubectx
KUBECTX_VERSION=v0.9.5
KUBECTX_TAR_FILE=kubectx_${KUBECTX_VERSION}_${KERNEL}_x86_64.tar.gz

if [ -z $(which ${KUBECTX_BIN}) ]; then
    curl -LO https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/${KUBECTX_TAR_FILE}
    tar -xvzf ${KUBECTX_TAR_FILE} kubectx
    chmod +x kubectx
    sudo mv kubectx /usr/local/bin/${KUBECTX_BIN}
    rm -rf ${KUBECTX_TAR_FILE}
    ${KUBECTX_BIN} --version
else
    echo "Kubectx is most likely installed"
fi

echo "5) Install kubens"
KUBENS_BIN=kubens
KUBENS_VERSION=v0.9.5
KUBENS_TAR_FILE=kubens_${KUBENS_VERSION}_${KERNEL}_x86_64.tar.gz

if [ -z $(which ${KUBENS_BIN}) ]; then
    curl -LO https://github.com/ahmetb/kubectx/releases/download/${KUBENS_VERSION}/${KUBENS_TAR_FILE}
    tar -xvzf ${KUBENS_TAR_FILE} kubens
    chmod +x kubens
    sudo mv kubens /usr/local/bin/${KUBENS_BIN}
    rm -rf ${KUBENS_TAR_FILE}
    ${KUBENS_BIN} --version
else
    echo "Kubectx is most likely installed"
fi

echo "6) Install helm 3 and its plugins"
HELM_BIN=helm
HELM_VERSION=v3.12.3
HELM_TAR_FILE=helm-${HELM_VERSION}-${KERNEL}-amd64.tar.gz

if [ -z $(which ${HELM_BIN}) ]; then
    curl -LO https://get.helm.sh/${HELM_TAR_FILE}
    tar -xvzf ${HELM_TAR_FILE} ${KERNEL}-amd64/helm
    chmod +x ${KERNEL}-amd64/helm
    sudo mv ${KERNEL}-amd64/helm /usr/local/bin/helm3
    sudo ln -sfn /usr/local/bin/helm3 /usr/local/bin/${HELM_BIN}
    rm -rf ${HELM_TAR_FILE}
    ${HELM_BIN} version

    ${HELM_BIN} repo update
    ${HELM_BIN} plugin install https://github.com/databus23/helm-diff
    ${HELM_BIN} plugin install https://github.com/jkroepke/helm-secrets --version v3.5.0

else
    echo "Helm 3 is most likely installed"
fi

echo "7) Install kind"
KIND_BIN=kind
KIND_VERSION=v0.19.0
KIND_FILE=kind-${KERNEL}-amd64

if [ -z $(which $KIND_BIN) ]; then
    curl -LO https://kind.sigs.k8s.io/dl/$KIND_VERSION/${KIND_FILE}
    chmod +x ${KIND_FILE}
    sudo mv ./${KIND_FILE} /usr/local/bin/${KIND_BIN}
    ${KIND_BIN} --version
else
    echo "Kind is most likely installed"
fi

echo "8) Tracetest"
TRACETEST_BIN=tracetest
if [ -z $(which $TRACETEST_BIN) ]; then
    curl -L https://raw.githubusercontent.com/kubeshop/tracetest/main/install-cli.sh | bash -s -- v0.14.5
else
    echo "Tracetest is most likely installed"
fi
#!/bin/bash

scenario=$1
if [ -z "${scenario}" ]; then
    scenario=${DEFAULT_SCENARIO}
fi

containerName=${CLUSTER_NAME}-control-plane
container=$(docker ps --format '{{.Names}}' -f name=${clusterName} 2> /dev/null)

if [ -z "${container}" ]; then
    echo "Demo container not running, starting it..."
    docker start ${containerName}

    if [ $? -eq 0 ]; then
        seconds=90
        echo "Waiting ${seconds} for the container restart it status correctly"
        sleep ${seconds}

        kubectx kind-${CLUSTER_NAME}
    else
        echo "Demo container with name "$containerName" not found, will try to install on the current k8s context"
    fi
fi

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm upgrade --install ${DEMO_CHART_NAME} \
    open-telemetry/opentelemetry-demo \
    -n ${DEMO_NAMESPACE} \
    -f ${SCENARIOS_FOLDER}/${scenario}/${K8S_VALUES_FILE_NAME} \
    --create-namespace

kubectl rollout status deployment otel-demo-frontendproxy --timeout=60s -n ${DEMO_NAMESPACE}
kubectl rollout status deployment otel-demo-frontend --timeout=60s -n ${DEMO_NAMESPACE}

if [ $? -eq 0 ]; then
    echo "OpenTelemetry Demo is running."
    echo "Access at http://localhost:8080 on Linux/WSL"
    echo "Access at http://host.docker.internal:8080 on Windows"
fi
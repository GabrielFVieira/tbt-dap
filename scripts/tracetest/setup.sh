#!/bin/bash

TRACETEST_DIR=$(dirname "$(readlink -f "$0")")
VALUES_FILE="${TRACETEST_DIR}/values.yaml"

helm repo add kubeshop https://kubeshop.github.io/helm-charts

helm install tracetest kubeshop/tracetest \
    --version ${TRACETEST_CHART_VERSION} \
    -f ${VALUES_FILE} \
    -n ${TRACETEST_NAMESPACE} \
    --create-namespace

kubectl patch service tracetest \
    --type json \
    -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value": 30001}]' \
    -n ${TRACETEST_NAMESPACE}

kubectl rollout status deployment tracetest --timeout=180s -n ${TRACETEST_NAMESPACE}

tracetest configure -e "http://localhost:11633"

tracetest apply config -f "${TRACETEST_DIR}/config.yaml"
tracetest apply datastore -f "${TRACETEST_DIR}/datastore.yaml"
tracetest apply demo -f "${TRACETEST_DIR}/demo.yaml"
tracetest apply pollingprofile -f "${TRACETEST_DIR}/poolingProfile.yaml"

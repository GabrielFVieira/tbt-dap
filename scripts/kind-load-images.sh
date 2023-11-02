#!/bin/bash

scenario=$1
if [ -z "${scenario}" ]; then
    scenario=${DEFAULT_SCENARIO}
fi

valuesFile="${SCENARIOS_FOLDER}/${scenario}/${K8S_VALUES_FILE_NAME}"
imageTag=$(yq r ${valuesFile} default.image.tag)

if [ -z "${imageTag}" ]; then
  echo "Empty image tag"
  exit 1
fi

services=("frontendproxy" "loadgenerator" "frontend" "checkoutservice" "shippingservice"
"recommendationservice" "featureflagservice" "currencyservice" "frauddetectionservice"
"adservice" "quoteservice" "emailservice" "productcatalogservice" "accountingservice"
"cartservice" "paymentservice" "kafka")

for service in ${services[@]}; do
  kind load docker-image dev.local/otel-demo:$imageTag-$service --name ${CLUSTER_NAME}
done

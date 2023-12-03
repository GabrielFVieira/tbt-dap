#!/bin/bash

scenario=$1
if [ -z "${scenario}" ]; then
    scenario=${DEFAULT_SCENARIO}
fi

cd ../${SYSTEM_REPO_NAME} && \
docker compose --env-file ${SCENARIOS_FOLDER}/${DOCKER_DEFAULT_ENV_FILE_NAME} \
    --env-file ${SCENARIOS_FOLDER}/${scenario}/${DOCKER_ENV_FILE_NAME} \
    up --force-recreate --remove-orphans --detach

if [ $? -eq 0 ]; then
    echo "OpenTelemetry Demo is running."
    echo "Go to http://localhost:8080 for the demo UI."
fi
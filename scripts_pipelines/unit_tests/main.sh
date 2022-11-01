#!/usr/bin/env bash
job_name=$1
docker_image_name="unit_tests-${job_name,,}"
echo "Create a container from image $docker_image_name"
docker run -i \
           --user $(id -u):$(id -g) \
           -v $PWD/unit_tests:/workdir/unit_tests \
           -v $PWD/scripts_pipelines:/workdir/scripts_pipelines \
           --workdir=/workdir \
           $docker_image_name \
           ./scripts_pipelines/unit_tests/execute_tests.sh
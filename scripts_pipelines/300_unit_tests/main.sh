#!/usr/bin/env bash
job_name=$1
this_folder="300_unit_tests"
docker_image_name="${this_folder}-${job_name,,}"
echo "Create a container from image $docker_image_name"
docker run -i \
           --user $(id -u):$(id -g) \
           -v $PWD/unit_tests:/workdir/unit_tests \
           -v $PWD/scripts_pipelines:/workdir/scripts_pipelines \
           --workdir=/workdir \
           $docker_image_name \
           ./scripts_pipelines/${this_folder}/execute_tests.sh
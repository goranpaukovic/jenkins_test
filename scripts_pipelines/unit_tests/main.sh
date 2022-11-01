#!/usr/bin/env bash
job_name=$1
docker run -i \
           --user $(id -u):$(id -g) \
           -v $PWD/unit_tests:/workdir/unit_tests \
           -v $PWD/scripts_pipelines:/workdir/scripts_pipelines \
           --workdir=/workdir \
           unit_tests-${job_name,,} \
           ./scripts_pipelines/unit_tests/execute_tests.sh
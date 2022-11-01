#!/usr/bin/env bash
job_name=$1
this_folder="200_bitbake_build"
docker_image_name="${this_folder}-${job_name,,}"
echo "Create a container from image $docker_image_name"
docker run -i \
           -v /opt/yocto_shares/sstate-cache:/opt/yocto_shares/sstate-cache \
           -v /opt/yocto_shares/downloads:/opt/yocto_shares/downloads \
           -v $PWD:/workdir \
           --workdir=/workdir \
           $docker_image_name \
           ./scripts_pipelines/${this_folder}/build_oe-core.sh
#!/usr/bin/env bash
job_name=$1
docker run -i \
           -v /opt/yocto_shares/sstate-cache:/opt/yocto_shares/sstate-cache \
           -v /opt/yocto_shares/downloads:/opt/yocto_shares/downloads \
           -v $PWD:/workdir \
           --workdir=/workdir \
           bitbake_build-${job_name,,} \
           ./scripts_pipelines/bitbake_build/build_oe-core.sh
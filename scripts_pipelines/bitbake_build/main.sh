#!/usr/bin/env sh
docker run -i \
           -v /opt/yocto_shares/sstate-cache:/opt/yocto_shares/sstate-cache \
           -v /opt/yocto_shares/downloads:/opt/yocto_shares/downloads \
           -v $PWD:/workdir \
           --workdir=/workdir \
           oe-build-goran:1.0 \
           ./scripts_pipelines/bitbake_build/build_oe-core.sh
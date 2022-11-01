#!/usr/bin/env bash
echo $1
echo $2
build_name=$1
workspace=$2

dockerfiles_folders=("bitbake_build" "unit_tests")
for dockerfile in ${dockerfiles_folders[@]}; do
  echo $dockerfile
  cd $workspace
  ls scripts_pipelines/$dockerfile/dockerfiles -ld
  ls scripts_pipelines/$dockerfile/dockerfiles
  cd scripts_pipelines/$dockerfile/dockerfiles
  #docker build .......
done
#!/bin/bash

image_name=$1
container_name=$2


if [ -z "$image_name" ] || [ -z "$container_name" ]; then
  echo "Usage: run_container.sh [image_name] [container_name]"
  exit
fi

current_dir=`pwd -P`

docker run \
  -it -d \
  --gpus all \
  --name $container_name \
  -v /mnt/d/datasets:/root/work/data \
  -v /mnt/d/out:/root/work/outputs \
  -v $current_dir:/root/work \
  -w /root/work \
  --shm-size=12g \
  $image_name \
  bash

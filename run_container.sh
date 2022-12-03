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
  -e TZ=Asia/Tokyo \
  -v /mnt/e/datasets:/root/work/data \
  -v /mnt/d/out:/root/work/outputs \
  -v /dev/shm:/dev/shm \
  -v $current_dir:/root/work \
  -p 6006:6006 \
  -v $HOME/.ssh:/root/.ssh \
  -w /root/work \
  $image_name \
  bash
  #-v /etc/group:/etc/group:ro \
  #-v /etc/passwd:/etc/passwd:ro \
  #-u $(id -u $USER):$(id -g $USER) \
  # --shm-size=12g \

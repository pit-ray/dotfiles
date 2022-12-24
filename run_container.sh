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
  -v /mnt/e/datasets:/root/work/data:ro \
  -v /mnt/d/out:/root/work/outputs \
  -v /dev/shm:/dev/shm \
  -v $current_dir:/root/work \
  -v $HOME/.ssh:/root/.ssh \
  -v $HOME/.gitconfig:/etc/gitconfig \
  -w /root/work \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/.Xauthority:/root/.Xauthority \
  --net host \
  $image_name \
  bash

docker start $container_name
docker exec -it $container_name /root/setup_vim.sh
docker exec -it $container_name pip install --upgrade pip
docker exec -it $container_name pip install -r requirements.txt
docker exec -it $container_name bash

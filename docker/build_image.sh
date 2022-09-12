#!/bin/bash

image_tag=$1
if [ -z "$image_tag" ] then
  echo "Usage: build_image.sh [image_tag] [path]"
  exit
fi

current_dir=$(dirname $0)

# docker pull nvidia/cuda:11.2.1-devel-ubuntu20.04
docker build -f $current_dir/Dockerfile -t $1 $dirname

#!/bin/bash

git clone https://github.com/pit-ray/dotfiles.git ~/.tmp/dotfiles
cp ~/.tmp/dotfiles/.vimrc ~
vim -c "qa!"

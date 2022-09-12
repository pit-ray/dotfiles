FROM nvidia/cuda:11.2.1-devel-ubuntu20.04

ENV DEBCONF_NOWARNINGS=yes
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
  git \
  build-essential \
  python3 \
  python3-pip \
  python3-tk \
  python3-dev \
  python-is-python3 \
  libgl1-mesa-dev

# build vim from the source file
RUN apt-get install -y gettext libtinfo-dev libacl1-dev libgpm-dev
RUN git clone https://github.com/vim/vim.git
WORKDIR vim
RUN git checkout v9.0.0445
RUN ./configure --with-features=huge --enable-fail-if-missing --enable-python3interp
RUN make -j4 ; make install

WORKDIR /root

# Setup .vimrc for Vim
RUN git clone https://github.com/pit-ray/dotfiles.git
RUN cp dotfiles/.vimrc $HOME/.vimrc
RUN vim -c "quitall!"
RUN vim -c "call InitVim()"

RUN pip3 install pip --upgrade
RUN pip3 install \
  torch torchvision torchaudio \
  --extra-index-url https://download.pytorch.org/whl/cu113

# dotfiles

## Setup Vim
The .vimrc supports cross-platform. Furthermore, it does not need to require preparation to construct .vim/vimfiles. All process is done automatically by .vimrc.

```sh
cp dotfiles/.vimrc ~
```

## Setup the environment for LaTeX on Windows.

1. Install chocolatey.
```sh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

2. Install some utilities
```sh
choco install dotfiles/choco.config -y
```

3. Execute post-processing
```sh
./dotfiles/setup.bat
```

## Setup the environment for deep-learning on Ubuntu.

1. build the docker image

```sh
./dotfiles/build_image.sh dlenv
```

2. run a container attaching the current working directory.

```sh
./dotfiles/run_container.sh dlenv project-1
```

The current working directory is attached into `/root/work`.

3. Enter the container.

```sh
docker exec -it project-1 bash
```

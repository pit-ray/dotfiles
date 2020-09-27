cp .vimrc ~
cp dein.toml ~


If(Test-Path vim-hybrid){
    cd vim-hybrid
    git pull
    cd ..
}
Else{
    git clone https://github.com/w0ng/vim-hybrid.git
}

cp vim-hybrid/colors/hybrid.vim ~/vimfiles/colors/


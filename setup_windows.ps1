cp .vimrc ~/.vimrc
cp .latexmkrc ~/.latexmkrc
cp init.vim ~/init.vim

cd windows
./setup_scoop.ps1
Start-Process powershell "-ExecutionPolicy RemoteSigned -File `"./setup_choco.ps1`"" -verb RunAs 
Start-Process powershell "-ExecutionPolicy RemoteSigned -File `"./setup.ps1`"" -verb RunAs

cp -r .win-vind/* ~/.win-vind

cd ..

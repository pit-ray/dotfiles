@chcp 65001

copy .vimrc ~/.vimrc
copy .latexmkrc ~/.latexmkrc
copy init.vim ~/init.vim

cd windows
call setup_scoop.bat
call setup_choco.bat
call setup.bat

xcopy /I /E /Y .win-vind ~

cd ..

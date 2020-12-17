#########################################################################
# File Name: root_install.sh
# Author: Daniel Gao
# mail: seraphdg@gmail.com
# Created Time: Wed Dec  9 16:38:28 2020
#########################################################################
#!/bin/bash

cd

# vimrc
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

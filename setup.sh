#!/bin/bash

VIM_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)


curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim_{undo,swap}
ln -s "$VIM_DIR/init.vim" ~/.vimrc


#!/bin/sh

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

ln -s $DIR/nvimrc ~/.config/nvim/init.vim
ln -s $DIR/bashrc ~/.bashrc

# print info
echo Run PlugInstall in neovim to install all plugins
echo Go here to look at available Coc.nvim language servers: https://github.com/neoclide/coc.nvim/wiki/Language-servers
echo To set up aliases, create new file in users root directory called .bash_aliases


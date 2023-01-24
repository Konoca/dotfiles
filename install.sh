#!/bin/sh

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

## web dev stuff
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node
npm install -g @angular/cli

## misc
sudo pacman -S neovim
sudo pacman -S htop

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# link dotfiles
ln -s $DIR/nvimrc ~/.config/nvim/init.vim
ln -s $DIR/bashrc ~/.bashrc

# print info
echo Run PlugInstall in neovim to install all plugins
echo Go here to look at available Coc.nvim language servers: https://github.com/neoclide/coc.nvim/wiki/Language-servers
echo To set up aliases, create new file in users root directory called .bash_aliases


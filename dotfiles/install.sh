#!/bin/bash
# 
# install.sh
# Small script used to install the dotfiles once the directory has been cloned

#
# Bash
#

ln -s ~/bin/dotfiles/bash/bashrc ~/.bashrc              # bashrc
ln -s ~/bin/dotfiles/bash/bash_aliases ~/.bash_aliases  # bashrc


#
# Vim
#

ln -s ~/bin/dotfiles/vim/dot_vim ~/.vim                 # Vim config directory
ln -s ~/bin/dotfiles/vim/vimrc ~/.vimrc                 # vimrc
# Install colour scheme into correct folder


#
# Git
#

## Add hooks here for ctags

#
# GDB
# 

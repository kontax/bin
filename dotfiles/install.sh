#!/bin/bash
# 
# install.sh
# Small script used to install the dotfiles once the directory has been cloned

#
# Bash
#

ln -sf ~/bin/dotfiles/bash/bashrc ~/.bashrc              # bashrc
ln -sf ~/bin/dotfiles/bash/bash_aliases ~/.bash_aliases  # bashrc


#
# Vim
#

ln -sf ~/bin/dotfiles/vim/dot_vim ~/.vim                 # Vim config directory
ln -sf ~/bin/dotfiles/vim/vimrc ~/.vimrc                 # vimrc
# Install colour scheme into correct folder


#
# Git
#
ln -sf ~/bin/dotfiles/git/netrc.gpg ~/.netrc.gpg         # Git netrc
git config --global credential.helper "netrc -f ~/.netrc.gpg -v -d"
git config --global user.name "James Coulson"
git config --global user.email "coulsonj@gmail.com"
echo "Git setup. Install GPG keys to use"

## Add hooks here for ctags

#
# GDB
# 

#!/bin/sh

DOTFILES=`dirname $0`

ln -fs ${DOTFILES}/vimrc ~/.vimrc
ln -fs ${DOTFILES}/vim ~/.vim

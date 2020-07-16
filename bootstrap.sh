#!/bin/sh

cd `dirname "$0"`
DOTFILES=`pwd -P`
cd -

mkdir -p ~/.local/bin

ln -fs ${DOTFILES}/bin/git-cleanup ~/.local/bin/git-cleanup

ln -fs ${DOTFILES}/vim ~/.vim

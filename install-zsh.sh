#!/bin/zsh
# TODO: make shure that this script is run in a zsh environment

TODAY=`date +%Y%m%d-%H-%M`
ZSHDIR="${ZDOTDIR:-$HOME}/.zsh"
PRESTODIR="$ZSHDIR/prezto"

if [ -e $ZSHDIR ]; then
  mv "$ZSHDIR" "$HOME/.zsh-$TODAY"
fi

mkdir $ZSHDIR

git clone --recursive https://github.com/jkuetemeier/prezto.git "$PRESTODIR"

setopt EXTENDED_GLOB

for rcfile in "$PRESTODIR"/runcoms/^README.md(.N); do
  DEST=".${rcfile:t}"
  DDIR="${ZDOTDIR:-$HOME}"
  if [ -e "$DDIR/$DEST" ]; then
    mv "$DDIR/$DEST" "$DDIR/$DEST-$TODAY"
  fi
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

ln -s "$PRESTODIR" "${ZDOTDIR:-$HOME}/.zprezto"

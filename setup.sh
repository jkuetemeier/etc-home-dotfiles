#!/usr/bin/env sh

exit 1

# chdir to script dir
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir

usage()
{
cat << EOF
usage: $0 options

This script can be installed local ($HOME) or global.

OPTIONS:
   -h      Show this message
   -l      install local ($HOME/.jk-sys)
   -g      install global (/opt/jk-sys)
   -v      Verbose

EOF
}

GLOBAL=
LOCAL=
VERBOSE=

while getopts “ghlv” OPTION
do
case $OPTION in
 g)
     GLOBAL=1
     ;;
 h)
     usage
     exit 1
     ;;
 l)
     LOCAL=1
     ;;
 v)
     VERBOSE=1
     ;;
 ?)
     usage
     exit
     ;;
esac
done

if [[ -z $GLOBAL ]] && [[ -z $LOCAL ]]; then
  usage
  exit 1
fi

if [[ -n $GLOBAL ]] && [[ -n $LOCAL ]]; then
  echo "ERROR: You can install only global OR local"
  usage
  exit 1
fi

if [[ -n $VERBOSE ]]; then
  if [[ -n $GLOBAL ]]; then
    echo "vim - starting global install..."
  else 
    echo "vim - starting local install..."
  fi
fi


if [[ -n $VERBOSE ]]; then
  echo "Detected User: $LOGNAME"
fi

VIM=`which vim`
if [[ ! $VIM =~ 'vim' ]]; then 
  echo "no vim found, perhaps you should try to install it."
  exit -1
fi

if [[ -n $VERBOSE ]]; then
  echo "vim found at: $VIM"
fi

DEST=$HOME

if [[ -n $GLOBAL ]]; then
  DEST="/etc"
  echo "TODO: global install... not ready yet!"
  exit -1
fi


TODAY=`date +%Y%m%d`
FILES="$dir/dotfiles/*"

MVARG=
if [[ -n $VERBOSE ]]; then
  MVARG=-v
fi

####
# link all files in ./dotfiles to $HOME or /etc
# backup files that are already there

for rcfile in $FILES; do
  # split path and file name
  file=${rcfile##*/}
  DESTFILE=
  if [[ -n $GLOBAL ]]; then
    DESTFILE="$DEST/$file"
  else
    DESTFILE="$DEST/.$file"
  fi
  if [[ -z $NOBACKUP ]]; then
    if [[ -n $VERBOSE ]]; then
      [ -e $DESTFILE ] && echo "backing up $DESTFILE"
    fi

    [ -e $DESTFILE ] && mv $MVARG $DESTFILE $DESTFILE.$TODAY
  fi
  ln -s "$rcfile" $DESTFILE
done

###
# prepare vim directory

vimdir="$DEST/.vim"

if [[ -e $vimdir.$TODAY ]]; then
  read -p "$vimdir.$TODAY already exists... continue?(y/n)" -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
  rm -rf "$vimdir.$TODAY"
fi

[ -e "$vimdir" ] && mv $MVARG "$vimdir" "$vimdir.$TODAY"

mkdir -p $vimdir/bundle
mkdir -p $vimdir/colors
mkdir -p $vimdir/spell

FILES="$dir/colors/*"

for rcfile in $FILES; do
  file=${rcfile##*/}
  destination="$vimdir/colors/$file"
  ln -s "$rcfile" "$destination"
done

FILES="$dir/spell/*"

for rcfile in $FILES; do
  file=${rcfile##*/}
  destination="$vimdir/spell/$file"
  ln -s "$rcfile" "$destination"
done

FILES="$dir/vimfiles/*"

for rcfile in $FILES; do
  file=${rcfile##*/}
  destination="$vimdir/$file"
  ln -s "$rcfile" "$destination"
done

# copy additinal spell-files
cp optional/.vim-spell-de.utf-8.add ~/.vim-spell-de.utf-8.add
cp optional/.vim-spell-en.utf-8.add ~/.vim-spell-en.utf-8.add

git clone https://github.com/gmarik/Vundle.vim.git "$vimdir/bundle/Vundle.vim"

vim +PluginInstall +qall


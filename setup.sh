#!/usr/bin/env bash

# setup script for jk-etc-home-dotfiles
# (c) 1998-2015 Joerg Kuetemeier <jk@kuetemeier.net>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Script setup {{{1
# =================

# chdir to script dir {{{2
# ------------------------
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir
# --- }}}2

# usage message {{{2
# ------------------
usage()
{
cat << EOF
usage: $0 options

This script can install the config files local ($HOME) or global.

OPTIONS:
   -h      Show this message
   -l      install local ($HOME)
   -g      install global (/etc)
   -v      Verbose

EOF
}
# --- }}}2

# get commandline options {{{2
# ----------------------------

GLOBAL=
LOCAL=
VERBOSE=
NAME=jk-etc-home-dotfiles

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
# --- }}}2

# calculate requirements {{{2
# ---------------------------

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
    echo "$NAME - starting global install..."
  else 
    echo "$NAME - starting local install..."
  fi
fi


if [[ -n $VERBOSE ]]; then
  echo "Detected User: $LOGNAME"
fi

SRC=$dir
DEST=$HOME

if [[ -n $GLOBAL ]]; then
  DEST="/etc"
  echo "TODO: global install... not ready yet!"
  exit -1
fi

MVARG=
if [[ -n $VERBOSE ]]; then
  MVARG=-v
fi

TODAY=`date +%Y%m%d`
# --- }}}2

# ===== }}}1

# Helper functions {{{1
# =====================

list() { # for debug listing {{{2
# -------------------------------
  cnt=${#SRC_FILES[@]}
  for (( i = 0; i < cnt; i++)); do
    s=${SRC_FILES[i]}
    d=${DST_FILES[i]}
    echo "$s -> $d"
  done
} # --- }}}2

backup_file() { # backup an already existing file {{{2
# ----------------------------------------------------
# backup_file "filename"
# the file "filename" will be moved to "filename.$TODAY"

  if [ -z "$1" ]; then
    echo "no filename given to backup"
    exit -1
  fi

  if [[ -z $NOBACKUP ]]; then
    if [ -e $1 ]; then
      if [[ -n $VERBOSE ]]; then
        echo "creating backup file:"
      fi

      mv $MVARG $d $d.$TODAY
    fi
  fi
} # --- }}}2

symlink_src_dst_files() { # symlink all SRC_FILES to DST_FILES {{{2
# -----------------------------------------------------------------

  cnt=${#SRC_FILES[@]}
  for (( i = 0; i < cnt; i++)); do
    s=${SRC_FILES[i]}
    d=${DST_FILES[i]}

    backup_file $s
    if [[ -n $VERBOSE ]]; then
      echo "linking $s to $d"
    fi
    ln -s "$s" "$d"
  done
} # --- }}}2

check_for() { # check if $1 is installed on system {{{2
# -----------------------------------------------------
  if [ -z "$1" ]; then
    echo "no programname given to check"
    exit -1
  fi

  # do we have a name string as second parameter? defaults to $1
  if [ -z "$2" ]; then
    name="$1"
  else
    name="$1"
  fi

  if [ -z "$3" ]; then
    optional=""
  else
    optional="$1"
  fi

  prog=`which "$1"`
  if [[ ! $prog =~ "$1" ]]; then
    echo "no $name found, perhaps you should try to install it first."
    if [[ -z $optional ]]; then
      exit -1
    fi
  else
    if [[ -n $VERBOSE ]]; then
      echo "$name found at: $prog"
    fi
  fi
} # }}}2

# ===== }}}1

# Tmux {{{1
# =========

SRC_FILES=( "$SRC/tmux/tmux.conf" "$SRC/tmux/tmux-osx.conf" )
DST_FILES=( "$DEST/.tmux.conf" "$DEST/.tmux-osx.conf")

check_for 'tmux' 'TMux'
symlink_src_dst_files

# ===== }}}1

# Screen {{{1
# ===========

SRC_FILES=( "$SRC/screen/screenrc" )
DST_FILES=( "$DEST/.screenrc" )

# do not require screen - it's replaced with tmux
check_for 'screen' 'Screen' 1
symlink_src_dst_files

# ===== }}}1

# Zsh {{{1
# ========

SRC_FILES=( "$SRC/zsh/zshrc" "$SRC/zsh/zsh" "$SRC/zsh/zshenv" )
DST_FILES=( "$DEST/.zshrc" "$DEST/.zsh" "$DEST/.zshenv" )

# do not require screen - it's replaced with tmux
check_for 'zsh' 'zsh'
symlink_src_dst_files

# ===== }}}1

# Vim {{{1
# ========

#FILES="$dir/dotfiles/*"
SRC_FILES=( "$SRC/vim/vimrc" )
DST_FILES=( "$DEST/.vimrc" )

check_for 'vim'
check_for 'git'

###
# prepare vim directory

vimdir="$DEST/.vim"

# check for backup dir
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
mkdir -p $vimdir/view

FILES="$SRC/vim/colors/*"

for rcfile in $FILES; do
  file=${rcfile##*/}
  destination="$vimdir/colors/$file"
  ln -s "$rcfile" "$destination"
done

FILES="$SRC/vim/spell/*"

for rcfile in $FILES; do
  file=${rcfile##*/}
  destination="$vimdir/spell/$file"
  ln -s "$rcfile" "$destination"
done

FILES="$SRC/vim/vim/*"

for rcfile in $FILES; do
  file=${rcfile##*/}
  destination="$vimdir/$file"
  ln -s "$rcfile" "$destination"
done

symlink_src_dst_files

git clone https://github.com/gmarik/Vundle.vim.git "$vimdir/bundle/Vundle.vim"

vim +PluginInstall +qall

cd "$vimdir/bundle/tern_for_vim" && npm install

# ===== }}}1

# TODO:  {{{1
exit 0

# copy additinal spell-files
cp optional/.vim-spell-de.utf-8.add ~/.vim-spell-de.utf-8.add
cp optional/.vim-spell-en.utf-8.add ~/.vim-spell-en.utf-8.add


# }}}1

# jk-etc-home-dotfiles
Configuration and dotfiles for zsh, vim, tmux, screen and more... for /etc and ~/ (home) usage

# Installation

```shell
git clone https://github.com/jkuetemeier/jk-etc-home-dotfiles.git

./setup.sh -l -v
```

## Backup files

```
# go to install dir
cd ~

# list all created backup files
ls -d .*.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]

# delete all created backup files - BE CAREFULL!!!
ls -d .*.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] | xargs rm -rf
```


# Requirements

## Mac OSX

```shell

# Homebrew (http://brew.sh)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# vim 7.4
brew install vim --with-lua --HEAD

# MacVim (with lua support)
brew install macvim --with-cscope --with-lua --HEAD

# Node.js
brew install node

# install essential Node modules (not required)
node/setup.sh

# Tmux
brew install tmux

# Ctags
brew install ctags

# reattach-to-user-namespace (for clipboard support)
brew install reattach-to-user-namespace
```

# License

&copy; 1998-2015 Jörg Kütemeier &lt;jk@kuetemeier.net&gt;

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

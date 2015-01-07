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

# License

(c) 1998-2015 Jörg Kütemeier <jk@kuetemeier.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

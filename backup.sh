#!/usr/bin/bash

date=`date +"%Y-%m-%dT%H:%M:%S%z"`
echo $date

# Sync config files with git repo
rsync ~/.bashrc ~/dotfiles/shell/.bashrc
rsync ~/.bash_aliases ~/dotfiles/shell/.bash_aliases
rsync ~/.bash_logout ~/dotfiles/shell/.bash_logout
rsync ~/.config/starship.toml ~/dotfiles/shell/starship.toml
# rsync ~/.tmux.conf ~/dotfiles/.tmux.conf
rsync ~/.gitconfig ~/dotfiles/.gitconfig
rsync ~/.dircolors ~/dotfiles/.dircolors
rsync ~/backup.sh ~/dotfiles/backup.sh

# Commit changes and push to github if there are any
cd ~/dotfiles/
if [  -n "$(git status --porcelain)"  ]; then
    git add .
    git commit -m "Logout backup - ${date}"
    git push origin master
fi

# source ~/.backup.sh

#!/usr/bin/bash

# Sync config files with git repo
rsync -ar ~/.config/ ~/dotfiles/
rsync ~/.bashrc ~/dotfiles/.bashrc
rsync ~/.bash_aliases ~/dotfiles/.bash_aliases
rsync ~/.bash_logout ~/dotfiles/.bash_logout
rsync ~/.my_commands.sh ~/dotfiles/.my_commands.sh
rsync ~/.tmux.conf ~/dotfiles/.tmux.conf
rsync ~/.gitconfig ~/dotfiles/.gitconfig
rsync ~/.dircolors ~/dotfiles/.dircolors
rsync ~/backup.sh ~/dotfiles/backup.sh

# Commit changes and push to github if there are any
cd ~/dotfiles/
if [  -n "$(git status --porcelain)"  ]; then
    git add .
    git commit -m "Logout backup"
    git push origin master
fi

# source ~/.backup.sh

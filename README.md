# dotfiles
Dot-files and configuration files. 

## Fresh install on Windows (as of 2018-09-30)

1. Install Ubuntu on Windows from the Microsoft Store.
1. Clones this repo, move `.vimrc` and `.tmux.conf` into `~/`. If you want to use oh-my-zsh, also move `ryi.zsh-theme` into the appropriate themes folder `~/.oh-my-zsh/...`and copy the `.zshrc` file over as well.
1. Run a `sudo apt-get update`.
1. Install pip and pip3 with `sudo apt-get install python3-pip` and `sudo apt-get install python-pip` (optional).
1. `sudo pip3 install virtualenv`.
1. Create a `./venvs` folder.
1. Run `virtualenv -p python3 default` within this folder.

## Notes
* Don't save important non-git-associated files in `~/` -- this directory will be deleted upon uninstall of Ubuntu. Use the `/mnt/c/Users/USERNAME` directory instead.



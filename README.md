## dotfiles
Dot-files and configuration files. 

## Fresh install on Windows (as of 2018-09-30)

### Bare minimum
1. Install Ubuntu on Windows from the Microsoft Store.
2. Clones this repo, move `.vimrc` and `.tmux.conf` into `~/`. If you want to use oh-my-zsh, also move `ryi.zsh-theme` into the appropriate themes folder `~/.oh-my-zsh/...`and copy the `.zshrc` file over as well.
3. Run a `sudo apt-get update`.
4. Install pip and pip3 with `sudo apt-get install python3-pip` and `sudo apt-get install python-pip` (optional).
5. `sudo pip3 install virtualenv`.
6. Create a `./venvs` folder.
7. Run `virtualenv -p python3 default` within this folder.

### Extras
1. Install vimwiki (make sure to do this after moving the `.vimrc` file over -- this contains instructions to create two vimwiki drives for work and personal).
2. Install jupyter-nb-extensions.
3. Install jupyter-vim-binding.

## Notes
* Don't save important non-git-associated files in `~/` -- this directory will be deleted upon uninstall of Ubuntu. Use the `/mnt/c/Users/USERNAME` directory instead.



# dotfiles
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
1. Install vim-plug.
2. Rename directory `vimwiki-personal` in `.vimrc` to whatever you want it to be. Or, add another!
3. Install vimwiki by running `:PlugInstall` in vim (make sure to do this after moving the `.vimrc` file over -- this contains instructions to create two vimwiki drives for work and personal).
4. Run `pip install python-language-server`, restart terminal, then install vim-lsp.
5. Install jupyter-nb-extensions.
6. Install jupyter-vim-binding.
7. Add an auto add, commit, push command, `git acp`, by running: `git config --global alias.acp '!git add -A && git commit -a -m "Automatic add, commit, push." && git push`.

## Notes
* If using WSL, don't save important non-git-associated files in `~/` -- this directory will be deleted upon uninstall of Ubuntu. Use the `/mnt/c/Users/USERNAME` directory instead.



# dotfiles
These are my personal dot-files and configuration files.

## MacOS
1. Clone this repo into `~/repos/dotfiles`.
1. Set up git. If necessary, [generate new SSH keys and add them to your github account](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
1. Navigate to the `dotfiles` directory, and run `. mac.sh`.
1. Run `:PlugInstall` in vim, to install all `.vimrc` plugins.


## Windows
*I spend nearly 100% of my time on mac these days, so these instructions are no longer maintained.*

### WSL
1. Install Ubuntu on Windows from the Microsoft Store.
2. Clones this repo, move `.vimrc` and `.tmux.conf` into `~/`. If you want to
   use oh-my-zsh, also move `ryi.zsh-theme` into the appropriate themes folder
   `~/.oh-my-zsh/...` and copy the `.zshrc` file over as well.
3. Add the contents of `.bashrc_partial` to `.bashrc`, or whatever shell config
   file you're using.
4. Run a `sudo apt-get update`.
5. Install pip and pip3 with `sudo apt-get install python3-pip` and `sudo
   apt-get install python-pip` (optional).
6. `sudo pip3 install virtualenv`.
7. Create a `./venvs` folder.
8. Run `virtualenv -p python3 default` within this folder.
9. Install jupyter-nb-extensions.
10. Install jupyter-vim-binding.

### Vimwiki Links in Browser
Add the line:
`export BROWSER='/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'`
to your `.zshrc` file in order to open links in chrome (or whatever browser you want to use). By default, I've already added it to my `.zshrc` file within this repo, but you might want to change the path according to your default browser.

Unfortunately, however, this doesn't work out of the box for the reasons laid out here: https://github.com/Microsoft/WSL/issues/1766 (at least as of 2019-03-27). Basically, `xdg-open`, which is used by `vimwiki` by default, hates spaces. To fix this, you can go directly into the executable file for `xdg-open` in `/usr/bin/xdg-open` and quote instances of `$browser$`, replacing them with `"$browser"` (around line 840).

### Notes
* If using WSL, don't save important non-git-associated files in `~/` -- this directory will be deleted upon uninstall of Ubuntu. Use the `/mnt/c/Users/USERNAME` directory instead.

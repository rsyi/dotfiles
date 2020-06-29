# dotfiles
These are my personal dot-files and configuration files.

## MacOS
I'm currently using MacOS. On a fresh install,

1. Clone this repo into `~/repos/dotfiles`.
1. Install brew.
1. Navigate to the `dotfiles` directory, and run `. mac.sh`.

### Vim
1. Install neovim (`sudo apt install neovim`).
2. Copy `init.vim` to `~/.config/nvim`.
3. Install vim-plug, following git repo instructions https://github.com/junegunn/vim-plug .
4. Rename directory `vimwiki-personal` in `.vimrc` to whatever you want it to
   be. Optionally, add another for work.
5. Run `pip3 install python-language-server`.
6. Run `:PlugInstall` in vim, to install vim-lsp, vimwiki.

## Fresh install on Windows (as of 2018-09-30) [deprecated]

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



# Prerequisites:
# - ssh keys for github are set up and this repo is cloned into ~/repos

# Install brew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Set up vim.
cp ~/repos/dotfiles/.vimrc ~/.vimrc
brew install neovim
# Other lazyvim dependencies
brew install lazygit
# Add python support.
# pip install neovim && pip3 install neovim
mkdir -p ~/.config/nvim && cp ~/repos/dotfiles/init.vim ~/.config/nvim/init.vim
# Set up zsh.
brew install zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ~/repos/dotfiles/.zshrc ~/.zshrc
cp ~/repos/dotfiles/ryi.zsh-theme ~/.oh-my-zsh/themes/

git config --global user.name "Robert Yi"
git config --global user.email "rosiny@gmail.com"
git config --global --add --bool push.autoSetupRemote true

git clone https://github.com/rupa/z.git ~/repos/z
# Set up python.
brew install python
# Install pip.
curl https://bootstrap.pypa.io/get-pip.py -o ~/get-pip.py
sudo python3 ~/get-pip.py

# Set up virtual environment.
mkdir -p ~/envs/default
python3 -m venv ~/envs/default

# Set up tmux.
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ~/repos/dotfiles/.tmux.conf ~/.tmux.conf

# Set up other CLI tools.
brew install fzf
#brew install fx

# Set up typescript-language-server.
#npm install -g typescript typescript-language-server

# Emacs, doom emacs
#mkdir ~/.emacs.d
#git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
#~/.emacs.d/bin/doom install
#brew install emacs
#brew install coreutils fd
#cp -r ~/repos/dotfiles/.doom.d ~/.doom.d

# Custom emacs functionality
# brew install pngpaste
# For this: https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/

# Custom functionality
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Alacritty
# mkdir -p ~/.config/alacritty/
# cd ~/repos/dotfiles
# cp dracula.yml ~/.config/alacritty/
# cp ./.alacritty.yml ~/

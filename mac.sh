# Prerequisites:
# - ssh keys for github are set up and this repo is cloned into ~/repos
# - brew is installed.
# Once this is complete, run `. mac.sh`.

# Set up vim.
cp ~/repos/dotfiles/.vimrc ~/.vimrc
brew install neovim
mkdir -p ~/.config/nvim && cp ~/repos/dotfiles/init.vim ~/.config/nvim/init.vim
# Set up zsh.
brew install zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ~/repos/dotfiles/.zshrc ~/.zshrc
cp ~/repos/dotfiles/ryi.zsh-theme ~/.oh-my-zsh/themes/

git config --global user.name "Robert Yi"
git config --global user.email "robert@ryi.me"

git clone https://github.com/rupa/z.git ~/repos/z
# Set up python.
brew install python
# Install pip.
curl https://bootstrap.pypa.io/get-pip.py -o ~/get-pip.py
sudo python ~/get-pip.py
pip3 install python-language-server

# Set up virtual environment.
mkdir -p ~/envs/default
python3 -m venv ~/envs/default

# Set up aws cli (CLI tool path added already in ~/.zshrc).
pip3 install awscli --upgrade --user

# Set up tmux.
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ~/repos/dotfiles/.tmux.conf ~/.tmux.conf

# Set up kubectl.
brew install kubectl
git clone git@github.com:ahmetb/kubectl-aliases.git ~/repos/kubectl-aliases/
cp ~/repos/kubectl-aliases/.kubectl_aliases ~/



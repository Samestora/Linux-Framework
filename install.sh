#!/bin/bash

# Install  first and NOT executing this as USER ROOT...
# Anyways...
#
# Detect wheter it's Arch or Ubuntu
detect_os() {
    if grep -qi 'ubuntu' /etc/os-release; then
        os=0
        echo "Ubuntu Detected"
    elif grep -qi 'arch' /etc/os-release; then
        os=1
        echo "Arch Detected"
    else
        echo "Unsupported! Exitting..."
        exit 1
    fi
}

detect_os

if [[ $os=0 ]]; then #Ubuntu
     apt update -y
     apt-get install software-properties-common -y
     add-apt-repository ppa:git-core/ppa -y
     apt update -y
     apt install curl zsh awk tmux neofetch git -y
else # Arch
     pacman -Syuu
     pacman -S curl,zsh,awk,tmux,neofetch,git --noconfirm
fi
    

# ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .zshrc ~/.zshrc

# Syntax Highlighing
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Getting neovim done
sh -c "$(curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
        rm -rf /opt/nvim \
        tar -C /opt -xzf nvim-linux64.tar.gz \
        export PATH="$PATH:/opt/nvim-linux64/bin")"

# installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
chmod +x ~/.fzf/install
~/.fzf/install
source <(fzf --completion --key-bindings --update-rc)

# moving config since im lazy af
mv .config/ ~/

# SOURCE ALL
nvim --headless +"luafile ~/.config/nvim/init.lua" +qall
nvim --headless +"luafile ~/.config/nvim/after/plugin/lsp.lua" +qall
nvim --headless +"luafile ~/.config/nvim/after/plugin/harpoon.lua" +qall
nvim --headless +"luafile ~/.config/nvim/after/plugin/fugitive.lua" +qall
nvim --headless +"luafile ~/.config/nvim/after/plugin/telescope.lua" +qall
nvim --headless +"luafile ~/.config/nvim/after/plugin/treesitter.lua" +qall
nvim --headless +"luafile ~/.config/nvim/lua/Samestora/init.lua" +qall
nvim --headless +"luafile ~/.config/nvim/lua/Samestora/set.lua" +qall
nvim --headless +"luafile ~/.config/nvim/lua/Samestora/remap.lua" +qall
nvim --headless +"luafile ~/.config/nvim/lua/Samestora/packer.lua" +qall
nvim --headless -c 'PackerSync' -c 'qa'

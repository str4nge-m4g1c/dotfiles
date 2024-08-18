# My dotfiles and installs

## Prerequisites

- Install "brew"
- Install "git"
- Install the Setapp and app store application manually
- Git pull "dotfiles" repo

## Running brew

- When getting a bundle, run ```brew bundle dump --file homebrew/Brewfile -f```
- When installing a bundle ```brew bundle install --file homebrew/Brewfile```

## Install oh my zsh

- [Oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
- Run ```sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"```
- Install plugins:
  - ```git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting```
  - ```git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions```

## Stow installation

- Run ```stow .``` from the root directory of this project

## Tmux setup

- Run ```git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm``` to copy the plugin manager for tmux
- Start up tmux by running the command ```tmux```
- Then run ```ctrl + a followed by shift + i```

## macOS installs

- Setapp applications
  - Paste
  - Bartender
  - CleanShot X
  - TextSniper
  - Yoink
  - SSH Config Editor
  - DevUtils
  - iStat Menus
  - Forklift
  - Capto
  - CleanMyMac X
  - Proxyman
  - RapidAPI (previously known as paw)
  - TablePlus
  - Gifox
  - Permute
  - Nitro PDF Pro
  - PDF Squeezer
  - Mindnode
- vs code
- beyond compare
- todoist
- canva
- Docker Desktop
- Magnet
- wireshark

## brew installs

- k9s
- tree
- ripgrep
- git
- aws-cli
- k8s
- fzf
- cheat
- jq
- k6
- kubectx
- lazydocker
- lazygit
- luarocks
- tmux
- watch
- yq
- zoxide
- atac
- neovim
- pyenv
- go

## Online apps

- [Excalidraw](https://excalidraw.com/)
- [Sequence Diagram](https://sequencediagram.org/)
- [Todoist](https://todoist.com/)

# My dotfiles and installs

## Prerequisites

- [brew](https://brew.sh/)
- [git](https://git-scm.com/) - use brew to install

## Running brew

- Pull dotfiles repo to local machine
- Run `brew bundle install --file homebrew/Brewfile` from the root directory of the project
  - If you are saving a bundle, run `brew bundle dump --file homebrew/Brewfile -f`

## Install oh my zsh

- [Oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
- Run `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- Install plugins using git:
  - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
  - `git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

## Stow installation

- Run `stow .` from the root directory of this project to create the symlinks for the dotfiles that house the config

## Tmux setup

- Run `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` to copy the plugin manager for tmux
- Start up tmux by running the command `tmux` in the terminal
- Then run `ctrl + a followed by shift + i` to install the plugins

Have fun! Or get to work! Whatever floats your boat.

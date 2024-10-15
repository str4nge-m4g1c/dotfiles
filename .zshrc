### Start prompt at the bottom of the terminal
printf '\n%.0s' {1..$LINES}

### Tmux setup
tmux_start_or_attach() {
    if tmux has-session -t main 2>/dev/null; then
        tmux attach-session -t main
    else
        tmux new-session -s main
    fi
}

if [ -z "$NVIM" ]; then
    if [ "$TERM_PROGRAM" != "vscode" ]; then
        tmux_start_or_attach
    fi
fi

### pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

### Go setup
export PATH=$PATH:$(go env GOPATH)/bin

### Github GPG setup
# if [ -r ~/.zshrc ]; then echo -e '\nexport GPG_TTY=$(tty)' >> ~/.zshrc; \
#   else echo -e '\nexport GPG_TTY=$(tty)' >> ~/.zprofile; fi
export GPG_TTY=$(tty)

## #ZSH config
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    1password
    git
    docker
    extract
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

###  Environment variables
if [[ -f ~/.zsh_env_vars ]]; then
  source ~/.zsh_env_vars
fi

# export http_proxy=""
# export https_proxy=""
# export no_proxy=""
# export REQUESTS_CA_BUNDLE=""
# export SSL_CERT_FILE=""
# export AWS_CA_BUNDLE=""
# export NODE_EXTRA_CA_CERTS=""
# export DOCKER_DEFAULT_PLATFORM="linux/amd64"
# export NVM_DIR="$HOME/.nvm"
# export VAULT_ADDR=
export EDITOR=nvim

### zsh aliases
alias ls='eza -al --icons=always --sort modified'
alias lg='lazygit'
alias ld='lazydocker'
alias fe='yazi'
alias v='nvim'
alias fo='nvim $(fzf --preview "bat --color=always --style=header,grid --line-range :500 {}")'
# alias fw='rg --files-with-matches --no-heading --line-number --color=always "" | fzf --preview "bat --color=always --style=header,grid --line-range :500 {1}" --bind "enter:execute(nvim {1} +{2})"'
alias clear="clear && printf '\n%.0s' {1..$LINES}"

### zoxide setup
eval "$(zoxide init zsh)"

### Starshp setup
eval "$(starship init zsh)"

### Plugin source
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### yazi config
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

### nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads NVM_DIR
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

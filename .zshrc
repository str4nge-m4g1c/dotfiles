### Tmux setup
tmux_start_or_attach() {
    if tmux has-session -t main 2>/dev/null; then
        tmux attach-session -t main
    else
        tmux new-session -s main
    fi
}

if [ "$TERM_PROGRAM" != "vscode" ]; then
    tmux_start_or_attach
fi

### ZSH config
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
alias ls='eza -al --icons=always'
alias lg='lazygit'
alias ld='lazydocker'
alias fe='yazi'
alias v='nvim'

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

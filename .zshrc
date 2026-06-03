# Start prompt at the bottom of the terminal
printf '\n%.0s' {1..1000000}

# TMUX Setup function
tmux_start_or_attach() {
    if tmux has-session -t main 2>/dev/null; then
        tmux attach-session -t main
    else
        tmux new-session -s main
    fi
}

# Only auto-start tmux if:
# - Not in Zed
# - Not in VSCode
# - Not in Neovim
# - Not already in tmux
# - In an interactive shell
if command -v tmux >/dev/null 2>&1; then
  if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$TERM_PROGRAM" != "zed" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ -z "$NVIM" ]]; then
    tmux_start_or_attach
  fi
fi

### Ghostty shell integration (needed inside tmux for notify-on-command-finish)
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

### maven setup
export MAVEN_HOME="/usr/local/apache-maven"
export PATH=$MAVEN_HOME/bin:$PATH


### pyenv setup
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

### Go setup
# export PATH=$PATH:$(go env GOPATH)/bin

### Github GPG setup
export GPG_TTY=$(tty)

## #ZSH config
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    # 1password
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
alias fh='fzf_history'
# alias fw='rg --files-with-matches --no-heading --line-number --color=always "" | fzf --preview "bat --color=always --style=header,grid --line-range :500 {1}" --bind "enter:execute(nvim {1} +{2})"'
alias clear="clear && printf '\n%.0s' {1..$LINES}"
alias specify="uvx --from git+https://github.com/github/spec-kit.git specify"
alias alert='osascript -e "display notification \"Last command finished (exit: $?)\" with title \"Terminal\" sound name \"Glass\""'
alias serve='markserv'


### Auto-notify for long-running commands (>10s)
_notify_cmd_start=""
_notify_cmd_name=""

_notify_preexec() {
  _notify_cmd_start=$EPOCHSECONDS
  _notify_cmd_name="$1"
}

_notify_precmd() {
  local exit_code=$?
  if [[ -n "$_notify_cmd_start" ]]; then
    local elapsed=$(( EPOCHSECONDS - _notify_cmd_start ))
    if (( elapsed >= 10 )); then
      local status_text="succeeded"
      (( exit_code != 0 )) && status_text="failed (exit: $exit_code)"
      osascript -e "display notification \"${_notify_cmd_name} ${status_text} after ${elapsed}s\" with title \"Terminal\" sound name \"Glass\"" &!
    fi
  fi
  _notify_cmd_start=""
  _notify_cmd_name=""
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _notify_preexec
add-zsh-hook precmd _notify_precmd

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

### fzf setup for history
fzf_history() {
  local selected_command=$(history | fzf --tac | awk '{$1=""; print $0}')
  if [[ -n $selected_command ]]; then
    print -z "$selected_command"
  fi
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"



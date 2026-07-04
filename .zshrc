# Start prompt at the bottom of the terminal
printf '\n%.0s' {1..1000000}

### Machine profile (personal | work) ---------------------------------------
# Decides which secrets and tools load. Defaults to "personal"; the work laptop
# overrides this via ~/.config/dotfiles/profile (machine-local, not committed).
# See .config/dotfiles/profile.example for the template.
export DOTFILES_PROFILE="personal"
[[ -f ~/.config/dotfiles/profile ]] && source ~/.config/dotfiles/profile

### Terminal multiplexing ----------------------------------------------------
# tmux has been retired. herdr handles agent multiplexing (Claude Code /
# Copilot / Gemini / pi) and, like a tmux auto-attach setup, we drop straight
# into the persistent workspace on every new interactive shell.
#
# The background `herdr server` daemon holds the session (panes + agents keep
# running when the window closes); this just reattaches a client to it.
# HERDR_ENV is set inside herdr's own panes, so nested shells skip the attach
# and get a plain prompt (no recursion). Ctrl-C at launch also drops to bare zsh.
if [[ $- == *i* && -z $HERDR_ENV && -z $HERDR_SESSION ]]; then
  herdr
fi

### Ghostty shell integration (notify-on-command-finish)
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

# Prompt is rendered by starship (see end of file), so leave the oh-my-zsh
# theme empty to avoid two prompt engines fighting each other.
ZSH_THEME=""

plugins=(
    # 1password
    git
    docker
    extract
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

### Secrets & machine-local config (never committed) ------------------------
# Layer 1: legacy env-var file, kept for back-compat.
[[ -f ~/.zsh_env_vars ]] && source ~/.zsh_env_vars

# Layer 2: per-machine overrides. This is where the WORK laptop keeps its
# proxy, CA bundle and platform exports (http_proxy, REQUESTS_CA_BUNDLE,
# SSL_CERT_FILE, AWS_CA_BUNDLE, NODE_EXTRA_CA_CERTS, DOCKER_DEFAULT_PLATFORM,
# VAULT_ADDR, ...). The home laptop simply won't have this file.
# Template: .zsh_local.example
[[ -f ~/.zsh_local ]] && source ~/.zsh_local

# Layer 3: 1Password secret injection. Pull API keys at runtime instead of
# writing them to disk. `op` is signed in to a different account per laptop, so
# work secrets never reach home and vice versa.
#   opsecret NAME "op://Vault/Item/field"  -> exports NAME from 1Password.
opsecret() {
  command -v op >/dev/null 2>&1 || return 0
  export "$1"="$(op read "$2" 2>/dev/null)"
}
# Put the actual opsecret calls in ~/.zsh_local, e.g.:
#   opsecret ANTHROPIC_API_KEY "op://Personal/anthropic/credential"
#   opsecret GEMINI_API_KEY    "op://Personal/gemini/credential"

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



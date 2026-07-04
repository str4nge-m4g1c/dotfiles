# My dotfiles and installs

Streamlined terminal setup: **Ghostty + Neovim/LazyVim**, **herdr** for agent
multiplexing (replaces tmux), and **pi (pi.dev)** as a unified AI-agent surface.
One repo runs on both my home and work laptops without sharing secrets between
them. See [DESIGN.md](DESIGN.md) for the full rationale.

## Prerequisites

- [brew](https://brew.sh/)
- [git](https://git-scm.com/) — `brew install git`

## 1. Install packages

From the root of this repo:

```sh
brew bundle install --file homebrew/Brewfile
```

This installs the whole toolchain including **herdr** and **bun** (bun runs pi).
To re-dump after changes: `brew bundle dump --file homebrew/Brewfile -f`.

## 2. Install oh-my-zsh + plugins

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

The prompt is rendered by **starship**; the oh-my-zsh theme is intentionally empty.

## 3. Symlink the dotfiles

```sh
stow .
```

`.example` files and `DESIGN.md` are excluded from stow (see `.stow-local-ignore`).

## 4. Machine profile + local config (per laptop)

These files are **not committed** and differ per machine. Copy the templates:

```sh
# personal vs work
mkdir -p ~/.config/dotfiles
cp .config/dotfiles/profile.example ~/.config/dotfiles/profile   # edit: personal | work

# per-machine shell config (work proxy/CA bundle, opsecret calls)
cp .zsh_local.example ~/.zsh_local                                # edit as needed
```

## 5. Git identity (per laptop)

Identity is kept out of the repo. Copy the templates you need:

```sh
cp .config/git/identity.local.example ~/.config/git/identity.local   # default identity
# work laptop only — applied automatically to repos under ~/work/
cp .config/git/identity.work.example  ~/.config/git/identity.work
```

## 6. Secrets via 1Password

API keys are pulled at runtime, never stored in the repo. Sign in to the
[1Password CLI](https://developer.1password.com/docs/cli/) (`op`) — use the
**personal** account at home and the **work** account at work. Then add
`opsecret` calls to `~/.zsh_local`, e.g.:

```sh
opsecret ANTHROPIC_API_KEY "op://Personal/anthropic/credential"   # home
opsecret GEMINI_API_KEY    "op://Personal/gemini/credential"      # home
```

## 7. AI agents

- **herdr** — run `herdr` to start/attach the agent workspace. Prefix `ctrl+b`,
  `ctrl+b ?` for all bindings. Add integrations:
  `herdr integration install pi|claude|copilot`.
- **pi** — `curl -fsSL https://pi.dev/install.sh | sh` (or `bun add -g @earendil-works/pi-coding-agent`).
  Same config both laptops; provider/key comes from the secret layer.
- Native CLIs stay available: Claude Code + Gemini CLI (home), GitHub Copilot CLI (work).

Have fun!

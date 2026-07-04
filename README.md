# My dotfiles and installs

Streamlined terminal setup: **Ghostty + Neovim/LazyVim**, **herdr** for agent
multiplexing (replaces tmux), with **pi** and/or **opencode** as optional
AI-agent surfaces. One repo runs on both my home and work laptops without
sharing secrets between them. See [DESIGN.md](DESIGN.md) for the full rationale.

## Prerequisites

- [brew](https://brew.sh/)
- [git](https://git-scm.com/) — `brew install git`

## 1. Install packages

From the root of this repo:

```sh
brew bundle install --file homebrew/Brewfile
```

This installs the core toolchain including **herdr** and **bun** (bun is the
runtime for optional AI agents). AI coding agents (pi, opencode) are listed in
the optional section at the bottom of the Brewfile — uncomment to install.
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

- **herdr** — auto-attaches on each new interactive shell (guarded by
  `HERDR_ENV`, so nested panes get a plain prompt; Ctrl-C at launch skips it).
  The `herdr server` daemon persists the session, so closing a window keeps
  panes + agents alive and the next shell reattaches. Prefix `ctrl+b`,
  `ctrl+b ?` for all bindings. Add integrations:
  `herdr integration install pi|claude|copilot`.
- Native CLIs always available: Claude Code + Gemini CLI (home), GitHub Copilot CLI (work).

**Optional TUI agents** — install one or both; see the Brewfile optional section
for brew formulas (where available) and manual install commands.

- **pi** — multi-provider TUI (Claude, Gemini, OpenAI, Copilot…). Committed
  config in `.config/pi/` is identical on both machines; provider + key come
  from `~/.zsh_local`. See `.config/pi/README.md`.
- **opencode** — TUI coding agent (Anthropic, OpenAI, local models).
  See `.config/opencode/README.md`.

Have fun!

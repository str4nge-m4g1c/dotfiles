# Dotfiles Design: Ghostty + Neovim + herdr + pi

This document describes the streamlined terminal setup and how one set of
dotfiles is shared across a **home** laptop and a **work** laptop without ever
sharing sensitive information between them.

## Goals

1. A lean terminal stack: **Ghostty + Neovim/LazyVim**, with **herdr** replacing
   tmux and **pi (pi.dev)** as a unified AI-agent surface.
2. **One dotfiles repo** cloned to both laptops, byte-for-byte identical.
3. **No secret leakage** between machines: work credentials, proxies, CA
   bundles and identities stay on the work laptop; personal ones stay at home.

## The stack

### Terminal & editor
- **Ghostty** is the terminal. Its native tabs and splits handle window
  management, so Neovim no longer needs a multiplexer wrapped around it.
- **Neovim / LazyVim** is the editor (`.config/nvim`), launched via `v`/`nvim`.

### tmux → herdr
tmux is retired. herdr is tmux rebuilt for AI agents: it keeps persistent
sessions, panes, tabs and workspaces, detaches/reattaches (including over SSH
from a phone), but also shows each agent's live state — 🔴 blocked, 🟡 working,
🔵 done, 🟢 idle — in a sidebar, and exposes a socket API that agents can drive.

- Not auto-started (the old tmux auto-attach in `.zshrc` is gone). Run `herdr`
  to start or attach the agent workspace.
- Prefix is `ctrl+b`; mouse-native otherwise. Config: `.config/herdr/config.toml`.
- Install per-agent integrations for native restore + semantic state:
  `herdr integration install pi|claude|copilot`.
- herdr supports Claude Code, GitHub Copilot CLI, pi and (detected) Gemini CLI —
  i.e. every agent used across both laptops.

### pi.dev as the unifying agent harness
The efficiency win. Instead of maintaining three different agent CLIs with three
config surfaces (Claude Code + Gemini at home, Copilot at work), **pi** gives one
consistent TUI, keybindings, skills and prompt templates. pi's `pi-ai` layer
speaks to 15+ providers behind one interface, so the *committed pi config is
identical on both machines* — only the provider + key change, and those come
from the machine-local secret layer, never from this repo.

- Home: `ANTHROPIC_API_KEY` (Claude) + `GEMINI_API_KEY` (Gemini).
- Work: point pi at the enterprise/OpenAI endpoint, or keep driving GitHub
  Copilot CLI natively — herdr shows both the same way.

The native CLIs (Claude Code, Copilot CLI, Gemini CLI) stay available; pi is the
common muscle-memory surface layered on top.

## Shared dotfiles without shared secrets

Everything is layered so the same repo is safe on both machines.

### Layer 1 — committed & shared (this repo)
All non-sensitive config: Ghostty, Neovim, herdr, pi, zsh logic, Brewfile,
starship, and a **git base config with no identity in it**.

### Layer 2 — machine profile (untracked)
`~/.config/dotfiles/profile` sets `DOTFILES_PROFILE` to `personal` or `work` and
any per-machine feature flags. `.zshrc` sources it early and defaults to
`personal` when absent. Template: `.config/dotfiles/profile.example`.

### Layer 3 — machine-local shell config (untracked)
`~/.zsh_local` holds anything that must differ per laptop: the **work** proxy,
CA bundle, `NODE_EXTRA_CA_CERTS`, `DOCKER_DEFAULT_PLATFORM`, `VAULT_ADDR`, etc.
The home laptop simply doesn't have this file. Template: `.zsh_local.example`.

### Layer 4 — secrets via 1Password (never on disk)
`.zshrc` defines `opsecret NAME "op://Vault/Item/field"`, which exports a value
read from 1Password at runtime. The actual `opsecret` calls live in `~/.zsh_local`.
Because `op` is signed in to a **different 1Password account per laptop**, the
work vault's keys are unreachable from the home machine and vice versa — even
though the committed dotfiles are identical. Both mechanisms are used: `op` for
API keys, the plaintext `~/.zsh_local` for non-secret machine settings.

### Git identity — automatic per context
`.config/git/config` (committed, XDG path) sets shared options but **no
identity**. It includes two untracked files:

- `~/.config/git/identity.local` — default identity for this machine.
- `~/.config/git/identity.work` — applied only to repos under `~/work/` via
  `includeIf`, so work commits get the work email/signing key automatically.

Templates: `.config/git/identity.local.example`, `identity.work.example`.

## What was removed
- `.tmux.conf`, `.config/tmux/` and TPM (replaced by herdr).
- `.config/kitty/` and `.wezterm.lua` (standardized on Ghostty).
- Redundant oh-my-zsh `robbyrussell` theme (starship renders the prompt).
- tmux auto-start block in `.zshrc`.

## What was added
- Machine profile + `~/.zsh_local` + `opsecret` layering in `.zshrc`.
- `.config/herdr/`, `.config/pi/` config modules.
- `.config/git/config` with `includeIf` and identity templates.
- `herdr` and `bun` in the Brewfile (bun runs pi); `tmux` removed.

## Files map

| Path | Committed? | Purpose |
|------|-----------|---------|
| `.config/ghostty/config` | yes | Terminal |
| `.config/nvim/` | yes | Editor (LazyVim) |
| `.config/herdr/config.toml` | yes | Agent multiplexer |
| `.config/pi/` | yes | Unified agent harness config |
| `.config/git/config` | yes | Shared git options (no identity) |
| `.config/git/identity.local` | **no** | Default identity |
| `.config/git/identity.work` | **no** | Work identity (`~/work/` only) |
| `~/.config/dotfiles/profile` | **no** | `personal` vs `work` |
| `~/.zsh_local` | **no** | Per-machine exports + `opsecret` calls |
| 1Password (`op`) | n/a | Runtime API keys, separate account per laptop |

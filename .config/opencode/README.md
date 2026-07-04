# opencode — optional TUI coding agent

opencode is one of two optional AI coding agent surfaces in this setup (the
other is pi). Committed config here is identical on both laptops; only the
*provider + key* differ, and those come from the machine-local secret layer —
never from this repo.

## Install (optional — choose one method)

```sh
bun add -g opencode-ai
```

bun is already installed by the Brewfile. See `homebrew/Brewfile` (optional
section) for a brew formula if one becomes available, or check
https://opencode.ai for the latest install method.

## Provider config

opencode picks up API keys via env vars injected at runtime by `opsecret`
(defined in `.zshrc`, called from `~/.zsh_local`):

- Home:  ANTHROPIC_API_KEY (Claude) + GEMINI_API_KEY (Gemini)
- Work:  OPENAI_API_KEY / enterprise endpoint

Because keys live in 1Password (different account per laptop), work credentials
never touch the home machine and vice versa.

## Settings

Put non-secret, shareable opencode settings (theme, keybinds, prompt templates)
in this directory. Verify the exact filename/schema against the docs before
relying on it, then commit it here so both laptops stay in sync.

Docs: https://opencode.ai

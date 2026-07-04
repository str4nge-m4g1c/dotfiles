# pi (pi.dev) — unified terminal coding agent

pi is the single agent surface used on BOTH laptops. The committed config here
is identical everywhere; only the *provider + key* differ, and those come from
the machine-local secret layer — never from this repo.

## How the same config works on both machines
pi-ai speaks to many providers behind one interface, selected by env vars that
are injected at runtime via `opsecret` (defined in `.zshrc`, called from
`~/.zsh_local`):

- Home:  ANTHROPIC_API_KEY (Claude) + GEMINI_API_KEY (Gemini)
- Work:  OPENAI_API_KEY / enterprise endpoint (or drive GitHub Copilot natively)

Because keys live in 1Password (different account per laptop), work credentials
never touch the home machine and vice versa.

## Install
    curl -fsSL https://pi.dev/install.sh | sh
    # or with bun/npm: bun add -g @earendil-works/pi-coding-agent

Docs: https://pi.dev/docs/latest

## Settings
Put non-secret, shareable pi settings (theme, keybinds, prompt templates,
skills) in this directory. Verify the exact filename/schema against the docs
before relying on it, then commit it here so both laptops stay in sync.

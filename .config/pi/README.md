# pi (pi.dev) — optional multi-provider TUI coding agent

pi is one of two optional AI coding agent surfaces in this setup (the other is
opencode). The committed config here is identical on both laptops; only the
*provider + key* differ, and those come from the machine-local secret layer —
never from this repo.

## Install (optional — choose one method)

```sh
bun add -g @earendil-works/pi-coding-agent
# or
curl -fsSL https://pi.dev/install.sh | sh
```

bun is already installed by the Brewfile. See `homebrew/Brewfile` (optional
section) for a brew formula if one becomes available.

## How the same config works on both machines

pi-ai speaks to many providers behind one interface, selected by env vars that
are injected at runtime via `opsecret` (defined in `.zshrc`, called from
`~/.zsh_local`):

- Home:  ANTHROPIC_API_KEY (Claude) + GEMINI_API_KEY (Gemini)
- Work:  OPENAI_API_KEY / enterprise endpoint (or drive GitHub Copilot natively)

Because keys live in 1Password (different account per laptop), work credentials
never touch the home machine and vice versa.

## Settings

Put non-secret, shareable pi settings (theme, keybinds, prompt templates,
skills) in this directory. Verify the exact filename/schema against the docs
before relying on it, then commit it here so both laptops stay in sync.

Docs: https://pi.dev/docs/latest

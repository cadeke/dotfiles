# dotfiles

Dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow .
```

Stow ignores `README.md`, `.git` and `.gitignore` by default.

## Contents

| Path | Tool |
| --- | --- |
| `.zshrc` | zsh (zinit, fzf, starship, nvm) |
| `.gitconfig`, `.config/git/allowed_signers` | git, SSH commit signing |
| `.config/nvim` | Neovim (kickstart-based, plugins in `lua/custom/plugins`) |
| `.config/tmux` | tmux (prefix `C-Space`, AZERTY-friendly window bindings) |
| `.config/kitty`, `.config/alacritty` | terminals |
| `.config/starship.toml` | prompt |

## Requirements

zsh, git, stow, fzf, bat, tree, starship, neovim, tmux, lazygit,
JetBrainsMono Nerd Font. Optional: Linuxbrew, nvm.
Neovim formatters/linters: stylua, shfmt, prettier(d), black, isort, ruff,
markdownlint, yamllint, shellcheck.

## Notes

- Commits are signed with `~/.ssh/id_ed25519`. The matching public key is in
  `.config/git/allowed_signers`, so `git log --show-signature` can verify them.
- The `imp` branch holds the work-machine variant; `main` is the base.

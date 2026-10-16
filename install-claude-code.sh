#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/modules.sh"

CLAUDE_BIN="$HOME/.local/bin/claude"
ALIAS_LINE='alias claude="$HOME/.local/bin/claude"'
CLAUDE_SETTINGS_SRC="$HOME/.dotfiles/claude-settings.json"
CLAUDE_SETTINGS_DEST="$HOME/.claude/settings.json"

# =========== Install ===========

FN_PRINT_GREEN_BANNER "Installing Claude Code CLI"

if [[ -x "$CLAUDE_BIN" ]]; then
  FN_PRINT_YELLOW "Claude Code already installed ($("$CLAUDE_BIN" --version)). Skipping install."
else
  curl -fsSL https://claude.ai/install.sh | bash
  [[ -x "$CLAUDE_BIN" ]] || FN_ERR_EXIT "claude binary not found at $CLAUDE_BIN after install"
  FN_PRINT_GREEN_BANNER "Claude Code CLI Installed!"
fi

# =========== Alias ===========

if ! grep -qxF "$ALIAS_LINE" ~/.bashrc; then
  FN_PRINT_YELLOW "Adding claude alias to bashrc"
  echo "$ALIAS_LINE" >> ~/.bashrc
else
  FN_PRINT_YELLOW "Claude Code alias already exists in bashrc. Skipping."
fi

# =========== Settings ===========

[[ -f "$CLAUDE_SETTINGS_SRC" ]] || FN_ERR_EXIT "settings not found at $CLAUDE_SETTINGS_SRC"

if ! [ -L "$CLAUDE_SETTINGS_DEST" ]; then
  FN_PRINT_YELLOW "Claude settings symlink not found. Linking settings.json"
  mkdir -p "$HOME/.claude"

  # A regular file may exist (e.g. created by Claude Code); back it up instead of failing
  if [ -e "$CLAUDE_SETTINGS_DEST" ]; then
    mv "$CLAUDE_SETTINGS_DEST" "${CLAUDE_SETTINGS_DEST}.bak"
    FN_PRINT_YELLOW "Existing settings.json backed up to ${CLAUDE_SETTINGS_DEST}.bak"
  fi

  ln -s "$CLAUDE_SETTINGS_SRC" "$CLAUDE_SETTINGS_DEST"
  FN_PRINT_GREEN_BANNER "Claude Code settings configured!"
else
  FN_PRINT_YELLOW "Claude settings symlink found."
fi

FN_PRINT_YELLOW "Open a new terminal (or run: source ~/.bashrc) to use 'claude'"

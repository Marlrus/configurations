#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/modules.sh"

CLAUDE_BIN="$HOME/.local/bin/claude"
ALIAS_LINE='alias claude="$HOME/.local/bin/claude"'

FN_PRINT_GREEN_BANNER "Installing Claude Code CLI"

# Early exit if already installed
if [[ -x "$CLAUDE_BIN" ]]; then
  FN_PRINT_YELLOW "Claude Code already installed ($("$CLAUDE_BIN" --version)). Skipping."
  exit 0
fi

curl -fsSL https://claude.ai/install.sh | bash

[[ -x "$CLAUDE_BIN" ]] || FN_ERR_EXIT "claude binary not found at $CLAUDE_BIN after install"

FN_PRINT_YELLOW "Adding claude alias to bashrc"
if ! grep -qxF "$ALIAS_LINE" ~/.bashrc; then
  echo "$ALIAS_LINE" >> ~/.bashrc
else
  FN_PRINT_YELLOW "Claude Code alias already exists in bashrc. Skipping."
fi

FN_PRINT_GREEN_BANNER "Claude Code CLI Installed!"
FN_PRINT_YELLOW "Open a new terminal (or run: source ~/.bashrc) to use 'claude'"

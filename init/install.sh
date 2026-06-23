#!/usr/bin/env bash
#
# Bootstrap a new Mac:
#   * Xcode Command Line Tools
#   * Homebrew
#   * every formula, cask and Mac App Store app from the Brewfile
#   * switch the login shell to the Homebrew Bash
#
# Run it from your $HOME, where this dotfiles repo lives:
#
#   ./init/install.sh

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ======== Xcode Command Line Tools ==========

if ! xcode-select -p >/dev/null 2>&1; then
    echo "Installing the Xcode Command Line Tools…"
    xcode-select --install
    # The install runs in a separate GUI process; wait for it to finish.
    until xcode-select -p >/dev/null 2>&1; do
        sleep 30
    done
fi

# ========= Homebrew ==========

if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew…"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make `brew` available in this shell (Apple Silicon uses /opt/homebrew).
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Install all formulae, casks and Mac App Store apps.
# `brew bundle` is built into Homebrew 6.0+, so no `brew tap` is needed.
# Sign in to the App Store first so the `mas` entries can install.
brew bundle --file="$DOTFILES/Brewfile"

# ========= Default shell ==========

# Enable the latest Bash installed from Homebrew.
BREW_BASH="$(brew --prefix)/bin/bash"
if ! grep -qxF "$BREW_BASH" /etc/shells; then
    echo "Adding $BREW_BASH to /etc/shells…"
    echo "$BREW_BASH" | sudo tee -a /etc/shells >/dev/null
fi
if [ "${SHELL:-}" != "$BREW_BASH" ]; then
    chsh -s "$BREW_BASH"
fi

echo "Done. Open a new terminal, then run ./.macos to apply macOS system preferences."

#!/usr/bin/env bash
#
# Bootstrap a new Mac:
#   * Xcode Command Line Tools
#   * Homebrew
#   * every formula, cask and Mac App Store app from the Brewfile
#   * switch the login shell to the Homebrew Bash
#   * apply macOS system preferences (./.macos)
#
# Run it from your $HOME, where this dotfiles repo lives:
#
#   ./init/install.sh
#
# It is idempotent — safe to re-run. Set NO_MACOS=1 to skip the .macos step
# (e.g. for an unattended run): NO_MACOS=1 ./init/install.sh

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

# Homebrew 6.0 refuses to load formulae from untrusted third-party taps.
# Trust just the formulae we use (narrower than trusting the whole tap).
# `brew trust` only records an entry, so it is safe to run before the tap
# exists; `brew bundle` taps it from the qualified name in the Brewfile.
brew trust --formula caarlos0/tap/fork-cleaner
brew trust --formula tdewolff/tap/minify

# Install all formulae, casks and Mac App Store apps.
# `brew bundle` is built into Homebrew 6.0+.
# Sign in to the App Store first so the `mas` entries can install.
#
# `--no-upgrade` only installs what is missing. Without it, an OS-bundled Mac
# App Store app that is a version behind (e.g. Keynote/Pages/Numbers) makes
# `brew bundle` attempt a `mas upgrade`, which needs an interactive sudo and
# is reported as a failure on a fresh machine.
#
# Homebrew 6.0 installs in parallel, and concurrent jobs can briefly contend
# for a shared dependency's Cellar lock ("process has already locked …"),
# failing an otherwise-fine formula. `brew bundle` is idempotent, so retry a
# few times; each pass only installs what is still missing.
bundled=false
for attempt in 1 2 3; do
    if brew bundle --file="$DOTFILES/Brewfile" --no-upgrade; then
        bundled=true
        break
    fi
    echo "brew bundle attempt $attempt failed; retrying…"
done
if [ "$bundled" != true ]; then
    echo "brew bundle still failing after 3 attempts; see the errors above." >&2
    exit 1
fi

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

# ========= macOS system preferences =========

# Apply this setup's macOS defaults (Dock, Finder, trackpad, Mission Control,
# Stage Manager, menu bar and keyboard shortcuts). `.macos` is idempotent but
# restarts Dock/Finder and quits a few apps, so confirm first when interactive.
# Skip entirely with NO_MACOS=1.
if [ "${NO_MACOS:-}" = 1 ]; then
    echo "Skipping macOS preferences (NO_MACOS=1). Run ./.macos later to apply."
else
    reply=y
    if [ -t 0 ]; then
        read -r -p "Apply macOS system preferences now (runs ./.macos, restarts Dock/Finder)? [Y/n] " reply
    fi
    case "$reply" in
        [nN]*) echo "Skipped .macos — run ./.macos later to apply." ;;
        *)     "$DOTFILES/.macos" ;;
    esac
fi

echo "Done. Open a new terminal so the new login shell and settings take effect."

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

# ========= SSH key ==========

# Generate a modern ed25519 key if none exists. Git is configured to sign
# commits with ~/.ssh/id_ed25519.pub (commit.gpgSign = true), so the key must
# exist before the first commit. After this, add it to GitHub as both an
# authentication and a signing key and switch the remote to SSH — see README.
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "Generating an ed25519 SSH key…"
    ssh-keygen -t ed25519 -a 100 -C "$(whoami)@$(hostname -s)" -f "$HOME/.ssh/id_ed25519" -N ""
fi

# ========= Touch ID for sudo ==========

# Let sudo (including the .macos step below) accept Touch ID. The drop-in
# /etc/pam.d/sudo_local persists across macOS updates (Sonoma and later).
if [ ! -e /etc/pam.d/sudo_local ]; then
    echo "Enabling Touch ID for sudo…"
    printf 'auth       sufficient     pam_tid.so\n' | sudo tee /etc/pam.d/sudo_local >/dev/null
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

# ========= Git maintenance ==========

# Register this dotfiles repo for background maintenance (incremental gc,
# commit-graph, prefetch). Run the same in any other repo you want kept tidy.
git -C "$DOTFILES" maintenance start 2>/dev/null || true

# ========= Headroom (Claude Code context compression) ==========

# Install the headroom CLI from PyPI into its own pipx-managed venv (Python,
# not the Docker image). pipx itself comes from the Brewfile. The `cc` alias in
# ~/.aliases runs `headroom wrap claude … --memory --code-graph`. Idempotent —
# pipx skips an already-installed package.
if command -v pipx >/dev/null 2>&1; then
    echo "Installing the headroom CLI…"
    pipx install "headroom-ai[all]" || true
fi

# Pre-install the code-graph backend (codebase-memory-mcp). headroom 0.27 pins
# v0.6.0, whose release has no published binaries (404), so its auto-download
# fails. headroom probes ~/.local/bin first, so drop a working build there to
# take over. Serena (the other --code-graph helper) runs via uvx from the
# Brewfile's `uv`. Bump CBM_VER as new tagged binaries ship.
CBM_VER="v0.8.1"
CBM_BIN="$HOME/.local/bin/codebase-memory-mcp"
if [ ! -x "$CBM_BIN" ]; then
    case "$(uname -m)" in
        arm64 | aarch64) CBM_ARCH="darwin-arm64" ;;
        *) CBM_ARCH="darwin-amd64" ;;
    esac
    CBM_URL="https://github.com/DeusData/codebase-memory-mcp/releases/download/${CBM_VER}/codebase-memory-mcp-${CBM_ARCH}.tar.gz"
    echo "Installing codebase-memory-mcp ${CBM_VER} (${CBM_ARCH})…"
    CBM_TMP="$(mktemp -d)"
    if curl -fsSL "$CBM_URL" -o "$CBM_TMP/cbm.tar.gz" && tar -xzf "$CBM_TMP/cbm.tar.gz" -C "$CBM_TMP"; then
        mkdir -p "$HOME/.local/bin"
        install -m 0755 "$(find "$CBM_TMP" -type f -name codebase-memory-mcp | head -1)" "$CBM_BIN"
    else
        echo "  codebase-memory-mcp download failed — skipping (code graph stays off)."
    fi
    rm -rf "$CBM_TMP"
fi

# ========= Linux container runtime (apple/container) ==========

# Start Apple's `container` service and install its default kernel so Linux
# containers work out of the box (Apple Silicon + macOS 26+). Idempotent;
# tolerate older hardware/OS where it isn't available. For an always-on service
# at login instead, use `brew services start container`.
if command -v container >/dev/null 2>&1; then
    echo "Starting the Apple container runtime…"
    container system start --enable-kernel-install || true
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

# Guard against the ~/.bash_profile <-> ~/.bashrc mutual-source loop that otherwise
# hangs every interactive shell (.bash_profile sources .bashrc at the bottom, and
# .bashrc sources .bash_profile when $PS1 is set). Load this file at most once.
[[ -n $__DOTFILES_PROFILE_LOADED ]] && return
__DOTFILES_PROFILE_LOADED=1

[[ $- == *i* ]] && bind -f ~/.inputrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Case-insensitive globbing (used in pathname expansion)
# shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
# shopt -s histappend;

# Autocorrect typos in path names when using `cd`
# shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar cmdhist lithist histappend nocaseglob nocasematch cdspell no_empty_cmd_completion; do
    shopt -s "$option" 2> /dev/null;
done;

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Enable Shell integration for iTerm2
# http://iterm2.com/shell_integration.html
if [ -f ~/.iterm2_shell_integration.bash ]; then
    source ~/.iterm2_shell_integration.bash
fi

# Add `rbenv init` to the shell to enable shims and autocompletion
if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi;

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,completion}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export PATH="$HOME/.local/bin:$PATH"

export PATH=$PATH:$HOME/.maestro/bin

# pnpm
export PNPM_HOME="/Users/hkdobrev/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Google Cloud SDK (installed via Homebrew cask, 2026-05-19)
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.bash.inc' ]; then
  . '/opt/homebrew/share/google-cloud-sdk/path.bash.inc'
fi
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.bash.inc' ]; then
  . '/opt/homebrew/share/google-cloud-sdk/completion.bash.inc'
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Mole shell completion
if output="$(mole completion bash 2>/dev/null)"; then eval "$output"; fi

[[ -r ~/.bashrc ]] && source ~/.bashrc

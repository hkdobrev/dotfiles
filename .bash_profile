# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable jump https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# If possible, add tab completion for many more commands
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Enable Shell integration for iTerm2
# http://iterm2.com/shell_integration.html
source ~/.iterm2_shell_integration.bash

if command -v brew >/dev/null; then
    # Add bash completion for brew installed formuale
    if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
        . $(brew --prefix)/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion;
    fi

    # Brew & Cask aliases
    alias b="brew"
    alias cask="brew cask"

    # Enable brew command autocompletion for `b` alias as well
    complete -o default -F _brew b

    # Enable vagrant command autocompletion for `vg` alias as well
    complete -o default -F _vagrant vg
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi

# Add `rbenv init` to the shell to enable shims and autocompletion
if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi;

# gulp completion
eval "$(gulp --completion=bash)"

# Symfony console completion
eval "$(symfony-autocomplete --aliases=c)"

# added by travis gem
[ -f /Users/hkdobrev/.travis/travis.sh ] && source /Users/hkdobrev/.travis/travis.sh

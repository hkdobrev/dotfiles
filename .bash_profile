bind -f ~/.inputrc

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Disable programmable completion which could escape dollars while doing tab completion
#shopt -u progcomp

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$HOMEBREW_PREFIX/local/opt/mysql@5.7/bin:$PATH"

#    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
#        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#      else
#        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
#          [[ -r "$COMPLETION" ]] && source "$COMPLETION"
#        done
#      fi

    # Add bash completion for brew installed formuale
    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

    # Brew & Cask aliases
    alias b="brew"
    alias cask="brew cask"

    # Enable brew command autocompletion for `b` alias as well
    complete -o default -F _brew b

    # Enable tab completion for `g` alias of git
    if [ -f "$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash" ]; then
        complete -o default -o nospace -F __git_wrap__git_main git;
        complete -o default -o nospace -F __git_wrap__git_main g;
    fi;

    # Enable terraform completion
    complete -C "$HOMEBREW_PREFIX/local/bin/terraform" terraform
    complete -C terraform tf

    # Minio completion
    complete -C "$HOMEBREW_PREFIX/local/bin/mc" mc

    # nvm setup
    [ -s "$HOMEBREW_PREFIX/local/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "$HOMEBREW_PREFIX/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completio

elif [ -f /etc/bash_completion ]; then
    # If brew bash completion is not available, add basic bash completion
    source /etc/bash_completion;
fi

# Add tab completion for dbt
if [ -f ~/.dbt-completion.bash ]; then
    source ~/.dbt-completion.bash
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config ~/.ssh/config.d/* | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Dock Finder SystemUIServer" killall;

# Enable Shell integration for iTerm2
# http://iterm2.com/shell_integration.html
if [ -f ~/.iterm2_shell_integration.bash ]; then
    source ~/.iterm2_shell_integration.bash
fi

# Add `rbenv init` to the shell to enable shims and autocompletion
if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi;

# added by travis gem
[ -f /Users/hkdobrev/.travis/travis.sh ] && source /Users/hkdobrev/.travis/travis.sh

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


complete -C /opt/homebrew/bin/mc mc

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;



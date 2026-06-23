[ -n "$PS1" ] && source ~/.bash_profile;


command -v direnv >/dev/null && eval "$(direnv hook bash)"


# >>> grok installer >>>
path_prepend "$HOME/.grok/bin"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<

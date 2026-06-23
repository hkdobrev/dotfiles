[ -n "$PS1" ] && source ~/.bash_profile;


command -v direnv >/dev/null && eval "$(direnv hook bash)"


# >>> grok installer >>>
# Guard path_prepend: ~/.bashrc can be sourced without ~/.bash_profile (e.g. a
# non-interactive shell via BASH_ENV), where the helper is not defined.
command -v path_prepend >/dev/null && path_prepend "$HOME/.grok/bin"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<

[ -n "$PS1" ] && source ~/.bash_profile;


command -v direnv >/dev/null && eval "$(direnv hook bash)"


# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<

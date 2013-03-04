function prompt_return { # make prompt red if return != 0
    [[ $? -ne 0 ]] && echo "%{$fg[red]%}"
}

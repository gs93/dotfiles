# parameter expansion, command substitution and arithmetic expansion
setopt prompt_subst

# set screen title
PR_STITLE=$'%{\ekzsh\e\\%}'

# set titlebar text
PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ \e\\%}'

# ???
PS1='abc'
export PS1

# plugins/prompt-git.zsh config
git_prompt_prefix="%{$fg[black]%}git:[%{$reset_color%}"
git_prompt_postfix="%{$fg[black]%}]%{$reset_color%}"
git_prompt_branch_prefix="%{$fg[blue]%}"
git_prompt_branch_postfix="%{$reset_color%} "
git_prompt_sha1_short_prefix="%{$fg[magenta]%}"
git_prompt_sha1_short_postfix="%{$reset_color%}"
git_prompt_mode_prefix=""
git_prompt_mode_postfix=""
git_prompt_clean=" %{$fg[green]%}✔%{$reset_color%}"
git_prompt_dirty=" %{$fg[red]%}✘%{$reset_color%}"

# set prompt
PROMPT='$(prompt_return)$PR_STITLE${(e)PR_TITLEBAR}%m:%~%<<$(prompt_char)%{$reset_color%} '
RPROMPT='$(git_prompt) %? %*'

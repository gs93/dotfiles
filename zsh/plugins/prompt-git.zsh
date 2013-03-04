if (( $+commands[git] )); then
    autoload -U colors && colors
    git_repo_path() {
        git rev-parse --git-dir 2>/dev/null
    }

    git_branch() {
        local branch=$(git symbolic-ref -q HEAD --short 2>/dev/null)
        [[ -n $branch ]] && echo "$git_prompt_branch_prefix$branch$git_prompt_branch_postfix"
    }

    git_sha1_short() {
        local sha1_short=$(git rev-parse --short HEAD 2>/dev/null)
        [[ -n $sha1_short ]] && echo "$git_prompt_sha1_short_prefix$sha1_short$git_prompt_sha1_short_postfix"
    }

    git_mode() {
        local repo_path=$(git_repo_path)
        if [[ -e $repo_path/BISECT_LOG ]]; then
            echo "$git_prompt_mode_prefix+bisect$git_prompt_mode_postfix"
        elif [[ -e $repo_path/MERGE_HEAD ]]; then
            echo "$git_prompt_mode_prefix+merge$git_prompt_mode_postfix"
        elif [[ -e $repo_path/rebase || -e $repo_path/rebase-apply || -e $repo_path/rebase-merge || -e $repo_path/../.dotest ]]; then
            echo "$git_prompt_mode_prefix+rebase$git_prompt_mode_postfix"
        fi
    }

    git_dirty() {
        if [[ -n $(git status -s --ignore-submodules=dirty 2>/dev/null) ]]; then
            echo $git_prompt_dirty
        else
            echo $git_prompt_clean
        fi
    }

    git_prompt() {
        local repo_path=$(git_repo_path)
        [[ -n $repo_path ]] && echo "$git_prompt_prefix$(git_branch)$(git_sha1_short)$(git_mode)$(git_dirty)$git_prompt_postfix"
    }
fi

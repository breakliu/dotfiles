
export PATH=$PATH:~/bin
alias grep='grep --color=auto'
alias ls='ls -GF'

## Parses out the branch name from .git/HEAD:
find_git_branch () {
  local dir=. head
  until [ "$dir" -ef / ]; do
    if [ -f "$dir/.git/HEAD" ]; then
      head=$(< "$dir/.git/HEAD")
      if [[ $head = ref:\ refs/heads/* ]]; then
        git_branch=" → ${head#*/*/}"
      elif [[ $head != '' ]]; then
        git_branch=" → (detached)"
      else
        git_branch=" → (unknow)"
      fi
      return
    fi
    dir="../$dir"
  done
  git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Here is bash color codes you can use
black=$'\[\e[1;30m\]'
red=$'\[\e[1;31m\]'
green=$'\[\e[1;32m\]'
yellow=$'\[\e[1;33m\]'
blue=$'\[\e[1;34m\]'
magenta=$'\[\e[1;35m\]'
cyan=$'\[\e[1;36m\]'
white=$'\[\e[1;37m\]'
normal=$'\[\e[m\]'

PS1="$white[$magenta\u$white@$green\h$white:$cyan\w$yellow\$git_branch$white]\$ $normal"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

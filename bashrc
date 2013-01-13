# Prompt with ruby version
# rbenv version | sed -e 's/ .*//'
function rbenv_ps1 () {
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
  printf $rbenv_ruby_version
}

function parse_git_branch {
  git_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ "$git_branch" ]; then
    printf "\033[0;37mon\033[0m $git_branch"
  fi
}

# Simple PS1
PS1="\[\033[0;37m\]using\[\033[0m\] \$(rbenv_ps1) \[\033[0;37m\]at\[\033[0m\] \\W \$(parse_git_branch) \n\\[\033[0;31m\]\\$\[\033[0m\] "

# Overwriting PATH for better homebrew compatibility
PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH:/usr/local/share/python

# Default Editor
export EDITOR=mvim

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# rbenv Configurations
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


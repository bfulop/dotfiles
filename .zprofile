export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# fnm
export PATH=/Users/balintfulop/.fnm:$PATH
eval "`fnm env`"

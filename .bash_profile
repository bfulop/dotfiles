eval "$(nodenv init -)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

source /Users/balintfulop/.config/broot/launcher/bash/br

export PATH="$HOME/.cargo/bin:$PATH"

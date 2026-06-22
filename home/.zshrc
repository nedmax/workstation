export WORKSTATION_HOME="/Users/nedimar.turatti/Sources/Personal/workstation"
source "$WORKSTATION_HOME/zsh/zshrc"


# bun completions
[ -s "/Users/nedimar.turatti/.bun/_bun" ] && source "/Users/nedimar.turatti/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

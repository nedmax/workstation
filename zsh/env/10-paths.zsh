path_prepend "$HOME/.local/bin"
path_prepend "$HOME/Desktop/bin"
path_prepend "$HOME/Sources/OpenSource/flutter/bin"

path_append "$HOME/.pub-cache/bin"
path_append "/usr/local/go/bin"
path_append "$HOME/go/bin"
path_append "/usr/local/sonar-scanner/bin"
path_append "/Applications/Postgres.app/Contents/Versions/17/bin"

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

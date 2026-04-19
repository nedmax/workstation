path_prepend() {
  local dir="${1:-}"
  [[ -n "$dir" ]] || return 0
  [[ -e "$dir" ]] || return 0

  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="${dir}${PATH:+:$PATH}" ;;
  esac
}

path_append() {
  local dir="${1:-}"
  [[ -n "$dir" ]] || return 0
  [[ -e "$dir" ]] || return 0

  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="${PATH:+$PATH:}${dir}" ;;
  esac
}

source_zsh_dir() {
  local dir="${1:-}"
  local file

  [[ -d "$dir" ]] || return 0

  for file in "$dir"/*.zsh(N); do
    source "$file"
  done
}

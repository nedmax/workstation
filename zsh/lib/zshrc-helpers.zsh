source_if_exists() {
  local file="${1:-}"
  [[ -r "$file" ]] && source "$file"
}

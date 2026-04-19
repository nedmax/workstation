export VIRTUAL_ENV_DISABLE_PROMPT=1

venv-create() {
  local target_dir="${1:-.venv}"
  local python_bin="${2:-python3}"

  command -v "$python_bin" >/dev/null 2>&1 || {
    echo "Python não encontrado: $python_bin" >&2
    return 1
  }

  "$python_bin" -m venv "$target_dir" || return 1
  venv-on "$target_dir"
}

venv-on() {
  local target_dir="${1:-.venv}"
  local activate_script="${target_dir}/bin/activate"

  [[ -r "$activate_script" ]] || {
    echo "Virtualenv não encontrado em ${target_dir}" >&2
    return 1
  }

  source "$activate_script"
}

venv-off() {
  if typeset -f deactivate >/dev/null 2>&1; then
    deactivate
  fi
}

alias mkvenv='venv-create'

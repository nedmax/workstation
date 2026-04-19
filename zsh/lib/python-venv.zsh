export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKSTATION_AUTO_VENV="${WORKSTATION_AUTO_VENV:-1}"

_workstation_find_venv() {
  local search_dir="${PWD:A}"

  while [[ "$search_dir" != "/" ]]; do
    if [[ -r "$search_dir/.venv/bin/activate" ]]; then
      print -r -- "$search_dir/.venv"
      return 0
    fi

    search_dir="${search_dir:h}"
  done

  if [[ -r "/.venv/bin/activate" ]]; then
    print -r -- "/.venv"
    return 0
  fi

  return 1
}

_workstation_auto_venv() {
  local detected_venv=""

  [[ "$WORKSTATION_AUTO_VENV" == "1" ]] || return 0

  detected_venv="$(_workstation_find_venv 2>/dev/null || true)"

  if [[ -n "$VIRTUAL_ENV" && "$WORKSTATION_AUTO_VENV_MANAGED" != "1" ]]; then
    return 0
  fi

  if [[ -n "$detected_venv" && "$VIRTUAL_ENV" == "$detected_venv" ]]; then
    export WORKSTATION_AUTO_VENV_MANAGED=1
    return 0
  fi

  if [[ "$WORKSTATION_AUTO_VENV_MANAGED" == "1" ]] && typeset -f deactivate >/dev/null 2>&1; then
    deactivate
    unset WORKSTATION_AUTO_VENV_MANAGED
  fi

  if [[ -n "$detected_venv" ]]; then
    source "$detected_venv/bin/activate"
    export WORKSTATION_AUTO_VENV_MANAGED=1
  fi
}

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

autoload -U add-zsh-hook
add-zsh-hook chpwd _workstation_auto_venv
_workstation_auto_venv

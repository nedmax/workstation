export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH_CUSTOM:-${ZSH}/custom}"
export ZSH_THEME="${ZSH_THEME:-robbyrussell}"

plugins=(
  git
  kubectl
  kubetail
)

zstyle ':omz:update' mode reminder

if [[ -r "${ZSH}/oh-my-zsh.sh" ]]; then
  source "${ZSH}/oh-my-zsh.sh"
else
  printf 'workstation: oh-my-zsh not found at %s; run ./bin/bootstrap\n' "$ZSH" >&2
fi

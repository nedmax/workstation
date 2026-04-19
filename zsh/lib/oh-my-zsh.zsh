export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="${ZSH_THEME:-robbyrussell}"

plugins=(
  git
  kubectl
  kubetail
)

zstyle ':omz:update' mode reminder

if [[ -r "${ZSH}/oh-my-zsh.sh" ]]; then
  source "${ZSH}/oh-my-zsh.sh"
fi

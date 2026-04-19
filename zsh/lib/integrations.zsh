[[ -r "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
[[ -r "$HOME/.openclaw/completions/openclaw.zsh" ]] && source "$HOME/.openclaw/completions/openclaw.zsh"

for gcloud_completion in \
  "$HOME/google-cloud-sdk/completion.zsh.inc" \
  "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc" \
  "/usr/local/share/google-cloud-sdk/completion.zsh.inc"
do
  if [[ -r "$gcloud_completion" ]]; then
    source "$gcloud_completion"
    break
  fi
done

export NVM_DIR="${HOME}/.nvm"

for nvm_script in \
  "/opt/homebrew/opt/nvm/nvm.sh" \
  "/usr/local/opt/nvm/nvm.sh"
do
  if [[ -r "$nvm_script" ]]; then
    source "$nvm_script"
    break
  fi
done

for nvm_completion in \
  "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" \
  "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
do
  if [[ -r "$nvm_completion" ]]; then
    source "$nvm_completion"
    break
  fi
done

if command -v aws_completer >/dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -C "$(command -v aws_completer)" aws
fi

if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

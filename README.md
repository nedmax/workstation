# Workstation

Dotfiles e bootstrap do meu ambiente local, começando pelo `zsh`.

Inspirado na ideia de organizar configs em pastas, como no post do Akita sobre o Omarchy 2.0:
[Omarchy 2.0 - ZSH Configs](https://akitaonrails.com/2025/09/07/omarchy-2-0-zsh-configs/).

## Estrutura

- `home/`: arquivos que viram `~/.zshenv`, `~/.zprofile` e `~/.zshrc`
- `zsh/zshenv`: setup mínimo carregado em todo shell
- `zsh/zprofile`: bootstrap de login shell
- `zsh/zshrc`: config interativa
- `zsh/lib/`: aliases, integrações, helpers e funções
- `zsh/env/`: variáveis versionadas por tópico/projeto
- `zsh/env/private/`: overrides locais e segredos, ignorados pelo git

## Como usar

1. Revise os arquivos versionados em `zsh/env/`.
2. Rode `./bin/bootstrap` para instalar dependências de máquina.
3. Se quiser preservar as envs atuais primeiro, rode `./bin/import-current-envs`.
4. Ajuste seus segredos e paths locais em `zsh/env/private/`.
5. Rode `./bin/install` para instalar os symlinks no `HOME`.
6. Abra um novo shell com `exec zsh -l`.

`./bin/import-current-envs` cria um arquivo local e gitignored com os `export`s do seu `~/.zshrc` atual, para a migração não quebrar credenciais logo de cara.
Ele salva em `zsh/env/private/00-imported-from-home.zsh`, para o privado sobrescrever a base versionada depois.

## Bootstrap

`./bin/bootstrap` prepara a máquina com o que esse setup referencia hoje:

- Homebrew
- `oh-my-zsh`
- plugin custom `kubetail`
- fórmulas/casks do [Brewfile](/Users/nedimar.turatti/Sources/Personal/workstation/Brewfile)

Algumas integrações continuam fora do bootstrap por dependerem de instalação manual ou escolha de ferramenta:
Flutter em checkout local, `Postgres.app`, integração do iTerm2 e completion do OpenClaw.

## Python

O fluxo novo evita `virtualenvwrapper`/`mkvirtualenv` e volta para o padrão do Python:

```zsh
venv-create
venv-on
venv-off
```

Por padrão, os helpers trabalham com `.venv` no diretório atual.
Ao entrar em um diretório que tenha `.venv` (ou em um subdiretório dele), o ambiente é ativado automaticamente.
Ao sair dele, o ambiente autoativado é desativado.

Se quiser desligar esse comportamento:

```zsh
export WORKSTATION_AUTO_VENV=0
```

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
2. Se quiser preservar as envs atuais primeiro, rode `./bin/import-current-envs`.
3. Use os exemplos em `zsh/env/*.example` como base para criar arquivos em `zsh/env/private/`.
4. Ajuste seus segredos e paths locais em `zsh/env/private/`.
5. Rode `./bin/install` para instalar os symlinks no `HOME`.
6. Abra um novo shell com `exec zsh -l`.

`./bin/import-current-envs` cria um arquivo local e gitignored com os `export`s do seu `~/.zshrc` atual, para a migração não quebrar credenciais logo de cara.
Ele salva em `zsh/env/private/00-imported-from-home.zsh`, para o privado sobrescrever a base versionada depois.

## Python

O fluxo novo evita `virtualenvwrapper`/`mkvirtualenv` e volta para o padrão do Python:

```zsh
venv-create
venv-on
venv-off
```

Por padrão, os helpers trabalham com `.venv` no diretório atual.

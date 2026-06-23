---
name: workstation-agents
description: "Use when: working with the Nedimar workstation setup repository, configuring development environment, managing shell configurations, Python/Go development setup, installing tools or dependencies, or maintaining dotfiles"
---

# Workstation Setup & Development Guide

This repository contains the configuration and setup scripts for Nedimar's development workstation. This document guides agents and developers on how to work effectively with this codebase.

## Repository Structure

```
workstation/
├── Brewfile              # Homebrew packages for macOS
├── requirements.txt      # Python development dependencies
├── bin/                  # Executable setup scripts
│   ├── bootstrap        # Initial workstation setup
│   ├── import-current-envs  # Import existing environment variables
│   └── install          # Install/update components
├── home/                # Home directory templates
├── zsh/                 # Zsh shell configuration
│   ├── zprofile        # Login shell initialization
│   ├── zshenv          # Environment variables
│   ├── zshrc           # Interactive shell configuration
│   ├── env/            # Environment-specific configs
│   │   ├── 00-base.zsh
│   │   ├── 10-paths.zsh
│   │   ├── 20-go.zsh   # Go environment setup
│   │   ├── 30-globo.zsh # Globo-specific settings
│   │   ├── anthropic.zsh
│   │   └── private/    # Sensitive configs (not in git)
│   └── lib/            # Reusable shell functions
│       ├── aliases.zsh
│       ├── history.zsh
│       ├── integrations.zsh
│       ├── oh-my-zsh.zsh
│       ├── python-venv.zsh
│       └── zshenv-helpers.zsh
```

## Setup Instructions

### Initial Setup

1. Clone this repository to `~/Sources/Personal/workstation/`
2. Run the bootstrap script:
   ```bash
   ./bin/bootstrap
   ```
3. Review and activate shell configurations:
   ```bash
   source ~/.zshrc
   ```

### Install/Update

To install or update dependencies and tools:
```bash
./bin/install
```

### Import Existing Configurations

If migrating from another machine:
```bash
./bin/import-current-envs
```

## Development Environment

### Python Development

- **Virtual environment support**: Use `python-venv.zsh` for automated venv management
- **Dependencies**: See `requirements.txt` for development tools
- **Configuration**: Python-specific paths and aliases in `zsh/lib/python-venv.zsh`

**When working with Python code in this repo:**
- Document any new Python dependencies in `requirements.txt`
- Add Python-specific aliases or functions to `zsh/lib/` if needed
- Test shell configuration changes before committing

### Go Development

- **Configuration**: `zsh/env/20-go.zsh` contains GOPATH, GOROOT, and related settings
- **Tools**: Homebrew installs Go via `Brewfile`
- **Best practices**: Use vendoring or go modules; keep GOPATH clean

**When working with Go projects:**
- Verify Go environment variables: `echo $GOPATH $GOROOT`
- Document any new Go tools in `Brewfile` if they're development dependencies
- Keep version management consistent across the team

## Working with Shell Configurations

### Adding New Environment Variables

1. **Temporary/Personal**: Add to `zsh/env/private/` (not committed)
2. **Shared/Team**: Add to appropriate file in `zsh/env/`:
   - Base settings → `00-base.zsh`
   - PATH modifications → `10-paths.zsh`
   - Language-specific → `20-go.zsh`, `30-globo.zsh`, etc.
3. **Reload**: Source the file or restart shell: `exec zsh`

### Adding New Shell Functions/Aliases

- **Functions**: Add to `zsh/lib/`-*.zsh` files by category
- **Organization**: Group by purpose (aliases, integrations, helpers, etc.)
- **Documentation**: Add comments explaining purpose and usage

### Private Configuration

The `zsh/env/private/` directory contains sensitive data:
- API keys, tokens, credentials (atlassian.zsh, slack.zsh, etc.)
- Workspace-specific settings (backoffice.zsh, webmedia.zsh)
- Should never be committed to version control

## Common Tasks

### Testing Shell Configuration

After making changes:
```bash
# Reload shell
exec zsh

# Verify syntax
zsh -n ~/.zshrc

# Check for errors
zsh -x ~/.zshrc 2>&1 | head -50
```

### Debugging Environment Issues

Check which configuration file is causing issues:
```bash
# Trace initialization
zsh -x ~/.zshrc

# Check specific variable
echo $GOPATH
echo $PYTHONPATH

# List loaded files
echo $fpath
```

### Managing Homebrew Packages

Update the Brewfile:
```bash
# Add a new package
echo "brew \"package-name\"" >> Brewfile

# Generate from current system (be careful!)
brew bundle dump --file=Brewfile --force
```

Install from Brewfile:
```bash
brew bundle --file=Brewfile
```

## Guidelines for Modifications

### When Adding Features

1. **Test locally** before committing changes
2. **Document** the purpose in comments
3. **Group logically** with related configurations
4. **Avoid duplicates** — check existing files first
5. **Update README.md** if adding major new functionality

### When Modifying Shell Configs

- **Performance**: Be mindful of shell startup time
- **Compatibility**: Test with both `zsh` and `bash` if it affects both
- **Idempotency**: Scripts should be safe to run multiple times
- **Error handling**: Add proper error messages for failed commands

### Before Committing

1. Run `./bin/bootstrap` or `./bin/install` to verify scripts work
2. Check that sensitive data isn't in public files
3. Review `.gitignore` to ensure private configs stay private
4. Test shell configuration reloading

## Troubleshooting

### Shell Won't Load

Check for syntax errors:
```bash
zsh -n ~/.zshrc
zsh -n ~/.zshenv
```

### Python/Go Environment Issues

Check initialization order:
```bash
echo $PATH | tr ':' '\n'  # Verify correct tool paths
go version
python3 --version
```

### Private Configuration Not Loading

Verify the file exists and is sourced:
```bash
ls -la ~/.zsh/env/private/
grep "private/" ~/.zshrc
```

## References

- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Oh My Zsh](https://ohmyz.sh/)
- [Homebrew Documentation](https://docs.brew.sh/)
- [Go Documentation](https://golang.org/doc/)
- [Python Virtual Environments](https://docs.python.org/3/tutorial/venv.html)

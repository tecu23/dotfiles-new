# CLAUDE.md - Repository Context

This file provides context about this repository for AI assistants like Claude.

## Repository Overview

This is a **dotfiles repository** - a collection of personal configuration files and settings for a macOS development environment. Dotfiles are configuration files (typically starting with a dot `.`) that customize Unix-based systems.

## Purpose

- Maintain consistent development environment across machines
- Version control configuration files
- Quickly bootstrap new development machines
- Share and backup configurations
- Document personal workflows and preferences

## Structure

```
dotfiles/
├── Brewfile              # Homebrew packages (cloud tools, k8s, terraform, docker)
├── install.sh            # Main installation script (creates symlinks)
├── cheatsheets/          # Quick reference guides
│   ├── GO_CHEATSHEET.md
│   └── TMUX_CHEATSHEET.md
├── docs/                 # Documentation (docsify site)
├── ghostty/              # Ghostty terminal emulator config
├── git/                  # Git configuration
│   ├── .gitconfig        # User settings, GitHub private email
│   └── ignore            # Global gitignore
├── mise/                 # mise version manager config
│   └── config.toml
├── nvim/                 # Neovim configuration (git submodule)
│   └── [Lua-based config with LSP, plugins, themes]
├── scripts/              # Utility scripts
│   ├── doctor.sh         # Health check
│   ├── sync-cheatsheets.sh
│   ├── test-install.sh
│   └── update.sh
├── tmux/                 # Tmux configuration (git submodule)
│   └── tmux.conf
└── zsh/                  # Zsh shell configuration
    ├── .zprofile         # Environment setup (loaded first)
    ├── .zshrc            # Shell configuration
    ├── aliases.zsh       # Git, k8s, terraform, docker aliases
    ├── functions.zsh     # Helper functions
    ├── private.zsh       # Machine-specific settings (gitignored)
    └── themes/           # Custom Oh My Zsh theme
```

## Key Technologies & Tools

### Shell & Environment
- **Zsh** with Oh My Zsh framework
- **mise** - Unified version manager (replaces nvm, rbenv, pyenv, gvm)
- Custom π (pi) theme - minimal prompt with git status

### Terminal & Multiplexer
- **Ghostty** - Modern GPU-accelerated terminal emulator
- **Tmux** - Terminal multiplexer with custom keybindings (Ctrl-a prefix)

### Editor
- **Neovim** - Highly customized with:
  - LSP support (Go, Python, Ruby, JS/TS, Lua, Bash, Docker, Terraform, etc.)
  - lazy.nvim plugin manager
  - Telescope fuzzy finder
  - Treesitter syntax highlighting
  - Go-specific tooling (go.nvim, gopls)
  - Git integration (fugitive, gitsigns)
  - UI enhancements (alpha dashboard, lualine, which-key)

### Development Tools (Brewfile)
- **Cloud**: google-cloud-sdk, grpcurl
- **Kubernetes**: helm, kind, k9s, kubectx, skaffold, stern
- **Containers**: docker, docker-compose, ctop, dive
- **Terraform**: terraform, tflint, tfsec, terraform-docs
- **Modern CLI**: bat, direnv, fzf, ripgrep, fd, tree, watch

## Installation Workflow

1. Clone with submodules: `git clone --recurse-submodules <repo>`
2. Run `./install.sh`
3. Script creates symlinks from `~/.config/` to dotfiles directory
4. Backs up existing configs with timestamps
5. Installs Oh My Zsh theme

## Git Submodules

Two configs are managed as separate git repositories:
- **nvim/** - Neovim configuration
- **tmux/** - Tmux configuration

Both track the `main` branch and are updated independently.

## Important Files for AI Assistants

### When Working with Shell Configs
- `zsh/.zshrc` - Main shell configuration
- `zsh/.zprofile` - Environment variables, PATH setup
- `zsh/aliases.zsh` - Command aliases (git, k8s, terraform, docker, gcp)
- `zsh/functions.zsh` - Shell helper functions

### When Working with Neovim
- `nvim/init.lua` - Entry point
- `nvim/lua/tecu/plugins/` - Plugin configurations
- `nvim/lua/tecu/lsp/` - LSP server configurations
- `nvim/lua/tecu/lsp/servers/gopls.lua` - Go language server settings

**Known Issues (as of 2024-01-24):**
- gopls `usePlaceholders = true` causes annoying auto-completion
- `go.format.goimports()` on save can delete code with syntax errors

### When Working with Git
- `git/.gitconfig` - User identity, GitHub SSH rewrite
- `git/ignore` - Global gitignore (DS_Store, IDE files, logs)

### When Working with Tmux
- `tmux/tmux.conf` - Key bindings, plugins, appearance

## Configuration Philosophy

1. **Symlinks over copying** - Files stay in repo, symlinked to home directory
2. **Submodules for complex configs** - Neovim and Tmux are separate repos
3. **Gitignored private settings** - `zsh/private.zsh` for secrets/machine-specific
4. **Brewfile for dependencies** - Declarative package management
5. **mise for versions** - Single tool for Node, Ruby, Go, Python versions
6. **Comprehensive LSP setup** - Full IDE features in Neovim
7. **Minimal, fast shell** - Optimized zsh with custom theme

## Common Tasks

### Editing Configurations
Edit either at symlink location (`~/.zshrc`) or in repo (`~/dotfiles/zsh/.zshrc`)

### Updating Submodules
```bash
cd ~/dotfiles/nvim  # or tmux
git add . && git commit && git push
cd ~/dotfiles
git add nvim && git commit -m "Update nvim submodule"
```

### Adding New Packages
```bash
echo 'brew "package-name"' >> Brewfile
brew bundle install
```

### Version Management
```bash
mise use --global node@20 ruby@3.3 go@1.22
mise list
mise outdated
```

## Special Notes for AI Assistants

### When Asked to Fix/Update Configs

1. **Check for submodules** - nvim/ and tmux/ are separate repos
2. **Preserve comments** - Configs are heavily documented
3. **Test before committing** - Broken shell configs can lock you out
4. **Backup approach** - install.sh already backs up, but warn user
5. **Don't remove gitignored files** - `zsh/private.zsh` is intentional

### When Troubleshooting

1. Check `scripts/doctor.sh` for health checks
2. Look at `cheatsheets/` for keybinding references
3. Neovim issues: Check LSP logs (`:LspInfo`, `:LspLog`)
4. Shell issues: Test with `zsh -n ~/.zshrc` (syntax check)
5. Submodule issues: `git submodule update --init --recursive`

### File Paths

- Configs are in: `~/dotfiles/`
- Symlinks point to: `~/.config/`, `~/.zshrc`, etc.
- Always edit source files in `~/dotfiles/`, not symlinks

### Privacy Considerations

- `git/.gitconfig` uses GitHub private email
- `zsh/private.zsh` is gitignored (for API keys, work settings)
- Never commit secrets to the repo

## Testing Changes

- Use `scripts/test-install.sh` for dry-run testing
- Check `scripts/doctor.sh` for environment validation
- Create test user account for full testing (documented in README)

## Documentation

- Main README: `README.md` - Installation, usage, configuration details
- Cheatsheets: `cheatsheets/` - Keybinding references
- Docsify site: `docs/` - Web-based documentation
- This file: Context for AI assistants

## Owner Preferences

Based on repository structure and comments:
- Prefers Lua for Neovim configuration
- Uses Go, Python, Ruby, JavaScript/TypeScript
- Works with Kubernetes, Terraform, Docker, GCP
- Favors modern CLI tools (bat, ripgrep, fd)
- Minimal, efficient configurations
- Privacy-conscious (private email, gitignored secrets)

## Last Updated

2024-01-24 - Initial CLAUDE.md creation

---

**Note**: This file should be updated when major structural changes are made to the repository.

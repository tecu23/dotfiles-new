# dotfiles

Personal configuration files and settings for development environment.

## Structure

```
dotfiles/
├── README.md
├── .gitmodules      # Git submodule configuration
├── install.sh       # Installation script
├── nvim/            # Neovim config (git submodule)
│   └── init.lua
└── zsh/
    └── .zshrc       # Zsh configuration
```

## Setup

1. Clone this repository (with submodules):

```bash
git clone --recurse-submodules git@github.com:tecu23/dotfiles-new.git ~/dotfiles
cd ~/dotfiles
```

If you already cloned without submodules, initialize them:

```bash
git submodule update --init --recursive
```

2. Run the installation script:

```bash
./install.sh
```

The script will:
- Backup any existing configuration files (with timestamp)
- Create symlinks from your home directory to the dotfiles repo
- Preserve your existing configs as `.backup.YYYYMMDD_HHMMSS`

3. Reload your shell:

```bash
source ~/.zshrc
```

## Usage

### Editing Configurations

Edit files in either location - changes apply to both:

```bash
# Edit via symlink
vim ~/.zshrc

# Or edit directly in repo
vim ~/dotfiles/zsh/.zshrc
```

### Committing Changes

```bash
cd ~/dotfiles
git add .
git commit -m "Update zsh configuration"
git push
```

### Deploying to a New Machine

```bash
git clone --recurse-submodules git@github.com:tecu23/dotfiles-new.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Working with Submodules (Neovim Config)

The neovim configuration is managed as a git submodule, which means it's a separate repository.

**Note:** This submodule is configured to track the `main` branch, so it will automatically pull the latest changes when updated.

### Updating Neovim Config

```bash
# Edit your nvim config (changes are in the submodule)
nvim ~/.config/nvim/init.lua

# Commit changes in the submodule
cd ~/dotfiles/nvim
git add .
git commit -m "Update neovim config"
git push

# Update the dotfiles repo to track the new submodule commit
cd ~/dotfiles
git add nvim
git commit -m "Update nvim submodule"
git push
```

### Pulling Latest Changes from Main

To get the latest nvim config from the `main` branch:

```bash
cd ~/dotfiles
git pull
git submodule update --remote --merge  # Pulls latest from main branch
```

This will:
1. Pull latest dotfiles changes
2. Update nvim submodule to latest commit on `main`
3. Update the commit reference in dotfiles repo

After updating, commit the new submodule reference:

```bash
git add nvim
git commit -m "Update nvim to latest main"
git push
```

## Adding More Configurations

To add new dotfiles:

1. Create a directory (e.g., `git/`, `vim/`, etc.)
2. Copy your config into it
3. Update `install.sh` to symlink the new file
4. Run `./install.sh` to create the symlink

To add a new submodule:

1. `git submodule add <repo-url> <directory-name>`
2. Update `install.sh` to symlink the directory
3. Commit `.gitmodules` and the new submodule

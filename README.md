# dotfiles

Personal configuration files and settings for development environment.

## Structure

```
dotfiles/
├── README.md
├── install.sh       # Installation script
└── zsh/
    └── .zshrc       # Zsh configuration
```

## Setup

1. Clone this repository:

```bash
git clone git@github.com:tecu23/dotfiles-new.git ~/dotfiles
cd ~/dotfiles
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
git clone git@github.com:tecu23/dotfiles-new.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Adding More Configurations

To add new dotfiles:

1. Create a directory (e.g., `git/`, `vim/`, etc.)
2. Copy your config into it
3. Update `install.sh` to symlink the new file
4. Run `./install.sh` to create the symlink

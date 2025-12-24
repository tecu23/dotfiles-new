export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Load private/local settings (not tracked in git)
# Create ~/dotfiles/zsh/private.zsh for machine-specific config
# Example: export GOPRIVATE=github.com/your-org
[ -f "$HOME/dotfiles/zsh/private.zsh" ] && source "$HOME/dotfiles/zsh/private.zsh"

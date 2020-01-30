#!/bin/sh

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up your Mac..."

# Link the dotfiles
ln -sf "$DOTFILES_DIR/.curlrc" ~
ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.mackup.cfg" ~
ln -sf "$DOTFILES_DIR/.zshrc" ~
ln -sf "$DOTFILES_DIR/aliases.zsh" ~
ln -sf "$DOTFILES_DIR/path.zsh" ~

# Setup GnuPG
mkdir -p ~/.gnupg
ln -sf "$DOTFILES_DIR/gpg.conf" ~/.gnupg/
ln -sf "$DOTFILES_DIR/gpg-agent.conf" ~/.gnupg/

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Code

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos

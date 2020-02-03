#!/bin/sh

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up your Mac..."

# Link the dotfiles
ln -sf "$DOTFILES_DIR/.curlrc" ~
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~
ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.mackup.cfg" ~
ln -sf "$DOTFILES_DIR/aliases.zsh" ~

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

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Overwrite .zshrc
rm ~/.zshrc
ln -sf "$DOTFILES_DIR/.zshrc" ~

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install PHP libraries via pecl
pecl install redis
pecl install xdebug
pecl install pcov

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Code

# Set git hook
mkdir -p ~/.git-templates/
ln -sf "$DOTFILES_DIR/git/hooks" ~/.git-templates

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos

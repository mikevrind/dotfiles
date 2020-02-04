#!/bin/sh

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.
echo "Check for software updates..."
sudo softwareupdate -i -a

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

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Overwrite .zshrc
rm ~/.zshrc
ln -sf "$DOTFILES_DIR/.zshrc" ~

# Install PHP libraries via pecl
brew link --overwrite php@7.2 --force
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
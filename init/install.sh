#!/usr/bin/env bash

# ======== XCode ==========

# Install Command Line Tools
xcode-select --install

# Agree to the XCode license
sudo xcodebuild -license

# ========= Brew ==========

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install brew bundle
brew tap Homebrew/bundle

# Install Brew formulae and apps via Cask
brew bundle --file=Brewfile

# Enable Bash 4 installed from brew
# Add the Bash shell to the list of legit shells
sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"

# Change the shell for the user
chsh -s /usr/local/bin/bash

# =========== Vim =============

# Install vim-plug plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ======= Composer =========

# Install composer
./composer-installer.sh

# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install bash
install bash-completion

# Install Bash completion
install bash-completion

# Install wget with IRI support
install wget --enable-iri

# Install more recent versions of some OS X tools
install vim --override-system-vi
install homebrew/dupes/grep
install homebrew/dupes/screen
install homebrew/dupes/zlib
install homebrew/php/php55 --with-gmp
install homebrew/php/php55-xdebug
install homebrew/php/composer
install homebrew/php/php-code-sniffer

# Install other useful binaries
install ack
install bfg
install foremost
install grc
install git
install imagemagick --with-webp
install hub
install htop-osx
install libidn
install node # This installs `npm` too using the recommended installation method
install p7zip
install pigz
install pv
install rbenv
install rename
install tree
install vagrant-completion
install webkit2png
install zopfli

# Remove outdated versions from the cellar
cleanup

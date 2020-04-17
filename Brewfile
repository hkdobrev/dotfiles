# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew 'coreutils'
# Install some other useful utilities like `sponge`
brew 'moreutils'
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew 'findutils'
# Install GNU `sed`, overwriting the built-in `sed`
brew 'gnu-sed', args: ['default-names']
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew 'bash'
# Install Bash completion
brew 'bash-completion'

# Install useful completions
brew 'homebrew/completions/apm-bash-completion'
brew 'homebrew/completions/brew-cask-completion'
brew 'homebrew/completions/composer-completion'
brew 'homebrew/completions/bundler-completion'
brew 'homebrew/completions/gem-completion'
brew 'homebrew/completions/grunt-completion'
brew 'homebrew/completions/open-completion'
brew 'homebrew/completions/vagrant-completion'

# Install wget with IRI support
brew 'wget', args: ['with-iri']

# Install more recent versions of some OS X tools
brew 'vim', args: ['override-system-vi']
brew 'homebrew/dupes/grep'
brew 'homebrew/dupes/screen'
brew 'homebrew/dupes/zlib'

# Install PHP and tools
brew 'homebrew/php/php70', args: ['with-gmp']
brew 'homebrew/php/php70-xdebug'

# Install other useful binaries
brew 'ack'
brew 'aria2'
brew 'bfg'
brew 'cloc'
brew 'cmake'
brew 'ctags'
brew 'diff-so-fancy'
brew 'exa'
brew 'ghex'
brew 'git'
brew 'git-standup'
brew 'git-utils'
brew 'imagemagick', args: ['with-webp']
brew 'hub', args: ['devel']
brew 'htop-osx'
brew 'jp2a'
brew 'jpegoptim'
brew 'keybase'
brew 'lastpass-cli', args: ['with-pinentry', 'with-doc']
brew 'node' # This installs `npm` too using the recommended installation method
brew 'openssl@1.1'
brew 'optipng'
brew 'p7zip'
brew 'pigz'
brew 'pv'
brew 'python3'
brew 'rbenv'
brew 'rbenv-binstubs'
brew 'rename'
brew 'ssh-copy-id'
brew 'subliminal'
brew 'tldr'
brew 'tree'
brew 'unar'
brew 'webkit2png'
brew 'yarn'
brew 'youtube-dl'
brew 'zopfli'

# Install Brew Cask along with Desktop apps
tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'caskroom/versions'

cask '1password-beta'
cask 'firefox'
cask 'font-source-code-pro'
cask 'google-chrome-dev'
cask 'google-drive'
cask 'iterm2-nightly'
cask 'java'
cask 'kindle'
cask 'licecap'
cask 'monodraw'
cask 'rescuetime'
cask 'screenflick'
cask 'sequel-pro-nightly'
cask 'slack-beta'
cask 'sublime-text-dev'
cask 'the-unarchiver'
cask 'vagrant'
cask 'virtualbox-beta'
cask 'vlc-nightly'
cask 'yubikey-personalization-gui'

# Quick Look plugins
# See https://github.com/sindresorhus/quick-look-plugins
cask 'betterzipql'
cask 'qlcolorcode'
cask 'qlimagesize'
cask 'qlmarkdown'
cask 'qlprettypatch'
cask 'qlstephen'
cask 'qlrest'
cask 'qlvideo'
cask 'quicklook-csv'
cask 'quicklook-json'
cask 'suspicious-package'
cask 'webpquicklook'

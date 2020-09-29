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
brew 'bash-completion@2'

# Install useful completions
brew 'homebrew/completions/apm-bash-completion'
brew 'homebrew/completions/brew-cask-completion'
brew 'homebrew/completions/bundler-completion'
brew 'homebrew/completions/composer-completion'
brew 'homebrew/completions/gem-completion'
brew 'homebrew/completions/launchctl-completion'
brew 'homebrew/completions/open-completion'
brew 'homebrew/completions/open-completion'
brew 'homebrew/completions/pip-completion'
brew 'homebrew/completions/rake-completion'
brew 'homebrew/completions/ruby-completion'
brew 'homebrew/completions/vagrant-completion'
brew 'homebrew/completions/yarn-completion'

# Install more recent versions of some OS X tools
brew 'vim', args: ['override-system-vi']
brew 'homebrew/dupes/grep'
brew 'homebrew/dupes/screen'
brew 'homebrew/dupes/zlib'

# Install PHP
brew 'php@7.4', link: true
brew 'php@7.1', link: false
brew 'php@7.3', link: false

# Install other useful binaries
brew 'ack'
brew 'aria2'
brew 'ansible'
brew 'awk'
brew 'awscli'
brew 'bat'
brew 'bfg'
brew 'cloc'
brew 'cmake'
brew 'csvkit'
brew 'ctags'
brew 'diff-so-fancy'
brew 'docker-compose'
brew 'dust'
brew 'exa'
brew 'fzf'
brew 'gcc'
brew 'github/gh/gh'
brew 'ghex'
brew 'git'
brew 'git-standup'
brew 'git-diet/tap/git-duet'
brew 'git-quick-stats'
brew 'git-utils'
brew 'gnupg'
brew 'go'
brew 'goaccess'
brew 'graphviz'
brew 'grip'
brew 'httpie'
brew 'htop-osx'
brew 'hub', args: ['devel']
brew 'jp2a'
brew 'jpegoptim'
brew 'jq'
brew 'jrnl'
brew 'jsonlint'
brew 'jupyterlab'
brew 'tdewolff/tap/minify'
brew 'mysql@5.7', restart_service: true, link: true
brew 'node' # This installs `npm` too using the recommended installation method
brew 'openssl@1.1'
brew 'optipng'
brew 'p7zip'
brew 'pigz'
brew 'postgresql'
brew 'pv'
brew 'python3'
brew 'rbenv'
brew 'rbenv-binstubs'
brew 'rename'
brew 'ssh-copy-id', link: true
brew 'subliminal'
brew 'terraform'
brew 'terraform-docs'
brew 'terraform-inventory'
brew 'terraform-provisioner-ansible'
brew 'titlecase'
brew 'tldr'
brew 'tree'
brew 'unar'
brew 'webkit2png'
brew 'wget', ags: ['with-iri']
brew 'yamllint'
brew 'yarn'
brew 'youtube-dl'
brew 'zopfli'

# Install Brew Cask along with Desktop apps
tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'caskroom/versions'

cask '1password-beta'
cask '1password-cli'
cask 'anaconda'
cask 'cyberduck'
cask 'docker'
cask 'firefox'
cask 'font-source-code-pro'
cask 'font-source-sans-pro'
cask 'google-chrome-dev'
cask 'google-drive'
cask 'haptickey'
cask 'iterm2-nightly'
cask 'java'
cask 'jupyter-notebook-viewer'
cask 'kindle'
cask 'licecap'
cask 'monodraw'
cask 'mysqlworkbench'
cask 'pocket-casts'
cask 'rescuetime'
cask 'screenflick'
cask 'slack-beta'
cask 'sublime-text-dev'
cask 'tableplus'
cask 'tabula'
cask 'telegram-alpha'
cask 'the-unarchiver'
cask 'vagrant'
cask 'virtualbox-beta'
cask 'vlc-nightly'
cask 'wireshark'
cask 'yubikey-personalization-gui'
cask 'zoom'

# Quick Look plugins
# See https://github.com/sindresorhus/quick-look-plugins
cask 'betterzipql'
cask 'jupyter-notebook-ql'
cask 'qlcolorcode'
cask 'qlcommonmark'
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

# Mac App Store apps
# Install mas cli for these to work
# https://github.com/mas-cli/mas
mas "AntiRSI", id: 442007571
mas "Keynote", id: 409183694
mas "Magnet", id: 441258766
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "Pocket", id: 568494494
mas "The Unarchiver", id: 425424353
mas "Unsplash Wallpapers", id: 1284863847

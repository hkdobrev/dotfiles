# Third-party taps. Homebrew 6.0 requires these to be trusted; init/install.sh
# runs `brew trust --formula …` for the formulae below before `brew bundle`.
tap 'caarlos0/tap'
tap 'tdewolff/tap'

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew 'coreutils'
brew 'less'

# Install some other useful utilities like `sponge`
brew 'moreutils'

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew 'findutils'

# Install GNU `sed`, overwriting the built-in `sed`
brew 'gnu-sed'

# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew 'bash'
# Install Bash completion
brew 'bash-completion@2'

# Install useful completions
brew 'brew-cask-completion'
# brew 'composer-completion'
brew 'gem-completion'
brew 'launchctl-completion'
brew 'open-completion'
brew 'ruby-completion'
brew 'yarn-completion'

# Install more recent versions of some OS X tools
brew 'vim'

brew 'grep'
brew 'screen'
brew 'zlib'

# Install other useful binaries
brew 'ack'
brew 'aria2'
brew 'awk'
brew 'awscli'
brew 'bat'
brew 'bfg'
brew 'cloc'
brew 'cmake'
brew 'csvkit'
brew 'ctags'
brew 'direnv'
brew 'docker-compose'
brew 'dust'
brew 'eza'
brew 'caarlos0/tap/fork-cleaner'
brew 'fzf'
brew 'gcc'
brew 'gh'
brew 'ghex'
brew 'git'
brew 'git-delta'
brew 'git-standup'
brew 'git-quick-stats'
brew 'git-spice'
brew 'glow'
brew 'gnupg'
brew 'go'
brew 'goaccess'
brew 'graphviz'
brew 'grip'
brew 'httpie'
brew 'htop'
brew 'http-prompt'
brew 'jp2a'
brew 'jpegoptim'
brew 'jq'
brew 'jrnl'
brew 'jsonlint'
brew 'tdewolff/tap/minify'
brew 'minio'
brew 'node' # This installs `npm` too using the recommended installation method
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
brew 'opentofu'
brew 'terraform-docs'
brew 'titlecase'
brew 'tldr'
brew 'tree'
brew 'unar'
brew 'webkit2png'
brew 'wget'
brew 'yamllint'
brew 'yarn'
brew 'yt-dlp'
brew 'zopfli'

# Desktop apps, CLI tools & runtimes via Cask
# (homebrew/cask is built-in; fonts & versions are merged in)
cask '1password'
cask '1password-cli'
cask 'beeper'
cask 'claude'
cask 'cursor'
cask 'font-source-sans-3'
cask 'gcloud-cli'
cask 'google-chrome'
cask 'haptickey'
cask 'hey-desktop'
cask 'iterm2'
cask 'meetingbar'
cask 'signal'
cask 'slack'
cask 'spotify'
cask 'tableplus'
cask 'tabula'
cask 'viber'
cask 'warp'
cask 'whatsapp'
cask 'zoom'
cask 'zulu@17'

# Quick Look plugins
# See https://github.com/sindresorhus/quick-look-plugins
cask 'qlmarkdown'
cask 'quicklook-csv'
# quicklook-json was disabled by Homebrew on 2025-12-23 (no longer meets cask criteria)
cask 'suspicious-package'
cask 'webpquicklook'

# Mac App Store apps
# Requires the `mas` CLI (https://github.com/mas-cli/mas) and being signed in
# to the App Store.
brew 'mas'
mas "Amazon Kindle", id: 302584613
mas "Keynote", id: 361285480
mas "Magnet", id: 441258766
mas "Numbers", id: 361304891
mas "Pages", id: 361309726
mas "The Unarchiver", id: 425424353
mas "Unsplash Wallpapers", id: 1284863847

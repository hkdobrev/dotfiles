# hkdobrev’s dotfiles

![Screenshot of my shell prompt](http://i.imgur.com/EkEtphC.png)

## Installation

### Using Git and the install script

The repository is made for use inside your `$HOME` directory. It will ignore everything other than what it explicitly is tracking already.

``` bash
cd $HOME
git init
# Use HTTPS for the first fetch — a brand-new Mac has no SSH key yet.
git remote add origin https://github.com/hkdobrev/dotfiles.git
git fetch origin main
git reset --hard origin/main
```

Once an SSH key is set up (e.g. via the 1Password SSH agent) you can switch the
remote back to SSH:

``` bash
git remote set-url origin git@github.com:hkdobrev/dotfiles.git
```

It is recommended to fork the repo and adjust it as needed.

#### Installing everything

When setting up a new computer run the `init/install.sh` script. It:

1. installs the Xcode Command Line Tools and Homebrew,
2. runs `brew bundle` over the `Brewfile` to install every formula, Cask app
   and Mac App Store app,
3. switches the login shell to the Homebrew Bash, and
4. applies the macOS system preferences via `.macos` (Dock, Finder, trackpad,
   Mission Control, Stage Manager, menu bar and keyboard shortcuts).

It is idempotent, so it's safe to re-run. Sign in to the App Store first so the
`mas` apps install.

``` bash
./init/install.sh
```

The final `.macos` step asks for confirmation (it restarts Dock/Finder and
quits a few apps). To run unattended and skip it:

``` bash
NO_MACOS=1 ./init/install.sh
```

You can also apply just the macOS preferences at any time by running the script
directly:

``` bash
./.macos
```

Some changes need a logout/restart to take effect.

# Updating

To later update the dotfiles configuration:

```bash
cd
git pull
```

To update your software run the `update` alias which will update Ruby gems, Homebrew formulae, Composer globals and others:

```bash
update
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/hkdobrev/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-26)) takes place.

Here’s an example `~/.path` file that adds `~/utils` to the `$PATH`:

```bash
export PATH="$HOME/utils:$PATH"
```

### Add custom configuration without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

Git would try to load additional configuration via `~/git/.gitconfig.local`. Use it to populate your own user information:

```bash
# Git credentials
git config --file=~/git/.gitconfig.local user.name "John Doe"
git config --file=~/git/.gitconfig.local user.email "jonh.doe@example.com"
git config --file=~/git/.gitconfig.local user.signingKey "0xABCDE"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/hkdobrev/dotfiles/fork) for any significant changes, though.

### Install Homebrew formulae and Cask apps

`init/install.sh` already runs `brew bundle` for you. To re-apply the
[Homebrew](http://brew.sh/) `Brewfile` on its own later (e.g. after editing it):

```bash
brew bundle --file=~/Brewfile
```

## Feedback

Suggestions/improvements
[welcome](https://github.com/hkdobrev/dotfiles/issues)!

## Author

| [![twitter/mathias](http://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](http://twitter.com/mathias "Follow @mathias on Twitter") |
|---|
| [Mathias Bynens](http://mathiasbynens.be/) |

This repo is a fork of the originial dotfiles of Mathias Bynens, it is heavily modified by Haralan Dobrev for his own purposes.

## Thanks to…

* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Chris Gerke](http://www.randomsquared.com/) and his [tutorial on creating an OS X SOE master image](http://chris-gerke.blogspot.com/2012/04/mac-osx-soe-master-image-day-7.html) + [_Insta_ repository](https://github.com/cgerke/Insta)
* [Cãtãlin Mariş](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* [Lauri ‘Lri’ Ranta](http://lri.me/) for sharing [loads of hidden preferences](http://osxnotes.net/defaults.html)
* [Matijs Brinkhuis](http://hotfusion.nl/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](http://sindresorhus.com/)
* [Tom Ryder](http://blog.sanctum.geek.nz/) and his [dotfiles repository](https://github.com/tejr/dotfiles)
* [Kevin Suttle](http://kevinsuttle.com/) and his [dotfiles repository](https://github.com/kevinSuttle/dotfiles) and [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults), which aims to provide better documentation for [`~/.osx`](http://mths.be/osx)
* [Haralan Dobrev](http://hkdobrev.com/)

* anyone who [contributed a patch](https://github.com/mathiasbynens/dotfiles/contributors) or [made a helpful suggestion](https://github.com/mathiasbynens/dotfiles/issues)

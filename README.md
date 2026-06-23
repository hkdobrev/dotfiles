# hkdobrev’s dotfiles

My personal macOS dotfiles: the Homebrew Bash shell setup, aliases, functions,
a thorough Git configuration, a `Brewfile` of every tool and app I install, and
a `.macos` script that reproduces my system preferences. Built for Apple Silicon
Macs.

## Installation

The repo is meant to live in your `$HOME` directory. It only tracks the files it
already knows about and ignores everything else.

A brand-new Mac has no SSH key yet, so clone over HTTPS first:

```bash
cd "$HOME"
git init
git remote add origin https://github.com/hkdobrev/dotfiles.git
git fetch origin main
git reset --hard origin/main
```

> It is recommended to [fork the repo](https://github.com/hkdobrev/dotfiles/fork)
> and adjust it to your own taste.

### Bootstrap with the install script

`init/install.sh` is the single entry point for a new machine. It:

1. installs the Xcode Command Line Tools and Homebrew,
2. runs `brew bundle` over the `Brewfile` — every formula, Cask app and Mac App
   Store app (sign in to the App Store first so the `mas` apps install),
3. switches the login shell to the Homebrew Bash, and
4. applies the macOS system preferences via `.macos` (Dock, Finder, trackpad,
   Mission Control, Stage Manager, menu bar and keyboard shortcuts).

```bash
./init/install.sh
```

It is idempotent — safe to re-run. The final `.macos` step asks for confirmation
(it restarts Dock/Finder and quits a few apps). To run unattended and skip it:

```bash
NO_MACOS=1 ./init/install.sh
```

You can also re-apply individual pieces at any time:

```bash
./.macos                       # just the macOS system preferences
brew bundle --file=~/Brewfile  # just the Homebrew packages
```

Some macOS changes need a logout/restart to take effect.

### Switch the Git remote to SSH

Once you have an SSH key, authenticate with GitHub and move the remote off HTTPS.
The bundled `~/.ssh/config` uses the default `~/.ssh/id_ed25519` key name:

```bash
# Create a modern key (no passphrase) if you don't have one:
ssh-keygen -t ed25519 -C "you@example.com"

# Authenticate the GitHub CLI (installed via the Brewfile), wire it into Git,
# and register the public key on your account:
gh auth login
gh auth setup-git
gh ssh-key add ~/.ssh/id_ed25519.pub --title "$(hostname -s)"

git remote set-url origin git@github.com:hkdobrev/dotfiles.git
```

## Updating

Pull the latest dotfiles:

```bash
cd && git pull
```

Update all your software with the `update` alias (macOS software updates,
Homebrew formulae and casks, npm globals and Ruby gems):

```bash
update
```

## Customisation

### `~/.path`

If `~/.path` exists it is sourced before the other files, so it can extend
`$PATH` before any feature detection runs:

```bash
export PATH="$HOME/utils:$PATH"
```

### `~/.extra`

If `~/.extra` exists it is sourced as well. Use it for machine-specific or
private settings, functions and aliases that you don't want to commit — a handy
way to tweak things without forking the whole repo.

### Per-machine Git identity

Git loads additional configuration from `~/git/.gitconfig.local` (untracked).
Use it to set your own identity:

```bash
git config --file=~/git/.gitconfig.local user.name "John Doe"
git config --file=~/git/.gitconfig.local user.email "john.doe@example.com"
git config --file=~/git/.gitconfig.local user.signingKey "0xABCDE"
```

## Feedback

Suggestions/improvements
[welcome](https://github.com/hkdobrev/dotfiles/issues)!

## Author

| [Haralan Dobrev](https://hkdobrev.com/) |
|---|

Originally forked from [Mathias Bynens’](https://mathiasbynens.be/) dotfiles and
heavily modified since for my own purposes.

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
* anyone who [contributed a patch](https://github.com/mathiasbynens/dotfiles/contributors) or [made a helpful suggestion](https://github.com/mathiasbynens/dotfiles/issues)

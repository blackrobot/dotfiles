# Purepower

View the [`purepower` config file on github][1].

## Install

1. Update the `01-purepower.config.zsh`.
2. Source the load script from your `~/.zshrc`.

```zsh
$ cd "${DOTFILES}/zsh/purepower"
$ curl -fsSL https://github.com/romkatv/dotfiles-public/raw/master/.purepower > 01-purepower.config.zsh
$ echo 'source "${DOTFILES}/zsh/purepower/load.zsh"' >> ~/.zshrc
```

## Updating

To update the purepower settings, use:

```zsh
$ curl -fsSL https://github.com/romkatv/dotfiles-public/raw/master/.purepower > 01-purepower.config.zsh
```

## Modifying

Make any custom changes in `02-local.config.zsh`.

[1]: https://github.com/romkatv/dotfiles-public/blob/master/.purepower

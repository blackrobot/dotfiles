# IINA Config

This directory contains an alias that makes IINA use `yt-dlp` instead of `youtube-dl`.

## Install

```sh
# install yt-dlp
brew install yt-dlp

# create the symlink
ln -svi "$(which yt-dlp)" "${HOME}/dotfiles/config/iina/youtube-dl"
```

Then add this directory as the search path for youtube-dl in the IINA settings.

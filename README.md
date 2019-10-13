# Alpaca Desktop

[BitBar][1] distribution including [Alpaca][2] and [launchd][3] daemon and [BitBar][1] plugin.

![Screenshot](docs/screenshot.png)

## Install

```
curl \
    --silent \
    --location https://github.com/jamesmoriarty/alpaca-desktop/releases/download/v0.0.1/Alpaca-v0.0.1.zip \
    -o Alpaca-v0.0.1.zip && \
unzip Alpaca-v0.0.1
```

## Build

```
bin/build
```

Creates a `dist/Alpaca.app`.

[1]: https://github.com/matryer/bitbar
[2]: https://github.com/samuong/alpaca
[3]: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html

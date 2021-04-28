# Alpaca Desktop

[![Latest Tag](https://img.shields.io/github/v/tag/jamesmoriarty/alpaca-desktop.svg?logo=github&label=latest)](https://github.com/jamesmoriarty/alpaca-desktop/releases) [![Build Status](https://travis-ci.org/jamesmoriarty/alpaca-desktop.svg?branch=master)](https://travis-ci.org/jamesmoriarty/alpaca-desktop) ![GitHub Releases](https://img.shields.io/github/downloads/jamesmoriarty/alpaca-desktop/total)

Experimental OSX menu bar widget for [Alpaca][2]. Built with [BitBar][1] distribution and includes [Alpaca][2] binary and [Launchd][3] daemon.

![Screenshot](docs/screenshot.jpg)

## Install

```
Alpaca.app
```
Releases can be downloaded from [here][4]. \[1] \[2]

<hr />

\[1] macOS Mojave and below - can be run as untrusted.

\[2] macOS Catalina and above - will need to be built locally.

## Build

```
bin/build
```
Build artifact can be found at `dist/Alpaca.app`.

## Icon

Application `icns` generated with [IconGenerator][5].

[1]: https://github.com/matryer/bitbar
[2]: https://github.com/samuong/alpaca
[3]: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
[4]: https://github.com/jamesmoriarty/alpaca-desktop/releases
[5]: https://github.com/onmyway133/IconGenerator

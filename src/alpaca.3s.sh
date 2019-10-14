#!/bin/sh

set -e
set -u

# Configuration

PLIST_NAME=com.github.alpaca
PLIST_PATH=~/Library/LaunchAgents/$PLIST_NAME.plist
APP_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ALPACA_PATH=$APP_PATH/bin/alpaca
INSTALL_ZSH_PATH=$APP_PATH/bin/install/zsh
LOG_PATH=~/.alpaca.log
ICON_BASE64=$(cat $APP_PATH/img/icon.png | base64)

installLaunchAgent() {
  cat <<-EOF >$PLIST_PATH
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>$PLIST_NAME</string>
    <key>ProgramArguments</key>
    <array>
      <string>$ALPACA_PATH</string>
    </array>
    <key>StandardOutPath</key>
    <string>$LOG_PATH</string>
    <key>StandardErrorPath</key>
    <string>$LOG_PATH</string>
  </dict>
</plist>
EOF

  launchctl unload $PLIST_PATH
  launchctl load $PLIST_PATH
}

isRunning() {
  pid=$(launchctl list | grep $1 | cut -f 1)

  if [ $pid != "" ] && [ $pid != "-" ] && [ $pid -gt 0 ]; then
    return 0
  else
    return 1
  fi
}

# Daemon controls

if isRunning $PLIST_NAME; then
  echo " ● | color=green templateImage=$ICON_BASE64"
  echo "---"
  echo "Running | bash=\"launchctl list $PLIST_NAME\""
  echo "Stop | terminal=false bash=/bin/launchctl args=stop__$PLIST_NAME"
else
  installLaunchAgent

  echo " ● | color=red templateImage=$ICON_BASE64"
  echo "---"
  echo "Start | terminal=false bash=/bin/launchctl args=start__$PLIST_NAME"
fi

# Instrument shells

echo "---"
echo "Install .zshrc | bash=$INSTALL_ZSH_PATH"

# Log tail

if test -f $LOG_PATH; then
  echo "---"
  tail -n 3 $LOG_PATH
fi

#!/bin/sh

set -e
set -u
# set -x

ICON_BASE64="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"
PLIST_NAME=com.github.alpaca
PLIST_PATH=~/Library/LaunchAgents/$PLIST_NAME.plist
DIR_PATH="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
BIN_PATH=$DIR_PATH/lib/alpaca
LOG_PATH=~/.alpaca.log

install() {
cat << EOF > $PLIST_PATH
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>$PLIST_NAME</string>
    <key>ProgramArguments</key>
    <array>
      <string>$BIN_PATH</string>
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

# Daemon control
if isRunning $PLIST_NAME; then
  echo " ● | color=green templateImage=$ICON_BASE64"
  echo "---"
  echo "Running | bash=\"launchctl list $PLIST_NAME\""
  echo "Stop | bash=\"launchctl stop $PLIST_NAME\" refresh=true"
else
  install

  echo " ● | color=red templateImage=$ICON_BASE64"
  echo "---"
  echo "Start | bash=\"launchctl start $PLIST_NAME\" refresh=true"
fi

# Log tail
if test -f $LOG_PATH; then
  echo "---"
  tail -n 3 $LOG_PATH
fi

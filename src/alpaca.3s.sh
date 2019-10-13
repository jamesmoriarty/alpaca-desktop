#!/bin/sh

set -e
set -u
# set -x

PLIST_NAME=com.github.alpaca
PLIST_PATH=~/Library/LaunchAgents/$PLIST_NAME.plist
DIR_PATH="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
BIN_PATH=$DIR_PATH/lib/alpaca
LOG_PATH=~/.alpaca.log

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

isRunning() {
  pid=$(launchctl list | grep $1 | cut -f 1)

  if [ $pid != "-" ] && [ $pid -gt 0 ]; then
    return 0
  else
    return 1
  fi
}

# Daemon control
if isRunning $PLIST_NAME; then
  echo "🦙● | color=green"
  echo "---"
  echo "Running | bash=\"launchctl list $PLIST_NAME\""
  echo "Stop | bash=\"launchctl stop $PLIST_NAME\" refresh=true"
else
  launchctl unload $PLIST_PATH
  launchctl load $PLIST_PATH

  echo "🦙● | color=red"
  echo "---"
  echo "Start | bash=\"launchctl start $PLIST_NAME\" refresh=true"
fi

# Log tail
if test -f $LOG_PATH; then
echo "---"
tail -n 3 $LOG_PATH
fi

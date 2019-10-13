#!/bin/sh

set -e
set -u
# set -x

PLIST_NAME=com.github.alpaca
PLIST_PATH=$(echo ~/Library/LaunchAgents/$PLIST_NAME.plist)
DIR_PATH="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
BIN_PATH=$(echo $DIR_PATH/lib/alpaca)
LOG_PATH=$(echo ~/.alpaca.log)

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

PID=$(launchctl list | grep $PLIST_NAME | cut -f 1)

if [ -z $PID ]; then
  launchctl unload $PLIST_PATH
  launchctl load $PLIST_PATH
fi

echo "🦙"
echo "---"
if [ $PID != "-" ] && [ "$PID" -gt 0 ]; then
  echo "Running | bash=\"launchctl list $PLIST_NAME\""
  echo "Stop | bash=\"launchctl stop $PLIST_NAME\" refresh=true"
  echo "---"
  echo "$(tail $LOG_PATH)"
else
  echo "Start | bash=\"launchctl start $PLIST_NAME\" refresh=true"
fi

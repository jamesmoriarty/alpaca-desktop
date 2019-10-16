#!/usr/bin/env ruby

require 'base64'

# Configuration

APP_PATH       = File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), "MacOS")
ALPACA_PATH    = File.join(APP_PATH, "/bin/alpaca")
INSTALL_PATH   = File.join(APP_PATH, "/bin/install")
UNINSTALL_PATH = File.join(APP_PATH, "/bin/uninstall")
LOG_PATH       = File.join(Dir.home, ".alpaca.log")
PLIST_NAME     = "com.github.alpaca"
PLIST_PATH     = File.expand_path(File.join(Dir.home, "/Library/LaunchAgents/#{PLIST_NAME}.plist"))
ICON_BASE64    = Base64.strict_encode64(IO.read(File.join(APP_PATH, "/img/icon.png"))).chomp

def running?(plist_name)
  return `launchctl list #{plist_name}`[/"PID" = (\d+)/, 1]
end

# Daemon controls

if running? PLIST_NAME
  puts "| templateImage=#{ICON_BASE64}"
  puts "---"
  puts "Daemon is running"
  puts "Stop | terminal=false bash=/bin/launchctl args=stop__#{PLIST_NAME}"
elsif File.exists? PLIST_PATH
  puts "⚠️ | templateImage=#{ICON_BASE64}"
  puts "---"
  puts "Daemon is stopped"
  puts "Start | terminal=false bash=/bin/launchctl args=start__#{PLIST_NAME}"
else
  puts "⚠️ | templateImage=#{ICON_BASE64}"
  puts "---"
  puts "Install | terminal=false bash=#{INSTALL_PATH} args=#{PLIST_NAME}__#{PLIST_PATH}__#{ALPACA_PATH}__#{LOG_PATH}"
end

  # Log tail

if File.exists? LOG_PATH
  puts "Logs | terminal=false bash=/usr/bin/open args=#{LOG_PATH}"
  puts "---"
  puts `tail -n 3 #{LOG_PATH}`
end

puts "---"
puts "Uninstall | terminal=false bash=#{UNINSTALL_PATH} args=#{PLIST_NAME}__#{PLIST_PATH}__#{ALPACA_PATH}__#{LOG_PATH}"

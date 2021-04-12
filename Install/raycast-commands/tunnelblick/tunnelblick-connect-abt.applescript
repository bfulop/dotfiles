#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tunnelblick: Connect ABT
# @raycast.mode silent
# @raycast.packageName TunnelBlick
#
# Optional parameters:
# @raycast.icon images/tunnelblick.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Connect ABT VPN configurations.
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

on run argv
    tell application "Tunnelblick" to connect "abt"
    return # Discard Output
end run

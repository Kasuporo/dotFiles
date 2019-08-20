#!/bin/bash

cd $(dirname $0)

sudo mkdir -p /usr/local/sbin /usr/local/share/man/man8
sudo cp bin/sleepwatcher /usr/local/sbin
sudo cp bin/sleepwatcher.8 /usr/local/share/man/man8

sudo cp de.bernhard-baehr.sleepwatcher-20compatibility.plist /Library/LaunchDaemons

launchctl load /Library/LaunchDaemons/de.bernhard-baehr.sleepwatcher-20compatibility.plist
launchctl start de.bernhard-baehr.sleepwatcher

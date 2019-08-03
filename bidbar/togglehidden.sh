#!/bin/sh

hidden=$(defaults read com.apple.Finder AppleShowAllFiles)

if [ "$hidden" = "true" ]; then
    defaults write com.apple.Finder AppleShowAllFiles false
else
    defaults write com.apple.Finder AppleShowAllFiles true
fi

killall Finder

#!/bin/sh

killall polybar

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar top -c ~/.config/polybar/config.ini &
		MONITOR=$m polybar bottom -c ~/.config/polybar/config.ini
	done
else
	polybar top -c ~/.config/polybar/config.ini &
	polybar bottom -c ~/.config/polybar/config.ini
fi

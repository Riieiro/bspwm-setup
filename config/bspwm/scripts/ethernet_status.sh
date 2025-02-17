#!/bin/sh

if [ $(/usr/sbin/ifconfig eth0 | grep 'inet ' | awk '{print $2}') ]; then
	echo "%{T7}%{F#ffffff}󰤉%{T-} %{F#ffffff}$(/usr/sbin/ifconfig eth0 | grep 'inet ' | awk '{print $2}')"
else
	echo "%{T7}%{F#ffffff}󰤮%{T-} %{F#ffffff}"

fi

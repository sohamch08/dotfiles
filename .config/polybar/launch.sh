#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
# polybar main 2>&1 | tee -a /tmp/polybar.log & disown
polybar top 2>&1 | tee -a /tmp/polybar.log & disown &
polybar bottom 2>&1 | tee -a /tmp/polybar.log & disown

# Launch
# polybar main &

echo "Bar launched..."

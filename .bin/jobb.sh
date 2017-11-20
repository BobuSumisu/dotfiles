#!/bin/bash

PRIMARY="DP-1-1"
SECONDARY="eDP-1"

function main() {

    # Ensure wanted output is connected.
    xrandr | grep "$PRIMARY" | grep "connected" > /dev/null || {
        echo "jobb.sh: output '$PRIMARY' is not connected"
        exit 1
    }

    # Also ensure secondary output is connected.
    xrandr | grep "$SECONDARY" | grep "connected" > /dev/null || {
        echo "jobb.sh: output '$SECONDARY' is not connected"
        exit 1
    }

    # Check if wanted primary output already is primary.
    xrandr | grep "$PRIMARY" | grep "primary" > /dev/null && {
        echo "jobb.sh: output '$PRIMARY' is already primary output"
        exit 1
    }

    # Turn primary off and then on again (because of docking?).
    # And turn off secondary output.
    xrandr --output $PRIMARY --off
    xrandr --output $PRIMARY --auto --primary
    xrandr --output $SECONDARY --off

}

main $@

unset main

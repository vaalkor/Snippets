#!/bin/bash

# Get the primary display name
DISPLAY_NAME=$(xrandr --query | grep " connected primary" | cut -d" " -f1)

# If no primary display is found, fall back to the first connected display
if [ -z "$DISPLAY_NAME" ]; then
    DISPLAY_NAME=$(xrandr --query | grep " connected" | head -n 1 | cut -d" " -f1)
fi

echo "Display name: $DISPLAY_NAME"w

# Check the current rotation of the display
CURRENT_ROTATION=$(xrandr --query --verbose | grep "$DISPLAY_NAME connected" -A 5 | cut -d " " -f6)

echo "Current rotation: $CURRENT_ROTATION"

# Rotate the display based on its current orientation
if [ "$CURRENT_ROTATION" == "normal" ]; then
    # If the display is in normal orientation, rotate it to the left
    xrandr --output "$DISPLAY_NAME" --rotate left
    echo "Display rotated to left (90 degrees)."
else
    # If the display is already rotated, return it to normal
    xrandr --output "$DISPLAY_NAME" --rotate normal
    echo "Display rotated back to normal."
fi

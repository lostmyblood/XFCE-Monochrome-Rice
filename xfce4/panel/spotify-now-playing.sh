#!/usr/bin/env bash
PLAYER="spotify"
ICON_DIR="$HOME/.config/xfce4/panel/icons"

if ! playerctl -p "$PLAYER" status &>/dev/null; then
    echo "<txt><span foreground='#555555'>--</span></txt>"
    exit 0
fi

STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
ARTIST=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)
TITLE=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)

TEXT="$ARTIST - $TITLE"
MAXLEN=40
if [ ${#TEXT} -gt $MAXLEN ]; then
    TEXT="${TEXT:0:$MAXLEN}…"
fi

TEXT=$(echo "$TEXT" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')

if [ "$STATUS" = "Playing" ]; then
    ICON="$ICON_DIR/spotify-active.png"
    COLOR="#e6e6e6"
else
    ICON="$ICON_DIR/spotify-dim.png"
    COLOR="#888888"
fi

echo "<img>$ICON</img>"
echo "<txt><span foreground='$COLOR' font_family='monospace'>$TEXT</span></txt>"
echo "<tool>$ARTIST — $TITLE ($STATUS)</tool>"
echo "<click>playerctl -p $PLAYER play-pause</click>"

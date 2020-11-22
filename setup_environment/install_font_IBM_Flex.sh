#!/bin/sh
# Userland mode (~$USER/), (~/).

# ~/.fonts is now deprecated and that
#FONT_HOME=~/.fonts
# ~/.local/share/fonts should be used instead
FONT_HOME=~/.local/share/fonts

echo "installing fonts at $PWD to $FONT_HOME"
mkdir -p "$FONT_HOME/IBM/plex"
# find "$FONT_HOME" -iname '*.ttf' -exec echo '{}' \;

(git clone \
   --branch master \
   --depth 1 \
   'https://github.com/IBM/plex.git' \
   "$FONT_HOME/IBM/plex" && \
fc-cache -f -v "$FONT_HOME/IBM/plex")

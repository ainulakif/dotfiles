which i3lock >> /tmp/lock_debug.log

#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#52727aff'
TEXT='#bcc3c3ff'
WRONG='#ef5d40ff'
HIGHLIGHT='#07bdeeff'
VERIFYING='#bcc3c3ff'

i3lock -n \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$HIGHLIGHT     \
--bshl-color=$WRONG          \
\
--screen 1                   \
--blur 25                    \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %Y-%m-%d"    \

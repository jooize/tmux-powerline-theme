#!/bin/sh

#
# Examples
#
# - 256 colors
# - 16 colors
# - 256 colors compact
# - 16 colors compact
# - 256 colors with flag
# - 16 colors with flag
# - 256 colors compact with flag
# - 16 colors compact with flag
#

# Powerline theme settings.
#export TMUX_POWERLINE_COMPACT_CURRENT="on"
#export TMUX_POWERLINE_COMPACT_OTHER="on"
#export TMUX_POWERLINE_FLAG="on"

# Path to Powerline theme.
target="$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"

# Set static information. Restored at end of script.
sessionwindowpane="0:2:1"
hostname="esko.bar"
date="Mar 04 Fri"
time="04:20"

sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)#S:#I:#P/\1${sessionwindowpane}/" "$target"
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)#H/\1${hostname}/" "$target"
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)%b %d %a/\1${date}/" "$target"
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)%H:%M/\1${time}/" "$target"

# Open windows.
tmux new-session -d -s "Demo" -n "Normal" "$SHELL"
tmux set-option -t Demo base-index 1
tmux new-window -t Demo:2 -n "Current" "$EDITOR ; $SHELL"
tmux new-window -t Demo:3 -n "Last" "$SHELL"
tmux new-window -t Demo:4 -n "Activity/Silence" "tmux set-window-option -t Demo:4 monitor-silence 1 && $SHELL"
tmux new-window -t Demo:5 -n "Bell" "sleep 1 && echo  && $SHELL"
tmux new-window -t Demo:6 -n "Content" "tmux set-window-option -t Demo:6 monitor-content 'Content!' && sleep 1 && echo 'Content!' && $SHELL"
#tmux new-window -t Demo -n "~/Projects"
#tmux new-window -t Demo -n "vim .tmux.conf"
#tmux new-window -t Demo -n "CMUS"
#tmux new-window -t Demo -n "top"
#tmux new-window -t Demo -n "WeeChat" "sleep 1 && echo  && $SHELL"
#tmux new-window -t Demo -n ""
#tmux new-window -t Demo -n "" "tmux set-window-option -t Demo:13 monitor-silence 1 && $SHELL"
#tmux new-window -t Demo -n ""
#tmux new-window -t Demo -n ""

tmux select-window -t Demo:3
tmux select-window -t Demo:2

# Reload Powerline theme.
source "$target"

# Restore configuration.
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)${sessionwindowpane}/\1#S:#I:#P/" "$target"
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)${hostname}/\1#H/" "$target"
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)${date}/\1%b %d %a/" "$target"
sed -i.bak "s/^\(tmux set-window-option -g status-right.*\)${time}/\1%H:%M/" "$target"

# Delete Sed's backup file.
rm "${target}.bak"

# Show everything.
tmux attach -t Demo

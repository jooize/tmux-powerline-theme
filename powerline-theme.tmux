#!/bin/sh

#
# Powerline symbols
#

: ${TMUX_POWERLINE_SYMBOLS:=unicode}

case "$TMUX_POWERLINE_SYMBOLS" in
    powerline )
        # Powerline glyphs at U+E000-U+F8FF range ("Private Use Area")
        # These are the code points used in the new universal Powerline
        tmux_powerline_symbol_right_full=""
        tmux_powerline_symbol_right_thin=""
        tmux_powerline_symbol_left_full=""
        tmux_powerline_symbol_left_thin=""
        ;;
    vim-powerline )
        # Powerline glyphs at U+2B60-U+2BFF range ("Miscellaneous Symbols and Arrows")
        # These are the code points used in Lokaltog/vim-powerline
        tmux_powerline_symbol_right_full="⮀"
        tmux_powerline_symbol_right_thin="⮁"
        tmux_powerline_symbol_left_full="⮂"
        tmux_powerline_symbol_left_thin="⮃"
        ;;
    unicode )
        # Unicode glyphs which don't require patched font
        tmux_powerline_symbol_right_full=""
        tmux_powerline_symbol_right_thin="│"
        tmux_powerline_symbol_left_full=""
        tmux_powerline_symbol_left_thin="│"
        ;;
    ascii )
        # ASCII glyphs which don't require patched font or Unicode support
        tmux_powerline_symbol_right_full=""
        tmux_powerline_symbol_right_thin="|"
        tmux_powerline_symbol_left_full=""
        tmux_powerline_symbol_left_thin="|"
        ;;
    none | * )
        # No symbols.
        tmux_powerline_symbol_right_full=""
        tmux_powerline_symbol_right_thin=""
        tmux_powerline_symbol_left_full=""
        tmux_powerline_symbol_left_thin=""
esac

#
# Show flag if terminal reports support for fewer than 8 colors
#
# Current: *
# Previous: -
# Activity/Silence: #
# Bell: !
# Content: +
#

enable_flag()
{
    tmux_powerline_flag="#F"
}

disable_flag()
{
    tmux_powerline_flag=""
}

# Support `tput Co` too?
colors="$(tput colors)"

if [ "${TMUX_POWERLINE_SHOW_FLAG}" = "on" ]; then
    # Force enable flag
    enable_flag
elif [ "${TMUX_POWERLINE_SHOW_FLAG}" = "off" ]; then
    # Force disable flag
    disable_flag
else
    # Dynamically enable flag
    if [ "$colors" -lt 8 ]; then
        # Fewer than n colors supported
        enable_flag
    else
        disable_flag
    fi
fi

#
# Status bar background colour
#

tmux set-window-option -g status-bg colour236 # Gray

#
# Status bar left side
#

# Show session name?
if [ "${TMUX_POWERLINE_SHOW_SESSION_NAME}" = "on" ]; then
    tmux set-window-option -g status-left "#[bg=colour240,fg=white] #S #[fg=colour236,reverse]${tmux_powerline_symbol_right_full}"
    tmux set-window-option -g status-left-length 40
else
    tmux set-window-option -g status-left ""
    #tmux set-window-option -g status-left-length 40
fi

#
# Status bar right side
#

tmux set-window-option -g status-right "#[fg=colour244]#S:#I:#P #[fg=colour240]${tmux_powerline_symbol_left_full}#[fg=colour231,bg=colour240] #H #[fg=colour252]${tmux_powerline_symbol_left_full}#[fg=black,bg=colour252,nobold] %b %d %a #[bold]%H:%M "
tmux set-window-option -g status-right-length 80

#
# Status bar window currently active
#

if [ "${TMUX_POWERLINE_COMPACT_CURRENT}" = "on" ]; then
    tmux set-window-option -g window-status-current-format "#[fg=colour236]${tmux_powerline_symbol_right_full}#[default,fg=colour231,bold] #I${tmux_powerline_flag} #[default,fg=colour236,reverse]${tmux_powerline_symbol_right_full}"
else
    tmux set-window-option -g window-status-current-format "#[fg=colour236]${tmux_powerline_symbol_right_full}#[default,bold] #I${tmux_powerline_flag} #[fg=colour123,reverse]${tmux_powerline_symbol_right_full}#[default]#[bg=colour123] #W #[fg=colour236,reverse]${tmux_powerline_symbol_right_full}"
fi

tmux set-window-option -g window-status-current-attr none
tmux set-window-option -g window-status-current-bg colour33 # Green
tmux set-window-option -g window-status-current-fg black

#
# Status bar window in background (not active)
#

if [ "${TMUX_POWERLINE_COMPACT_OTHER}" = "on" ]; then
    tmux set-window-option -g window-status-format "#[fg=colour236,nounderscore]${tmux_powerline_symbol_right_full}#[default,bold,nounderscore] #I${tmux_powerline_flag} #[fg=colour236,reverse]${tmux_powerline_symbol_right_full}"
else
    tmux set-window-option -g window-status-format "#[fg=colour236,nounderscore]${tmux_powerline_symbol_right_full}#[default,bold,nounderscore] #I${tmux_powerline_flag} #[fg=colour240,reverse]${tmux_powerline_symbol_right_full}#[default]#[bg=colour240]#[nounderscore] #[default]#[fg=colour231,bg=colour240]#W#[nounderscore] #[fg=colour236,reverse]${tmux_powerline_symbol_right_full}"
fi

# Black on green
tmux set-window-option -g window-status-attr none
tmux set-window-option -g window-status-bg colour76 # Green
tmux set-window-option -g window-status-fg black

# Black on white
#tmux set-window-option -g window-status-bg colour231
#tmux set-window-option -g window-status-fg black

# Green more alike non-256color
#tmux set-window-option -g window-status-bg colour40

#
# Status bar window last active (Tmux 1.8+)
#

tmux set-window-option -g window-status-last-attr none
tmux set-window-option -g window-status-last-bg cyan
tmux set-window-option -g window-status-last-fg black

#
# Status bar window with activity/silence (monitor-activity, monitor-silence)
#

tmux set-window-option -g window-status-activity-attr bold #,underscore
tmux set-window-option -g window-status-activity-bg colour127 # Pink
tmux set-window-option -g window-status-activity-fg black

#
# Status bar window with bell triggered
#

tmux set-window-option -g window-status-bell-attr bold #,underscore
tmux set-window-option -g window-status-bell-bg red # Red is urgent
tmux set-window-option -g window-status-bell-fg black

#
# Status bar window with content found (monitor-content) (Tmux <2.0)
#

tmux set-window-option -g window-status-content-attr bold #,underscore
tmux set-window-option -g window-status-content-bg colour226 # Yellow because search highlighting usually is
tmux set-window-option -g window-status-content-fg black


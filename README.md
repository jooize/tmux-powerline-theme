TMUX_POWERLINE_SYMBOLS
======================

## Environment variable options

    "powerline"     If you have a new Powerline font (January 2013 or later)

    "vim-powerline" If you have an older font from the now deprecated
                    Lokaltog/vim-powerline project.

    "unicode"       If you don't have a patched font. (default)

    "ascii"         If you don't have a patched font or Unicode support.

## Enabling powerline symbols
Enable Powerline symbols by putting the following in your .tmux.conf before the line loading this theme.

    if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'

## Switching symbols
To switch between symbols, set the environment variable and reload the theme.

    $ tmux set-environment -g TMUX_POWERLINE_SYMBOLS "vim-powerline"
    $ tmux source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

## Toggle key for switching symbols
Switch symbols with Tmux key bindings by putting this in your .tmux.conf

    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"'

## Enable and disable keys for switching symbols
Add these lines to your .tmux.conf, replacing the bracketed keys with your preferred enable/disable keys

    bind-key <enable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    bind-key <disable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

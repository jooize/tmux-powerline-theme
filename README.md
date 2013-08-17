Tmux Powerline theme
====================

## Installation
Put the following in your `.tmux.conf`:

    source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'

## Alternative Powerline symbols

    "powerline"      If you have a new Powerline font. (January 2013 or later)

    "vim-powerline"  If you have an older font from the now deprecated
                     Lokaltog/vim-powerline project.

    "unicode"        If you don't have a patched font. (default)

    "ascii"          If you don't have a patched font or Unicode support.

## Switch symbols
To switch between symbols, set the environment variable and reload the theme.

    $ tmux set-environment -g TMUX_POWERLINE_SYMBOLS "vim-powerline"
    $ tmux source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

## Use toggle key for symbols
Switch symbols with Tmux key bindings by putting this in your .tmux.conf

    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"'

## Use enable and disable keys for symbols
Add these lines to your .tmux.conf, replacing the bracketed keys with your preferred enable/disable keys

    bind-key <enable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    bind-key <disable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

## Specify symbols in shell
You can also specify preference in your shell before starting Tmux.

    $ export TMUX_POWERLINE_SYMBOLS="powerline"

**Note: The Tmux server can't be running for this to work.**

Tmux Powerline theme
====================

## Installation
Put the following in your `.tmux.conf` to use the recommended configuration.

    #
    # Powerline theme
    #
    
    # Enable Powerline symbols
    if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'
    
    # Toggle between Powerline and Unicode symbols
    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "vim-powerline" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"'
    
    # Load Powerline theme
    source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

## List of Powerline symbols

    "powerline"      If you have a new Powerline font. (January 2013 or later)

    "vim-powerline"  If you have an older font from the now deprecated
                     Lokaltog/vim-powerline project.

    "unicode"        If you don't have a patched font. (default)

    "ascii"          If you don't have a patched font or Unicode support.

## Suggestions

### Use toggle key for symbols (recommended)
Switch between two sets of symbols with `^B P` by putting this in your `.tmux.conf`.

    # Switch between Unicode and new Powerline symbols
    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"'

### Use enable/disable keys for symbols
Add these lines to your `.tmux.conf` and replace the brackets with your preferred keys.

    bind-key <enable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    bind-key <disable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

### Switch symbols manually while Tmux is running

    $ tmux set-environment -g TMUX_POWERLINE_SYMBOLS "vim-powerline"
    $ tmux source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

### Specify symbols in shell
You can also specify preference in your shell before starting Tmux.  
*Note: Must be done before Tmux is started or it won't have effect.*

    $ export TMUX_POWERLINE_SYMBOLS="powerline"

### Attach Tmux on device without Powerline font
Write these lines to a file (`~/Executables/AttachTmuxPhone.sh`), `chmod +x` it
and specify its location as command to run on connect in your SSH client.

    #!/bin/sh
    
    tmux set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"
    tmux source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    tmux attach


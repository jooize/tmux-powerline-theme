Tmux Powerline theme
====================

* Gracefully degrades with terminal color support (256 → 2).
* Compatible with the new and old Powerline fonts, and can use UTF-8 or ASCII symbols.

## Installation
Put the following in your `~/.tmux.conf` to use the recommended configuration.

    #
    # Powerline theme
    #
    
    # Enable Powerline symbols (unless already specified otherwise in environment)
    if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'
    
    # Toggle between Powerline and UTF-8 symbols with ^B P
    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "utf-8"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "utf-8" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"'
    
    # Load Powerline theme
    source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

*If you don't want Powerline symbols, only load the theme (assumes UTF-8 support).*

    # Powerline theme
    source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

## List of Powerline symbols

| Option          | Explanation
| --------------- | -----------
| "powerline"     | If you have a new Powerline font. (January 2013 or later)
| "vim-powerline" | If you have an older font from the now deprecated Lokaltog/vim-powerline project.
| "utf-8"         | If you don't have a patched font. *(default)*
| "ascii"         | If you don't have a patched font or UTF-8 support.

## Suggestions

### Use toggle key for symbols
Switch between two sets of symbols with `^B P` by putting this in your `.tmux.conf`.

    # Toggle between UTF-8 and new Powerline symbols
    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "utf-8"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "utf-8" ; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"'

### Use enable/disable keys for symbols
Add these lines to your `.tmux.conf` and replace the brackets with your preferred keys.

    bind-key <enable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    bind-key <disable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "utf-8" \; source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

### Change symbols manually while Tmux is running

    $ tmux set-environment -g TMUX_POWERLINE_SYMBOLS "vim-powerline"
    $ tmux source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"

Or replace `$ tmux` with `^B :` to use Tmux's command line.

### Specify symbols in shell
You can also specify preference in your shell before starting Tmux.  
*Note: Must be done before Tmux is started or it won't have effect.*

    $ export TMUX_POWERLINE_SYMBOLS="powerline"

### Attach Tmux on device without Powerline font
Write these lines to a file (`~/Executables/AttachTmuxPhone.sh`), `chmod +x` it
and (optionally) specify its location as command to run on connect in your SSH client.

    #!/bin/sh
    
    tmux set-environment -g TMUX_POWERLINE_SYMBOLS "utf-8"
    tmux source-file "$HOME/.tmux/powerline-theme/powerline-theme.conf"
    tmux attach


Tmux Powerline theme
====================

* Gracefully degrades with terminal color support (256 → 2).
* Compatible with the new and old Powerline fonts, and can use Unicode or ASCII symbols.

## Installation

1. Use [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
2. Add `set -g @plugin 'jooize/tmux-powerline-theme'` to your `~/.tmux.conf`.
3. Hit `^B I` inside Tmux to have TPM install it.

### Enable Powerline symbols (optional)

*If you don't want Powerline symbols, only load the theme (assumes Unicode support).*

    #
    # Powerline theme
    #
    
    # Enable Powerline symbols (unless already specified otherwise in environment)
    if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'
    
    # Toggle between Powerline and Unicode symbols with ^B P
    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"'

## List of Powerline symbols

| Option          | Explanation
| --------------- | -----------
| "powerline"     | If you have a new Powerline font. (January 2013 or later)
| "vim-powerline" | If you have an older font from the now deprecated Lokaltog/vim-powerline project.
| "unicode"       | If you don't have a patched font. *(default)*
| "ascii"         | If you don't have a patched font or Unicode support.

## Compact mode

Make current window compact: `$ export TMUX_POWERLINE_COMPACT_CURRENT=on`

    # Make inactive (other) windows compact
    $ export TMUX_POWERLINE_COMPACT_INACTIVE=on

Make all windows compact

    $ export TMUX_POWERLINE_COMPACT=on

## Suggestions

### Use toggle key for symbols
Switch between two sets of symbols with `^B P` by putting this in your `.tmux.conf`.

    # Toggle between Unicode and new Powerline symbols
    bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"'

### Use enable/disable keys for symbols
Add these lines to your `.tmux.conf` and replace the brackets with your preferred keys.

    bind-key <enable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" \; run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"
    bind-key <disable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" \; run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"

### Change symbols manually while Tmux is running

    $ tmux set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"
    $ tmux run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"

Or replace `$ tmux` with `^B :` to use Tmux's command line.

### Specify symbols in shell
You can also specify preference in your shell before starting Tmux.  
*Note: Must be done before Tmux is started or it won't have effect.*

    $ export TMUX_POWERLINE_SYMBOLS="powerline"

### Attach Tmux on device without Powerline font
Write these lines to a file (`~/Executables/AttachTmuxPhone.sh`), `chmod +x` it
and (optionally) specify its location as command to run on connect in your SSH client.

    #!/bin/sh
    
    tmux set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"
    tmux run-shell "$HOME/.tmux/powerline-theme/powerline-theme.tmux"
    tmux attach


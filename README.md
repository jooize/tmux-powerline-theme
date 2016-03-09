Tmux Powerline theme
====================

![](https://i.imgur.com/oqLvFf7.gif)

(March 2016) Rewritten with support for [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (optional), and avoids an ugly race condition workaround used in the [previous version](https://github.com/jooize/tmux-powerline-theme/tree/native). Upgrade!

## Features

- Colors chosen to degrade gracefully (256 → 16 → 2), and shows flag automatically if initialised with fewer than 16 colors supported.
- Supports new and old Powerline glyphs, but defaults to no special symbols.

## Issues

- Doesn't check Tmux version before executing commands, resulting in error messages at startup. ([#2](https://github.com/jooize/tmux-powerline-theme/issues/2))

## Install

### Tmux Plugin Manager (TPM)

1. Use [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
2. Add to your `.tmux.conf`: `set -g @plugin 'jooize/tmux-powerline-theme'`
3. Hit `^B I` inside Tmux to make TPM install it.

### Load from shell

1. Save `powerline-theme.tmux` somewhere.
2. Run in a shell: `source powerline-theme.tmux`

### Manual install in `tmux.conf`

1. Save `powerline-theme.tmux` to `$HOME/.tmux/tmux-powerline-theme/powerline-theme.tmux`
2. Put in your `tmux.conf`: `run-shell "$HOME/.tmux/tmux-powerline-theme/powerline-theme.tmux"`

## Configure

All paths assume installation by Tmux Plugin Manager.

    $HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux

### Enable Powerline symbols

*If you don't want Powerline symbols, simply load the theme.*

```tmux
#
# Powerline theme
#

# Enable Powerline symbols (unless already specified otherwise in environment)
if-shell ': ${TMUX_POWERLINE_SYMBOLS?}' '' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"'

# Toggle between Powerline and Unicode symbols with ^B P
bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; run-shell "$HOME/.tmux/plugins/powerline-theme/powerline-theme.tmux"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"'
```

### Symbol alternatives

| Option          | Explanation
| --------------- | -----------
| `powerline`     | Use the new Powerline symbols. (January 2013 or later)
| `vim-powerline` | Use the old Powerline symbols from the now deprecated [Lokaltog/vim-powerline](https://github.com/Lokaltog/vim-powerline) project.
| `unicode`       | Use Unicode symbols. *(default)*
| `ascii`         | Use ASCII symbols.
| `none`          | No symbols.

*Both `unicode` and `ascii` effectively mean no symbols at this time.*

### Compact mode

Environment variables. Run in shell either before starting Tmux or execute `powerline-theme.tmux` afterwards to apply.

#### Compact current window

```sh
export TMUX_POWERLINE_COMPACT_CURRENT=on
```

#### Compact other windows

```sh
export TMUX_POWERLINE_COMPACT_OTHER=on
```

### Flag

```sh
export TMUX_POWERLINE_FLAG=on
```

### Symbols

```sh
export TMUX_POWERLINE_SYMBOLS="powerline"
```

## Suggestions

### Toggle key for symbols

Switch between two sets of symbols with `^B P` by putting this in your `.tmux.conf`.

```tmux
# Toggle between Unicode and new Powerline symbols
bind-key P if-shell 'test $(echo "${TMUX_POWERLINE_SYMBOLS}") = "unicode"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" ; run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"' 'set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" ; run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"'
```

### Enable and disable keys for symbols

Add these lines to your `.tmux.conf` and replace the brackets with your preferred keys.

```tmux
bind-key <enable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "powerline" \; run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"
bind-key <disable_key> set-environment -g TMUX_POWERLINE_SYMBOLS "unicode" \; run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"
```

### Change symbols manually while Tmux is running

```sh
tmux set-environment -g TMUX_POWERLINE_SYMBOLS "powerline"
tmux run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"
```

Or replace `tmux` with pressing `^B :` to use Tmux's command line.

### Attach Tmux on device without Powerline font

Run the following in a shell, then optionally specify its location as command to run on connect in your SSH client.

```sh
mkdir -p "$HOME/Executables"

cat << 'EOF' > "$HOME/Executables/TmuxAttachMobile.sh"
#!/bin/sh

# Set desired symbols.
tmux set-environment -g TMUX_POWERLINE_SYMBOLS "unicode"

# Run Powerline theme again to apply.
tmux run-shell "$HOME/.tmux/plugins/tmux-powerline-theme/powerline-theme.tmux"

# Attach Tmux.
tmux attach
EOF

chmod +x "$HOME/Executables/TmuxAttachMobile.sh"
```


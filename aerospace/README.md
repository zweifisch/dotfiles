# AeroSpace

From `~/.dotfiles`, run `stow aerospace` to link `.aerospace.toml` into your
home directory. AeroSpace also supports `~/.config/aerospace/aerospace.toml`;
keep only one of these config locations populated.

Stop skhd and yabai before starting AeroSpace so they do not compete for
shortcuts or windows:

```sh
skhd --stop-service
yabai --stop-service
open -a AeroSpace
```

If you run them through Homebrew services instead, stop those services with
`brew services stop skhd` and `brew services stop yabai`.

After editing the installed config:

```sh
aerospace reload-config --dry-run --no-gui
aerospace reload-config
```

The active skhd bindings are preserved, including the app launchers and
im-select input sources. `Cmd+Q` closes a window. `Cmd+H/L` switches workspaces;
`Cmd+J/K` focuses left/right. `Cmd+1..9` selects a workspace and adding Shift
moves the focused window there and follows it. `Alt+Tab` returns to the previous
workspace.

The yabai config uses floating windows globally, so this config does too.
`Cmd+Shift+F` is an added shortcut to toggle floating/tiling for a window.
`Cmd+Space` toggles tiled layout orientation, and `Cmd+Shift+Space` balances
tiled window sizes. Remove the first `on-window-detected` callback to make new
windows tile by default; the explicit app floating rules will still apply.

Emacs opens on workspace 8, and iTerm2/Alacritty on workspace 1. AeroSpace
workspaces are independent of native macOS Spaces. The unused yabai space
labels, Dictionary opacity/grid rule, and scripting-addition setup are not
carried over. AeroSpace does not have a direct equivalent of yabai's
`auto_balance on`; use `Cmd+Shift+Space` to balance manually.

The bindings use physical QWERTY key positions, matching skhd's number-row
keycodes. If macOS already handles `Cmd+Space`, `Ctrl+Space`, or `Alt+Space`,
disable the conflicting Spotlight/input-source shortcut in System Settings.

Command and callback syntax follows the [AeroSpace guide](https://nikitabobko.github.io/AeroSpace/guide)
and [command reference](https://nikitabobko.github.io/AeroSpace/commands), targeting
the installed AeroSpace 0.21.3-Beta.

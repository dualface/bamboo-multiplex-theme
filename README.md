# Bamboo Multiplex theme export

Colors come from the QuickTUI client terminal theme `bamboo-multiplex`
(upstream: https://github.com/ribru17/bamboo.nvim, MIT,
`extras/ghostty/bamboo_multiplex`). This is a dark theme.

| Target | File | Install |
| --- | --- | --- |
| Windows Terminal | `windows-terminal/bamboo-multiplex.json` | `powershell -ExecutionPolicy Bypass -File .\install.ps1` |
| kitty (macOS / Linux) | `kitty/bamboo-multiplex.conf` | `sh kitty/install.sh` |
| herdr | `herdr/bamboo-multiplex.toml` | `sh herdr/install.sh` |

## Windows Terminal

`install.ps1` copies the JSON fragment to
`%LOCALAPPDATA%\Microsoft\Windows Terminal\Fragments\bamboo-multiplex\`.
Restart Windows Terminal, then choose **Bamboo Multiplex** under
Settings > Profile > Appearance > Color scheme, or set
`"colorScheme": "Bamboo Multiplex"` on a profile or in `profiles.defaults`.
The fragment only adds the scheme; it does not switch any profile to it.

## kitty

`install.sh` copies the theme to `~/.config/kitty/themes/` and runs
`kitten themes --reload-in=all "Bamboo Multiplex"`. The kitten writes
`current-theme.conf` and adds an `include` for it to `kitty.conf`.
Manual alternative: copy the file anywhere and add
`include /path/to/bamboo-multiplex.conf` to `kitty.conf`.

## herdr

herdr has no named user themes and no config include: `theme.name` only
accepts built-in names, and a `[theme.bamboo-multiplex]` table is rejected as an
unknown config key. The only user-defined slot is `[theme.custom]`.
`install.sh` therefore backs up `config.toml`, sets `name = "one-dark"` under
`[theme]` (adding the table when missing), replaces any existing
`[theme.custom]` table with the one from `bamboo-multiplex.toml`, runs
`herdr config check` and reloads the running server. Running another theme's
installer afterwards switches themes the same way.
This themes herdr's own UI only; pane colors follow the host terminal, so
install the Windows Terminal or kitty theme as well.

Three herdr tokens differ from a direct mapping of the client theme: `accent`
uses green instead of the near-white cursor color, `overlay0` / `overlay1` /
`subtext0` are blends of brightBlack and foreground (brightBlack alone is
unreadable on the background), and `peach` equals yellow because the client
theme has no orange.

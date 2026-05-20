# clipssh

Send clipboard screenshots to remote SSH hosts. Perfect for pasting images into AI coding tools like Claude Code or OpenCode running over SSH.

## The Problem

When using Claude Code, OpenCode (or similar tools) over SSH, you can't paste images from your local clipboard. The remote terminal has no access to your local display server.

## The Solution

`clipssh` extracts the screenshot from your local clipboard, uploads it to the remote server, and copies the file path to your clipboard. Just paste the path into Claude Code, OpenCode, or any terminal tool and it auto-attaches the image.

## Install

```bash
# macOS (requires Homebrew)
brew install pngpaste
curl -fsSL https://raw.githubusercontent.com/samuellawrentz/clipssh/main/install.sh | bash

# Or clone and install
git clone https://github.com/samuellawrentz/clipssh.git
cd clipssh
./install.sh
```

## Usage

```bash
# 1. Take a screenshot to the clipboard
# macOS: Cmd+Shift+Ctrl+4 (select area, copies to clipboard)

# 2. Run the clipssh command to move the clipboard file to the SSH machine
clipssh user@myserver

# 3. Cmd/Ctrl + V in SSH Machine
# The image will auto-attach
```

## Aliases

Save hosts under short names so you don't have to type `user@host` every time.

```bash
# Save an alias
clipssh alias add myserver user@myserver.com

# List saved aliases
clipssh alias list

# Remove an alias
clipssh alias remove myserver

# Use an alias directly
clipssh myserver
```

Aliases are stored in `~/.clipssh/aliases`, one `name=user@host` per line.

## Set Default Host

```bash
# Add to ~/.zshrc or ~/.bashrc
export CLIPSSH_HOST=user@myserver

# Now just run:
clipssh
```

`CLIPSSH_HOST` also accepts an alias name.

## Change Upload Directory

Uploads land in `/tmp` by default. Override with `CLIPSSH_REMOTE_DIR`:

```bash
export CLIPSSH_REMOTE_DIR=~/.cache/clipssh   # must already exist on the remote
```

Files are written with `umask 077` so they're created as `0600` (owner-readable only) — important on shared hosts where `/tmp` is world-readable by default.

## Requirements

**macOS:**
- `pngpaste` - Install with `brew install pngpaste`
- SSH access to remote host

**Linux:**
- `xclip` (X11) or `wl-clipboard` (Wayland)
- SSH access to remote host

## How It Works

1. Extracts PNG image from your local clipboard
2. Uploads to `$CLIPSSH_REMOTE_DIR/clipboard-<timestamp>.png` (default `/tmp`) on remote host via SSH, with `umask 077` so the file is `0600`
3. Copies the remote path to your clipboard
4. You paste the path into Claude Code, OpenCode, or any tool, which reads and displays the image

## License

MIT

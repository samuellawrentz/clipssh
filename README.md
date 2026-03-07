# clipssh

Send clipboard screenshots to remote SSH hosts. Perfect for pasting images into terminal tools like Claude Code running over SSH.

## The Problem

When using Claude Code (or similar tools) over SSH, you can't paste images from your local clipboard. The remote terminal has no access to your local display server.

## The Solution

`clipssh` extracts the screenshot from your local clipboard, uploads it to the remote server, and copies the file path to your clipboard. Just paste the path into Claude Code and it auto-attaches the image.

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
# Take a screenshot to clipboard
# macOS: Cmd+Shift+Ctrl+4 (select area, copies to clipboard)

# Upload to remote host
clipssh user@myserver

# Paste the path into Claude Code on the remote
# The image will auto-attach
```

## Set Default Host

```bash
# Add to ~/.zshrc or ~/.bashrc
export CLIPSSH_HOST=user@myserver

# Now just run:
clipssh
```

## Requirements

**macOS:**
- `pngpaste` - Install with `brew install pngpaste`
- SSH access to remote host

**Linux:**
- `xclip` (X11) or `wl-clipboard` (Wayland)
- SSH access to remote host

## How It Works

1. Extracts PNG image from your local clipboard
2. Uploads to `/tmp/clipboard-<timestamp>.png` on remote host via SSH
3. Copies the remote path to your clipboard
4. You paste the path into Claude Code, which reads and displays the image

## License

MIT

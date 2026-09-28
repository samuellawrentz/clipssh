# clipssh

Send clipboard screenshots to remote SSH hosts or save locally. Perfect for pasting images into AI coding tools like Claude Code, OpenCode, or local LLMs.

## The Problem

When using Claude Code, OpenCode (or similar tools) over SSH or in local CLI environments, you need a quick way to reference clipboard images as file paths. Over SSH, the remote terminal has no access to your local display server; locally, taking a screenshot and finding its path is tedious.

## The Solution

`clipssh` extracts the screenshot from your local clipboard, saves it locally or uploads it to a remote server, and copies the file path to your clipboard. Just paste the path into Claude Code, OpenCode, local LLMs, or any terminal tool and it auto-attaches the image.

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

### Remote SSH Host

```bash
# 1. Take a screenshot to the clipboard
# macOS: Cmd+Shift+Ctrl+4 (select area, copies to clipboard)

# 2. Run the clipssh command to move the clipboard file to the SSH machine
clipssh user@myserver

# 3. Cmd/Ctrl + V in SSH Machine
# The image will auto-attach
```

### Local Mode (No SSH)

Save clipboard screenshots directly to your local `/tmp` directory and copy the local file path to your clipboard (ideal for pasting into local LLMs):

```bash
# Save locally using the -l or --local flag
clipssh -l
# or
clipssh --local

# Or run bare clipssh when CLIPSSH_HOST is not set
clipssh
```

## Custom SSH Port

Specify a custom SSH port directly in the host target using the `user@host:port` format:

```bash
clipssh user@myserver.com:2222
```

This syntax is also fully supported in aliases and default host environment variables:

```bash
# Save an alias with a custom port
clipssh alias add myserver user@myserver.com:2222

# Or configure it as default
export CLIPSSH_HOST=user@myserver.com:2222
```

### Alternative: SSH Configuration (`~/.ssh/config`)

Since `clipssh` delegates connections directly to your system's standard `ssh` client, it seamlessly obeys any configurations defined in your local `~/.ssh/config` file. This is often the cleanest way to manage custom ports, private keys, or proxy jumps.

Example config block:
```ssh
Host myserver
    HostName myserver.example.com
    User user
    Port 2222
```

Once defined in your SSH config, you can simply run:
```bash
clipssh myserver
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

## Change Directory

For remote uploads, files land in `/tmp` by default. Override with `CLIPSSH_REMOTE_DIR`:

```bash
export CLIPSSH_REMOTE_DIR=~/.cache/clipssh   # must already exist on the remote
```

For local saves, files land in `/tmp` by default. Override with `CLIPSSH_LOCAL_DIR`:

```bash
export CLIPSSH_LOCAL_DIR=~/.local/state/clipssh
```

Files are written with `umask 077` so they're created as `0600` (owner-readable only) — important on shared hosts or systems where `/tmp` is world-readable by default.

## Requirements

**macOS:**
- `pngpaste` - Install with `brew install pngpaste`
- SSH access to remote host (for remote mode)

**Linux:**
- `xclip` (X11) or `wl-clipboard` (Wayland)
- SSH access to remote host (for remote mode)

## How It Works

1. Extracts PNG image from your local clipboard
2. Saves to `$CLIPSSH_LOCAL_DIR/clipboard-<timestamp>.png` (default `/tmp`) locally or uploads to `$CLIPSSH_REMOTE_DIR/clipboard-<timestamp>.png` on the remote host via SSH, with `umask 077` so the file is `0600`
3. Copies the resulting file path to your clipboard
4. You paste the path into Claude Code, OpenCode, local LLMs, or any tool, which reads and displays the image

## License

MIT

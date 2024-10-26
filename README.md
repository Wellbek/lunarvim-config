# My LunarVim Configuration

This repository contains my custom configuration for [LunarVim](https://www.lunarvim.org/).

## Prerequisites

1. **LunarVim**: Ensure [LunarVim](https://www.lunarvim.org/docs/installation) is installed. This configuration assumes the latest version.
2. **Dependencies**: Any tools, language servers, or packages that LunarVim relies on should be installed as well (e.g., Node.js for JavaScript/TypeScript support, Python for Python LSPs, etc.).

## Installation Steps

### Step 1: Clone the Configuration

Clone this repository to your local machine. You can place it wherever you prefer, but a common choice is within your main configuration directory (e.g., `~/.config` on Unix or `C:\Users\<Username>\AppData\Local` on Windows).

For Unix:
```bash
git clone https://github.com/Wellbek/lunarvim-config ~/.config/lvim-config
```

For Windows:
```bash
git clone https://github.com/Wellbek/lunarvim-config C:\Users\<Username>\AppData\Local\lvim-config
```

### Step 2: Set Up a Symlink (Recommended)

Tell LunarVim to use this config folder by creating a symbolic link pointing to it.

On Unix:
```bash
ln -s ~/.config/lvim-config ~/.config/lvim
```

On Windows (PowerShell):
```bash
New-Item -ItemType SymbolicLink -Path C:\Users\<Username>\AppData\Local\lvim -Target C:\Users\<Username>\AppData\Local\lvim-config
```

### Alternative: Copy the Config

Instead of symlinking, you can also copy the contents to the LunarVim config path. However, this requires manual updating each time you make changes.

### Step 3: Open LunarVim and Sync Plugins

After linking or copying, open LunarVim and run `LvimSync` to install plugins and apply configurations.

```bash
lvim
:LvimSync
```

### Additional Notes

- **Custom Plugins**_: If your `config.lua` includes plugins not included by default, ensure they're listed correctly in the `plugins` section.
- **Key Mapping & Custom Settings**: Update key bindings or custom settings as needed, especially if this configuration is used across different environments.
- **Issues**: If LunarVim doesn't recognize the configuration, double-check the symbolic link and that the folder structure matches the expected layout (`config.lua` should be at the root of your config folder).

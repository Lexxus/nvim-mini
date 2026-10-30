# Neovim config

A minimalistic Neovim configuration built on the native features of Neovim 0.12+. Plugins are managed with the built-in `vim.pack`, with no external plugin manager.

## Requirements

- [Neovim](https://neovim.io) 0.12 or newer
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) for project search
- `git`
- `make` and a C compiler to build `telescope-fzf-native.nvim`
- Optional, for language servers:
  - [`lua-language-server`](https://github.com/LuaLS/lua-language-server) for Lua
  - TypeScript 7.0+ (`tsc --lsp`, or `tsgo`) for JavaScript/TypeScript
- Optional: [`cursor-agent`](https://cursor.com/cli) for the agent terminal

## Installation

```sh
git clone <this-repo-url> ~/.config/nvim
nvim
```

On first start, `vim.pack` offers to install the plugins. Plugin revisions are pinned in `nvim-pack-lock.json`.

## Structure

```
init.lua              Entry point; sets leader and loads modules
lua/
  options.lua         Editor options
  keymaps.lua         Window and buffer navigation
  lsp.lua             LSP enable, completion, lua_ls setup
  colorscheme.lua     Built-in catppuccin with transparent background
  netrw.lua           File explorer (netrw) settings
  statusline.lua      Custom statusline (mode, git branch, diagnostics)
  _find.lua           Native fuzzy finder via `findfunc` (disabled, replaced by Telescope)
  _grep.lua           Native ripgrep grep (disabled, replaced by Telescope)
  diagnostics.lua     Diagnostics to quickfix
  plugins/
    init.lua          Loads the plugin modules
    telescope.lua     Telescope, fzf-native, frecency and keymaps
    git.lua           gitsigns and zdiff
    fugitive.lua      vim-fugitive (currently disabled)
  terminal.lua        Terminal and agent terminal toggles
  autocommands.lua    Auto-reload files changed on disk
lsp/
  lua_ls.lua          Lua language server config
  tsc.lua             TypeScript language server config
```

## Plugins

| Plugin | Purpose |
| --- | --- |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, buffers, diagnostics and more |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utilities required by Telescope |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native fzf sorter for Telescope (built with `make` on install/update) |
| [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim) | Frequency/recency based file search |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in the sign column |
| [zdiff.nvim](https://github.com/martindur/zdiff.nvim) | Git diff viewer (uncommitted changes or against `main`) |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration (disabled; enable it in `lua/plugins/init.lua`) |

## Features

- **Search**: Telescope pickers for files, frecency, live grep (ripgrep), buffers, diagnostics, help tags and git status, with a minimal title-less horizontal layout.
- **Git**: gitsigns in the sign column with hunk navigation, staging, reset, preview, blame and diff keymaps (see [Keymaps](#keymaps)), and a `zdiff` view with buffer-local keymaps (`<CR>` open, `<Tab>` toggle, `R` refresh, `q` close, `m` switch between uncommitted changes and `main`).
- **LSP**: native `vim.lsp` with auto-triggered completion for `lua_ls` and `tsc`.
- **Statusline**: mode, git branch, relative path, diagnostic counts, filetype and position.
- **Explorer**: netrw in a tree view on the left, with no banner.
- **Terminal**: toggleable bottom terminal and a side terminal running `cursor-agent`.
- **Auto-reload**: files are re-checked on `BufEnter` and `FocusGained`.

## Keymaps

The leader key is `<Space>`.

| Key | Mode | Action |
| --- | --- | --- |
| `<C-h/j/k/l>` | n | Move between splits |
| `<C-S-h>` / `<C-S-l>` | n | Move to left / right split (works inside netrw) |
| `]b` / `[b` | n | Next / previous buffer (`:bn` / `:bp`) |
| `<leader>sf` | n | Find files (Telescope) |
| `<leader>sr` | n | Frequently/recently opened files (frecency) |
| `<leader>sg` | n | Live grep |
| `<leader>sb` | n | Browse open buffers |
| `<leader>sd` | n | Diagnostics (Telescope) |
| `<leader>sh` | n | Search help tags |
| `<leader>su` | n | Git status |
| `<leader>s.` | n | Resume previous Telescope search |
| `<leader>d` | n | Open diagnostics in the quickfix list |
| `<leader>e` | n | Toggle file explorer (`:Lexplore`) |
| `<leader>t` | n | Toggle terminal |
| `<leader>a` | n | Toggle agent terminal (`cursor-agent`) |
| `<A-l>` | n, x | Send `@file:line[-line]` reference to the agent terminal |
| `<leader>zd` | n | Open the zdiff view (`:Zdiff`) |
| `]c` / `[c` | n | Next / previous git hunk (regular diff motion in diff mode) |
| `<leader>hs` | n, v | Stage hunk (visual: stage selected lines) |
| `<leader>hr` | n, v | Reset hunk (visual: reset selected lines) |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hp` | n | Preview hunk |
| `<leader>hi` | n | Preview hunk inline |
| `<leader>hb` | n | Blame line (full) |
| `<leader>hd` | n | Diff against index |
| `<leader>hD` | n | Diff against last commit (`~`) |
| `<leader>hq` | n | Hunks of the current buffer to quickfix |
| `<leader>hQ` | n | All hunks in the repo to quickfix |
| `<leader>tb` | n | Toggle current line blame |
| `<leader>tw` | n | Toggle word diff |
| `ih` | o, x | Select hunk (text object) |

The gitsigns keymaps are buffer-local and only set in buffers attached to a git repository.

## Options

Reative and absolute line numbers, 2-space indentation with spaces, always-visible sign column, persistent undo, `autoread`, global statusline and a hidden command line (`cmdheight = 0`).

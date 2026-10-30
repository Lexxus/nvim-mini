# Neovim config

A minimalistic Neovim configuration built on the native features of Neovim 0.12+. It uses only one plugin and has no plugin manager beyond the built-in `vim.pack`.

## Requirements

- [Neovim](https://neovim.io) 0.12 or newer
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) for project search
- `git`
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
  find.lua            Fuzzy file finder via `findfunc`
  grep.lua            Project grep via ripgrep
  diagnostics.lua     Diagnostics to quickfix
  pack.lua            Plugins (vim.pack)
  terminal.lua        Terminal and agent terminal toggles
  autocommands.lua    Auto-reload files changed on disk
lsp/
  lua_ls.lua          Lua language server config
  tsc.lua             TypeScript language server config
```

## Plugins

| Plugin | Purpose |
| --- | --- |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |

## Features

- **Fuzzy find**: `:find` uses `matchfuzzy` over `**/*`, ignoring `node_modules`, `.git`, `dist`, `build`, caches and logs.
- **Grep**: `ripgrep` (`--smart-case --hidden`) with results in the quickfix list.
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
| `<leader>]` / `<leader>[` | n | Next / previous buffer (`:bn` / `:bp`) |
| `<leader>f` | n | Fuzzy find a file (`:find`) |
| `<leader>s` | n | Grep across files |
| `<leader>d` | n | Open diagnostics in the quickfix list |
| `<leader>e` | n | Toggle file explorer (`:Lexplore`) |
| `<leader>t` | n | Toggle terminal |
| `<leader>a` | n | Toggle agent terminal (`cursor-agent`) |
| `<A-l>` | n, x | Send `@file:line[-line]` reference to the agent terminal |
| `<leader>gd` | n | Git diff split (`:Gvdiffsplit`) |

## Options

Relative and absolute line numbers, 2-space indentation with spaces, always-visible sign column, persistent undo, `autoread`, global statusline and a hidden command line (`cmdheight = 0`).

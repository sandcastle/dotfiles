# Neovim Keymaps Reference

All keymaps are centralized in `lua/config/keymaps.lua` for easier management and discovery.

## Leader Key

- **Neovim**: `<Space>` (space bar)
- **Traditional Vim**: `,` (comma)

## Quick Reference

Press `<leader>` (space) in normal mode to see all available keymaps with descriptions via which-key.

## General Keymaps

| Key          | Mode   | Description                   |
| ------------ | ------ | ----------------------------- |
| `jk`         | Insert | Exit insert mode              |
| `<leader>nh` | Normal | Clear search highlights       |
| `<leader>+`  | Normal | Increment number under cursor |
| `<leader>-`  | Normal | Decrement number under cursor |

## Window Management

| Key          | Description               |
| ------------ | ------------------------- |
| `<leader>sv` | Split window vertically   |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size    |
| `<leader>sx` | Close current split       |

## Tab Management

| Key          | Description                    |
| ------------ | ------------------------------ |
| `<leader>to` | Open new tab                   |
| `<leader>tx` | Close current tab              |
| `<leader>tn` | Go to next tab                 |
| `<leader>tp` | Go to previous tab             |
| `<leader>tf` | Open current buffer in new tab |

## File Explorer (nvim-tree)

| Key          | Description                          |
| ------------ | ------------------------------------ |
| `<leader>e`  | Toggle file explorer                 |
| `<leader>ef` | Toggle file explorer on current file |
| `<leader>ec` | Collapse file explorer               |
| `<leader>er` | Refresh file explorer                |

## Telescope (Fuzzy Finder)

### File Finding

| Key          | Description                     |
| ------------ | ------------------------------- |
| `<leader>ff` | Find files (including dotfiles) |
| `<leader>fh` | Find files (excluding hidden)   |
| `<leader>fb` | Find buffers                    |
| `<leader>fH` | Find help tags                  |
| `<leader>fs` | Find in current buffer          |
| `<leader>fo` | Find old files                  |
| `<leader>fc` | Find string (custom search)     |

### Search

| Key          | Description      |
| ------------ | ---------------- |
| `<leader>fg` | Live grep search |

### Git Integration

| Key           | Description      |
| ------------- | ---------------- |
| `<leader>gc`  | Git commits      |
| `<leader>gfc` | Git file commits |
| `<leader>gb`  | Git branches     |
| `<leader>gs`  | Git status       |

## Text Editing

### Movement

| Key     | Mode   | Description                       |
| ------- | ------ | --------------------------------- |
| `J`     | Visual | Move selected text down           |
| `K`     | Visual | Move selected text up             |
| `<C-d>` | Normal | Scroll down and center cursor     |
| `<C-u>` | Normal | Scroll up and center cursor       |
| `n`     | Normal | Next search result (centered)     |
| `N`     | Normal | Previous search result (centered) |

### Indentation

| Key | Mode   | Description                        |
| --- | ------ | ---------------------------------- |
| `<` | Visual | Indent left (stay in visual mode)  |
| `>` | Visual | Indent right (stay in visual mode) |

### Clipboard Operations

| Key         | Mode          | Description                      |
| ----------- | ------------- | -------------------------------- |
| `<leader>y` | Normal/Visual | Yank to system clipboard         |
| `<leader>Y` | Normal        | Yank line to system clipboard    |
| `<leader>p` | Visual        | Paste without losing yanked text |
| `<leader>d` | Normal/Visual | Delete without yanking           |

### Advanced

| Key         | Description                  |
| ----------- | ---------------------------- |
| `<leader>s` | Replace word under cursor    |
| `<leader>x` | Make current file executable |

## Organization Benefits

### Before (Scattered)

- Keymaps spread across multiple plugin files
- Hard to discover all available shortcuts
- Difficult to avoid conflicts
- No consistent grouping

### After (Centralized)

- All keymaps in one file (`lua/config/keymaps.lua`)
- Clear organization with comments and sections
- Easy to discover with which-key integration
- Consistent leader key prefixes for logical grouping
- Plugin configurations focus purely on setup, not keymaps

## Adding New Keymaps

1. Open `lua/config/keymaps.lua`
2. Add your keymap in the appropriate section
3. Use descriptive `desc` for which-key integration
4. Follow the existing naming conventions for leader key prefixes

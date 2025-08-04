-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua


local keymap = vim.keymap.set

-- Leader key is already set in init.lua as space

-- ============================================================================
-- GENERAL KEYMAPS
-- ============================================================================

-- Better escape
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Clear highlights
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- ============================================================================
-- PLUGIN KEYMAPS
-- ============================================================================

-- File Explorer (nvim-tree)
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- Telescope fuzzy finder
keymap("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = true,
  })
end, { desc = "Find files (including dotfiles)" })

keymap("n", "<leader>fh", function()
  require("telescope.builtin").find_files({
    hidden = false,
    no_ignore = false,
  })
end, { desc = "Find files (excluding hidden)" })

keymap("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep search" })

keymap("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffers" })

keymap("n", "<leader>fH", function()
  require("telescope.builtin").help_tags()
end, { desc = "Find help tags" })

keymap("n", "<leader>fs", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Find in current buffer" })

keymap("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Find old files" })

keymap("n", "<leader>fc", function()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find string" })

-- Git with telescope
keymap("n", "<leader>gc", function()
  require("telescope.builtin").git_commits()
end, { desc = "Git commits" })

keymap("n", "<leader>gfc", function()
  require("telescope.builtin").git_bcommits()
end, { desc = "Git file commits" })

keymap("n", "<leader>gb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git branches" })

keymap("n", "<leader>gs", function()
  require("telescope.builtin").git_status()
end, { desc = "Git status" })

-- ============================================================================
-- EDITOR KEYMAPS
-- ============================================================================

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search terms centered
keymap("n", "n", "nzzzv", { desc = "Next search result centered" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Better paste (don't lose yanked text when pasting over selection)
keymap("x", "<leader>p", '"_dP', { desc = "Paste without losing yanked text" })

-- System clipboard
keymap("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Delete without yanking
keymap("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
keymap("v", "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Replace word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

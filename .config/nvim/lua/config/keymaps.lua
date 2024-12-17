-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Local options for keymaps
local opts = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- This keybinding uses jj as escape in insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Dismiss Noice Message
-- vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- golang code formatting
-- vim.keymap.set("n", "<leader>ff", ":!gofmt -w %<CR><CR>")
-- vim.keymap.set("n", "<leader>fp", ":!prettier -w %<CR><CR>") -- prettier formatter

-- Disable Ctrl+Z
vim.api.nvim_set_keymap("n", "<C-z>", "<Nop>", { noremap = true, silent = true })

-- Keymaps for hop
vim.api.nvim_set_keymap("n", "<leader>hw", "<cmd>HopWord<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ha", "<cmd>HopAnywhere<CR>", { noremap = true })

-- Map keybindings for GitHub Copilot
-- vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true })
-- vim.g.copilot_no_tab_map = true

-- Set up normal mode keymaps for vim-visual-multi
vim.api.nvim_set_keymap(
  "n",
  "<leader>ma",
  "<Plug>(VM-Select-All)<Tab>",
  { noremap = true, silent = true, desc = "Select All" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>mo",
  "<Plug>(VM-Toggle-Mappings)",
  { noremap = true, silent = true, desc = "Toggle Mapping" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>mp",
  "<Plug>(VM-Add-Cursor-At-Pos)",
  { noremap = true, silent = true, desc = "Add Cursor At Pos" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>mr",
  "<Plug>(VM-Start-Regex-Search)",
  { noremap = true, silent = true, desc = "Start Regex Search" }
)

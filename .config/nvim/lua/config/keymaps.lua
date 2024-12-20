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

-- golang code formatting
-- vim.keymap.set("n", "<leader>ff", ":!gofmt -w %<CR><CR>")
-- vim.keymap.set("n", "<leader>fp", ":!prettier -w %<CR><CR>") -- prettier formatter

-- Disable Ctrl+Z
vim.api.nvim_set_keymap("n", "<C-z>", "<Nop>", { noremap = true, silent = true })

-- Keymaps for hop
vim.api.nvim_set_keymap("n", "<leader>hw", "<cmd>HopWord<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ha", "<cmd>HopAnywhere<CR>", { noremap = true })

-- Map keybindings for GitHub Copilot
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true })
vim.g.copilot_no_tab_map = true

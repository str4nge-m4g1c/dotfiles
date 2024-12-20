return {
  "github/copilot.vim", -- Install CoPilot that allows code suggestions/completions
  config = function()
    -- Set key bindings for Copilot
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true })
    vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Dismiss()', { silent = true, expr = true, noremap = true })
    vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Next()', { silent = true, expr = true, noremap = true })    
    vim.api.nvim_set_keymap("i", "<C-[>", 'copilot#Previous()', { silent = true, expr = true, noremap = true })

    -- Disable default tab mapping
    vim.g.copilot_no_tab_map = true
  end
}

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
    -- Keybindings
    vim.keymap.set("n", "<leader>tgp", ":Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<leader>tgb", ":Gitsigns toggle_current_line_blame<CR>", {})
  end,
}

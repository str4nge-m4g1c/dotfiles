return {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
        keys = "etovxqpdygfblzhckisuran",
    },
    config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "<leader>hw", "<cmd>HopWord<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>ha", "<cmd>HopAnywhere<CR>", { noremap = true })
    end,
}

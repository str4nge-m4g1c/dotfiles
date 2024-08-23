return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<c-\>]],
            direction = "float",
        })

        -- Keymaps for floating and vertical terminals
        vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap(
            "n",
            "<leader>tv",
            "<cmd>ToggleTerm direction=vertical<CR>",
            { noremap = true, silent = true }
        )
    end,
}

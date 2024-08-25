return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
        local nvim_lsp = require("lspconfig")
        local keymap = vim.keymap -- for conciseness
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Common capabilities for LSP servers
        local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- List of LSP servers
        local servers = { "gopls", "pyright", "tsserver" }

        -- Setup each LSP server
        for _, lsp in ipairs(servers) do
            nvim_lsp[lsp].setup({
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        end

        -- Create autocmd for LspAttach to set keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- Set keybinds
                keymap.set(
                    "n",
                    "gR",
                    "<cmd>Telescope lsp_references<CR>",
                    { desc = "Show LSP references", buffer = ev.buf, silent = true }
                )
                keymap.set("n", "gD", vim.lsp.buf.declaration,
                    { desc = "Go to declaration", buffer = ev.buf, silent = true })
                keymap.set(
                    "n",
                    "gd",
                    "<cmd>Telescope lsp_definitions<CR>",
                    { desc = "Show LSP definitions", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    "n",
                    "gi",
                    "<cmd>Telescope lsp_implementations<CR>",
                    { desc = "Show LSP implementations", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    "n",
                    "gt",
                    "<cmd>Telescope lsp_type_definitions<CR>",
                    { desc = "Show LSP type definitions", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    { "n", "v" },
                    "<leader>ca",
                    vim.lsp.buf.code_action,
                    { desc = "See available code actions", buffer = ev.buf, silent = true }
                )
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                    { desc = "Smart rename", buffer = ev.buf, silent = true })
                keymap.set(
                    "n",
                    "<leader>D",
                    "<cmd>Telescope diagnostics bufnr=0<CR>",
                    { desc = "Show buffer diagnostics", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    "n",
                    "<leader>d",
                    vim.diagnostic.open_float,
                    { desc = "Show line diagnostics", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    "n",
                    "[d",
                    vim.diagnostic.goto_prev,
                    { desc = "Go to previous diagnostic", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    "n",
                    "]d",
                    vim.diagnostic.goto_next,
                    { desc = "Go to next diagnostic", buffer = ev.buf, silent = true }
                )
                keymap.set(
                    "n",
                    "K",
                    vim.lsp.buf.hover,
                    { desc = "Show documentation for what is under cursor", buffer = ev.buf, silent = true }
                )
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = ev.buf, silent = true })
            end,
        })
    end,
}

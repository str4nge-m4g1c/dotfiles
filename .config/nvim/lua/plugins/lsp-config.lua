return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local nvim_lsp = require("lspconfig")
    local keymap = vim.keymap -- for conciseness
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Common capabilities for LSP servers
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- List of LSP servers
    local servers = { "gopls", "pyright", "ts_ls" }

    -- Setup each LSP server
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup({
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })
    end

    -- Specific settings for gopls
    nvim_lsp.gopls.setup({
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })

    -- Specific settings for pyright
    nvim_lsp.pyright.setup({
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict",
          },
        },
      },
    })

    -- Create autocmd for LspAttach to set keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Set keybinds
        keymap.set(
          "n",
          "gr",
          "<cmd>Telescope lsp_references<CR>",
          { desc = "Show LSP references", buffer = ev.buf, silent = true }
        )
        keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf, silent = true })
        keymap.set(
          "n",
          "gs",
          "<cmd>Telescope lsp_document_symbols<CR>",
          { desc = "Show LSP document symbols", buffer = ev.buf, silent = true }
        )
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
          "n",
          "<leader>li",
          "<cmd>Telescope lsp_incoming_calls<CR>",
          { desc = "Show LSP incoming calls", buffer = ev.buf, silent = true }
        )
        keymap.set(
          "n",
          "<leader>lo",
          "<cmd>Telescope lsp_outgoing_calls<CR>",
          { desc = "Show LSP outgoing calls", buffer = ev.buf, silent = true }
        )
        keymap.set(
          { "n", "v" },
          "<leader>la",
          vim.lsp.buf.code_action,
          { desc = "See available code actions", buffer = ev.buf, silent = true }
        )
        keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Smart rename", buffer = ev.buf, silent = true })
        keymap.set(
          "n",
          "<leader>lD",
          "<cmd>Telescope diagnostics bufnr=0<CR>",
          { desc = "Show buffer diagnostics", buffer = ev.buf, silent = true }
        )
        keymap.set(
          "n",
          "<leader>ld",
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
        keymap.set("n", "<leader>ls", ":LspRestart<CR>", { desc = "Restart LSP", buffer = ev.buf, silent = true })

        if vim.bo.filetype == "go" then
          -- Additional keymap for organizing imports in Go
          keymap.set(
            "n",
            "<C-i>",
            "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })<CR>",
            { desc = "Organize Imports", buffer = ev.buf, silent = true }
          )
          -- Keymaps for switching between Go source and test files
          keymap.set(
            "n",
            "<leader>tt",
            ":lua require('config.go_utils').switch_to_test()<CR>",
            { desc = "Switch to test file", buffer = ev.buf, silent = true }
          )
          keymap.set(
            "n",
            "<leader>tv",
            ":lua require('config.go_utils').switch_to_test_vsplit()<CR>",
            { desc = "Switch to test file in vertical split", buffer = ev.buf, silent = true }
          )
          keymap.set(
            "n",
            "<leader>ts",
            ":lua require('config.go_utils').switch_to_source()<CR>",
            { desc = "Switch to source file", buffer = ev.buf, silent = true }
          )
        end
      end,
    })
  end,
}

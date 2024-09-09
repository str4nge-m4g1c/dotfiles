return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    require("mason").setup({
      PATH = "prepend", -- "skip" seems to cause the spawning error
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "gopls",
        "bufls",
        "emmet_ls",
        "prismals",
        "pyright",
        "templ",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "debugpy", -- python debugger
        "golines", -- go formatter
        "templ",
        "pylint", -- python linter
        "eslint_d", -- js linter
      },
    })
  end,
}

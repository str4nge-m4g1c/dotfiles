return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
    -- "hrsh7th/cmp-nvim-lsp", -- cmp_nvim_lsp
    -- "neovim/nvim-lspconfig", -- lspconfig
    "onsails/lspkind-nvim", -- lspkind (VS pictograms)
    { "saadparwaiz1/cmp_luasnip", enabled = true }, -- for autocompletion
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        -- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local types = require("luasnip.util.types")

    -- Display virtual text to indicate snippet has more nodes
    luasnip.config.setup({
      ext_opts = {
        [types.choiceNode] = {
          active = { virt_text = { { "⇥", "GruvboxRed" } } },
        },
        [types.insertNode] = {
          active = { virt_text = { { "⇥", "GruvboxBlue" } } },
        },
      },
    })

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        -- { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          show_labelDetails = true,
        }),
      },
    })
    -- local lspconfig = require("lspconfig")
    -- Python: brew install pyright
    -- lspconfig["pyright"].setup({})
  end,
}

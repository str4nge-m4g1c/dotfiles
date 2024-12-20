return {
    -- LSP and completion plugins
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },

    -- Setup nvim-cmp.
    config = function()
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                end,
            },
            mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- Setup lspconfig.
        local lspconfig = require'lspconfig'

        -- Enable the following language servers
        local servers = { 'pyright', 'tsserver', 'gopls', 'rust_analyzer' }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            }
        end

        -- Additional configuration for specific language servers
        lspconfig.pyright.setup{}
        lspconfig.tsserver.setup{}
        lspconfig.gopls.setup{}
        lspconfig.rust_analyzer.setup{}
    end
}
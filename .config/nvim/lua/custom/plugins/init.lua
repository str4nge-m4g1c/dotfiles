-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
vim.opt.conceallevel = 1
vim.keymap.set('n', '<leader>oo', ':cd ~/Repositories/mysecondbrain<cr>')
vim.keymap.set('n', '<leader>ot', ':ObsidianToday<cr>')
vim.keymap.set('n', '<leader>os', ':Telescope find_files search_dirs={"~/Repositories/mysecondbrain"}<cr>')
vim.keymap.set('n', '<leader>oz', ':Telescope live_grep search_dirs={"~/Repositories/mysecondbrain"}<cr>')
--
return {
  'github/copilot.vim', -- Install CoPilot that allows code suggestions/completions
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debug logging
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections
    },
    keys = {
      {
        desc = 'CopilotChat - Quick chat',
        '<leader>ccq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
      },
      -- Show help actions with telescope
      {
        '<leader>cch',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ccp',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
    },
  },
  'mg979/vim-visual-multi', -- Install Visual Multi that allows multiple cursors
  'sudormrfbin/cheatsheet.nvim',
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- Provider configuration
    provider = "copilot", -- Use copilot as the provider
    auto_suggestions_provider = "copilot",
    copilot = {
      endpoint = "https://api.githubcopilot.com",
      model = "gpt-4o-2024-05-13",
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
    -- UI configuration
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 30, -- default % based on available width
      sidebar_header = {
        align = "center", -- left, center, right for title
        rounded = true,
      },
    },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {
    -- Avante specific keybindings
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "Avante - Ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "Avante - Refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "Avante - Edit",
      mode = "v",
    },
    { "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante - Toggle" },
    { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Avante - Focus" },
    { "<leader>ac", "<cmd>AvanteChat<cr>", desc = "Avante - Chat" },
    { "<leader>as", "<cmd>AvanteSwitchProvider<cr>", desc = "Avante - Switch Provider" },

    -- Quick actions
    {
      "<leader>ax",
      function()
        require("avante.api").ask({
          question = "Explain this code",
          selection = true,
        })
      end,
      desc = "Avante - Explain Code",
      mode = "v",
    },
    {
      "<leader>ao",
      function()
        require("avante.api").ask({
          question = "Optimize this code",
          selection = true,
        })
      end,
      desc = "Avante - Optimize Code",
      mode = "v",
    },
    {
      "<leader>ad",
      function()
        require("avante.api").ask({
          question = "Add documentation to this code",
          selection = true,
        })
      end,
      desc = "Avante - Document Code",
      mode = "v",
    },
    {
      "<leader>ab",
      function()
        require("avante.api").ask({
          question = "Find and fix bugs in this code",
          selection = true,
        })
      end,
      desc = "Avante - Debug Code",
      mode = "v",
    },
  },
}

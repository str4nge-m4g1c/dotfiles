return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "mysecondbrain",
        path = "~/Repositories/mysecondbrain",
      },
    },
    templates = {
      folder = "~/Repositories/mysecondbrain/9_templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
  },
  notes_subdir = "1_inbox",
  new_notes_location = "notes_subdir",
  daily_notes = {
    folder = "~/Repositories/mysecondbrain/1_inbox",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    default_tags = { "daily-notes" },
    template = "New Note Template.md",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Obsidian keymaps for mysecondbrain
    vim.opt.conceallevel = 1
    -- vim.keymap.set(
    --   "n",
    --   "<leader>oo",
    --   ":cd ~/Repositories/mysecondbrain<cr>",
    --   { noremap = true, silent = true, desc = "Change Directory to Obsidian Vault" }
    -- )
    -- vim.keymap.set(
    --   "n",
    --   "<leader>ot",
    --   ":ObsidianToday<cr>",
    --   { noremap = true, silent = true, desc = "Create Today's Note" }
    -- )
    vim.keymap.set(
      "n",
      "<leader>os",
      ':Telescope find_files search_dirs={"~/Repositories/mysecondbrain"}<cr>',
      { noremap = true, silent = true, desc = "Search Files in Obsidian Vault" }
    )
    vim.keymap.set(
      "n",
      "<leader>oz",
      ':Telescope live_grep search_dirs={"~/Repositories/mysecondbrain"}<cr>',
      { noremap = true, silent = true, desc = "Live Grep in Obsidian Vault" }
    )

    -- -- Function to create a new note using a template
    -- local function create_new_note_with_template()
    --   local obsidian = require("obsidian")
    --   local template_name = "New Note Template.md"
    --   local note_name = vim.fn.input("Note name: ")
    --   local note_path = note_name .. ".md"
    --   obsidian.create_note_from_template(note_path, template_name)
    -- end
    --
    -- -- Set up keybinding to create a new note using a template
    -- vim.keymap.set(
    --   "n",
    --   "<leader>on",
    --   create_new_note_with_template,
    --   { noremap = true, silent = true, desc = "Create New Note with Template" }
    -- )
  end,
}

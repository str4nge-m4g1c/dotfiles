return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    -- Document existing key chains
    require("which-key").add({
      { "<leader>c", group = "[c]ode" },
      { "<leader>d", group = "[d]ocument" },
      { "<leader>s", group = "[s]earch" },
      { "<leader>h", group = "[h]op" },
      { "<leader>o", group = "[o]bsidian" },
      { "<leader>f", group = "[f]ormat" },
      -- { "<leader>l", group = "[l]sp" },
      { "<leader>x", group = "[x]trouble" },
    })
  end,
}

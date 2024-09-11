return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    -- Document existing key chains
    require("which-key").add({
      { "<leader>c", group = "[c]ode" },
      { "<leader>d", group = "[d]ocument" },
      { "<leader>r", group = "[r]ename" },
      { "<leader>s", group = "[s]earch" },
      { "<leader>w", group = "[w]orkspace" },
      { "<leader>h", group = "[h]op" },
      { "<leader>t", group = "[t]oggle" },
      { "<leader>n", group = "[n]oice" },
      { "<leader>o", group = "[o]bsidian" },
      { "<leader>f", group = "[f]ormat" },
      { "<leader>l", group = "[l]sp" },
      { "<leader>x", group = "[x]trouble" },
      { "<leader>m", group = "Visual Multi" },
    })
  end,
}

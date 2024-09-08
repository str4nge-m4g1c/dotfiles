return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("render-markdown").disable()
    -- Define a function to toggle markdown rendering
    local function toggle_markdown_rendering()
      require("render-markdown").toggle()
    end

    -- Set up the keybinding
    vim.api.nvim_set_keymap("n", "<leader>tm", ":RenderMarkdown toggle<CR>", { noremap = true, silent = true })
  end,
}

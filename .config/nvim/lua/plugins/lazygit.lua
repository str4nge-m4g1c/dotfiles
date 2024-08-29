return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    keys = {
        { "<leader>tl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
}

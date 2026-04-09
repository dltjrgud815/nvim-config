return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    opts = {},
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
      { "<leader>gD", "<cmd>DiffviewOpen --staged<CR>", desc = "Git staged diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git file history" },
      { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Git diff view close" },
    },
  },
}

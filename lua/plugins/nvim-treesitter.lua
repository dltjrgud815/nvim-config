return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})
      ts.install({
        "c",
        "cpp",
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
      })
    end,
  },
}

return {
  { "mason-org/mason.nvim" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "clang-format",
        "stylua",
        "shfmt",
        "shellcheck",
        "prettier",
        "prettierd",
        "isort",
        "black",
        "rustfmt",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
  { "mason-org/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" }
}

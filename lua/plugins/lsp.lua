return {
  { "mason-org/mason.nvim" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
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
        -- rustfmt 은 mason 에서 제거됨: rustup component add rustfmt 로 설치
      },
      auto_update = false, -- 매 실행마다 업데이트하지 않음 (:MasonToolsUpdate 로 수동 갱신)
      run_on_start = true,
    },
  },
  { "mason-org/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" }
}

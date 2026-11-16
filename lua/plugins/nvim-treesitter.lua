-- nvim-treesitter (main 브랜치)
-- - lazy-loading 을 지원하지 않으므로 lazy = false
-- - 파서 설치에 tree-sitter CLI 가 필요하다 (brew install tree-sitter-cli)
-- - 하이라이트는 Neovim 내장 기능이라 vim.treesitter.start() 로 직접 켜야 한다
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "c",
        "cpp",
        "lua",
        "bash",
        "python",
        "markdown",
        "markdown_inline",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
        callback = function(args)
          -- 파서가 없는 filetype 이면 조용히 넘어간다
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}

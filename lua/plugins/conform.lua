return {
  'stevearc/conform.nvim',
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        sh = { "shfmt" },
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style=file" },
        },
      },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "c" or ft == "cpp" then
          return nil
        end

        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
    })
  end,
}

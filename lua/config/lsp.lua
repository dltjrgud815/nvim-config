-- LSP 설정 (Neovim 0.11+ 의 vim.lsp.config / vim.lsp.enable API 사용)
-- nvim-lspconfig 은 서버별 기본 설정(lsp/*.lua)만 제공하고,
-- 여기서는 vim.lsp.config() 로 그 위에 덮어쓸 값만 지정한다.

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Diagnostics: Neovim 0.11 부터 virtual_text 가 기본으로 꺼져 있어서 다시 켠다.
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- 모든 서버 공통 설정: nvim-cmp 자동완성 capabilities
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  vim.lsp.config("*", {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  })
end

-- clangd
-- root 는 compile_commands.json / compile_flags.txt 가 있는 디렉터리를 우선으로 잡고,
-- 없으면 .git 루트를 쓴다. clangd 는 root 와 그 상위 디렉터리, 그리고 각 디렉터리의
-- build/ 아래에서 compile_commands.json 을 스스로 찾기 때문에
-- 예전의 --compile-commands-dir 수동 지정은 필요 없다.
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=never",
    "--function-arg-placeholders=0",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  init_options = {
    clangdFileStatus = true,
    fallbackFlags = { "-std=gnu11" },
  },
})

-- lua_ls: 이 설정 파일 같은 Neovim Lua 코드를 편집할 때 `vim` 전역 경고가 뜨지 않도록
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

-- mason 으로 서버를 설치하고, 설치된 서버를 vim.lsp.enable() 로 자동 활성화
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua_ls", "bashls", "pyright" },
  -- stylua 는 mason 으로 설치돼 있어서 LSP 로도 자동 활성화되는데,
  -- 포매팅은 conform 이 담당하므로 LSP 로는 켜지 않는다.
  automatic_enable = {
    exclude = { "stylua" },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local km = require("utils.keyMapper")
    local function opts(desc)
      return { buffer = args.buf, desc = desc }
    end

    km.nmap("gd", vim.lsp.buf.definition, opts("Go to definition"))
    km.nmap("gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    -- nowait: Neovim 기본 gr* 매핑(grn, gra, grr, gri ...)을 기다리지 않고 바로 실행
    km.nmap("gr", vim.lsp.buf.references, vim.tbl_extend("force", opts("References"), { nowait = true }))
    km.nmap("gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    km.nmap("K", vim.lsp.buf.hover, opts("Hover"))
    km.nmap("<leader>ld", vim.diagnostic.open_float, opts("Line diagnostics"))
    km.nmap("[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts("Prev diagnostic"))
    km.nmap("]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts("Next diagnostic"))
    km.nmap("<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
    km.nmap("<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    km.nmap("<leader>cf", function()
      require("conform").format({
        async = true,
        lsp_format = "fallback",
      })
    end, opts("Format buffer"))
  end,
})

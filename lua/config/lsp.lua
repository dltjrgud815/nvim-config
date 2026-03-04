require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
    },
})

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function find_clangd_root(fname)
  return util.root_pattern("compile_commands.json", "compile_flags.txt")(fname)
    or util.root_pattern(".git")(fname)
end

local function find_compile_commands_dir(fname)
  local build_files = { "compile_commands.json", "compile_flags.txt" }
  local dir = vim.fs.dirname(fname)
  local match = vim.fs.find(build_files, {
    path = dir,
    upward = true,
    stop = vim.loop.os_homedir(),
  })[1]

  if match then
    return vim.fs.dirname(match)
  end
end

require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua_ls", "bashls", "pyright" },
  automatic_enable = true,
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end,
    clangd = function()
      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--function-arg-placeholders=0",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = find_clangd_root,
        init_options = {
          clangdFileStatus = true,
          fallbackFlags = { "-std=gnu11" },
        },
        on_new_config = function(new_config, new_root_dir)
          local search_path = new_root_dir or vim.api.nvim_buf_get_name(0)
          local compile_dir = find_compile_commands_dir(search_path)

          if compile_dir then
            local cmd = vim.deepcopy(new_config.cmd)
            table.insert(cmd, "--compile-commands-dir=" .. compile_dir)
            new_config.cmd = cmd
          end
        end,
        capabilities = capabilities,
      })
    end,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local km = require("utils.keyMapper")
    local opts = { buffer = args.buf }

    km.nmap("gd", vim.lsp.buf.definition, opts)
    km.nmap("gD", vim.lsp.buf.declaration, opts)
    km.nmap("gr", vim.lsp.buf.references, opts)
    km.nmap("gi", vim.lsp.buf.implementation, opts)
    km.nmap("K",  vim.lsp.buf.hover, opts)
    km.nmap("<leader>ld", vim.diagnostic.open_float, opts)
    km.nmap("[d", vim.diagnostic.goto_prev, opts)
    km.nmap("]d", vim.diagnostic.goto_next, opts)
    km.nmap("<leader>rn", vim.lsp.buf.rename, opts)
    km.nmap("<leader>ca", vim.lsp.buf.code_action, opts)
    km.nmap("<leader>cf", function()
      require("conform").format({
        async = true,
        lsp_format = "fallback",
      })
    end, opts)
  end,
})

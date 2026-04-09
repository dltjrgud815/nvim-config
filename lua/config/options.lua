local opt = vim.opt

-- tab/indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- visual
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"

-- etc
vim.opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.cmdheight = 1
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.updatetime = 250
opt.timeoutlen = 400
opt.mouse:append("a")
opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
opt.completeopt = { "menuone", "noselect" }

local keymap = require("utils.keyMapper")

local nmap = keymap.nmap
local imap = keymap.imap
local vmap = keymap.vmap

-- Neotree toggle
nmap("<leader>e", ":Neotree toggle<cr>", { desc = "Neotree toggle" })

-- Path Navigation
nmap("<C-h>", "<C-w>h", { desc = "Window left" })
nmap("<C-j>", "<C-w>j", { desc = "Window down" })
nmap("<C-k>", "<C-w>k", { desc = "Window up" })
nmap("<C-l>", "<C-w>l", { desc = "Window right" })

-- Clear Search Highlight
nmap("<leader>h", ":nohlsearch<CR>", { desc = "off search highlight"})

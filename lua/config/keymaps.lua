local keymap = require("utils.keyMapper")

local nmap = keymap.nmap
local vmap = keymap.vmap

nmap("<leader>w", "<cmd>w<CR>", { desc = "Write buffer" })
nmap("<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

-- Neotree toggle
nmap("<leader>e", ":Neotree toggle<cr>", { desc = "Neotree toggle" })

-- Path Navigation
nmap("<C-h>", "<C-w>h", { desc = "Window left" })
nmap("<C-j>", "<C-w>j", { desc = "Window down" })
nmap("<C-k>", "<C-w>k", { desc = "Window up" })
nmap("<C-l>", "<C-w>l", { desc = "Window right" })

-- Clear Search Highlight
nmap("<leader>h", ":nohlsearch<CR>", { desc = "off search highlight"})

-- Quickfix navigation
-- <leader>c 는 <leader>ca / <leader>cf 와 접두사가 겹쳐서 하나의 토글 키로 합침
nmap("<leader>x", function()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end, { desc = "Quickfix toggle" })
nmap("]q", "<cmd>cnext<CR>", { desc = "Quickfix next" })
nmap("[q", "<cmd>cprev<CR>", { desc = "Quickfix prev" })

-- Git
nmap("<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })
nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })
nmap("<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })

-- indent
vmap("<", "<gv")
vmap(">", ">gv")

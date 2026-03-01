local KM = {}
local function map(mode, from, to, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false

	vim.keymap.set(mode, from, to, opts)
end

KM.map = map
KM.nmap = function(from, to, opts) map("n", from, to, opts) end
KM.imap = function(from, to, opts) map("i", from, to, opts) end
KM.vmap = function(from, to, opts) map("v", from, to, opts) end
KM.xmap = function(from, to, opts) map("x", from, to, opts) end
KM.tmap = function(from, to, opts) map("t", from, to, opts) end

return KM

-- local keyMapper = function(from, to, mode, opts)
--	local options = { noremap = true, silent = true }
--	mode = mode or "n"

--	if opts then
--		options = vim.tbl_extend("force", options, opts)
--	end

--	vim.keymap.set(mode, from, to, options)
--end

--return { mapKey = keyMapper }

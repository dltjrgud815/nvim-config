local keymap = require("utils.keyMapper")
return {
    'nvim-telescope/telescope.nvim', version = '0.1.9',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local builtin = require("telescope.builtin")
      keymap.nmap("<leader>ff", builtin.find_files)
      keymap.nmap("<leader>fg", builtin.live_grep)
      keymap.nmap("<leader>fb", builtin.buffers)
      keymap.nmap("<leader>fh", builtin.help_tags)
    end,
    {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        require("telescope").setup {
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {
              }
            }
          }
        }
        require("telescope").load_extension("ui-select")
      end
    }
}

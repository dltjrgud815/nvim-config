return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.9",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local keymap = require("utils.keyMapper")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      telescope.load_extension("ui-select")

      keymap.nmap("<leader>ff", builtin.find_files, { desc = "Find files" })
      keymap.nmap("<leader>fg", builtin.live_grep, { desc = "Live grep" })
      keymap.nmap("<leader>fb", builtin.buffers, { desc = "Buffers" })
      keymap.nmap("<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },
}

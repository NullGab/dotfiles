return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-live-grep-args.nvim' }, -- optional but recommended
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup {
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable quoting for easier searches
          },
        },
      }

      -- load extension if available
      pcall(telescope.load_extension, "live_grep_args")

      -- keymaps
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<C-n>', builtin.git_files, { desc = 'Git files' })

      -- use live_grep_args if installed, else fallback to built-in live_grep
      vim.keymap.set('n', '<leader>lg', function()
        if pcall(require("telescope").extensions.live_grep_args.live_grep_args) then
          require("telescope").extensions.live_grep_args.live_grep_args()
        else
          builtin.live_grep()
        end
      end, { desc = 'Live Grep' })
    end,
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    'andrew-george/telescope-themes',
    config = function()
      require('telescope').load_extension('themes')
    end,
  },
}

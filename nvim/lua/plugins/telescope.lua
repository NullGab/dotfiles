return {
  {	'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' }, 
  config = function() 
    local builtin =
    require("telescope.builtin")
    require("telescope").setup{}
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-n>', builtin.git_files, {})
  end
},
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

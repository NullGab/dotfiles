return {
  { 'hiphish/rainbow-delimiters.nvim'},
  { 'lukas-reineke/indent-blankline.nvim',
  config = function()
    require("ibl").setup()
  end
},
{ 'm4xshen/autoclose.nvim',
config = function()
  require("autoclose").setup({
    keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },

      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },

      ['"'] = { escape = true, close = true, pair = '""' },
      ["'"] = { escape = true, close = true, pair = "''" },
      ["`"] = { escape = true, close = true, pair = "``" },
    },
    options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      pair_spaces = false,
      auto_indent = true,
      disable_command_mode = false,
    },
  })
end
}
  }

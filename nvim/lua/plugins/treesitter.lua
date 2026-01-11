return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context"
  },
  priority = 1000,
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "c", "cpp", "lua", "markdown", "markdown_inline",
        "python", "rust", "javascript", "vim", "vimdoc", "zig",
        "php", "html", "css", "go"
      },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
    }
  end
}


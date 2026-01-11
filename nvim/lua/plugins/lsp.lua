return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "rust_analyzer",
          "intelephense",
          "html",
          "cssls",
          "gopls"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Compatibility layer (for older versions of Neovim)
      local use_new_api = vim.lsp and vim.lsp.config

      local function setup(server, opts)
        opts = opts or {}
        opts.capabilities = capabilities

        if use_new_api then
          vim.lsp.config(server, opts)
        else
          require("lspconfig")[server].setup(opts)
        end
      end

      -- LSP servers
      setup("lua_ls")
      setup("clangd")
      setup("rust_analyzer")
      setup("intelephense")
      setup("html")
      setup("cssls")

      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}

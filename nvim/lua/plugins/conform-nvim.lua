return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        go = { "gofmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        javascript = { "prettier" },
      },

      -- Automatically format on save
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    })

    -- Manual format command
    vim.keymap.set("n", "<leader>f", function()
      conform.format({ async = true, lsp_fallback = true })
    end, { desc = "Format file with Conform" })
  end,
}


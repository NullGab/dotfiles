return {
  "barrett-ruth/live-server.nvim",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = true,
  keys = {
    { "<leader>ls", "<cmd>LiveServerStart<CR>", desc = "Iniciar Live Server" },
    { "<leader>lq", "<cmd>LiveServerStop<CR>", desc = "Parar Live Server" },
  }
}

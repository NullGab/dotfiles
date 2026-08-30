return{
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local config = {
      cmd = {'jdtls'},
      root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'pom.xml'}),
    }
    require('jdtls').start_or_attach(config)
  end
}

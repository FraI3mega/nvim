vim.lsp.config("*", {
  before_init = function(_, config)
    local codesettings = require("codesettings")
    codesettings.with_local_settings(config.name, config)
  end,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("nixd")
-- vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
vim.lsp.enable("jsonls")

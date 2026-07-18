vim.lsp.codelens.enable(true)
vim.lsp.inlay_hint.enable()

vim.lsp.config("*", {
  before_init = function(_, config)
    local codesettings = require("codesettings")
    codesettings.with_local_settings(config.name, config)
  end,
})

vim.lsp.config("*", {
  on_attach = function(client, bufnr)
    -- some clients support workspace diagnostics natively
    if client:supports_method("workspace/diagnostic", bufnr) then
      vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
    else
      require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end
  end,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("nixd")
-- vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
vim.lsp.enable("jsonls")
vim.lsp.enable("jsonls")
vim.lsp.enable("marksman")

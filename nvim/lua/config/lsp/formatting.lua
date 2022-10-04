local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- If there are multiple formatters for the buffer, we are going to prefer the null-ls one.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/923
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local lsp_formatting = function(bufnr)
  local has_null_ls = not vim.tbl_isempty(vim.lsp.get_active_clients({ bufnr = bufnr, name = "null-ls" }))

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(lsp_client)
      if has_null_ls then
        return lsp_client.name == "null-ls"
      end

      -- If a null-ls formatter isn't attached to the buffer, allow the other formatter to handle it.
      return true
    end,
  })
end

function M.setup(client, bufnr)
  -- Enable formatting when a file is saved
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

return M

local M = {}

local wk = require("which-key")
local util = require("util")

function M.setup(client, bufnr)
   local opts = { noremap = true, silent = true, buffer = bufnr }

   local keymap = {
      c = {
         name = "+code",
         a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
         d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
         l = {
            name = "+lsp",
            i = { "<cmd>LspInfo<cr>", "Lsp Info" },
            a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
            r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
            l = {
               "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
               "List Folders",
            },
         },
         g = {
            name = "+goto",
            d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
            r = { "<cmd>Telescope lsp_references<cr>", "References" },
            R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
            D = { "<Cmd>Telescope lsp_declarations<CR>", "Goto Declaration" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
            i = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
            t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
         },
      },
   }

   local keymap_visual = {
      c = {
         name = "+code",
         a = { ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
      },
   }

   if client.server_capabilities.documentFormatting then
      keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
   end

   if client.server_capabilities.documentRangeFormatting then
      keymap_visual.c.f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format Range" }
   end

   if client.server_capabilities.renameProvider then
      keymap.c.r = { vim.lsp.buf.rename, "Rename" }
   end

   util.nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   util.nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
   util.nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

   wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
   wk.register(keymap_visual, { buffer = bufnr, prefix = "<leader>", mode = "v" })
end

return M

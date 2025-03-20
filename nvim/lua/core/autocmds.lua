local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
   group = highlight_yank,
   desc = "Highlight text when yanked",
   pattern = "*",
   command = "silent! lua require'vim.highlight'.on_yank({timeout = 200})",
})

local format_options = vim.api.nvim_create_augroup("format_options", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
   group = format_options,
   desc = "Set format options for all file types",
   pattern = "*",
   callback = function()
      vim.opt.formatoptions = vim.opt.formatoptions
         + "c" -- Comments respect textwidth
         + "j" -- Auto-remove comments when joining together two lines
         - "r" -- Don't automatically continue comment when I hit ender
         - "o" -- Don't automatically continue comment when using o/O
   end,
})

local function should_format_buffer(bufnr)
   if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then return false end

   local ok, disabled = pcall(function() return vim.api.nvim_buf_get_var(bufnr, "formatting_disabled") end)
   -- If the variable is missing, then formatting hasn't been explicitly disabled and we should try
   if not ok then return true end
   return not disabled
end

local lsp_group = vim.api.nvim_create_augroup("lsp_group", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
   group = lsp_group,
   desc = "Format on save",
   pattern = "*",
   callback = function(args)
      if not should_format_buffer(args.buf) then return end
      require("conform").format({
         bufnr = args.buf,
         timeout_ms = 3000,
         lsp_format = "fallback",
      })
   end,
})

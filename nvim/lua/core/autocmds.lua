local M = {
    augroup = vim.api.nvim_create_augroup("dotfiles", { clear = true }),
    formatting_buffer_var = "formatting_disabled",
}

--- Returns if a buffer should have formatting run on it
---
--- @param bufnr integer Buffer handle, or 0 for current buffer
--- @return boolean
local function should_format_buffer(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
        return false
    end
    local ok, disabled = pcall(function()
        return vim.api.nvim_buf_get_var(bufnr, M.formatting_buffer_var)
    end)
    -- If the variable is missing, then formatting hasn't been explicitly disabled and we should try
    if not ok then
        return true
    end
    return not disabled
end

--- Set up all common autocommands
--- @return nil
function M.setup()
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = M.augroup,
        desc = "Highlight text when yanked",
        pattern = "*",
        callback = function()
            vim.hl.on_yank({ timeout = 200 })
        end,
    })

    vim.api.nvim_create_autocmd("FileType", {
        group = M.augroup,
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

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = M.augroup,
        desc = "Format on save",
        pattern = "*",
        callback = function(args)
            if not should_format_buffer(args.buf) then
                return
            end
            require("conform").format({
                bufnr = args.buf,
                timeout_ms = 3000,
                lsp_format = "fallback",
            })
        end,
    })
end

return M

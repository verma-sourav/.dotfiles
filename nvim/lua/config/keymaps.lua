local keys = require("util.keys")
local nmap = keys.nmap
local imap = keys.imap
local vmap = keys.vmap
local xmap = keys.xmap
local omap = keys.omap
local smap = keys.smap

vim.g.mapleader = " "

-- Faster buffer navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- Resize window using shift + arrow keys
nmap("<S-Up>", ":resize +2<CR>")
nmap("<S-Down>", ":resize -2<CR>")
nmap("<S-Left>", ":vertical resize -2<CR>")
nmap("<S-Right>", ":vertical resize +2<CR>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- Make `n` and `N` always search forward and backwards regardless of if a seach was started with `/` or `?`
nmap("n", "'Nn'[v:searchforward]", { expr = true })
xmap("n", "'Nn'[v:searchforward]", { expr = true })
omap("n", "'Nn'[v:searchforward]", { expr = true })
nmap("N", "'nN'[v:searchforward]", { expr = true })
xmap("N", "'nN'[v:searchforward]", { expr = true })
omap("N", "'nN'[v:searchforward]", { expr = true })

-- Shortcuts for copying to the system clipboard
nmap("<leader>y", '"+y', { desc = "copy to clipboard" })
vmap("<leader>y", '"+y', { desc = "copy to clipboard" })
nmap("<leader>Y", '"+yy', { desc = "copy line to clipboard" })

-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
-- Automatically reselect the last selection when using `<` and `>` to shift lines
xmap(">", ">gv")
xmap("<", "<gv")

local function luasnip_next()
   local ls = require("luasnip")
   if ls.expand_or_jumpable() then
      ls.expand_or_jump()
   end
end

local function luasnip_prev()
   local ls = require("luasnip")
   if ls.jumpable(-1) then
      ls.jump(-1)
   end
end

-- Snippet
imap("<c-k>", luasnip_next, { desc = "snippet: jump to next" })
smap("<c-k>", luasnip_next, { desc = "snippet: jump to next" })
imap("<c-j>", luasnip_prev, { desc = "snippet: jump to previous" })
smap("<c-j>", luasnip_prev, { desc = "snippet: jump to previous" })

-- Files
nmap("<leader>fe", "<cmd>Oil --float<cr>", { desc = "file explorer (oil) " })
nmap("<leader>fg", function()
   local git_path = vim.fn.finddir(".git", ".;")
   local cd_git = vim.fn.fnamemodify(git_path, ":h")
   require("oil").open_float(cd_git)
end, { desc = "open explorer in git root (oil) " })

-- Buffer
nmap("<leader>bs", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "switch buffer" })
nmap("<leader>bd", function()
   require("mini.bufremove").delete(0, false)
end, { desc = "delete current buffers" })
nmap("<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "delete other buffers" })
nmap("<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "delete buffers to the right" })
nmap("<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "delete buffers to the left" })
nmap("<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "previous buffer" })
nmap("<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "next buffer" })

-- g: git
nmap("<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "view commits" })
nmap("<leader>gC", "<cmd>Telescope git_bcommits<CR>", { desc = "view buffer commits" })
nmap("<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "view branches" })
nmap("<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "view status" })
nmap("<leader>gS", "<cmd>Telescope git_stash<CR>", { desc = "view stashes" })

-- s: search
nmap("<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "search in buffer" })
nmap("<leader>sc", "<cmd>Telescope commands<cr>", { desc = "search commands" })
nmap("<leader>sl", "<cmd>Telescope resume<cr>", { desc = "re-open last search" })
nmap("<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "search files" })
nmap("<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "search all files (grep)" })
nmap("<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "search help pages" })
nmap("<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "search keymaps" })
nmap("<leader>sm", "<cmd>Telescope marks<cr>", { desc = "search marks" })
nmap("<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "search recent files" })
nmap("<leader>su", "<cmd>Telescope undo<cr>", { desc = "search undo tree" })
nmap("<leader>ss", function()
   require("telescope.builtin").lsp_document_symbols({
      symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait" },
   })
end, { desc = "search lsp symbols" })
nmap("<leader>st", "<cmd>Trouble telescope<cr>", { desc = "trouble: telescope results" })
nmap("<leader>sT", "<cmd>Trouble telescope_files<cr>", { desc = "trouble: telescope file results" })

-- x: diagnostics & errors
nmap("<leader>xf", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "diagnostics float" })
nmap("<leader>xt", "<cmd>Telescope diagnostics<cr>", { desc = "telescope diagnostics" })
nmap("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "trouble diagnostics" })
nmap("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "trouble diagnostics (buffer)" })

-- code + LSP
-- I used to do this only when an LSP attached to a buffer, but whatever. If I press on of these
-- keys and an LSP isn't attached I'll just get an error which is better than the keymap not
-- existing and doing nothing when I'm expecting an LSP to be attached imho.
nmap("K", vim.lsp.buf.hover)
nmap("]d", vim.diagnostic.goto_next, { desc = " go to next diagnostics" })
nmap("[d", vim.diagnostic.goto_prev, { desc = " go to prev diagnostic" })

nmap("<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
nmap("<leader>cr", vim.lsp.buf.rename, { desc = "rename symbol" })
nmap("<leader>cS", vim.lsp.buf.signature_help, { desc = "signature help" })
imap("<A-s>", vim.lsp.buf.signature_help, { desc = "signature help" })

nmap("<leader>cgd", "<cmd>Telescope lsp_definitions<cr>", { desc = "go to definitions" })
nmap("<leader>cgD", "<cmd>Telescope lsp_declarations<cr>", { desc = "go to declaration" })
nmap("<leader>cgt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "go to type definition" })
nmap("<leader>cgr", "<cmd>Telescope lsp_references<cr>", { desc = "go to references" })
nmap("<leader>cgi", "<cmd>Telescope lsp_implementations<cr>", { desc = "go to implementations" })

nmap("<leader>css", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "show symbols" })
nmap("<leader>csd", "<cmd>Trouble lsp_definitions toggle focus=false<cr>", { desc = "show definitions" })
nmap("<leader>csi", "<cmd>Trouble lsp_implementations toggle focus=false<cr>", { desc = "show implementations" })
nmap("<leader>csI", "<cmd>Trouble lsp_incoming_calls toggle focus=false<cr>", { desc = "show incoming calls" })
nmap("<leader>cso", "<cmd>Trouble lsp_outgoing_calls toggle focus=false<cr>", { desc = "show outgoing calls" })
nmap("<leader>csr", "<cmd>Trouble lsp_references toggle focus=false<cr>", { desc = "show references" })
nmap("<leader>cst", "<cmd>Trouble lsp_type_definitions toggle focus=false<cr>", { desc = "show type definitions" })
nmap("<leader>csl", "<cmd>Trouble lsp toggle focus=false<cr>", { desc = "show lsp info (grouped)" })

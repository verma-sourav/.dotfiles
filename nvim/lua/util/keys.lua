--[[
| Arg | Applicible Modes                 |
| --- | -------------------------------- |
| n   | normal                           |
| i   | insert                           |
| s   | select                           |
| x   | visual                           |
| c   | command-line                     |
| t   | terminal                         |
| v   | visual + select                  |
| !   | insert + command-line            |
| l   | insert + command-line + lang-arg |
| o   | operator-pending                 |

https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set
https://neovim.io/doc/user/lua.html#vim.keymap.set()
--]]
local M = {}

local map = function(mode, key, cmd, opts, defaults)
   opts = vim.tbl_deep_extend("force", { silent = true }, defaults or {}, opts or {})
   -- vim.keymap.set has noremap enabled by default
   vim.keymap.set(mode, key, cmd, opts)
end

function M.map(mode, key, cmd, opt, defaults)
   return map(mode, key, cmd, opt, defaults)
end

function M.nmap(key, cmd, opts)
   return map("n", key, cmd, opts)
end

function M.imap(key, cmd, opts)
   return map("i", key, cmd, opts)
end

function M.vmap(key, cmd, opts)
   return map("v", key, cmd, opts)
end

function M.xmap(key, cmd, opts)
   return map("x", key, cmd, opts)
end

function M.omap(key, cmd, opts)
   return map("o", key, cmd, opts)
end

function M.smap(key, cmd, opts)
   return map("s", key, cmd, opts)
end

return M

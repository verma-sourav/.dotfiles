local ok, notify = pcall(require, "notify")
if not ok then
  return
end

-- Replace the built in notifications with the custom notifications from notify
vim.notify = notify

local wezterm = require("wezterm")
return {
    on_mac   = wezterm.target_triple:find("darwin") ~= nil,
    on_linux = wezterm.target_triple:find("linux") ~= nil,
}

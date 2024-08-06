local on_mac = require("util").on_mac
local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

local function os_specific(cfg)
   if on_mac then
      return cfg.mac
   else
      return cfg.linux
   end
end

local function tab_switch_bind(tabnum)
   return {
      key = tostring(tabnum),
      mods = os_specific({ mac = "CMD", linux = "ALT" }),
      action = act.ActivateTab(tabnum - 1),
   }
end

local mouse_bindings = {
   -- Change the default click behavior so that it only selects text and doesn't open hyperlinks
   {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelection("PrimarySelection"),
   },

   -- Use CTRL/CMD-Click open hyperlinks
   {
      event = { Up = { streak = 1, button = "Left" } },
      mods = os_specific({ mac = "CMD", linux = "CTRL" }),
      action = act.OpenLinkAtMouseCursor,
   },

   -- Disable the 'Down' event of the bind above to avoid weird program behaviors
   -- https://wezfurlong.org/wezterm/config/mouse.html#gotcha-on-binding-an-up-event-only
   {
      event = { Down = { streak = 1, button = "Left" } },
      mods = os_specific({ mac = "CMD", linux = "CTRL" }),
      action = act.Nop,
   },
}

local keymaps = {
   -- Add tab-switching keymaps that work for mac *and* linux
   tab_switch_bind(1),
   tab_switch_bind(2),
   tab_switch_bind(3),
   tab_switch_bind(4),
   tab_switch_bind(5),
   tab_switch_bind(6),
   tab_switch_bind(7),
   tab_switch_bind(8),
   tab_switch_bind(9),
   -- Remap split bindings to be a little more rememberable (- and |)
   {
      key = "\\",
      mods = "CTRL|ALT",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
   },
   {
      key = "-",
      mods = "CTRL|ALT",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
   },
   {
      key = "E",
      mods = "CTRL|SHIFT",
      action = act.PromptInputLine({
         description = "Enter new name for tab",
         action = wezterm.action_callback(function(window, _, line)
            if line then
               window:active_tab():set_title(line)
            end
         end),
      }),
   },
}

local mac_only_keymaps = {
   -- Allow using cmd+backspace to delete an entire line
   {
      key = "Backspace",
      mods = "CMD",
      action = act.SendKey({ key = "u", mods = "CTRL" }),
   },
   -- Use cmd+arrows to jump to the start and end of the line
   {
      key = "LeftArrow",
      mods = "CMD",
      action = act.SendKey({ key = "Home" }),
   },
   {
      key = "RightArrow",
      mods = "CMD",
      action = act.SendKey({ key = "End" }),
   },
}

function M.apply_to_config(config)
   config.mouse_bindings = mouse_bindings
   config.keys = keymaps
   if not on_mac then
      return
   end

   for _, v in ipairs(mac_only_keymaps) do
      table.insert(config.keys, v)
   end
end

return M

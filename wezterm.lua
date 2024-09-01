local wezterm = require 'wezterm'

local config = {}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 500 }

-- 启动menu
local act = wezterm.action;

-- keyboard mappings
-- 禁用所有默认的按键配置，仅使用下面的按键配置
config.disable_default_key_bindings = true;
config.keys = {
  { key = 'w',          mods = 'ALT',        action = act.ShowLauncher },
  { key = 'n',          mods = 'SHIFT|CTRL', action = act.ToggleFullScreen },
  { key = 'Tab',        mods = 'CTRL',       action = act.ActivateTabRelative(1) },
  { key = 'Tab',        mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'LeftArrow',  mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
  { key = 'RightArrow', mods = 'SHIFT',      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'DownArrow',  mods = 'SHIFT',      action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'p',          mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
}
config.launch_menu = {}
-- Using shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Windows
  table.insert(config.launch_menu, {
    label = 'PowerShell-NewWindow',
    args = { "pwsh.exe" }
  })
  table.insert(config.launch_menu, {
    label = 'CMD-NewWindow',
    args = { 'cmd.exe' }
  })
elseif wezterm.target_triple == 'x86_64-apple-darwin' then
  -- macOS (Intel)
  table.insert(config.launch_menu, {
    label = 'zsn-NewWindow',
    args = { 'zsh', '-l' }
  })
  table.insert(config.keys, { key = "c", mods = "CMD", action = act.CopyTo 'Clipboard' })
  table.insert(config.keys, { key = "v", mods = "CMD", action = act.PasteFrom 'Clipboard' })
elseif wezterm.target_triple == 'aarch64-apple-darwin' then
  -- macOS (Apple Silicon)
  table.insert(config.launch_menu, {
    label = 'zsn-NewWindow',
    args = { 'zsh', '-l' }
  })
  table.insert(config.keys, { key = "c", mods = "CMD", action = act.CopyTo 'Clipboard' })
  table.insert(config.keys, { key = "v", mods = "CMD", action = act.PasteFrom 'Clipboard' })
end
-- font config
config.font = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font'
};
config.font_size = 18;
config.line_height = 1.2;
--
-- theme
config.color_scheme = "JetBrains Darcula"
--
-- all config
return config;

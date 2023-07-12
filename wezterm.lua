local wezterm = require 'wezterm'
-- 启动menu
local launch_menu = {}
-- Using shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Windows
  table.insert(launch_menu, {
    label = 'PowerShell-NewWindow',
    args = { "pwsh.exe" }
  })
  table.insert(launch_menu, {
    label = 'CMD-NewWindow',
    args = { 'cmd.exe' }
  })
elseif wezterm.target_triple == 'x86_64-apple-darwin' then
  -- macOS (Intel)
  table.insert(launch_menu, {
    label = 'zsn-NewWindow',
    args = { 'zsh', '-l' }
  })
elseif wezterm.target_triple == 'aarch64-apple-darwin' then
  -- macOS (Apple Silicon)
  table.insert(launch_menu, {
    label = 'zsn-NewWindow',
    args = { 'zsh', '-l' }
  })
end
-- keyboard mappings
local keys = {
  { key = 'w',   mods = 'ALT',        action = wezterm.action.ShowLauncher },
  { key = 'n',   mods = 'SHIFT|CTRL', action = wezterm.action.ToggleFullScreen },
  { key = 'Tab', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
}
-- font config
local font = wezterm.font('JetBrainsMono Nerd Font', {});
--
-- all config
return {
  font = font,
  font_size = 16,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  color_scheme = "JetBrains Darcula",
  -- color_scheme = "Sakura",
  keys = keys,
  -- 禁用所有默认按键，仅使用上面自定义按键
  disable_default_key_bindings = true,
  -- 启动菜单
  launch_menu = launch_menu
}

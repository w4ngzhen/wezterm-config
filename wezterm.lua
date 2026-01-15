local wezterm = require 'wezterm'

local config = {}

-- windows
local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc';
-- macOS (Apple Silicon or Intel CPU)
local is_mac_os = wezterm.target_triple == 'aarch64-apple-darwin' or wezterm.target_triple == 'x86_64-apple-darwin';

-- CONFIG: default prog
-- 请注意，使用default_prog请确保相关工具已经安装
local use_default_prog = true;

if use_default_prog then
    if is_windows then
        -- todo
    elseif is_mac_os then
        -- https://github.com/zellij-org/zellij-org.github.io/issues/284
        config.default_prog = { "zsh", "-c", "zellij -l welcome" }
    end
end

local act = wezterm.action;
-- CONFIG: keyboard mappings
-- https://wezterm.org/config/lua/keyassignment/index.html
-- 禁用所有默认的按键配置，仅使用下面的按键配置
config.disable_default_key_bindings = true;
config.keys = {
  { key = 'w',          mods = 'ALT',        action = act.ShowLauncher },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = act.SpawnCommandInNewTab },
  { key = 'LeftArrow',  mods = 'SHIFT',      action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'SHIFT',      action = act.ActivateTabRelative(1) },
}

-- macOS command特殊按键绑定
if is_mac_os then
    table.insert(config.keys, { key = "c", mods = "CMD", action = act.CopyTo 'Clipboard' })
    table.insert(config.keys, { key = "v", mods = "CMD", action = act.PasteFrom 'Clipboard' })
    table.insert(config.keys, { key = "n", mods = "CMD", action = act.SpawnCommandInNewTab { } })
    table.insert(config.keys, { key = "w", mods = "CMD", action = act.CloseCurrentTab { confirm = true } })
end


-- CONFIG: launch_menu
config.launch_menu = {}
-- Using shell
if is_windows then
  -- Windows
  table.insert(config.launch_menu, {
    label = 'PowerShell-Tab',
    args = { "pwsh.exe" }
  })
  table.insert(config.launch_menu, {
    label = 'CMD-Tab',
    args = { 'cmd.exe' }
  })
elseif is_mac_os then
  -- macOS (Intel)
  table.insert(config.launch_menu, {
    label = 'zsn-Tab',
    args = { 'zsh', '-l' }
  })
end

-- CONFIG: font
-- disable Font Shaping
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
-- font config
config.font = wezterm.font_with_fallback {
  'JetBrainsMono Nerd Font'
};
config.font_size = 18;
config.line_height = 1.2;

-- CONFIG: theme
config.color_scheme = "JetBrains Darcula"
--
-- all config
return config;

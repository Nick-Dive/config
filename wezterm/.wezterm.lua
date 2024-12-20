local wezterm = require 'wezterm';

local config = {}

config.enable_wayland = true
--config.front_end = 'WebGpu'
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- Hot reload
config.automatically_reload_config = true

config.launch_menu = {
  { args = {'htop'}, label = 'htop' },
  { args = {'nvim'}, label = 'nvim' },
}
-- =========================================
-- Status
-- =========================================
wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

  -- Make it italic and underlined
  window:set_right_status(wezterm.format {
    { Attribute = { Underline = 'Single' } },
    { Text = date },
  })
end)
-- =========================================
-- Customized movement
-- =========================================
local move_around = function(window, pane, direction_wez, direction_vim)
	if pane:get_foreground_process_name():sub(1,26) == "/home/nick/.local/bin/nvim" then
		window:perform_action(wezterm.action{SendKey={key = direction_vim, mods = 'CTRL'}}, pane)
	else
		window:perform_action(wezterm.action{ActivatePaneDirection=direction_wez}, pane)
	end
end
wezterm.on(
  "move-left",
	function(window, pane)
		move_around(window, pane, "Left", "h")
	end
)

wezterm.on(
	"move-right",
	function(window, pane)
		move_around(window, pane, "Right", "l")
	end
)

wezterm.on(
	"move-up",
	function(window, pane)
		move_around(window, pane, "Up", "k")
	end
)

wezterm.on(
	"move-down",
	function(window, pane)
		move_around(window, pane, "Down", "j")
	end
)
-- =========================================
-- Key combinations 
-- =========================================

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'DefaultDomain',
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = 'c',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SpawnWindow,
  },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
  {
    key = 'h',
    mods = 'CTRL',
    --action = wezterm.action.ActivatePaneDirection 'Left',
    action = wezterm.action.EmitEvent 'move-left',
  },
  {
    key = 'l',
    mods = 'CTRL',
    --action = wezterm.action.ActivatePaneDirection 'Right',
    action = wezterm.action.EmitEvent 'move-right',
  },
  {
    key = 'k',
    mods = 'CTRL',
    --action = wezterm.action.ActivatePaneDirection 'Up',
    action = wezterm.action.EmitEvent 'move-up',
  },
  {
    key = 'j',
    mods = 'CTRL',
    --action = wezterm.action.ActivatePaneDirection 'Down',
    action = wezterm.action.EmitEvent 'move-down',
  },
  {
    key = 'h',
    mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
  -- app launching
	{
		key = 'l',
		mods = 'LEADER|CTRL',
		action = wezterm.action.ShowLauncher 
	},
  -- Search overlay
  {
    key = ']',
    mods = 'LEADER',
    action = wezterm.action.Search{CaseSensitiveString=""},
  },
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
  -- rotate workspace
  { key = 'w', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(1) },
  -- new workspace
  { key = 'W', mods = 'LEADER', action = wezterm.action.SwitchToWorkspace },
  -- Rename active workspace
  {
    key = 'w',
    mods = 'LEADER|CTRL',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Rename current workspace ' .. wezterm.mux.get_active_workspace() },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          wezterm.mux.rename_workspace( wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
  },
}

-- =========================================
-- Appearance 
-- =========================================

-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox dark, soft (base16)'

config.tab_bar_at_bottom = true

config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0',
  bottom = '0',
}

-- Fonts
config.font = wezterm.font_with_fallback {
  'Fira Code',
  'Nimbus Mono PS',
  'Fantasque Sans Mono',
}

-- and finally, return the configuration to wezterm
return config

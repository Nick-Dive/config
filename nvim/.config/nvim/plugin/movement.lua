require('wezterm-move')
vim.keymap.set('n', '<C-h>',function() require("wezterm-move").move "h" end)
vim.keymap.set('n', '<C-l>',function() require("wezterm-move").move "l" end)
vim.keymap.set('n', '<C-j>',function() require("wezterm-move").move "j" end)
vim.keymap.set('n', '<C-k>',function() require("wezterm-move").move "k" end)

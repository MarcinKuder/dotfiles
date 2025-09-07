-- keymap
--------------------------------------------------------------------------------

-- Navigating buffers
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to alternate buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<cr>', { desc = 'Previous buffer' })

-- Quickly source current file / execute Lua code
vim.keymap.set('n', '<leader>xx', '<Cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>x', '<Cmd>:.lua<CR>', { desc = 'Lua: execute current line' })
vim.keymap.set('v', '<leader>x', '<Cmd>:lua<CR>', { desc = 'Lua: execute current selection' })

-- mini.files
vim.keymap.set('n', '<leader>e', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Explore files' })
-- todo: not working?
vim.keymap.set('n', '<leader>E', function()
  require('mini.files').open(vim.uv.cwd())
end, { desc = 'Explore files (cwd)' })

-- mini.pick
vim.keymap.set('n', '<leader><leader>', ':Pick files<cr>', { desc = 'Explore files (cwd)' })
vim.keymap.set('n', '<leader>fr', function()
  require('mini.extra').pickers.oldfiles()
end, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>,', ':Pick buffers<cr>', { desc = 'Buffers' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Window management
vim.keymap.set('n', '<leader>w', '<C>w<C>k', { desc = 'Open diagnostic [Q]uickfix list' })

-- Neovide (macOS)
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>")      -- Save
  -- vim.keymap.set("i", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y')         -- Copy
  vim.keymap.set("n", "<D-v>", '"+P')         -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P')         -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+")      -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
  -- change cmd to ctrl on macOS
  vim.keymap.set("n", "<D-u>", "<C-u>")
  vim.keymap.set("n", "<D-d>", "<C-d>")
  vim.keymap.set("n", "<D-r>", "<C-r>")
  vim.keymap.set("i", "<D-r>", "<C-r>")
  vim.keymap.set("n", "<D-o>", "<C-o>")
  vim.keymap.set("n", "<D-i>", "<C-i>")
  vim.keymap.set("n", "<D-w>", "<C-w>")
end

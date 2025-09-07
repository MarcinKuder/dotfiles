vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
vim.pack.add({ "https://github.com/echasnovski/mini.extra" })

-- Files
require("mini.files").setup({
  windows = {
    preview = true,
    width_focus = 30,
    width_preview = 30,
  },
  options = {
    -- Whether to use for editing directories
    -- Disabled by default in LazyVim because neo-tree is used for that
    use_as_default_explorer = true,
  },
    mappings = {
      go_in = "<Right>",
      go_out = "<Left>",
    },
})

-- Clues
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<D-w>' }, --macOS - not working
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },

    -- Bracketed
    { mode = 'n', keys = '['},
    { mode = 'n', keys = ']'},

  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

-- Others (and dependencies)
require("mini.icons").setup()
require("mini.git").setup()
require("mini.diff").setup()
require("mini.ai").setup()
require("mini.pick").setup()
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.jump2d").setup({
  labels = 'ldcnrtsxmwfouhaeip'
})
require("mini.bracketed").setup()
require("mini.extra").setup()

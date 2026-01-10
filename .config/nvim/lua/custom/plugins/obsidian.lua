return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    'BufReadPre /home/cdk/Documents/notes/*.md',
    'BufNewFile /home/cdk/Documents/notes/*.md',
    -- 'BufReadPre /home/rockylinux/notes/*.md',
    -- 'BufNewFile /home/rockylinux/notes/*.md',
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/notes/big-brain-vault',
      },
      -- {
      --   name = 'work',
      --   path = '~/notes',
      -- },
    },
    legacy_commands = false,
    ui = { enable = true },
  },
}

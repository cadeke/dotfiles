return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.indentscope').setup {
      symbol = '│',
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.linear { duration = 5, unit = 'total' },
      },
    }

    -- Disable in nvim-tree
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'NvimTree' },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}

return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Open [U]ndo tree' },
  },
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}

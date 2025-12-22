return {
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,
  config = function()
    require('rose-pine').setup {
      variant = 'main', -- 'main', 'moon', or 'dawn'
      dark_variant = 'main',
      styles = {
        italic = false,
        transparency = true,
      },
    }
    vim.cmd 'colorscheme rose-pine'
  end,
}

return {
  'stevearc/conform.nvim',
  -- Load when a buffer is opened (not lazily on BufWritePre): lazy.nvim re-fires the
  -- event after loading, which would run the format-on-save autocmds twice.
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<C-f>',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function(_, opts)
    -- YAML files never end with a trailing newline. 'endofline' decides whether the
    -- last line gets one, so it is handled around conform's format-on-save, in this
    -- fixed order (autocmds run in the order they are registered):
    --   1. before the formatter: set 'endofline' back to true. With 'noeol' (e.g. after a
    --      previous save) conform would treat the formatter's final newline as an extra
    --      empty last line and re-add a newline on save.
    --   2. conform formats (registered by setup below)
    --   3. after the formatter: set 'endofline' to false so the file is written without
    --      a final newline, whatever the formatter or an .editorconfig did.
    local group = vim.api.nvim_create_augroup('yaml-final-newline', { clear = true })
    local function yaml_eol(eol)
      return function(args)
        if vim.bo[args.buf].filetype == 'yaml' then
          vim.bo[args.buf].fixendofline = false
          vim.bo[args.buf].endofline = eol
        end
      end
    end

    vim.api.nvim_create_autocmd('BufWritePre', { group = group, callback = yaml_eol(true) })
    require('conform').setup(opts)
    vim.api.nvim_create_autocmd('BufWritePre', { group = group, callback = yaml_eol(false) })
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 2500,
          lsp_format = 'fallback',
        }
      end
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      markdown = { 'prettierd', 'prettier' },
      yaml = { 'prettierd', 'prettier' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
    },
  },
}

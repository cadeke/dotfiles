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
      -- Only whitespace fixes for YAML (same as pre-commit trailing-whitespace and
      -- end-of-file-fixer); 'fixendofline' then writes exactly one final newline.
      -- prettier rewrites valid style that yamllint rejects ({ a: b } braces, wrapped
      -- flow maps, collapsed comment spacing) and yamlls formats with prettier too.
      yaml = { 'trim_whitespace', 'trim_newlines' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      terraform = { 'tofu_fmt' },
      ['terraform-vars'] = { 'tofu_fmt' },
      hcl = { 'terragrunt_hclfmt' },
    },
  },
}

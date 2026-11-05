-- nvim-treesitter `main` branch: a full rewrite with no `nvim-treesitter.configs`
-- module and no lazy-loading. Highlighting and indent are enabled per filetype below.
-- See https://github.com/nvim-treesitter/nvim-treesitter (branch `main`).
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- Parsers to install up front (no-op if already installed; runs asynchronously)
    ts.install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

    local available = ts.get_available()
    local requested = {}

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        -- Auto-install a missing parser once per session, if one exists for this language
        if not vim.list_contains(ts.get_installed(), lang) then
          if vim.list_contains(available, lang) and not requested[lang] then
            requested[lang] = true
            ts.install({ lang }):await(function()
              if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == args.match then
                pcall(vim.treesitter.start, args.buf, lang)
              end
            end)
          end
          return
        end

        pcall(vim.treesitter.start, args.buf, lang)
        if lang ~= 'ruby' then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}

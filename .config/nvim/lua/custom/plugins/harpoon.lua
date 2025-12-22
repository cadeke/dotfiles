return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()

    -- set keymaps
    local keymap = vim.keymap

    keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = '[E]xplorer toggle' }) -- toggle file explorer
    keymap.set('n', '<leader>E', '<cmd>NvimTreeFindFileToggle<CR>', { desc = '[E]xplorer toggle focused' }) -- toggle file explorer on current file

    -- Basic keymaps
    keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add to Harpoon' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open Harpoon menu' })

    -- Navigate to specific files
    vim.keymap.set('n', '<C-&>', function()
      harpoon:list():select(1)
    end, { desc = 'Select Harpoon item 1' })
    vim.keymap.set('n', '<C-é>', function()
      harpoon:list():select(2)
    end, { desc = 'Select Harpoon item 2' })
    vim.keymap.set('n', '<C-">', function()
      harpoon:list():select(3)
    end, { desc = 'Select Harpoon item 3' })
    vim.keymap.set('n', "<C-'>", function()
      harpoon:list():select(4)
    end, { desc = 'Select Harpoon item 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():prev()
    end, { desc = 'Select previous Harpoon item' })
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next()
    end, { desc = 'Select next Harpoon item' })
  end,
}

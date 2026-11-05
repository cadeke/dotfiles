-- YAML must be indented with spaces (tabs are invalid), two per level.
-- Tab inserts spaces up to the next multiple of 2 and <BS> removes them the same way.
vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

-- YAML files never end with a trailing newline. The write-time handling lives in
-- lua/custom/plugins/conform.lua so that it runs in the right order around the formatter.
vim.bo.fixendofline = false

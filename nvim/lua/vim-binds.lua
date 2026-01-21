vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " ",
-- vim.opt.clipboard = "unnamedplus",


-- Copy from clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', {noremap = true, silent = true})

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', {noremap = true, silent = true})


-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)

-- Tabs not as spaces and auto indent
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0

vim.opt.mouse = "r"
vim.opt.clipboard = "unnamedplus"
vim.g.autosave = true
vim.g.nvim_tree_show_icons = {
     git = 1,
     folders = 0,
  }
	

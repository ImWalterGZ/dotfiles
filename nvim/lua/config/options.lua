-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true  -- números de línea relativos (útil con movimientos)
vim.opt.scrolloff = 8          -- mantener 8 líneas de margen al hacer scroll
vim.opt.sidescrolloff = 8
vim.opt.wrap = false           -- no partir líneas largas
vim.opt.tabstop = 2            -- tamaño de tabulación
vim.opt.shiftwidth = 2
vim.opt.expandtab = true       -- usar espacios en vez de tabs
vim.g.lazyvim_python_lsp = "pyright"  -- LSP de Python ya instalado vía Mason

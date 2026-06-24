-- Archivo de ejemplo para agregar plugins personalizados.
-- Cada archivo .lua en esta carpeta es cargado automáticamente por lazy.nvim.
--
-- Para agregar un plugin:
--   return {
--     { "autor/nombre-plugin", opts = {} },
--   }
--
-- Para sobrescribir la configuración de un plugin de LazyVim:
--   return {
--     {
--       "nvim-treesitter/nvim-treesitter",
--       opts = function(_, opts)
--         vim.list_extend(opts.ensure_installed, { "bash", "lua" })
--       end,
--     },
--   }

return {}

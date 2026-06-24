return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- fondo oscuro
      color_overrides = {
        mocha = {
          -- Paleta de rojos basada en #ff0031
          red     = "#ff0031", -- rojo principal (errores, keywords)
          maroon  = "#cc0027", -- rojo oscuro (variante)
          flamingo = "#ff3355", -- rojo-rosado (strings, otros acentos)
          pink    = "#ff6680", -- rosa-rojo suave
          mauve   = "#ff0031", -- acento principal: funciones, variables destacadas
        },
      },
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        noice = true,
        which_key = true,
        mini = { enabled = true },
        treesitter = true,
        lsp_trouble = true,
      },
    },
  },
  -- Decirle a LazyVim que use este tema
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

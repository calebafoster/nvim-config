return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000, -- Set priority to ensure it loads first
  config = function()
    require("rose-pine").setup({
      -- Customize your settings here
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "moon", -- main, moon, or dawn
      -- ... other options from the Rosé Pine GitHub
    })
    vim.cmd("colorscheme rose-pine-moon") -- Set the desired variant
  end,
}


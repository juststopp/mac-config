-- Thème Catppuccin Mocha (le même partout : terminal, prompt, barre, widgets)
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha",
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
    },
    integrations = {
      blink_cmp = true,
      flash = true,
      gitsigns = true,
      lsp_trouble = true,
      mason = true,
      mini = { enabled = true },
      render_markdown = true,
      snacks = { enabled = true },
      treesitter = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}

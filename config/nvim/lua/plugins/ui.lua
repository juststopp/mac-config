-- Interface : barre de statut, onglets de fichiers, aide aux raccourcis, icônes
local function lsp_clients()
  local names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(names, client.name)
  end
  return #names > 0 and (" " .. table.concat(names, " ")) or ""
end

return {
  -- Barre de statut
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          "diagnostics",
          { "filename", path = 1, symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[sans nom]" } },
        },
        lualine_x = { { lsp_clients, color = { gui = "italic" } }, "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      extensions = { "lazy", "mason", "oil", "trouble" },
    },
  },

  -- Onglets des fichiers ouverts (n'apparaît qu'à partir de 2 fichiers)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        offsets = { { filetype = "snacks_layout_box" } },
        separator_style = "thin",
      },
    },
  },

  -- Aide-mémoire : appuie sur Espace et attends
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "fichiers" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "modifs git (hunks)" },
        { "<leader>q", group = "quitter" },
        { "<leader>s", group = "rechercher" },
        { "<leader>t", group = "terminal" },
        { "<leader>u", group = "interface on/off" },
        { "<leader>w", group = "fenêtres" },
        { "<leader>x", group = "diagnostics" },
        { "g", group = "aller à" },
        { "gs", group = "entourer (surround)" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Raccourcis de ce fichier" },
    },
  },
}

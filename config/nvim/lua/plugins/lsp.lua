-- LSP : autocomplétion intelligente, erreurs en direct, aller à la définition…
-- Les serveurs sont installés automatiquement par Mason (<leader>cm pour voir).
local servers = {
  "bashls",        -- Bash / zsh
  "clangd",        -- C / C++
  "cssls",         -- CSS
  "eslint",        -- ESLint
  "html",          -- HTML
  "jsonls",        -- JSON
  "lua_ls",        -- Lua
  "marksman",      -- Markdown
  "pyright",       -- Python (types)
  "ruff",          -- Python (lint)
  "rust_analyzer", -- Rust
  "tailwindcss",   -- Tailwind
  "vtsls",         -- TypeScript / JavaScript / React
  "yamlls",        -- YAML
}

local tools = { "prettierd", "shfmt", "stylua" } -- formateurs utilisés par conform

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
    build = ":MasonUpdate",
    opts = { ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } } },
  },

  -- Complétion de l'API Neovim quand on édite cette config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Apparence des diagnostics
      local sev = vim.diagnostic.severity
      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        underline = true,
        virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
        float = { source = "if_many" },
        signs = { text = { [sev.ERROR] = " ", [sev.WARN] = " ", [sev.INFO] = " ", [sev.HINT] = "󰌵 " } },
      })

      -- Réglages communs et spécifiques
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
      vim.lsp.config("lua_ls", {
        settings = { Lua = { workspace = { checkThirdParty = false }, hint = { enable = true } } },
      })

      -- Swift : sourcekit-lsp fourni par Xcode
      if vim.fn.executable("sourcekit-lsp") == 1 then
        vim.lsp.config("sourcekit", { filetypes = { "swift" } })
        vim.lsp.enable("sourcekit")
      end

      -- Installe (si besoin) et active automatiquement les serveurs
      require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = true })
      require("mason-tool-installer").setup({ ensure_installed = tools })

      -- Raccourcis disponibles quand un serveur LSP est attaché au fichier
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(ev)
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or "n", lhs, rhs, { buffer = ev.buf, desc = desc, nowait = true })
          end
          map("gd", function() Snacks.picker.lsp_definitions() end, "Aller à la définition")
          map("gD", vim.lsp.buf.declaration, "Aller à la déclaration")
          map("gr", function() Snacks.picker.lsp_references() end, "Références")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Implémentations")
          map("gy", function() Snacks.picker.lsp_type_definitions() end, "Définition du type")
          map("K", vim.lsp.buf.hover, "Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Actions de code", { "n", "x" })
          map("<leader>cr", vim.lsp.buf.rename, "Renommer le symbole")
          map("<leader>ci", "<cmd>checkhealth vim.lsp<cr>", "Infos LSP")
          map("<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
          end, "Indices de types on/off")
        end,
      })
    end,
  },
}

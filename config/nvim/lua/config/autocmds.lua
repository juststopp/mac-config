local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Surligne brièvement le texte copié
au("TextYankPost", {
  group = group,
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

-- Rouvre un fichier là où on l'avait laissé
au("BufReadPost", {
  group = group,
  callback = function(ev)
    if vim.bo[ev.buf].filetype:match("commit") then return end
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Recharge un fichier modifié en dehors de Neovim
au({ "FocusGained", "TermClose", "TermLeave" }, { group = group, command = "checktime" })

-- Réajuste les splits quand la fenêtre du terminal change de taille
au("VimResized", { group = group, command = "tabdo wincmd =" })

-- « q » ferme les fenêtres utilitaires
au("FileType", {
  group = group,
  pattern = { "help", "qf", "man", "checkhealth", "lspinfo", "startuptime", "notify" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})

-- Retour à la ligne automatique pour la prose
au("FileType", {
  group = group,
  pattern = { "markdown", "gitcommit", "text" },
  callback = function() vim.opt_local.wrap = true end,
})

-- Crée les dossiers manquants à la sauvegarde
au("BufWritePre", {
  group = group,
  callback = function(ev)
    if ev.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

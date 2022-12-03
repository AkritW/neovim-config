-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then return end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup {
  -- setup formatters & linters
  sources = {
    --  to disable file types use
    --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
    formatting.prettier.with { extra_args = { "--no-semi" } }, -- js/ts formatter
    formatting.stylua, -- lua formatter
    formatting.gofmt, -- go formatter
    formatting.black.with { extra_args = { "--line-length", 79 } }, -- python formatter
    formatting.rustfmt, -- rust formatter
    diagnostics.eslint_d, -- js/ts linter
    diagnostics.pylint, -- python linter
    diagnostics.flake8, -- python linter
    diagnostics.golangci_lint, -- go linter
    diagnostics.codespell, -- grammer checker
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          }
        end,
      })
    end
  end,
}

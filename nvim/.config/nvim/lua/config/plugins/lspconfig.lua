return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on Lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "hrsh7th/cmp-nvim-lsp"
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()


      -- Formatting on save
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf })
              end,
            })
          end
        end,
      })

      -- Lua LSP (lua_ls)
      lspconfig.lua_ls.setup({
        cmd = { "/usr/local/bin/lua-language-server" },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Go LSP (gopls)
      lspconfig.gopls.setup({
        cmd = { "gopls" },
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork" },
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        settings = {
          gopls = {
            directoryFilters = { "-vendor" },
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            deepCompletion = true,
          },
        },
      })

      -- Templ
      lspconfig.templ.setup({
        cmd = { "templ", "lsp" },
        capabilities = capabilities,
        filetypes = { "templ" }, -- Ensure this is set properly
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
      })


      -- sqls
      lspconfig.sqls.setup({
        cmd = { "sqls", "-c", vim.fn.expand("~/.sqls.yml") },
        capabilities = capabilities,
        filetypes = { "sql", "spanner" },
        root_dir = lspconfig.util.root_pattern(".git", ".sqls.yml"),
        on_attach = function(client, _)
          -- Disable sqls formatting
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      -- TypeScript & JavaScript LSP (ts_ls)
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
      })

      -- Svelte LSP (svelte)
      lspconfig.svelte.setup({
        cmd = { "/opt/homebrew/bin/svelteserver", "--stdio" },
        capabilities = capabilities,
        filetypes = { "svelte" },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
      })

      -- HTML LSP (html)
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "templ" },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
      })

      -- CSS LSP (cssls)
      lspconfig.cssls.setup({
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })
    end,
  },
}

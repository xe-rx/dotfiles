return {
  -- Mason (keep custom registries!)
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- mason-lspconfig (regular servers; NOT roslyn)
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "html",
          "tailwindcss",
          "ast_grep",
          "ts_ls",   -- typescript
          "clangd",  -- you configure it below, so ensure it's installed too
          "gdscript" -- same
          -- NOTE: do NOT add "roslyn" here; install via :MasonInstall roslyn
        },
      })
    end,
  },

  -- LSP configs (Neovim 0.11+ via vim.lsp.config/vim.lsp.enable)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Buffer-local keymaps when an LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
        end,
      })

      -- Regular servers
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.config("rust_analyzer", { capabilities = capabilities })
      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.config("gdscript", { capabilities = capabilities })
      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.config("tailwindcss", { capabilities = capabilities })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
            },
          },
        },
      })

      ------------------------------------------------------------------
      -- ROSLYN (C#) — via vim.lsp.config
      ------------------------------------------------------------------

      -- Optional: hard-wire Mason Roslyn binary to avoid PATH issues
      local mason_roslyn = vim.fn.expand("~/.local/share/nvim/mason/bin/Microsoft.CodeAnalysis.LanguageServer")
      local roslyn_cmd = nil
      if vim.fn.executable(mason_roslyn) == 1 then
        roslyn_cmd = {
          mason_roslyn,
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fn.stdpath("state"),
          "--stdio",
        }
      end

      vim.lsp.config("roslyn", {
        capabilities = capabilities,
        cmd = roslyn_cmd, -- if nil, will fall back to PATH
        on_attach = function(_, bufnr)
          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
          if vim.lsp.codelens then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = bufnr,
              callback = function()
                pcall(vim.lsp.codelens.refresh)
              end,
            })
          end
        end,
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
          ["csharp|background_analysis"] = {
            background_analysis = {
              dotnet_analyzer_diagnostics_scope = "openFiles", -- or "fullSolution"
              dotnet_compiler_diagnostics_scope = "openFiles", -- or "fullSolution"
            },
          },
        },
      })

      -- Enable everything (Neovim 0.11+)
      vim.lsp.enable({
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
        "clangd",
        "gdscript",
        "pyright",
        "html",
        "tailwindcss",
        "ast_grep",
        "roslyn",
      })
    end,
  },
}

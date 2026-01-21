return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls      = require("null-ls")
    local project_root = vim.fn.getcwd()
    local pylint_path  = project_root .. "/.venv/bin/pylint"

    local sources = {
      -- formatters
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.black.with({
        extra_args = { "--line-length", "100" },
      }),
      null_ls.builtins.formatting.jq,
    }

    -- only register pylint if it actually exists
    if vim.fn.executable(pylint_path) == 1 then
      table.insert(sources, null_ls.builtins.diagnostics.pylint.with({
        command = pylint_path,
        args    = { "--output-format=json", "--score=no", "$FILENAME" },
      }))
    else
      vim.notify("null-ls: unable to find pylint at " .. pylint_path, vim.log.levels.WARN)
    end

    null_ls.setup({
      sources  = sources,
      root_dir = require("null-ls.utils").root_pattern("pyproject.toml", ".git"),
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}


return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- required: this plugin does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- basic setup (new API)
      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- install parsers (sync on startup; remove :wait() if you prefer async)
      ts.install({
        "lua",
        "c",
        "cpp",
        "rust",
        "vim",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
      }):wait(300000)

      -- enable highlighting automatically when a buffer's filetype is set
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- enable treesitter indentation (optional)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}

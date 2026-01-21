return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "c", "rust", "vim", "vimdoc", "html", "css", "cpp", "javascript", "typescript"},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
      additional_vim_regex_highlighting = false,
		})
	end,
}

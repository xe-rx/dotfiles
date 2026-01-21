return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "vb" },  -- lazy-load on C#/VB files
    ---@type RoslynNvimConfig
    opts = {
      -- Let Neovim do normal filewatching. Try "roslyn" if you want the server to watch files.
      filewatching = "auto", -- "auto" | "roslyn" | "off"
      -- If you often have multiple .sln files, turn this on so it searches parents too:
      broad_search = true,
      -- lock_target = true, -- uncomment if you want to stick to the first chosen solution
      silent = true,         -- hide init notifications if you prefer
    },
  },
}

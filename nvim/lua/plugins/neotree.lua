return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = true,
                use_libuv_file_watcher = true,
                filtered_items = {
                  hide_by_pattern = {"*.meta"},
                },
            },
            buffers = {
                follow_current_file = true,
            },
            git_status = {
                show_untracked = true,
            },
        })
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
    end,
}

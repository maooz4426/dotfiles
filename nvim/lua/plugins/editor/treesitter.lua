return {
    'nvim-treesitter/nvim-treesitter',
    dev = require("nixCatsUtils").isNixCats,
    lazy = false,
    build = require("nixCatsUtils").isNixCats and nil or ':TSUpdate',
    config = function()
    end,
    opts = {
        indent = { enable = true },
        highlight = { enable = true },
        folds = { enable = true },
        auto_install = not require("nixCatsUtils").isNixCats,
        ensure_installed = require("nixCatsUtils").isNixCats and {} or {
            "go",
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "json",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "python",
            "toml",
            "tsx",
            "typescript",
            "yaml",
            "terraform",
        },
    }
}

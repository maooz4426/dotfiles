vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('nixCatsUtils.lazyCat').setup(nil, {
    spec = {
        { import = "plugins" },
    },
    install = { colorscheme = { "habamax" } },
    checker = {
        enabled = true,
        notify = false,
    },
})

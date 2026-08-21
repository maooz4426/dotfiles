-- alpha-nvimのダッシュボード設定。
-- nixCats版 nvim/lua/plugins/ui/alpha.lua の config 関数本体を移植したもの。
-- builtins.readFile でextraConfigLuaに読み込む（絵文字などのバイト列をNix文字列の
-- エスケープなしにそのまま扱うため、Nix属性ではなくLuaファイルとして持つ）。
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[   .-') _   ('-.                    (`-.            _   .-')      ]],
	[[  ( OO ) )_(  OO)                 _(OO  )_        ( '.( OO )_     ]],
	[[,--./ ,--,'(,------. .-'),-----. ,--(_/   ,. \ ,-.-') ,--.   ,--.)]],
	[[|   \ |  |\ |  .---'( OO'  .-.  '\   \   /(__/ |  |OO)|   `.'   | ]],
	[[|    \|  | )|  |    /   |  | |  | \   \ /   /  |  |  \|         | ]],
	[[|  .     |/(|  '--. \_) |  |\|  |  \   '   /,  |  |(_/|  |'.'|  | ]],
	[[|  |\    |  |  .--'   \ |  | |  |   \     /__),|  |_.'|  |   |  | ]],
	[[|  | \   |  |  `---.   `'  '-'  '    \   /   (_|  |   |  |   |  | ]],
	[[`--'  `--'  `------'     `-----'      `-'      `--'   `--'   `--' ]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "" .. " Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "" .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "" .. " Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "" .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "" .. " Config", ":e ~/dotfiles/modules/home/nixvim/config.nix <CR>"),
	dashboard.button("q", "" .. " Quit", ":qa<CR>"),
}
local handle = io.popen("fortune")
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

dashboard.config.opts.noautocmd = true

dashboard.config.layout = {
	{ type = "padding", val = 10 },
	dashboard.section.header,
	{ type = "padding", val = 2 },
	dashboard.section.buttons,
	{ type = "padding", val = 1 },
	dashboard.section.footer,
}

alpha.setup(dashboard.config)

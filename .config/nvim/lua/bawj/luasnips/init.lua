require("luasnip").filetype_extend("javascript", { "react", "react-native-ts" })

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/bawj/luasnips/ft" })

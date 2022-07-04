local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("all", {
	s("test", fmt([[this is a test: {}]], { i(1) })),
	s("us", fmt([[const [{}, set{}] = useState({})]], { i(1), i(2), i(3) })),
	s(
		"rfc",
		fmt(
			[[
    import React from "react"

    const {} = () => {{
      return (
        <div>
          {}
        </div>
      )
    }}
  ]],
			{ f(function()
				return vim.fn.expand("%:t:r")
			end), i(1) }
		)
	),
})

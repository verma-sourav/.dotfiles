local filetype = "go"
local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- If you assign an insert node index 0 it will be the last node that's jumped to.
-- If it's not set explicitly, it will be automatically added after all other nodes.
-- stylua: ignore start
local tab = t("\t")
require("luasnip.session.snippet_collection").clear_snippets(filetype)
ls.add_snippets(filetype, {
   s("ap", fmta("append(<>, <>)", { i(1, "slice"), i(2, "value") })),
   s("pf", fmta("fmt.Printf(<>)", { i(1) })),
   s("pl", fmta("fmt.Println(<>)", { i(1) })),
   s("spf", fmta("fmt.Sprintf(<>)", { i(1) })),
   -- This one was throwing an error when using a placeholeder and the "tab" text node so...
   s("iferr", fmta(
      "if err != nil {\n" ..
      "\t<>\n" ..
      "}"
      , { i(1, "return err") }
   )),
   s("swc", fmta(
      [[
         switch <> {
         case <>:
         default:
         <><>
         }
      ]], { i(1, "expression"), i(2, "expression"), tab, i(3, "statement") }
   )),
})
-- stylua: ignore end

local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

-- Function to get current date
local function get_date()
  return { os.date("%Y-%m-%d") }
end

-- Add snippets for all file types
ls.add_snippets("all", {
  s("date", f(get_date, {})),
})
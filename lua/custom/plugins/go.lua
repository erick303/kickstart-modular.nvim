-- conform.nvim is set up in kickstart/plugins/conform.lua, which loads first.
require('conform').formatters_by_ft.go = { 'goimports', 'gofmt' }

-- vim: ts=2 sts=2 sw=2 et

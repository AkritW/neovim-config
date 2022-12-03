-- vim.g.nightflyTransparent = true
-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- if not status then
--     print("Colorscheme not found")
--     return
-- end
--

local status, onedark = pcall(require, "onedark")
if not status then
  print "Colorscheme not found"
  return
end

onedark.setup {
  style = "cool",
  transparent = true,
}

onedark.load()

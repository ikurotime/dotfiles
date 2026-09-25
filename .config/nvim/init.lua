-- Lazy owns plugin loading. Exclude legacy Packer packages during migration.
local site = vim.fn.stdpath("data") .. "/site"
vim.opt.packpath:remove(site)
for _, path in ipairs(vim.opt.runtimepath:get()) do
    if path:find("/site/pack/packer/", 1, true) then vim.opt.runtimepath:remove(path) end
end
require("ikurotime")

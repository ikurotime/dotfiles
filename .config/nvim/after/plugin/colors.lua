require("ikurotime.theme").setup()
-- Keep the existing helper available, now with persistence.
function ColorMyPencils(color)
    require("ikurotime.theme").apply(color or "everforest", true)
end

PrefabFiles = {
    "dummyflingo",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/dummyflingo.xml"),
    Asset("IMAGE", "images/inventoryimages/dummyflingo.tex"),
    Asset("IMAGE", "minimap/minimap_dummyflingo.tex"),
    Asset("ATLAS", "minimap/minimap_dummyflingo.xml"),
}

AddMinimapAtlas("minimap/minimap_dummyflingo.xml")

local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient

--Config

STRINGS.DUMMYFLINGO = "Dummy Flingomatic"
STRINGS.NAMES.DUMMYFLINGO = "Dummy Flingomatic"
STRINGS.RECIPE_DESC.DUMMYFLINGO = "Does not put out fires."



    local dummyflingo = Recipe("dummyflingo",{Ingredient("log",1)},  RECIPETABS.SCIENCE, TECH.NONE, "dummyflingo_placer")
    dummyflingo.atlas = "images/inventoryimages/dummyflingo.xml"

	GLOBAL.global("mods")
if GLOBAL.mods == nil then
    GLOBAL.mods = {}
end
GLOBAL.assert(type(GLOBAL.mods) == "table", string.format("Type of GLOBAL.mods is %s, expected table; caused most probably by incompatibility between mods.", type(GLOBAL.mods)))
GLOBAL.assert(GLOBAL.mods.dummyflingo == nil, string.format("GLOBAL.mods.dummyflingo is %s, expected nil; caused most probably by incompatibility between mods.", tostring(GLOBAL.mods.dummyflingo)))
GLOBAL.mods.dummyflingo = {}
GLOBAL.mods.dummyflingo.test = GetModConfigData("config_test")



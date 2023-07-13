local PLUGIN = PLUGIN
PLUGIN.name = 'Weapons'
PLUGIN.author = 'OctraSource'
PLUGIN.description = "A better base for weapons in Helix."

local playerMeta = FindMetaTable("Player")

ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")
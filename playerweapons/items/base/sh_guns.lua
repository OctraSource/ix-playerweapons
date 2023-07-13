ITEM.name = "weapon"
ITEM.description = "weaponDesc"
ITEM.category = "Weapons - Guns"
ITEM.model = "error.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.weapon = ""
ITEM.slot = ""
--[[
    must be:
        longarm
        sidearm
]]
ITEM.acceptsAmmo = {"ammoName", false}
--[[
	must be:
		the filename of the ammo
		whether or not the ammo is fed into this weapon
]]


ITEM.useSound = "items/ammo_pickup.wav"



-- when compiled by the client,
if CLIENT then
	-- draw a green rectangle over the item if it's equipped
	function ITEM:PaintOver(item, w, h)
		if item:GetData("equip", false) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end



ITEM.functions.Unequip = {
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		item:DoUnequip()
		return false
	end,
	OnCanRun = function(item)
		--[[
			if this was equipped, then it's assumed that this is in the player's inventory
			can only unequip if the item is currently equipped
		]]
		return item:GetData("equip", false)
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		item:DoEquip()
		return false
	end,
	OnCanRun = function(item)
		--[[
			can only equip the item if it is currently NOT equipped 
			AND
			if it is in the player's inventory
		]]
		return not(item:GetData("equip", false)) and item:IsInPlayerInventory()
	end
}

ITEM.functions.Unload = {
	name = "Unload",
	icon = "icon16/tab.png",
	OnRun = function(item)
		item:RefundAmmo()

		return false
	end,
	OnCanRun = function(item)
		-- local weapon = item.player:GetCharacter():GetData("currentWeapon")[1]

		-- print("--- unload ---")
		-- print(tostring(weapon))

		-- if IsValid(weapon) and weapon:GetClass() == item.weapon and weapon:Clip1() > 0 then
		-- 	return true
		-- end
		return false
	end
}




function ITEM:DoUnequip()
	-- save current ammo
	self:OnSave()

	self:SetData("equip", false)

	self:StripWeapon()
end

function ITEM:DoEquip()
	self:CleanSlot(self.player:GetCharacter():GetInventory():GetItems())

	self:SetData("equip", true)

	self:SetData("weapon", self:GiveWeapon())

	self:SetupAmmo()

	-- save current ammo
	self:OnSave()
end

function ITEM:CanTransfer()
	if self:GetData("equip", false) then
		self:DoUnequip()
	else
		self:OnSave()
	end

	return true
end

function ITEM:StripWeapon()
	self:SetData("weapon", nil)
	self.player:StripWeapon(self.weapon)
end

function ITEM:GiveWeapon()
	return self.player:Give(self.weapon)
end

function ITEM:GetWeapon()
	return self.player:GetWeapon(self.weapon)
end

function ITEM:SetupAmmo()
	
end

-- when a save is initiated,
function ITEM:OnSave()
	
end

-- upon the player loading their character
function ITEM:OnLoadout()
	
end

function ITEM:IsInPlayerInventory()
    -- if self.entity exists, then the physical model representing this item is somewhere in the world.
    -- if self.player is not equal to self:GetOwner(), then the item is not in the player who is running this item's function's inventory.
    return !IsValid(self.entity) and self.player == self:GetOwner()
end

-- returns true if there's space for this item.
function ITEM:IsThereSpace(ammowidth, ammoheight, inventory)
	-- width, height, whether or not bags is a place where this item can go.
	if inventory:FindEmptySlot(ammowidth, ammoheight, true) then
		return true
	end
	return false
end

function ITEM:CleanSlot(items)
	for index, item in pairs(items) do

		

		-- if the selected item in the inventory is a weapon item, is not the same as this item, and is in the same slot
		if item.weapon and self:GetID() ~= item:GetID() and self.slot == item.slot then
			-- unequip it
			print(self)
			print(item)
			item:DoUnequip()
			break
		end
    end
end

function ITEM:AddAmmo(amount)
	local ply = self.player
	local character = ply:GetCharacter()

	local weapon = character:GetData("currentWeapon")[1]

	local ammoType = game.GetAmmoName(weapon:GetPrimaryAmmoType())
	local currentAmmo = ply:GetAmmoCount(ammoType)


end

function ITEM:UnloadAmmo()
	local ply = self.player
	local character = ply:GetCharacter()
	local inventory = character:GetInventory()

	local weapon = character:GetData("currentWeapon")[1]

	local ammoType = game.GetAmmoName(weapon:GetPrimaryAmmoType())
	
	
end


-- do something when the item is dropped
ITEM:Hook("drop", function(item)
	self:CanTransfer()
end)

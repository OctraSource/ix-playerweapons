--[[
    Schema:KeyPress(client, key)
        Schema : adding a function within the schema
            Schema:KeyPress : a function that runs whenever any key is pressed by a player

]]
function Schema:KeyPress(client, key)
    -- if the player pressed their reload key (8192)
    if key == 8192 then
        print("reload pressed!")
        local character = client:GetCharacter()

        local weaponData = character:GetData("currentWeapon")
        local weapon, wepItem = weaponData[1], weaponData[2]
        
        -- if the character, weapon, AND item exists,
        if character and weapon and wepItem then
            local maximum = weapon:GetMaxClip1()
            local currentAmmo = weapon:Clip1()
            local hasAnyAmmo = weapon:HasAmmo()
            local charInv = character:GetInventory()

            -- finish up
            -- TODO: must set the data point "currentlyLoadedName" of this weapon item to whatever the ammo item they loaded (use the item's LoadWeapon() function!!)
        end
    end
end

local itemBlacklist = {
                        ["gmod_toolgun"] = true,
                        ["gmod_physgun"] = true, 
                        ["weapon_physcannon"] = true,
                        ["ix_hands"] = true, 
                        ["ix_keys"] = true
                    }

-- save data within the old weapon the player has.
function Schema:PlayerSwitchWeapon(ply, oldWep, newWep)
    if IsValid(oldWep) and IsValid(newWep) then
        print("weapon is valid")
        local 
        if 
    else
        print("current weapon isn't valid!")
    end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    local weapon = client:GetActiveWeapon()
        
    client:SaveWeapon(weapon)
end
